#include "block_optimize.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <list>
#include <map>
#include <queue>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "llvm_assem.h"

using namespace std;
using namespace LLVM_IR;

struct my_graph_ {
    vector<Temp_label> pred;
    vector<Temp_label> succ;
    vector<T_ir> phi;
};
// todo:
// 注意一下自环的问题

static const char relops_str[][15] = {"eq", "ne", "slt", "sgt", "sle", "sge", "oeq", "one", "olt", "ogt", "ole", "oge"};
// 可能导致的问题：
// 1、一个false label的前驱有两个，要注意修复
// 2、两个block 的 true label 和false label都一样

unordered_set<AS_block2> del_emp_block;

static AS_block2List graph_2_block(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph) {
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        Temp_label label = (*it)->label;
        AS_instr2List instrList = (*it)->instrs;
        T_ir instr = instrList->ilist.back();
        if (instr->s->kind == llvm_T_stm_::T_JUMP || instr->s->kind == llvm_T_stm_::T_CJUMP) {
            Temp_labelList i_succ, b_succ;
            i_succ = instr->i->u.OPER.jumps->labels;
            b_succ = (*it)->succs;
            for (int i = 0; i < Graph[label].succ.size(); i++, i_succ = i_succ->tail, b_succ = b_succ->tail) {
                if (Graph[label].succ[i] != i_succ->head) {
                    // printf("修改 后继 %s  -> %s\n", S_name(i_succ->head), S_name(Graph[label].succ[i]));
                    i_succ->head = Graph[label].succ[i];
                    b_succ->head = Graph[label].succ[i];
                }
            }
            if (instr->s->kind == llvm_T_stm_::T_JUMP) {
                instr->s->u.JUMP.jump = Graph[label].succ[0];
            } else {
                instr->s->u.CJUMP.true_label = Graph[label].succ[0];
                instr->s->u.CJUMP.false_label = Graph[label].succ[1];
            }
        } else {
            assert(instr->s->kind == llvm_T_stm_::T_RETURN);
        }
    }
    return bl;
}

