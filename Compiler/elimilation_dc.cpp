#include "elimilation_dc.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <list>
#include <map>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "llvm_assem.h"
#include "ssa.h"
#include "translate.hpp"

using namespace std;
using namespace LLVM_IR;

struct my_dc_graph_ {
    unordered_set<Temp_label> pred;
    vector<Temp_label> succ;
    bool is_colored;
};

static G_graph RA_bg;
static S_table block_env;

static Temp_label parent;
static Temp_label r_label, exit_label;

typedef struct work_item_* work_item;
struct work_item_ {
    Temp_temp temp;
    AS_block2 block;  // def所在的block
    std::list<T_ir>::iterator def;
    std::list<T_ir> use;
};

static bool is_call(T_ir instr) {
    if (instr->s->kind == LLVM_IR::llvm_T_stm_::T_CALL || instr->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL) {
        return true;
    }
    return false;
}

AS_block2List simple_DeadCD(AS_block2List bl, Temp_tempList argvs) {
    unordered_map<int, work_item> work_table;
    unordered_set<int> prolog;
    for (auto it = argvs; it; it = it->tail) {
        prolog.insert(it->head->num);
    }
    for (list<AS_block2>::iterator tl = bl->blist.begin(); tl != bl->blist.end(); ++tl) {
        AS_instr2List instrsList = (*tl)->instrs;
        for (list<T_ir>::iterator il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
            T_ir instr = (*il);
            Temp_tempList defs, uses;
            defs = get_defs(instr);
            uses = get_uses(instr);
            for (Temp_tempList temp_l = defs; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (work_table.count(temp->num)) {
                    // 只能def一次
                    assert(work_table[temp->num]->block == NULL);
                    work_table[temp->num]->def = il;
                    work_table[temp->num]->block = (*tl);
                } else {
                    work_table[temp->num] = new struct work_item_();
                    work_table[temp->num]->temp = temp;
                    work_table[temp->num]->def = il;
                    work_table[temp->num]->block = (*tl);
                }
            }
            for (Temp_tempList temp_l = uses; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (work_table.count(temp->num)) {
                    work_table[temp->num]->use.push_back(instr);
                } else {
                    work_table[temp->num] = new struct work_item_();
                    work_table[temp->num]->temp = temp;
                    work_table[temp->num]->use.push_back(instr);
                }
            }
        }
    }
    // 优先删除没有use的，直到为空
    unordered_map<int, work_item> delete_table;
    for (auto it = work_table.begin(); it != work_table.end(); ++it) {
        if (it->second->use.empty()) {
            delete_table.insert(*it);
        }
    }

    while (!delete_table.empty()) {
        int index = delete_table.begin()->first;
        work_item item = delete_table.begin()->second;
        delete_table.erase(index);
        work_table.erase(index);
        if (item->use.empty()) {
            // 如果没有def，默认是参数
            // 虽然参数应该是def过的
            if (!item->block || prolog.find(index) != prolog.end()) {
                continue;
            }
            // 如何判断副作用?
            // 目前默认没有副作用
            if (!is_call(*item->def) || ((*item->def)->s->kind == LLVM_IR::llvm_T_stm_::T_CALL && ispure((*item->def)->s->u.CALL.fun))) {
                item->block->instrs->ilist.erase(item->def);
            } else {
                continue;
            }
            T_ir instr = (*(item->def));
            Temp_tempList uses;
            uses = get_uses(instr);
            for (Temp_tempList temp_l = uses; temp_l; temp_l = temp_l->tail) {
                int num = temp_l->head->num;
                for (auto it = work_table[num]->use.begin(); it != work_table[num]->use.end(); ++it) {
                    if ((*it) == instr) {
                        work_table[num]->use.erase(it);
                        break;
                    }
                }
                if (work_table[num]->use.empty()) {
                    delete_table.insert({num, work_table[num]});
                }
            }
        }
    }
    return bl;
}

static G_node my_Look_bg(AS_block2 b) {
    G_node n1 = NULL;
    for (G_nodeList n = G_nodes(RA_bg); n != NULL; n = n->tail) {
        if ((AS_block2)G_nodeInfo(n->head) == b) {
            n1 = n->head;
            break;
        }
    }
    if (n1 == NULL)
        return (G_Node(RA_bg, b));
    else
        return n1;
}

