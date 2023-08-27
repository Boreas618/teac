#include "fun_inline.h"
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

using namespace std;
using namespace LLVM_IR;

unordered_set<std::string> n_funInline_table;

struct my_fun_graph_ {
    vector<P_funList> pred, succ;
};

static void move_alloc(P_funList now) {
    auto bl = now->blockList;
    AS_block2 block;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        if (it == bl->blist.begin()) {
            block = *it;
            continue;
        }
        auto& il = (*it)->instrs->ilist;
        for (auto tl = il.begin(); tl != il.end();) {
            if ((*tl)->s->kind == llvm_T_stm_::T_ALLOCA) {
                block->instrs->ilist.insert(--block->instrs->ilist.end(), *tl);
                tl = il.erase(tl);
            } else {
                ++tl;
            }
        }
    }
}

static void fix_phi(P_funList now, AS_block2 block, Temp_label prev_label) {
    auto bl = now->blockList;
    if (block->succs) {
        Temp_label label, succ_label = block->succs->head;
        AS_block2 succ_block = NULL;
        label = block->label;
        for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
            if ((*it)->label == succ_label) {
                succ_block = *it;
                break;
            }
        }
        for (auto instr = succ_block->instrs->ilist.begin(); instr != succ_block->instrs->ilist.end(); ++instr) {
            if ((*instr)->s->kind == llvm_T_stm_::T_PHI) {
                Temp_labelList i_list = (*instr)->i->u.OPER.jumps->labels;
                Phi_pair_List s_list = (*instr)->s->u.PHI.phis;
                for (; i_list && s_list; i_list = i_list->tail, s_list = s_list->tail) {
                    if (i_list->head == prev_label) {
                        i_list->head = label;
                        s_list->head->label = label;
                    }
                }
            }
        }
    }
    if (block->succs && block->succs->tail) {
        Temp_label label, succ_label = block->succs->tail->head;
        AS_block2 succ_block = NULL;
        label = block->label;
        for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
            if ((*it)->label == succ_label) {
                succ_block = *it;
                break;
            }
        }
        for (auto instr = succ_block->instrs->ilist.begin(); instr != succ_block->instrs->ilist.end(); ++instr) {
            if ((*instr)->s->kind == llvm_T_stm_::T_PHI) {
                Temp_labelList i_list = (*instr)->i->u.OPER.jumps->labels;
                Phi_pair_List s_list = (*instr)->s->u.PHI.phis;
                for (; i_list && s_list; i_list = i_list->tail, s_list = s_list->tail) {
                    if (i_list->head == prev_label) {
                        i_list->head = label;
                        s_list->head->label = label;
                    }
                }
            }
        }
    }
}
static void proc_integration(P_funList now, P_funList succ) {
    auto bl = now->blockList;
    auto call_block = bl->blist.begin();
    std::list<LLVM_IR::T_ir>::iterator call_ins;
    bool x = true;
    for (; call_block != bl->blist.end(); ++call_block) {
        auto& il = (*call_block)->instrs->ilist;
        for (call_ins = il.begin(); call_ins != il.end(); ++call_ins) {
            if ((*call_ins)->s->kind == llvm_T_stm_::T_CALL || (*call_ins)->s->kind == llvm_T_stm_::T_VOID_CALL) {
                if ((*call_ins)->s->u.CALL.fun == succ->name) {
                    x = false;
                    break;
                }
            }
        }
        if (!x) {
            break;
        }
    }
    assert(*call_ins);
    assert(*call_block);

    // 删除开头对参数的def
    auto succ_def_block = succ->blockList->blist.begin();
    for (auto it = (*succ_def_block)->instrs->ilist.begin(); it != (*succ_def_block)->instrs->ilist.end();) {
        if ((std::string)(*it)->i->u.OPER.assem == "") {
            it = (*succ_def_block)->instrs->ilist.erase(it);
        } else {
            ++it;
        }
    }
    // 形参move到实参
    Temp_tempList read_args = succ->args;
    AS_operandList formal_args = (*call_ins)->i->u.OPER.src;
    auto front_instr = ++(*succ_def_block)->instrs->ilist.begin();
    for (; read_args && formal_args; read_args = read_args->tail, formal_args = formal_args->tail) {
        AS_operand src = formal_args->head;
        AS_operand dst = AS_Operand_Temp(read_args->head);
        AS_instr instr;
        llvm_T_stm_* stm;
        switch (src->kind) {
            case AS_operand_::T_TEMP: {
                switch (src->u.TEMP->type) {
                    case INT_TEMP: {
                        instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        stm = LLVM_IR::T_Move(dst, src);
                    } break;
                    case FLOAT_TEMP: {
                        instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        stm = LLVM_IR::T_Move(dst, src);
                    } break;
                    case INT_PTR:
                    case FLOAT_PTR: {
                        instr = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        stm = LLVM_IR::T_Move(dst, src);
                    } break;
                    default:
                        assert(0);
                }
            } break;
            case AS_operand_::T_ICONST: {
                instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                stm = LLVM_IR::T_Move(dst, src);
            } break;
            case AS_operand_::T_FCONST: {
                instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                stm = LLVM_IR::T_Move(dst, src);
            } break;
            case AS_operand_::T_NAME: {
                char as_buf[100];
                my_string label_str = S_name(src->u.NAME.name);
                sprintf(as_buf, "`d0 = bitcast ptr @%s to ptr", label_str);
                instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL);
                stm = LLVM_IR::T_Move(dst, src);
            }
        }
        (*succ_def_block)->instrs->ilist.insert(front_instr, T_Ir(stm, instr));
    }
    assert(read_args == NULL && formal_args == NULL);
    // 分成两个block
    AS_block2 new_block = new AS_block2_();
    new_block->label = Temp_newlabel();
    new_block->instrs = new AS_instr2List_();
    new_block->instrs->ilist.splice(new_block->instrs->ilist.end(), (*call_block)->instrs->ilist, call_ins, (*call_block)->instrs->ilist.end());

    new_block->succs = (*call_block)->succs;
    AS_instr instr = AS_Label(StringLabel(S_name(new_block->label)), new_block->label);
    LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Label(new_block->label);
    new_block->instrs->ilist.push_front(T_Ir(stm, instr));

    auto next_tmp = call_block;
    ++next_tmp;
    now->blockList->blist.insert(next_tmp, new_block);

    (*call_block)->succs = Temp_LabelList((*succ_def_block)->label, NULL);
    instr = AS_Oper(String("br label `j0"), NULL, NULL, AS_Targets((*call_block)->succs));
    stm = LLVM_IR::T_Jump((*succ_def_block)->label);
    (*call_block)->instrs->ilist.push_back(T_Ir(stm, instr));

    // 修改new_block后继的phi
    fix_phi(now, new_block, (*call_block)->label);
    // 将所有ret修改
    unordered_map<Temp_label, AS_operand> re_phi;
    for (auto& it : succ->blockList->blist) {
        if (it->succs == NULL) {
            T_ir t_instr = it->instrs->ilist.back();
            assert(t_instr->s->kind == llvm_T_stm_::T_RETURN);
            re_phi[it->label] = t_instr->s->u.RET.ret;
            it->succs = Temp_LabelList(new_block->label, NULL);
            instr = AS_Oper(String("br label `j0"), NULL, NULL, AS_Targets(it->succs));
            stm = LLVM_IR::T_Jump(new_block->label);
            it->instrs->ilist.pop_back();
            it->instrs->ilist.push_back(T_Ir(stm, instr));
        }
    }
    // 将call改成phi
    T_ir t_call = *(++new_block->instrs->ilist.begin());
    assert(t_call->s->kind == llvm_T_stm_::T_CALL || t_call->s->kind == llvm_T_stm_::T_VOID_CALL);
    if (t_call->s->kind == llvm_T_stm_::T_CALL) {
        if (re_phi.size() == 1) {
            AS_operand src = re_phi.begin()->second;
            AS_instr instr;
            AS_operand dst = t_call->s->u.CALL.res;
            if (isFloatPtr(dst) || isIntPtr(dst)) {
                instr = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
            } else if (isFloat(dst)) {
                instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
            } else if (isInt(dst)) {
                instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
            } else {
                assert(0);
            }
            LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Move(dst, src);
            t_call = (LLVM_IR::T_Ir(stm, instr));
        } else {
            AS_operandList new_tempList = NULL;
            Temp_labelList new_labelList = NULL;
            for (auto& tmp_p : re_phi) {
                new_tempList = AS_OperandList(tmp_p.second, new_tempList);
                new_labelList = Temp_LabelList(tmp_p.first, new_labelList);
            }
            AS_operand dst = t_call->s->u.CALL.res;
            // 重新生成string
            char str[300];
            char str_temp[50];
            memset(str, 0, strlen(str));
            switch (dst->u.TEMP->type) {
                case INT_TEMP: {
                    sprintf(str, "`d0 = phi i32 ");
                    break;
                }
                case FLOAT_TEMP: {
                    sprintf(str, "`d0 = phi float ");
                    break;
                }
                case INT_PTR:
                case FLOAT_PTR: {
                    sprintf(str, "`d0 = phi ptr ");
                    break;
                }
                default: {
                    assert(0);
                    break;
                }
            }
            for (int i = 0; i < re_phi.size(); i++) {
                if (i == 0)
                    sprintf(str_temp, "[`s0, `j0]");
                else
                    sprintf(str_temp, ", [`s%d, `j%d]", i, i);
                strcat(str, str_temp);
            }
            AS_instr instr = AS_Oper(String(str), AS_OperandList(dst, NULL), new_tempList, AS_Targets(new_labelList));
            LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Phi(dst, new_labelList, new_tempList);
            t_call = (LLVM_IR::T_Ir(stm, instr));
        }
        *(++new_block->instrs->ilist.begin()) = t_call;
    } else {
        new_block->instrs->ilist.erase(++new_block->instrs->ilist.begin());
    }
    // 拼接过来
    now->blockList->blist.splice(now->blockList->blist.end(), succ->blockList->blist);
    move_alloc(now);
}
// 拷贝func & 重命名temp和label
static P_funList copy_rename(P_funList now) {
    P_funList fun = new struct P_funList_();
    // name
    fun->name = now->name;
    unordered_map<Temp_temp, Temp_temp> temp_table;
    unordered_map<Temp_label, Temp_label> label_table;

    Temp_tempList args = NULL;
    list<Temp_temp> t_list;
    for (auto it = now->args; it; it = it->tail) {
        Temp_temp temp = Temp_newtemp();
        temp->type = it->head->type;
        temp_table[it->head] = temp;
        t_list.push_back(temp);
    }
    while (!t_list.empty()) {
        args = Temp_TempList(t_list.back(), args);
        t_list.pop_back();
    }
    // args
    fun->args = args;

    // blockList
    fun->blockList = new struct AS_block2List_();

    auto bl = now->blockList;
    for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
        AS_block2 block = new AS_block2_();
        Temp_label label = Temp_newlabel();
        label_table[(*it)->label] = label;
        // label
        block->label = label;
        fun->blockList->blist.push_back(block);
    }
    for (auto it = bl->blist.begin(), new_it = fun->blockList->blist.begin(); it != bl->blist.end(); ++it, ++new_it) {
        auto& il = (*it)->instrs->ilist;

        Temp_labelList succs = NULL;
        list<Temp_label> l_list;
        for (auto succ = (*it)->succs; succ; succ = succ->tail) {
            Temp_label label = label_table[succ->head];
            l_list.push_back(label);
        }
        while (!l_list.empty()) {
            succs = Temp_LabelList(l_list.back(), succs);
            l_list.pop_back();
        }
        // succs
        (*new_it)->succs = succs;

        AS_instr2List instrsList = new struct AS_instr2List_();
        for (auto ins = il.begin(); ins != il.end(); ++ins) {
            AS_instr instr = (*ins)->i, new_instr = NULL;
            llvm_T_stm_ *s = (*ins)->s, *new_s = NULL;
            AS_operandList new_dst = NULL, new_src = NULL;
            AS_targets new_jumps = NULL;
            Temp_label new_label = NULL;
            switch (instr->kind) {
                case AS_instr_::I_OPER: {
                    AS_operandList dst, src;
                    dst = instr->u.OPER.dst;
                    src = instr->u.OPER.src;
                    AS_targets jumps = instr->u.OPER.jumps;
                    list<AS_operand> dst_list, src_list;
                    for (; dst; dst = dst->tail) {
                        AS_operand operand = new AS_operand_();
                        *operand = *(dst->head);
                        if (operand->kind == AS_operand_::T_TEMP) {
                            if (temp_table.find(operand->u.TEMP) != temp_table.end()) {
                                operand->u.TEMP = temp_table[operand->u.TEMP];
                            } else {
                                Temp_temp temp = Temp_newtemp();
                                temp->type = operand->u.TEMP->type;
                                temp_table[operand->u.TEMP] = temp;
                                operand->u.TEMP = temp;
                            }
                        }
                        dst_list.push_back(operand);
                    }
                    while (!dst_list.empty()) {
                        new_dst = AS_OperandList(dst_list.back(), new_dst);
                        dst_list.pop_back();
                    }
                    for (; src; src = src->tail) {
                        AS_operand operand = new AS_operand_();
                        *operand = *(src->head);
                        if (operand->kind == AS_operand_::T_TEMP) {
                            if (temp_table.find(operand->u.TEMP) != temp_table.end()) {
                                operand->u.TEMP = temp_table[operand->u.TEMP];
                            } else {
                                Temp_temp temp = Temp_newtemp();
                                temp->type = operand->u.TEMP->type;
                                temp_table[operand->u.TEMP] = temp;
                                operand->u.TEMP = temp;
                            }
                        }
                        src_list.push_back(operand);
                    }
                    while (!src_list.empty()) {
                        new_src = AS_OperandList(src_list.back(), new_src);
                        src_list.pop_back();
                    }

                    if (jumps) {
                        Temp_labelList labels = jumps->labels;
                        Temp_labelList new_labels = NULL;
                        list<Temp_label> l_list;
                        for (; labels; labels = labels->tail) {
                            Temp_label label = label_table[labels->head];
                            l_list.push_back(label);
                        }
                        while (!l_list.empty()) {
                            new_labels = Temp_LabelList(l_list.back(), new_labels);
                            l_list.pop_back();
                        }
                        new_jumps = AS_Targets(new_labels);
                    }
                    new_instr = AS_Oper(String(instr->u.OPER.assem), new_dst, new_src, new_jumps);
                } break;
                case AS_instr_::I_LABEL: {
                    new_label = label_table[instr->u.LABEL.label];
                    new_instr = AS_Label(StringLabel(S_name(new_label)), new_label);
                } break;
                case AS_instr_::I_MOVE: {
                    AS_operandList dst, src;
                    dst = instr->u.OPER.dst;
                    src = instr->u.OPER.src;
                    AS_targets jumps = instr->u.OPER.jumps;
                    list<AS_operand> dst_list, src_list;
                    for (; dst; dst = dst->tail) {
                        AS_operand operand = new AS_operand_();
                        *operand = *(dst->head);
                        if (operand->kind == AS_operand_::T_TEMP) {
                            if (temp_table.find(operand->u.TEMP) != temp_table.end()) {
                                operand->u.TEMP = temp_table[operand->u.TEMP];
                            } else {
                                Temp_temp temp = Temp_newtemp();
                                temp->type = operand->u.TEMP->type;
                                temp_table[operand->u.TEMP] = temp;
                                operand->u.TEMP = temp;
                            }
                        }
                        dst_list.push_back(operand);
                    }
                    while (!dst_list.empty()) {
                        new_dst = AS_OperandList(dst_list.back(), new_dst);
                        dst_list.pop_back();
                    }
                    for (; src; src = src->tail) {
                        AS_operand operand = new AS_operand_();
                        *operand = *(src->head);
                        if (operand->kind == AS_operand_::T_TEMP) {
                            if (temp_table.find(operand->u.TEMP) != temp_table.end()) {
                                operand->u.TEMP = temp_table[operand->u.TEMP];
                            } else {
                                Temp_temp temp = Temp_newtemp();
                                temp->type = operand->u.TEMP->type;
                                temp_table[operand->u.TEMP] = temp;
                                operand->u.TEMP = temp;
                            }
                        }
                        src_list.push_back(operand);
                    }
                    while (!src_list.empty()) {
                        new_src = AS_OperandList(src_list.back(), new_src);
                        src_list.pop_back();
                    }
                    new_instr = AS_Move(String(instr->u.MOVE.assem), new_dst, new_src);
                } break;
            }
            switch (s->kind) {
                case llvm_T_stm_::T_BINOP: {
                    new_s = T_Binop(s->u.BINOP.op, new_dst->head, new_src->head, new_src->tail->head);
                } break;
                case llvm_T_stm_::T_INTTOPTR: {
                    new_s = T_InttoPtr(new_dst->head, new_src->head);
                } break;
                case llvm_T_stm_::T_PTRTOINT: {
                    new_s = T_PtrtoInt(new_dst->head, new_src->head);
                } break;
                case llvm_T_stm_::T_LOAD: {
                    new_s = T_Load(new_dst->head, new_src->head);
                } break;
                case llvm_T_stm_::T_STORE: {
                    new_s = T_Store(new_src->head, new_src->tail->head);
                } break;
                case llvm_T_stm_::T_LABEL: {
                    new_s = T_Label(new_label);
                } break;
                case llvm_T_stm_::T_JUMP: {
                    new_s = T_Jump(new_jumps->labels->head);
                } break;
                case llvm_T_stm_::T_CMP: {
                    new_s = T_Cmp(s->u.CMP.op, new_src->head, new_src->tail->head);
                } break;
                case llvm_T_stm_::T_CJUMP: {
                    new_s = T_Cjump(s->u.CJUMP.op, new_jumps->labels->head, new_jumps->labels->tail->head);
                } break;
                case llvm_T_stm_::T_MOVE: {
                    if (new_src) {
                        new_s = T_Move(new_dst->head, new_src->head);
                    } else {
                        printf("%s\n", instr->u.OPER.assem);
                        if (!strcmp("`d0 = bitcast ptr @AaBbcCL2 to ptr", instr->u.OPER.assem)) {
                            assert(instr->u.OPER.src);
                        }
                        assert(0);
                        new_s = T_Move(new_dst->head, NULL);
                    }
                } break;
                case llvm_T_stm_::T_CALL: {
                    new_s = T_Call(String(s->u.CALL.fun), new_dst->head, new_src);
                } break;
                case llvm_T_stm_::T_VOID_CALL: {
                    new_s = T_VoidCall(String(s->u.CALL.fun), new_src);
                } break;
                case llvm_T_stm_::T_RETURN: {
                    if (new_src) {
                        new_s = T_Return(new_src->head);
                    } else {
                        new_s = LLVM_IR::T_Return(NULL);
                    }
                } break;
                case llvm_T_stm_::T_PHI: {
                    new_s = T_Phi(new_dst->head, new_jumps->labels, new_src);
                } break;
                case llvm_T_stm_::T_NULL: {
                    new_s = T_Null();
                } break;
                case llvm_T_stm_::T_ALLOCA: {
                    new_s = T_Alloca(new_dst->head, s->u.ALLOCA.size, s->u.ALLOCA.isIntArr);
                } break;
                case llvm_T_stm_::T_I2F: {
                    new_s = T_I2f(new_dst->head, new_src->head);
                } break;
                case llvm_T_stm_::T_F2I: {
                    new_s = T_F2i(new_dst->head, new_src->head);
                } break;
                case llvm_T_stm_::T_GEP: {
                    new_s = T_Gep(new_dst->head, new_src->head, new_src->tail->head);
                } break;
            }
            instrsList->ilist.push_back(T_Ir(new_s, new_instr));
        }
        // instrs
        (*new_it)->instrs = instrsList;
    }
    return fun;
}

