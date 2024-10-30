#include "ssa.h"
#include <cassert>
#include <iostream>
#include <list>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "bg_llvm.h"
#include "graph.hpp"
#include "liveness.h"
#include "printLLVM.h"

using namespace std;
using namespace LLVMIR;
using namespace GRAPH;
struct imm_Dominator {
    LLVMIR::L_block* pred;
    unordered_set<LLVMIR::L_block*> succs;
};

unordered_map<L_block*, unordered_set<L_block*>> dominators;
unordered_map<L_block*, imm_Dominator> tree_dominators;
unordered_map<L_block*, unordered_set<L_block*>> DF_array;
unordered_map<L_block*, Node<LLVMIR::L_block*>*> revers_graph;
unordered_map<Temp_temp*, AS_operand*> temp2ASoper;

unordered_map<Temp_temp*,bool> exitASoper;
static void init_table() {
    dominators.clear();
    tree_dominators.clear();
    DF_array.clear();
    revers_graph.clear();
    temp2ASoper.clear();
}

LLVMIR::L_prog* SSA(LLVMIR::L_prog* prog) {
    for (auto& fun : prog->funcs) {
        init_table();
        combine_addr(fun);
        mem2reg(fun);
        auto RA_bg = Create_bg(fun->blocks);
        // printL_block(cout,RA_bg.mynodes[0]->info);
        SingleSourceGraph(RA_bg.mynodes[0], RA_bg,fun);
        Liveness(RA_bg.mynodes[0], RA_bg, fun->args);
        Dominators(RA_bg);
        // printf_domi();
        tree_Dominators(RA_bg);
        // printf_D_tree();
        // 默认0是入口block
        computeDF(RA_bg, RA_bg.mynodes[0]);
        // Show_graph(stdout,RA_bg);
        // printf_DF();
        Place_phi_fu(RA_bg, fun);
        Rename(RA_bg);
        combine_addr(fun);
    }
    return prog;
}

static bool is_mem_variable(L_stm* stm) {
    return stm->type == L_StmKind::T_ALLOCA && stm->u.ALLOCA->dst->kind == OperandKind::TEMP && stm->u.ALLOCA->dst->u.TEMP->type == TempType::INT_PTR && stm->u.ALLOCA->dst->u.TEMP->len == 0;
}

// 保证相同的AS_operand,地址一样 。常量除外
void combine_addr(LLVMIR::L_func* fun) {
    unordered_map<Temp_temp*, unordered_set<AS_operand**>> temp_set;
    unordered_map<Name_name*, unordered_set<AS_operand**>> name_set;
    for (auto& block : fun->blocks) {
        for (auto& stm : block->instrs) {
            auto AS_operand_list = get_all_AS_operand(stm);
            for (auto AS_op : AS_operand_list) {
                if ((*AS_op)->kind == OperandKind::TEMP) {
                    temp_set[(*AS_op)->u.TEMP].insert(AS_op);
                } else if ((*AS_op)->kind == OperandKind::NAME) {
                    name_set[(*AS_op)->u.NAME].insert(AS_op);
                }
            }
        }
    }
    for (auto temp : temp_set) {
        AS_operand* fi_AS_op = **temp.second.begin();
        for (auto AS_op : temp.second) {
            *AS_op = fi_AS_op;
        }
    }
    for (auto name : name_set) {
        AS_operand* fi_AS_op = **name.second.begin();
        for (auto AS_op : name.second) {
            *AS_op = fi_AS_op;
        }
    }
}