static void my_Enter_bg(AS_block2 b1, AS_block2 b2) {
    G_node n1 = my_Look_bg(b1);
    G_node n2 = my_Look_bg(b2);
    G_addEdge(n1, n2);
    return;
}

static G_nodeList my_Create_reverse_bg(AS_block2List bl) {
    auto list = bl;

    RA_bg = G_Graph();      // prepare the empty graph
    block_env = S_empty();  // build a table of label -> block

    for (auto it = bl->blist.rbegin(); it != bl->blist.rend(); ++it) {
        S_enter(block_env, (*it)->label, *it);
        my_Look_bg(*it); /* enter the block into graph as a node */
    }

    for (auto it = bl->blist.rbegin(); it != bl->blist.rend(); ++it) {
        Temp_labelList tl = (*it)->succs;
        while (tl) {
            auto succ = (AS_block2)S_look(block_env, tl->head);
            // if the succ label doesn't have a block, assume it's the "exit label",
            // then this doesn't form an edge in the bg graph
            // 翻转图
            if (succ)
                my_Enter_bg(succ, (*it));
            tl = tl->tail;
        }
    }
    return G_nodes(RA_bg);
}

static void add_CFG(AS_block2List bl) {
    r_label = Temp_newlabel();
    exit_label = Temp_newlabel();
    AS_block2 r_block = new AS_block2_();
    AS_block2 exit_block = new AS_block2_();

    r_block->label = r_label;
    r_block->instrs = new AS_instr2List_();
    r_block->succs = Temp_LabelList((*bl->blist.begin())->label, Temp_LabelList(exit_label, NULL));

    exit_block->label = exit_label;
    exit_block->instrs = new AS_instr2List_();
    exit_block->succs = NULL;
    for (auto& it : bl->blist) {
        if (!it->succs) {
            it->succs = Temp_LabelList(exit_label, NULL);
        }
    }
    bl->blist.push_front(r_block);
    bl->blist.push_back(exit_block);
}

static void del_CFG(AS_block2List bl) {
    for (auto it = bl->blist.begin(); it != bl->blist.end();) {
        if ((*it)->label == r_label || (*it)->label == exit_label) {
            it = bl->blist.erase(it);
        } else {
            if ((*it)->succs->head == exit_label) {
                (*it)->succs = NULL;
            }
            ++it;
        }
    }
}

static bool init_active(T_ir instr) {
    if ((is_call(instr) && !ispure((instr)->s->u.CALL.fun)) || instr->s->kind == llvm_T_stm_::T_STORE || instr->s->kind == llvm_T_stm_::T_RETURN) {
        return true;
    }
    return false;
}

static void delete_instr(AS_block2List bl, unordered_map<T_ir, bool>& instr_state) {
    for (auto it : bl->blist) {
        auto& instrList = it->instrs->ilist;
        for (auto instr = instrList.begin(); instr != instrList.end();) {
            if ((*instr)->s->kind == llvm_T_stm_::T_LABEL || (*instr)->s->kind == llvm_T_stm_::T_JUMP || (*instr)->s->kind == llvm_T_stm_::T_CJUMP) {
                ++instr;
            } else if (!instr_state[*instr]) {
                instr = instrList.erase(instr);
            } else {
                ++instr;
            }
        }
    }
}

static Temp_label DFS(AS_block2List bl, unordered_map<Temp_label, bool>& block_state, Temp_label label, unordered_map<Temp_label, struct my_dc_graph_>& Graph) {
    if (Graph[label].is_colored) {
        return NULL;
    }
    if (block_state[label]) {
        return label;
    }
    Graph[label].is_colored = true;
    for (auto it : Graph[label].succ) {
        parent = label;
        Temp_label ans = DFS(bl, block_state, it, Graph);
        if (ans) {
            Graph[label].is_colored = false;
            return ans;
        }
    }
    Graph[label].is_colored = false;
    return NULL;
}

static void DFS_d(AS_block2 block, unordered_set<Temp_label>& table, unordered_map<Temp_label, AS_block2>& label_block) {
    if (table.find(block->label) != table.end()) {
        return;
    }
    table.insert(block->label);
    if (block->succs) {
        DFS_d(label_block[block->succs->head], table, label_block);
        if (block->succs->tail) {
            DFS_d(label_block[block->succs->tail->head], table, label_block);
        }
    }
}