void fun_inline(unordered_map<std::string, P_funList>& fun_list) {
    unordered_map<std::string, struct my_fun_graph_> Graph;
    unordered_set<P_funList> table;

    for (auto& fun : fun_list) {
        auto bl = fun.second->blockList;
        for (auto it = bl->blist.begin(); it != bl->blist.end(); ++it) {
            auto& il = (*it)->instrs->ilist;
            for (auto instr = il.begin(); instr != il.end(); ++instr) {
                if ((*instr)->s->kind == llvm_T_stm_::T_CALL || (*instr)->s->kind == llvm_T_stm_::T_VOID_CALL) {
                    if (fun_list.find((*instr)->s->u.CALL.fun) != fun_list.end()) {
                        P_funList succ = (*fun_list.find((*instr)->s->u.CALL.fun)).second;
                        Graph[fun.first].succ.push_back(succ);
                        Graph[succ->name].pred.push_back(fun.second);
                    }
                }
            }
        }
        if (Graph[fun.first].succ.empty() && fun.first != "main" && n_funInline_table.find(fun.first) == n_funInline_table.end()) {
            table.insert(fun.second);
        }
    }
    // unordered_map<std::string, P_funList> tmp;
    // for(auto &it:fun_list){
    //     printf("inline %s\n", it.first.c_str());
        // P_funList new_fun = copy_rename(it.second);
        // tmp[it.first]=new_fun;
    // }
    // fun_list=tmp;

    while (!table.empty()) {
        auto it = table.begin();
        P_funList now = *it;
        table.erase(it);
        for (auto& pred : Graph[now->name].pred) {
            if (n_funInline_table.find(pred->name) != n_funInline_table.end()) {
                continue;
            }
            P_funList new_fun = copy_rename(now);
            proc_integration(pred, new_fun);
            for (auto tmp = Graph[pred->name].succ.begin(); tmp != Graph[pred->name].succ.end(); ++tmp) {
                if ((*tmp) == now) {
                    Graph[pred->name].succ.erase(tmp);
                    break;
                }
            }
            if (Graph[pred->name].succ.empty() && pred->name != "main" && n_funInline_table.find(pred->name) == n_funInline_table.end()) {
                table.insert(pred);
            }
        }
        fun_list.erase(now->name);
        Graph.erase(now->name);
    }

    // delete not inline func 
    for (auto it = fun_list.begin(); it != fun_list.end();) {
        if (n_funInline_table.find(it->first) != n_funInline_table.end()) {
            it = fun_list.erase(it);
        }else{
            ++it;
        }
    }
}