void mem2reg(LLVMIR::L_func* fun) {
    if (fun->blocks.empty())
        return;
    unordered_set<Temp_temp*> args;
    for (auto arg : fun->args) {
        args.insert(arg);
    }
    // 找到所有的alloca标量
    unordered_map<AS_operand*, AS_operand*> variables;
    auto fi_block = fun->blocks.front();
    for (auto stm = fi_block->instrs.begin(); stm != fi_block->instrs.end();) {
        if (is_mem_variable(*stm)) {
            auto dst=(*stm)->u.ALLOCA->dst;
            variables.insert({dst, AS_Operand_Temp(Temp_newtemp_int())});
            stm = fi_block->instrs.erase(stm);
            fi_block->instrs.insert(stm, L_Move(AS_Operand_Const(0), variables[dst]));
        } else {
            ++stm;
        }
    }
    // 删除冗余load和store
    unordered_map<AS_operand*, AS_operand*> alias_var;
    for (auto& block : fun->blocks) {
        for (auto stm = block->instrs.begin(); stm != block->instrs.end();) {
            if ((*stm)->type == L_StmKind::T_STORE && (*stm)->u.STORE->ptr->kind == OperandKind::TEMP && (*stm)->u.STORE->ptr->u.TEMP->type == TempType::INT_PTR && (*stm)->u.STORE->ptr->u.TEMP->len == 0 && variables.find((*stm)->u.STORE->ptr) != variables.end()) {
                if (alias_var.find((*stm)->u.STORE->src) != alias_var.end()) {
                    auto src = (*stm)->u.STORE->src;
                    auto dst = (*stm)->u.STORE->ptr;
                    stm = block->instrs.erase(stm);
                    block->instrs.insert(stm, L_Move(src, variables[dst]));
                } else {
                    if ((*stm)->u.STORE->src->kind == OperandKind::TEMP) {
                        if (args.find((*stm)->u.STORE->src->u.TEMP) == args.end()) {
                            alias_var.insert({(*stm)->u.STORE->src, variables[(*stm)->u.STORE->ptr]});
                            stm = block->instrs.erase(stm);
                        } else {
                            auto src = (*stm)->u.STORE->src;
                            auto dst = (*stm)->u.STORE->ptr;
                            stm = block->instrs.erase(stm);
                            block->instrs.insert(stm, L_Move(src, variables[dst]));
                        }
                    } else if ((*stm)->u.STORE->src->kind == OperandKind::ICONST) {
                        auto src = (*stm)->u.STORE->src;
                        auto dst = (*stm)->u.STORE->ptr;
                        stm = block->instrs.erase(stm);
                        block->instrs.insert(stm, L_Move(src, variables[dst]));
                    } else {
                        assert(0);
                    }
                }
            } else if ((*stm)->type == L_StmKind::T_LOAD && (*stm)->u.LOAD->ptr->kind == OperandKind::TEMP && (*stm)->u.LOAD->ptr->u.TEMP->type == TempType::INT_PTR && (*stm)->u.LOAD->ptr->u.TEMP->len == 0 && variables.find((*stm)->u.LOAD->ptr) != variables.end()) {
                 if (alias_var.find((*stm)->u.STORE->src) != alias_var.end()){
                    assert(0);
                 }
                alias_var.insert({(*stm)->u.LOAD->dst, variables[(*stm)->u.LOAD->ptr]});
                stm = block->instrs.erase(stm);
            } else {
                ++stm;
            }
        }
    }
    // 替换所有的别名
    for (auto& block : fun->blocks) {
        for (auto& stm : block->instrs) {
            auto AS_operand_list = get_all_AS_operand(stm);
            for (auto AS_op : AS_operand_list) {
                if (alias_var.find(*AS_op) != alias_var.end()) {
                    *AS_op = alias_var[*AS_op];
                }
                if ((*AS_op)->kind == OperandKind::TEMP) {
                    temp2ASoper[(*AS_op)->u.TEMP] = *AS_op;
                }
            }
        }
    }
}

void Dominators(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    dominators.clear();
    for (auto block : bg.mynodes) {
        revers_graph[block.second->info] = block.second;
    }
    for (auto block_i : bg.mynodes) {
        if (block_i.second->inDegree()) {
            for (auto block_j : bg.mynodes) {
                dominators[block_i.second->info].insert(block_j.second->info);
            }
        } else {
            dominators[block_i.second->info].insert(block_i.second->info);
        }
    }
    bool changed = true;
    int i = 0;
    while (changed) {
        changed = false;
        i++;
        for (auto block : bg.mynodes) {
            if (block.second->inDegree() == 0)
                continue;
            unordered_set<LLVMIR::L_block*> next_dom;
            //  intersection D[p]
            auto preds = block.second->preds;
            if (preds.size()) {
                next_dom = dominators[bg.mynodes[*preds.begin()]->info];
            }
            for (auto pred : preds) {
                if (pred == *preds.begin())
                    continue;
                for (auto t = next_dom.begin(); t != next_dom.end();) {
                    if (dominators[bg.mynodes[pred]->info].find(*t) != dominators[bg.mynodes[pred]->info].end()) {
                        ++t;
                    } else {
                        t = next_dom.erase(t);
                    }
                }
            }
            next_dom.insert(block.second->info);
            if (!changed) {
                for (auto x : dominators[block.second->info]) {
                    if (next_dom.find(x) != next_dom.end()) {
                        continue;
                    } else {
                        changed = true;
                        break;
                    }
                }
            }
            dominators[block.second->info] = next_dom;
        }
    }
    // cout<<i<<endl;
}