static AS_block2List block_false_fix(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    // 保证 CJUMP 之后紧跟false label的block
    unordered_map<Temp_label, Temp_label> label_trace;
    unordered_map<Temp_label, bool> label_node;
    unordered_map<Temp_label, std::list<AS_block2>::iterator> block_ptr;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        // printf("插入 block %s\n", S_name((*it)->label));
        block_ptr[(*it)->label] = it;
        if ((*it)->succs && (*it)->succs->tail) {
            if (label_trace.find((*it)->succs->tail->head) != label_trace.end()) {
                // 交换true和false label 应该保证 true和false label 不会同时一样
                AS_block2 block = *it;
                Temp_label true_label, false_label;
                true_label = block->succs->head;
                false_label = block->succs->tail->head;
                if (label_trace.find(true_label) != label_trace.end()) {
                    // printf("block 的 true label 和false label都被占用\n");
                    // printf("block label %s\n %s %s \n", S_name((*it)->label), S_name(true_label), S_name(false_label));

                    // 复用一个空的block
                    // 默认是优化导致的问题
                    assert(!del_emp_block.empty());
                    AS_block2 new_block = *del_emp_block.begin();
                    del_emp_block.erase(del_emp_block.begin());
                    Temp_label new_label = new_block->label;
                    // printf("1复用 添加%s  %s\n", S_name(block->label), S_name(new_label));
                    new_block->succs->head = false_label;
                    T_ir new_instr = new_block->instrs->ilist.back();

                    new_instr->i->u.OPER.jumps->labels->head = false_label;
                    new_instr->s->u.JUMP.jump = false_label;

                    label_block[new_label] = new_block;
                    bl->blist.push_back(new_block);
                    Graph[new_label].succ.push_back(false_label);
                    Graph[new_label].pred.push_back(block->label);

                    // 修改block的false label
                    Graph[(*it)->label].succ[1] = new_label;

                    block->succs->tail->head = new_label;

                    T_ir instr = block->instrs->ilist.back();
                    instr->i->u.OPER.jumps->labels->tail->head = new_label;
                    instr->s->u.CJUMP.false_label = new_label;

                    label_trace[(*it)->succs->tail->head] = (*it)->label;
                    label_node[(*it)->label] = false;
                    label_node[(*it)->succs->tail->head] = false;
                    // 修改block原来后继的前驱
                    for (int i = 0; i < Graph[false_label].pred.size(); i++) {
                        if (Graph[false_label].pred[i] == (*it)->label) {
                            Graph[false_label].pred[i] = new_label;
                            break;
                        }
                    }
                    // 修改后继的phi
                    for (int i = 0; i < Graph[false_label].phi.size(); i++) {
                        T_ir instr = Graph[false_label].phi[i];
                        Temp_labelList i_list = instr->i->u.OPER.jumps->labels;
                        Phi_pair_List s_list = instr->s->u.PHI.phis;
                        for (; i_list && s_list; i_list = i_list->tail, s_list = s_list->tail) {
                            if (i_list->head == block->label) {
                                i_list->head = new_label;
                                s_list->head->label = new_label;
                            }
                        }
                    }
                } else {
                    // printf("%s  %s %s\n", S_name((*it)->label), S_name(true_label),S_name(false_label));
                    Graph[(*it)->label].succ[0] = false_label;
                    Graph[(*it)->label].succ[1] = true_label;

                    block->succs->head = false_label;
                    block->succs->tail->head = true_label;

                    T_ir instr = block->instrs->ilist.back();
                    instr->i->u.OPER.jumps->labels->head = false_label;
                    instr->i->u.OPER.jumps->labels->tail->head = true_label;
                    instr->s->u.CJUMP.true_label = false_label;
                    instr->s->u.CJUMP.false_label = true_label;

                    // 取反操作符
                    LLVM_IR::T_relOp op = LLVM_IR::T_notRel(instr->s->u.CJUMP.op);
                    instr->s->u.CJUMP.op = op;

                    auto tmp_ptr = block->instrs->ilist.rbegin();
                    instr = *(++tmp_ptr);
                    instr->s->u.CMP.op = op;
                    if(strstr(instr->i->u.OPER.assem,"icmp")){
                        sprintf(instr->i->u.OPER.assem, "`d0 = icmp %s i32 `s0, `s1", relops_str[op]);
                    }
                    else if(strstr(instr->i->u.OPER.assem,"fcmp")){
                        sprintf(instr->i->u.OPER.assem, "`d0 = fcmp %s float `s0, `s1", relops_str[op]);
                    }
                    else{
                        assert(0);
                    }

                    label_trace[(*it)->succs->tail->head] = (*it)->label;
                    label_node[(*it)->label] = false;
                    label_node[(*it)->succs->tail->head] = false;
                }
            } else {
                // printf("插入 %s  %s\n", S_name((*it)->label), S_name((*it)->succs->tail->head));
                label_trace[(*it)->succs->tail->head] = (*it)->label;
                label_node[(*it)->label] = false;
                label_node[(*it)->succs->tail->head] = false;
            }
        }
    }
    // 第一个块不能动
    label_node[(*bl->blist.begin())->label]=true;
    // printf("label %s\n",S_name((*bl->blist.begin())->label));
    while (!label_trace.empty()) {
        auto it = label_trace.begin();
        Temp_label now_label, succ_label;
        now_label = it->second;
        succ_label = it->first;
        label_trace.erase(it);
        auto now_ptr = block_ptr[now_label], succ_ptr = block_ptr[succ_label];
        auto tmp_ptr = now_ptr;
        ++tmp_ptr;
        if (tmp_ptr != succ_ptr) {
            if (!label_node[succ_label]) {
                // printf("false label 添加%s  <--  %s\n", S_name(now_label), S_name(succ_label));
                auto next_ptr = bl->blist.insert(tmp_ptr, *succ_ptr);
                block_ptr[succ_label] = next_ptr;
                bl->blist.erase(succ_ptr);
            } else if (!label_node[now_label]) {
                // printf("false label 添加%s  -->  %s\n", S_name(now_label), S_name(succ_label));
                auto next_ptr = bl->blist.insert(succ_ptr, *now_ptr);
                block_ptr[now_label] = next_ptr;
                bl->blist.erase(now_ptr);
            } else {
                // 复用一个空的block
                // 默认是优化导致的问题
                AS_block2 block = *now_ptr;
                Temp_label true_label, false_label;
                true_label = block->succs->head;
                false_label = block->succs->tail->head;

                assert(!del_emp_block.empty());
                AS_block2 new_block = *del_emp_block.begin();
                del_emp_block.erase(del_emp_block.begin());
                Temp_label new_label = new_block->label;
                // printf("复用 添加%s  %s  %s\n", S_name(now_label), S_name(new_label), S_name(succ_label));
                new_block->succs->head = false_label;
                T_ir new_instr = new_block->instrs->ilist.back();

                new_instr->i->u.OPER.jumps->labels->head = false_label;
                new_instr->s->u.JUMP.jump = false_label;

                label_block[new_label] = new_block;
                Graph[new_label].succ.push_back(false_label);
                Graph[new_label].pred.push_back(block->label);
                bl->blist.insert(tmp_ptr, new_block);

                // 修改block的false label
                Graph[now_label].succ[1] = new_label;

                block->succs->tail->head = new_label;

                T_ir instr = block->instrs->ilist.back();
                instr->i->u.OPER.jumps->labels->tail->head = new_label;
                instr->s->u.CJUMP.false_label = new_label;

                // 修改block原来后继的前驱
                for (int i = 0; i < Graph[false_label].pred.size(); i++) {
                    if (Graph[false_label].pred[i] == block->label) {
                        Graph[false_label].pred[i] = new_label;
                        break;
                    }
                }
                // 修改后继的phi
                for (int i = 0; i < Graph[false_label].phi.size(); i++) {
                    T_ir instr = Graph[false_label].phi[i];
                    Temp_labelList i_list = instr->i->u.OPER.jumps->labels;
                    Phi_pair_List s_list = instr->s->u.PHI.phis;
                    for (; i_list && s_list; i_list = i_list->tail, s_list = s_list->tail) {
                        if (i_list->head == block->label) {
                            i_list->head = new_label;
                            s_list->head->label = new_label;
                        }
                    }
                }
            }
        }
        label_node[now_label] = true;
        label_node[succ_label] = true;
    }
    return bl;
}