static void delete_block(AS_block2List bl, unordered_map<Temp_label, bool>& block_state, unordered_map<T_ir, bool>& instr_state, unordered_map<Temp_label, struct my_dc_graph_>& Graph, unordered_map<Temp_label, AS_block2>& label_block) {
    for (auto it : bl->blist) {
        T_ir instr = it->instrs->ilist.back();
        if (!instr_state[instr]) {
            if (instr->s->kind == llvm_T_stm_::T_CJUMP) {
                // printf("删除 %s\n", S_name(it->label));
                parent = it->label;
                Temp_label label = DFS(bl, block_state, it->succs->head, Graph);
                if (!label) {
                    parent = it->label;
                    label = DFS(bl, block_state, it->succs->tail->head, Graph);
                }
                assert(label);
                // 替换后继的phi label
                AS_block2 succ_block = label_block[label];
                for (auto ir : succ_block->instrs->ilist) {
                    if (ir->s->kind == llvm_T_stm_::T_PHI) {
                        Temp_labelList i_list = ir->i->u.OPER.jumps->labels;
                        Phi_pair_List s_list = ir->s->u.PHI.phis;
                        for (; i_list && s_list; i_list = i_list->tail, s_list = s_list->tail) {
                            if (i_list->head == parent) {
                                i_list->head = it->label;
                                s_list->head->label = it->label;
                            }
                        }
                    }
                }
                it->instrs->ilist.pop_back();
                it->succs = Temp_LabelList(label, NULL);
                AS_instr instr = AS_Oper((my_string) "br label `j0", NULL, NULL, AS_Targets(it->succs));
                llvm_T_stm_* stm = LLVM_IR::T_Jump(label);
                T_ir ir = T_Ir(stm, instr);
                it->instrs->ilist.push_back(ir);
            }
        }
    }
    // 删除不可达块
    unordered_set<Temp_label> table;
    DFS_d((*bl->blist.begin()), table, label_block);
    for (auto tl = bl->blist.begin(); tl != bl->blist.end();) {
        if (table.find((*tl)->label) == table.end()) {
            // printf("%s\n",S_name((*tl)->label));
            tl = bl->blist.erase(tl);
        } else {
            ++tl;
        }
    }
    Graph.clear();
    for (auto it : bl->blist) {
        Temp_label label = it->label;
        Temp_labelList succ = it->succs;
        for (; succ; succ = succ->tail) {
            Graph[label].succ.push_back(succ->head);
            Graph[succ->head].pred.insert(label);
        }
    }
    // phi应该不增不减 ,这里不应该有任何删除
    // for (auto tl = bl->blist.begin(); tl != bl->blist.end(); ++tl) {
    //     AS_instr2List instrsList = (*tl)->instrs;
    //     for (auto il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
    //         T_ir ir = *il;
    //         if (ir->s->kind == llvm_T_stm_::T_PHI) {
    //             AS_operandList tempList = ir->i->u.OPER.src;
    //             Temp_labelList labelList = ir->i->u.OPER.jumps->labels;
    //             list<AS_operand> list_temp;
    //             list<Temp_label> list_label;
    //             int num = 0;
    //             bool x = true;
    //             for (; labelList && tempList; labelList = labelList->tail, tempList = tempList->tail) {
    //                 if (Graph[(*tl)->label].pred.find(labelList->head) != Graph[(*tl)->label].pred.end()) {
    //                     list_temp.push_back(tempList->head);
    //                     list_label.push_back(labelList->head);
    //                     num++;
    //                 } else {
    //                     x = false;
    //                 }
    //             }
    //             if (x) {
    //                 continue;
    //             }
    //             if (num == 1) {
    //                 // 不一定是temp，也可能dst是undef，后续该指令会被删掉
    //                 // assert((*list_temp.begin())->kind == AS_operand_::T_TEMP);
    //                 AS_operand src = *list_temp.begin();
    //                 AS_instr instr;
    //                 AS_operand dst = ir->i->u.OPER.dst->head;
    //                 if (isFloatPtr(dst) || isIntPtr(dst)) {
    //                     instr = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
    //                 } else if (isFloat(dst)) {
    //                     instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
    //                 } else if (isInt(dst)) {
    //                     instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
    //                 }
    //                 LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Move(dst, src);
    //                 (*il) = (LLVM_IR::T_Ir(stm, instr));
    //             } else {
    //                 AS_operandList new_tempList = NULL;
    //                 Temp_labelList new_labelList = NULL;
    //                 while (!list_temp.empty()) {
    //                     new_tempList = AS_OperandList(list_temp.back(), new_tempList);
    //                     list_temp.pop_back();
    //                 }
    //                 while (!list_label.empty()) {
    //                     new_labelList = Temp_LabelList(list_label.back(), new_labelList);
    //                     list_label.pop_back();
    //                 }
    //                 // AS_print_llvm(stdout, use_instr->i, Temp_name());
    //                 ir->i->u.OPER.src = new_tempList;
    //                 ir->i->u.OPER.jumps->labels = new_labelList;
    //                 // 重新生成string
    //                 char str_temp[50];
    //                 my_string str = ir->i->u.OPER.assem;
    //                 memset(str, 0, strlen(str));
    //                 switch (ir->s->u.PHI.dst->u.TEMP->type) {
    //                     case INT_TEMP: {
    //                         sprintf(str, "`d0 = phi i32 ");
    //                         break;
    //                     }
    //                     case FLOAT_TEMP: {
    //                         sprintf(str, "`d0 = phi float ");
    //                         break;
    //                     }
    //                     case INT_PTR:
    //                     case FLOAT_PTR: {
    //                         sprintf(str, "`d0 = phi ptr ");
    //                         break;
    //                     }
    //                     default: {
    //                         assert(0);
    //                         break;
    //                     }
    //                 }
    //                 for (int i = 0; i < num; i++) {
    //                     if (i == 0)
    //                         sprintf(str_temp, "[`s0, `j0]");
    //                     else
    //                         sprintf(str_temp, ", [`s%d, `j%d]", i, i);
    //                     strcat(str, str_temp);
    //                 }
    //                 //
    //                 ir->s = T_Phi(ir->s->u.PHI.dst, new_labelList, new_tempList);
    //             }
    //         }
    //     }
    // }
}