void printf_domi() {
    printf("Dominator:\n");
    for (auto x : dominators) {
        printf("Dom(%s)={", x.first->label->name.c_str());
        for (auto t : x.second) {
            printf("%s , ", t->label->name.c_str());
        }
        if(x.second.size()>=1){
            printf("\b\b");
        }
        printf("}\n");
    }
}

void printf_D_tree() {
    printf("dominator tree:\n");
    for (auto x : tree_dominators) {
        printf("%s ", x.first->label->name.c_str());
        for (auto t : x.second.succs) {
            printf("%s ", t->label->name.c_str());
        }
        printf("}\n\n");
    }
}
void printf_DF() {
    printf("DF:\n");
    for (auto x : DF_array) {
        printf("DF(%s)={", x.first->label->name.c_str());
        for (auto t : x.second) {
            printf("%s , ", t->label->name.c_str());
        }
        if(x.second.size()>=1){
            printf("\b\b");
        }
        printf("}\n");
    }
}

void tree_Dominators(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    for (auto block_node : bg.mynodes) {
        auto now = block_node.second->info;
        // printf("%s\n",now->label->name.c_str());
        for (auto domi : dominators[block_node.second->info]) {
            //  printf("支配节点%s\n",domi->label->name.c_str());
            if (domi == block_node.second->info) {
                continue;
            }
            if (now == block_node.second->info) {
                now = domi;
                continue;
            }
            if (dominators[domi].find(now) != dominators[domi].end()) {
                now = domi;
            }
        }
        if (now != block_node.second->info) {
            tree_dominators[block_node.second->info].pred = now;
            tree_dominators[now].succs.insert(block_node.second->info);
        }
    }
}

void computeDF(GRAPH::Graph<LLVMIR::L_block*>& bg, GRAPH::Node<LLVMIR::L_block*>* r) {
    for (auto succ : r->succs) {
        if (tree_dominators[bg.mynodes[succ]->info].pred != r->info) {
            DF_array[r->info].insert(bg.mynodes[succ]->info);
        }
    }
    for (auto domi_succ : tree_dominators[r->info].succs) {
        computeDF(bg, revers_graph[domi_succ]);
        for (auto w : DF_array[domi_succ]) {
            if (dominators[w].find(r->info) == dominators[w].end() || r->info == w) {
                DF_array[r->info].insert(w);
            }
        }
    }
}