// 删除空块：必然只有一个后继
// 删除条件：
// 后继没有phi 否则会导致SSA有问题
// 因为这种block不是真的空块
// 可能导致需要 jump_combine
static AS_block2List empty_block_delete(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    for (auto it = bl->blist.begin(); it != bl->blist.end();) {
        if(it==bl->blist.begin()){
            ++it;
            continue;
        }
        Temp_label label = (*it)->label, succ_label, pred_label;
        AS_instr2List instrList = (*it)->instrs;
        auto begin = instrList->ilist.begin();
        bool is_delete = false;
        ++begin;
        if (*begin == instrList->ilist.back() && ((*begin)->s->kind != llvm_T_stm_::T_RETURN)) {
            assert(Graph[label].succ.size() == 1);
            succ_label = Graph[label].succ[0];
            // 注意:while(1)
            if (Graph[succ_label].phi.size() == 0&&succ_label!=label) {
                // 修改前驱的后继
                for (int i = 0; i < Graph[label].pred.size(); i++) {
                    pred_label = Graph[label].pred[i];
                    for (int j = 0; j < Graph[pred_label].succ.size(); j++) {
                        if (Graph[pred_label].succ[j] == label) {
                            Graph[pred_label].succ[j] = succ_label;
                        }
                    }
                }
                // 删除后继的前驱
                for (auto item = Graph[succ_label].pred.begin(); item != Graph[succ_label].pred.end();) {
                    if (*item == label) {
                        item = Graph[succ_label].pred.erase(item);
                    } else {
                        ++item;
                    }
                }
                // 添加后继的前驱
                for (int i = 0; i < Graph[label].pred.size(); i++) {
                    Graph[succ_label].pred.push_back(Graph[label].pred[i]);
                }
                // 删除当前label
                Graph.erase(label);
                label_block.erase(label);
                // printf("删除 block %s\n", S_name(label));
                is_delete = true;
            }
        }
        // 删除block
        if (is_delete) {
            del_emp_block.insert(*it);
            it = bl->blist.erase(it);
        } else {
            ++it;
        }
    }

    return graph_2_block(bl, Graph);
}