static void advance_deadcd(AS_block2List bl, unordered_map<Temp_label, unordered_set<Temp_label>>& re_DF_set) {
    unordered_map<Temp_temp, work_item> work_table;
    unordered_map<Temp_label, bool> block_state;
    unordered_map<T_ir, bool> instr_state;

    unordered_map<T_ir, AS_block2> instr_block;
    unordered_map<Temp_label, AS_block2> label_block;
    unordered_set<T_ir> active_instr;
    unordered_set<AS_block2> active_block;
    for (auto tl = bl->blist.begin(); tl != bl->blist.end(); ++tl) {
        AS_instr2List instrsList = (*tl)->instrs;
        block_state[(*tl)->label] = false;
        label_block[(*tl)->label] = *tl;
        for (list<T_ir>::iterator il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
            T_ir instr = (*il);
            instr_block[instr] = *tl;
            instr_state[instr] = init_active(instr);
            if (instr_state[instr]) {
                active_instr.insert(instr);
            }
            Temp_tempList defs, uses;
            defs = get_defs(instr);
            uses = get_uses(instr);
            for (Temp_tempList temp_l = defs; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (work_table.count(temp)) {
                    // 只能def一次
                    assert(work_table[temp]->block == NULL);
                    work_table[temp]->def = il;
                    work_table[temp]->block = (*tl);
                } else {
                    work_table[temp] = new struct work_item_();
                    work_table[temp]->temp = temp;
                    work_table[temp]->def = il;
                    work_table[temp]->block = (*tl);
                }
            }
            for (Temp_tempList temp_l = uses; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (work_table.count(temp)) {
                    work_table[temp]->use.push_back(instr);
                } else {
                    work_table[temp] = new struct work_item_();
                    work_table[temp]->temp = temp;
                    work_table[temp]->use.push_back(instr);
                }
            }
        }
    }
    while (!active_instr.empty() || !active_block.empty()) {
        if (!active_instr.empty()) {
            T_ir instr = *active_instr.begin();
            active_instr.erase(active_instr.begin());
            Temp_tempList uses;
            uses = get_uses(instr);
            // 注意phi里面可能是常量，但pred也要是live的
            if (instr->s->kind == llvm_T_stm_::T_PHI) {
                Temp_labelList labelList = instr->i->u.OPER.jumps->labels;
                for (; labelList; labelList = labelList->tail) {
                    AS_block2 def_block = label_block[labelList->head];
                    if (!block_state[def_block->label]) {
                        block_state[def_block->label] = true;
                        active_block.insert(def_block);
                    }
                }
            }
            for (Temp_tempList temp_l = uses; temp_l; temp_l = temp_l->tail) {
                Temp_temp use_temp = temp_l->head;
                T_ir def_ir = *work_table[use_temp]->def;
                if (!instr_state[def_ir]) {
                    instr_state[def_ir] = true;
                    active_instr.insert(def_ir);
                }
                AS_block2 def_block = instr_block[def_ir];
                if (!block_state[def_block->label]) {
                    block_state[def_block->label] = true;
                    active_block.insert(def_block);
                }
            }
            AS_block2 def_block = instr_block[instr];
            if (!block_state[def_block->label]) {
                block_state[def_block->label] = true;
                active_block.insert(def_block);
            }
        } else {
            AS_block2 block = *active_block.begin();
            // printf("block %s\n", S_name(block->label));
            active_block.erase(active_block.begin());
            for (auto it : re_DF_set[block->label]) {
                if (label_block.find(it) == label_block.end()) {
                    continue;
                }
                AS_block2 cd_block = label_block[it];
                if (cd_block->succs && cd_block->succs->tail) {
                    auto instr = cd_block->instrs->ilist.end();
                    --instr;
                    if (!instr_state[*instr]) {
                        instr_state[*instr] = true;
                        active_instr.insert(*instr);
                    }
                    --instr;
                    if (!instr_state[*instr]) {
                        instr_state[*instr] = true;
                        active_instr.insert(*instr);
                    }
                } else if (cd_block->succs) {
                    auto instr = cd_block->instrs->ilist.end();
                    --instr;
                    if (!instr_state[*instr]) {
                        instr_state[*instr] = true;
                        active_instr.insert(*instr);
                    }
                } else {
                    // 必然有后继
                    assert(0);
                }
            }
        }
    }
    unordered_map<Temp_label, struct my_dc_graph_> Graph;
    for (auto it : bl->blist) {
        Temp_label label = it->label;
        Temp_labelList succ = it->succs;
        Graph[label].is_colored = false;
        for (; succ; succ = succ->tail) {
            Graph[label].succ.push_back(succ->head);
        }
    }
    delete_instr(bl, instr_state);
    delete_block(bl, block_state, instr_state, Graph, label_block);
}