// 只对标量做
void Place_phi_fu(GRAPH::Graph<LLVMIR::L_block*>& bg, L_func* fun) {
    unordered_map<Temp_temp*, unordered_set<L_block*>> defsites;
    unordered_map<L_block*, unordered_set<Temp_temp*>> temp_phi;
    for (auto block_node : bg.mynodes) {
        auto defset = FG_def(block_node.second);
        for (auto var : defset) {
            if (var->type == TempType::INT_TEMP)
                defsites[var].insert(block_node.second->info);
        }
    }
    for (auto var : defsites) {
        auto W = defsites[var.first];
        while (!W.empty()) {
            auto block_it = W.begin();
            auto block = *block_it;
            W.erase(block_it);
            for (auto Y : DF_array[block]) {
                // printf("%s  %s\n", block->label->name.c_str(), Y->label->name.c_str());
                auto inSet = FG_In(revers_graph[Y]);
                // 需要是live in 的
                if (temp_phi[Y].find(var.first) == temp_phi[Y].end() && inSet.find(var.first) != inSet.end()) {
                    AS_operand* dst = temp2ASoper[var.first];
                    assert(dst);
                    vector<pair<AS_operand*, Temp_label*>> phis;
                    for (auto pred : revers_graph[Y]->preds) {
                        auto pred_outset=FG_Out(bg.mynodes[pred]);
                        if(pred_outset.find(var.first)!=pred_outset.end())
                            phis.push_back({dst, bg.mynodes[pred]->info->label});
                    }
                    // printf("前驱  %s  %zu\n",Y->label->name.c_str(),revers_graph[Y]->preds.size());
                    auto tmp = L_Phi(dst, phis);
                    // printL_stm(cout,tmp);
                    auto first = Y->instrs.begin();
                    ++first;
                    Y->instrs.insert(first, tmp);
                    temp_phi[Y].insert(var.first);
                    auto defset = FG_def(revers_graph[Y]);
                    if (defset.find(var.first) == defset.end()) {
                        W.insert(Y);
                    }
                }
            }
        }
    }
}

static list<AS_operand**> get_def_int_operand(LLVMIR::L_stm* stm) {
    list<AS_operand**> ret1 = get_def_operand(stm), ret2;
    for (auto AS_op : ret1) {
        if ((**AS_op).u.TEMP->type == TempType::INT_TEMP) {
            ret2.push_back(AS_op);
        }
    }
    return ret2;
}

static list<AS_operand**> get_use_int_operand(LLVMIR::L_stm* stm) {
    list<AS_operand**> ret1 = get_use_operand(stm), ret2;
    for (auto AS_op : ret1) {
        if ((**AS_op).u.TEMP->type == TempType::INT_TEMP) {
            ret2.push_back(AS_op);
        }
    }
    return ret2;
}

static void Rename_temp(GRAPH::Graph<LLVMIR::L_block*>& bg, GRAPH::Node<LLVMIR::L_block*>* n, unordered_map<Temp_temp*, stack<Temp_temp*>>& Stack) {
    auto block = n->info;
    // printf("%s\n",block->label->name.c_str());
    unordered_map<Temp_temp*, int> def_temp;
    for (auto stm : block->instrs) {
        if (stm->type != L_StmKind::T_PHI) {
            auto uses = get_use_int_operand(stm);
            for (auto use : uses) {
                *use = temp2ASoper[Stack[(**use).u.TEMP].top()];
            }
        }
        auto defs = get_def_int_operand(stm);
        for (auto def : defs) {
            Temp_temp*temp;
            AS_operand*AS_op;
            temp=(**def).u.TEMP;
            if(!exitASoper[temp]){
                AS_op = *def;
                exitASoper[temp]=true;
            }
            else{
                temp = Temp_newtemp_int();
                AS_op = AS_Operand_Temp(temp);
                temp2ASoper[temp] = AS_op;
            }
            def_temp[(**def).u.TEMP]++;
            Stack[(**def).u.TEMP].push(temp);
            *def = AS_op;
        }
    }
    for (auto succ_key : n->succs) {
        auto succ_node = bg.mynodes[succ_key];
        auto succ = succ_node->info;
        int j = 0;
        for (auto pred = succ_node->preds.begin(); *pred != n->mykey; ++j, ++pred)
            ;
        for (auto stm : succ->instrs) {
            if (stm->type == L_StmKind::T_PHI) {
                auto temp = stm->u.PHI->phis[j].first->u.TEMP;
                auto AS_op = temp2ASoper[Stack[temp].top()];
                stm->u.PHI->phis[j].first = AS_op;
            }
        }
    }
    for (auto child : tree_dominators[block].succs) {
        Rename_temp(bg, revers_graph[child], Stack);
    }
    for (auto def : def_temp) {
        int i = def.second;
        while (i--) {
            Stack[def.first].pop();
        }
    }
}

void Rename(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    unordered_map<Temp_temp*, stack<Temp_temp*>> Stack;
    for (auto temp : temp2ASoper) {
        if (temp.first->type == TempType::INT_TEMP)
            Stack[temp.first].push(temp.first);
    }
    Rename_temp(bg, bg.mynodes[0], Stack);
}