// cjump两个分支一样
static AS_block2List jump_combine(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    for (auto it = Graph.begin(); it != Graph.end(); ++it) {
        if (it->second.succ.size() == 2 && it->second.succ[0] == it->second.succ[1]) {
            Temp_label label = it->second.succ[0];
            // printf("block %s  label %s一样\n", S_name(it->first), S_name(label));
            it->second.succ.pop_back();
            int num = 0;
            for (int i = 0; i < Graph[label].pred.size(); i++) {
                if (Graph[label].pred[i] == it->first) {
                    num++;
                    if (num == 2) {
                        Graph[label].pred.erase(Graph[label].pred.begin() + i);
                        i--;
                    }
                }
            }
            AS_block2 block = label_block[it->first];
            block->succs = Temp_LabelList(label, NULL);
            assert(block->instrs->ilist.back()->s->kind == llvm_T_stm_::T_CJUMP);
            block->instrs->ilist.pop_back();
            block->instrs->ilist.pop_back();
            AS_instr instr = AS_Oper((my_string) "br label `j0", NULL, NULL, AS_Targets(Temp_LabelList(label, NULL)));
            llvm_T_stm_* stm = LLVM_IR::T_Jump(label);
            T_ir ir = T_Ir(stm, instr);
            block->instrs->ilist.push_back(ir);
        }
    }
    return bl;
}

// 伸直化
// 相邻的两个，出入度为1————后者必然没有phi
// 应当使用后者的label
// 必然没有副作用?不允许自环
// O(n)
static AS_block2List block_combine(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    unordered_set<AS_block2> table;
    unordered_map<AS_block2, std::list<AS_block2>::iterator> block_ptr;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        block_ptr[(*it)] = it;
    }
    for (auto it = Graph.begin(); it != Graph.end(); ++it) {
        if (it->second.pred.size() == 1) {
            table.insert(label_block[it->first]);
        }
    }
    while (!table.empty()) {
        AS_block2 block = *table.begin(), pred_block;
        table.erase(block);
        Temp_label label = block->label, pred_label;
        pred_label = Graph[label].pred[0];
        if (Graph[pred_label].succ.size() == 1) {
            pred_block = label_block[pred_label];
            // 避免自环
            bool x=false;
            for(int i=0;i<Graph[pred_label].pred.size();i++){
                if(Graph[pred_label].pred[i]==label){
                    x=true;
                    break;
                }
            }
            if(x){
                continue;
            }
            // printf("合并block %s  %s\n", S_name(pred_label), S_name(label));
            auto pos = block->instrs->ilist.begin();
            ++pos;
            block->instrs->ilist.splice(pos, pred_block->instrs->ilist, ++pred_block->instrs->ilist.begin(), --pred_block->instrs->ilist.end());
            label_block.erase(pred_label);
            Graph[label].pred = Graph[pred_label].pred;
            Graph[label].phi = Graph[pred_label].phi;
            Graph.erase(pred_label);
            table.erase(pred_block);

            // 注意将block接到pred_block的位置上
            auto now_ptr = block_ptr[block];
            auto pred_ptr = block_ptr[pred_block];
            block_ptr[block] = bl->blist.insert(pred_ptr, block);
            bl->blist.erase(now_ptr);

            if (Graph[label].pred.size() == 1) {
                table.insert(block);
            }

            for (int i = 0; i < Graph[label].pred.size(); i++) {
                Temp_label gp_label = Graph[label].pred[i];
                AS_block2 gp_block = label_block[gp_label];
                AS_instr2List instrList = gp_block->instrs;
                T_ir instr = instrList->ilist.back();
                Temp_labelList i_succ, b_succ;
                i_succ = instr->i->u.OPER.jumps->labels;
                b_succ = gp_block->succs;

                for (int i = 0; i < Graph[gp_label].succ.size(); i++, i_succ = i_succ->tail, b_succ = b_succ->tail) {
                    if (Graph[gp_label].succ[i] == pred_label) {
                        // printf("修改 后继 %s  -> %s\n", S_name(i_succ->head), S_name(Graph[label].succ[i]));
                        Graph[gp_label].succ[i] = label;
                        i_succ->head = label;
                        b_succ->head = label;
                    }
                }
                if (instr->s->kind == llvm_T_stm_::T_JUMP) {
                    instr->s->u.JUMP.jump = label;
                } else {
                    i_succ = instr->i->u.OPER.jumps->labels;
                    instr->s->u.CJUMP.true_label = i_succ->head;
                    i_succ = i_succ->tail;
                    instr->s->u.CJUMP.false_label = i_succ->head;
                }
            }
        }
    }
    for (auto it = bl->blist.begin(); it != bl->blist.end();) {
        Temp_label label = (*it)->label;
        if (label_block.find(label) == label_block.end()) {
            del_emp_block.insert(*it);
            it = bl->blist.erase(it);
        } else {
            ++it;
        }
    }
    return bl;
}