AS_block2List elimilation_DeadCD(AS_block2List bl) {
    add_CFG(bl);
    G_nodeList bg = my_Create_reverse_bg(bl);
    SingleSourceGraph(bg->head, RA_bg);
    Dominators(RA_bg);
    computeDF(bg->head);

    unordered_map<Temp_label, unordered_set<Temp_label>> re_DF_set;
    unordered_map<int, Temp_label> nodes;
    vector<vector<int*>> DF = get_DF_array();

    for (G_nodeList tmp_bg = bg; tmp_bg; tmp_bg = tmp_bg->tail) {
        G_node head = tmp_bg->head;
        nodes[head->mykey] = (AS_block2(head->info))->label;
    }
    for (int i = 0; i < bl->blist.size(); i++) {
        Temp_label now_label = nodes[i];
        // printf("i: %d :\n",i);
        assert(now_label);
        for (int j = 0; j < DF[i].size(); j++) {
            // printf("%d\n",*DF[i][j]);
            Temp_label succ_label = nodes[*DF[i][j]];
            re_DF_set[now_label].insert(succ_label);
        }
    }
    del_CFG(bl);
    // printf("控制依赖图:\n");
    // for (auto& x : re_DF_set) {
    //     printf("%s 依赖:   ", S_name(x.first));
    //     for (auto y : x.second) {
    //         printf("%s  ", S_name(y));
    //     }
    //     printf("\n");
    // }
    // printf("end\n");
    advance_deadcd(bl, re_DF_set);
    return bl;
}