static AS_block2List block_trace(AS_block2List bl, unordered_map<Temp_label, struct my_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    unordered_map<Temp_label, bool> is_false_succ;
    unordered_map<Temp_label, std::list<AS_block2>::iterator> block_ptr;
    unordered_map<Temp_label, bool> table;
    queue<Temp_label> qu;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        qu.push((*it)->label);
        block_ptr[(*it)->label] = it;
    }
    for (auto& it : Graph) {
        table[it.first] = false;
        if (is_false_succ.find(it.first) == is_false_succ.end()) {
            is_false_succ[it.first] = false;
        }
        if (Graph[it.first].succ.size() == 2) {
            // printf("block %s  %s\n", S_name(it.first), S_name(Graph[it.first].succ[1]));
            is_false_succ[Graph[it.first].succ[1]] = true;
        }
    }
    while (!qu.empty()) {
        Temp_label label = qu.front(), succ_label;
        qu.pop();
        if (is_false_succ[label]) {
            // printf("%s  %d\n",S_name(label),qu.size());
            qu.push(label);
        } else {
            table[label] = true;
            while (1) {
                if (Graph[label].succ.size() == 2) {
                    succ_label = Graph[label].succ[1];
                    assert(table[succ_label] == false);
                    auto now = block_ptr[label], succ = block_ptr[succ_label];
                    bl->blist.splice(++now, bl->blist, succ);
                    table[succ_label] = true;
                    label = succ_label;
                } else if (Graph[label].succ.size()) {
                    succ_label = Graph[label].succ[0];
                    if (table[succ_label] || is_false_succ[succ_label]) {
                        break;
                    } else {
                        auto now = block_ptr[label], succ = block_ptr[succ_label];
                        bl->blist.splice(++now, bl->blist, succ);
                        table[succ_label] = true;
                        label = succ_label;
                    }
                } else {
                    break;
                }
            }
        }
        while (!qu.empty() && table[qu.front()]) {
            qu.pop();
        }
    }
    return bl;
}

// 注意顺序不能乱
AS_block2List block_Optimize(AS_block2List bl) {
    unordered_map<Temp_label, struct my_graph_> Graph;
    unordered_map<Temp_label, AS_block2> label_block;
    // unordered_set<AS_block2> del_emp_block;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        Temp_label label = (*it)->label;
        label_block[label] = *it;
        Temp_labelList succ = (*it)->succs;
        for (; succ; succ = succ->tail) {
            Graph[label].succ.push_back(succ->head);
            Graph[succ->head].pred.push_back(label);
        }
        auto instr = (*it)->instrs->ilist.begin();
        for (; instr != (*it)->instrs->ilist.end(); ++instr) {
            if ((*instr)->s->kind == llvm_T_stm_::T_PHI) {
                Graph[label].phi.push_back(*instr);
            }
        }
    }
    bl = empty_block_delete(bl, Graph, label_block);
    bl = jump_combine(bl, Graph, label_block);
    bl = block_combine(bl, Graph, label_block);
    bl = block_false_fix(bl, Graph, label_block);
    bl = block_trace(bl, Graph, label_block);
    return bl;
}