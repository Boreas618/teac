#include "deadce.h"
#include <assert.h>
#include <string.h>
#include <map>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "llvm_assemblock.h"
#include "translate.hpp"
using namespace std;
using namespace LLVM_IR;


typedef struct work_var_* work_var;

struct intOrfloat {
    enum { ICONT,
           FCONT } kind;
    union {
        int icons;
        float fcons;
    } u;

    intOrfloat() {}
    intOrfloat(int x) {
        this->kind = ICONT;
        this->u.icons = x;
    }
    intOrfloat(float x) {
        this->kind = FCONT;
        this->u.fcons = x;
    }
    bool operator!=(const intOrfloat& x) const {
        if (this->kind == ICONT && x.kind == ICONT) {
            return this->u.icons != x.u.icons;
        }
        if (this->kind == FCONT && x.kind == FCONT) {
            return this->u.fcons != x.u.fcons;
        }
        return false;
    }
};

// 不用继承，是因为这两个关系不大
struct work_var_ {
    Temp_temp temp;
    enum { UNDEF,
           CONS,
           NAC } kind;
    struct intOrfloat cons;
    std::list<T_ir>::iterator def;
    std::list<T_ir> use;
};

// 将单向链表转成双向  block和instr
AS_block2List single_2_double(llvm_AS_blockList bl) {
    AS_block2List blockList = new struct AS_block2List_();
    for (llvm_AS_blockList tl = bl; tl; tl = tl->tail) {
        llvm_AS_block head = tl->head;
        AS_block2 head_2 = new struct AS_block2_();
        head_2->label = head->label;
        head_2->succs = head->succs;
        AS_instr2List instr2List = new AS_instr2List_();
        for (T_irList instrsList = head->irs; instrsList; instrsList = instrsList->tail) {
            T_ir instr = instrsList->head;
            instr2List->ilist.push_back(instr);
        }
        head_2->instrs = instr2List;
        blockList->blist.push_back(head_2);
    }
    return blockList;
}

// 将双向链表转成单向
llvm_AS_blockList double_2_single(AS_block2List bl) {
    llvm_AS_blockList blockList = NULL;
    while (!bl->blist.empty()) {
        AS_block2 head2 = bl->blist.back();
        bl->blist.pop_back();
        T_irList instrList = NULL;
        AS_instr2List instr2List = head2->instrs;
        while (!instr2List->ilist.empty()) {
            T_ir instr = instr2List->ilist.back();
            instr2List->ilist.pop_back();
            instrList = T_IrList(instr, instrList);
        }
        llvm_AS_block block = (llvm_AS_block)checked_malloc(sizeof(*block));
        block->irs = instrList;
        block->label = head2->label;
        block->succs = head2->succs;
        blockList = AS_BlockList(block, blockList);
    }
    return blockList;
}

Temp_tempList get_defs(T_ir instr) {
    return get_defs(instr->i);
}
Temp_tempList get_uses(T_ir instr) {
    return get_uses(instr->i);
}
Temp_tempList get_defs(AS_instr instr) {
    Temp_tempList defs = NULL;
    AS_operandList op_def = NULL;
    switch (instr->kind) {
        case AS_instr_::I_OPER:
            op_def = instr->u.OPER.dst;
            break;
        case AS_instr_::I_LABEL:
            break;
        case AS_instr_::I_MOVE:
            op_def = instr->u.MOVE.dst;
            break;
    }
    list<Temp_temp> temp_defs;
    for (auto it = op_def; it; it = it->tail) {
        auto head = it->head;
        if (head->kind == AS_operand_::T_TEMP) {
            temp_defs.push_back(head->u.TEMP);
        }
    }
    // 保证是有序的
    while (!temp_defs.empty()) {
        defs = Temp_TempList(temp_defs.back(), defs);
        temp_defs.pop_back();
    }
    return defs;
}
Temp_tempList get_uses(AS_instr instr) {
    Temp_tempList uses = NULL;
    AS_operandList op_use = NULL;
    switch (instr->kind) {
        case AS_instr_::I_OPER:
            op_use = instr->u.OPER.src;
            break;
        case AS_instr_::I_LABEL:
            break;
        case AS_instr_::I_MOVE:
            op_use = instr->u.MOVE.src;
            break;
    }
    list<Temp_temp> temp_uses;
    for (auto it = op_use; it; it = it->tail) {
        auto head = it->head;
        if (head->kind == AS_operand_::T_TEMP) {
            temp_uses.push_back(head->u.TEMP);
        }
    }
    while (!temp_uses.empty()) {
        uses = Temp_TempList(temp_uses.back(), uses);
        temp_uses.pop_back();
    }
    return uses;
}
static bool is_call(T_ir instr) {
    if (instr->s->kind == LLVM_IR::llvm_T_stm_::T_CALL || instr->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL) {
        return true;
    }
    return false;
}
static bool is_re_call(T_ir instr) {
    if (instr->s->kind == LLVM_IR::llvm_T_stm_::T_CALL) {
        return true;
    }
    return false;
}
static bool is_load(T_ir instr) {
    if ((instr->s->kind == llvm_T_stm_::T_LOAD) || (instr->s->kind == llvm_T_stm_::T_GEP) ||
        (instr->s->kind == llvm_T_stm_::T_MOVE && instr->i->u.OPER.src->head->kind == AS_operand_::T_NAME) ||
        (instr->s->kind == llvm_T_stm_::T_ALLOCA)) {
        return true;
    }
    return false;
}
static bool is_operation(T_ir instr) {
    int kind = instr->s->kind;
    if ((kind == llvm_T_stm_::T_BINOP) || (kind == llvm_T_stm_::T_CMP) || (kind == llvm_T_stm_::T_MOVE && instr->i->u.OPER.src->head->kind != AS_operand_::T_NAME) ||
        (kind == llvm_T_stm_::T_I2F) || (kind == llvm_T_stm_::T_F2I)) {
        return true;
    }
    return false;
}

static vector<struct intOrfloat> get_consNum(T_ir instr) {
    vector<struct intOrfloat> x;
    AS_operandList op_use = NULL;
    switch (instr->i->kind) {
        case AS_instr_::I_OPER:
            op_use = instr->i->u.OPER.src;
            break;
        case AS_instr_::I_LABEL:
            assert(0);
        case AS_instr_::I_MOVE:
            op_use = instr->i->u.MOVE.src;
            break;
    }
    for (auto it = op_use; it; it = it->tail) {
        auto head = it->head;
        if (head->kind == AS_operand_::T_ICONST) {
            x.push_back(head->u.ICONST);
        } else if (head->kind == AS_operand_::T_FCONST) {
            x.push_back(head->u.FCONST);
        } else if (head->kind == AS_operand_::T_TEMP) {
            x.push_back(0);
        } else {
            cout << "指令 " << instr->i->u.OPER.assem << endl;
            assert(0);
        }
    }
    if (x.size() == 1)
        x.push_back(0);
    return x;
}

// 默认都是两个src,一个dst
// 常量传播注意浮点数的问题，+0和-0不一样
static void op_compute(T_ir instr, unordered_map<Temp_temp, work_var>& var_state, unordered_set<Temp_temp>& wt_var) {
    Temp_tempList defs, uses;
    defs = get_defs(instr);
    uses = get_uses(instr);
    Temp_temp dst, src1 = NULL, src2 = NULL;
    dst = defs->head;
    assert(defs->tail == NULL);
    int state;
    struct intOrfloat cons_1, cons_2;
    vector<struct intOrfloat> consList = get_consNum(instr);
    // cout<<"size "<<consList.size()<<"  "<<instr->i->u.OPER.assem<<endl;
    assert(consList.size() == 2);
    cons_1 = consList[0];
    cons_2 = consList[1];

    work_var d, s1 = NULL, s2 = NULL;
    d = var_state[dst];
    if (uses == NULL) {
        state = 0;
    } else {
        src1 = uses->head;
        s1 = var_state[src1];
        uses = uses->tail;
        if (uses == NULL) {
            // 判断只有一个temp时的位置
            if (instr->i->u.OPER.src->head->kind == AS_operand_::T_TEMP) {
                cons_1 = s1->cons;
            } else {
                cons_2 = s1->cons;
            }
            state = 1;
        } else {
            src2 = uses->head;
            s2 = var_state[src2];
            cons_1 = s1->cons;
            cons_2 = s2->cons;
            state = 2;
        }
    }

    // (4)
    if (state == 0 || (state == 1 && s1->kind == work_var_::CONS) || (state == 2 && (s1->kind == work_var_::CONS && s2->kind == work_var_::CONS))) {
        if (d->kind == work_var_::UNDEF) {
            if (wt_var.find(dst) == wt_var.end()) {
                wt_var.insert(dst);
            }
            d->kind = work_var_::CONS;
        }
        struct intOrfloat ans;
        switch (instr->s->kind) {
            case llvm_T_stm_::T_BINOP: {
                switch (instr->s->u.BINOP.op) {
                    case LLVM_IR::T_plus:
                        ans = cons_1.u.icons + cons_2.u.icons;
                        break;
                    case LLVM_IR::T_minus:
                        ans = cons_1.u.icons - cons_2.u.icons;
                        break;
                    case LLVM_IR::T_mul:
                        ans = cons_1.u.icons * cons_2.u.icons;
                        break;
                    case LLVM_IR::T_div:
                        ans = cons_1.u.icons / cons_2.u.icons;
                        break;
                    case LLVM_IR::T_mod:
                        ans = cons_1.u.icons % cons_2.u.icons;
                        break;
                    case LLVM_IR::F_plus:
                        ans = cons_1.u.fcons + cons_2.u.fcons;
                        break;
                    case LLVM_IR::F_minus:
                        ans = cons_1.u.fcons - cons_2.u.fcons;
                        break;
                    case LLVM_IR::F_mul:
                        ans = cons_1.u.fcons * cons_2.u.fcons;
                        break;
                    case LLVM_IR::F_div:
                        ans = cons_1.u.fcons / cons_2.u.fcons;
                        break;
                    default:
                        assert(0);
                }
            } break;
            case llvm_T_stm_::T_CMP: {
                switch (instr->s->u.CMP.op) {
                    case LLVM_IR::T_eq:
                        ans = cons_1.u.icons == cons_2.u.icons;
                        break;
                    case LLVM_IR::T_ne:
                        ans = cons_1.u.icons != cons_2.u.icons;
                        break;
                    case LLVM_IR::T_lt:
                        ans = cons_1.u.icons < cons_2.u.icons;
                        break;
                    case LLVM_IR::T_gt:
                        ans = cons_1.u.icons > cons_2.u.icons;
                        break;
                    case LLVM_IR::T_le:
                        ans = cons_1.u.icons <= cons_2.u.icons;
                        break;
                    case LLVM_IR::T_ge:
                        ans = cons_1.u.icons >= cons_2.u.icons;
                        break;
                    case LLVM_IR::F_eq:
                        ans = (int)(cons_1.u.fcons == cons_2.u.fcons);
                        break;
                    case LLVM_IR::F_ne:
                        ans = (int)(cons_1.u.fcons != cons_2.u.fcons);
                        break;
                    case LLVM_IR::F_lt:
                        ans = (int)(cons_1.u.fcons < cons_2.u.fcons);
                        break;
                    case LLVM_IR::F_gt:
                        ans = (int)(cons_1.u.fcons > cons_2.u.fcons);
                        break;
                    case LLVM_IR::F_le:
                        ans = (int)(cons_1.u.fcons <= cons_2.u.fcons);
                        break;
                    case LLVM_IR::F_ge:
                        ans = (int)(cons_1.u.fcons >= cons_2.u.icons);
                        break;
                    default:
                        assert(0);
                }
            } break;
            case llvm_T_stm_::T_MOVE: {
                ans = cons_1;
            } break;
            case llvm_T_stm_::T_I2F: {
                ans = (float)cons_1.u.icons;
            } break;
            case llvm_T_stm_::T_F2I: {
                ans = (int)cons_1.u.fcons;
            } break;
            default:
                assert(0);
        }
        d->cons = ans;
    }
    // (5)
    else if (s1->kind == work_var_::NAC || (state == 2 && s2->kind == work_var_::NAC)) {
        if (d->kind != work_var_::NAC) {
            if (wt_var.find(dst) == wt_var.end()) {
                wt_var.insert(dst);
            }
            d->kind = work_var_::NAC;
        }
    }
}

static void phi_compute(T_ir instr, unordered_map<T_ir, AS_block2>& find_block, unordered_map<Temp_temp, work_var>& var_state, unordered_set<Temp_temp>& wt_var, unordered_map<Temp_label, AS_block2>& label_block, unordered_map<AS_block2, pair<bool, int>>& block_state, bool isExec, unordered_map<Temp_label, vector<pair<Temp_label, bool>>>& succ_Graph) {
    Temp_tempList defs;
    defs = get_defs(instr);
    AS_operandList uses = instr->i->u.OPER.src;
    Temp_temp d;
    d = defs->head;
    Temp_labelList labelList = instr->i->u.OPER.jumps->labels;
    work_var dst, src;
    int num = 0;
    struct intOrfloat cons;
    bool isNAC = false;
    for (; labelList && (!isNAC); labelList = labelList->tail, uses = uses->tail) {
        Temp_label label = labelList->head;
        AS_block2 block = label_block[label];
        bool x = block_state[block].first;
        bool y = false;
        Temp_label now_label = find_block[instr]->label;
        if (succ_Graph[label][0].first == now_label) {
            y = succ_Graph[label][0].second;
        } else if (succ_Graph[label].size() == 2 && succ_Graph[label][1].first == now_label) {
            y = succ_Graph[label][1].second;
        } else {
            assert(0);
        }
        if (x && y) {
            switch (uses->head->kind) {
                case AS_operand_::T_TEMP: {
                    Temp_temp temp = uses->head->u.TEMP;
                    src = var_state[temp];
                } break;
                case AS_operand_::T_FCONST: {
                    src = new work_var_();
                    src->kind = work_var_::CONS;
                    src->cons = uses->head->u.FCONST;
                } break;
                case AS_operand_::T_ICONST: {
                    src = new work_var_();
                    src->kind = work_var_::CONS;
                    src->cons = uses->head->u.ICONST;
                } break;
                case AS_operand_::T_NAME: {
                    // 默认phi里面没有 全局变量的label
                    assert(0);
                } break;
            }
            dst = var_state[d];
            isNAC = dst->kind == work_var_::NAC;
            if (isNAC) {
                break;
            }
            if (isExec) {
                switch (src->kind) {
                        // (8)
                    case work_var_::NAC: {
                        if (wt_var.find(d) == wt_var.end()) {
                            wt_var.insert(d);
                        }
                        dst->kind = work_var_::NAC;
                    } break;
                    case work_var_::CONS: {
                        if (num == 0) {
                            num++;
                            cons = src->cons;
                        } else if (cons != src->cons) {
                            num++;
                        }
                        // (9) 可执行
                        if (num == 1) {
                            if (dst->kind == work_var_::UNDEF) {
                                if (wt_var.find(d) == wt_var.end()) {
                                    wt_var.insert(d);
                                }
                                dst->kind = work_var_::CONS;
                                dst->cons = cons;
                            }
                        }
                        // (6)
                        else {
                            if (wt_var.find(d) == wt_var.end()) {
                                wt_var.insert(d);
                            }
                            dst->kind = work_var_::NAC;
                        }
                    } break;
                    case work_var_::UNDEF:
                        break;
                }
            } else {
                switch (src->kind) {
                    case work_var_::NAC:
                        break;
                    case work_var_::CONS: {
                        if (num == 0) {
                            num++;
                            cons = src->cons;
                        } else if (cons != src->cons) {
                            num++;
                        }
                    } break;
                    case work_var_::UNDEF:
                        break;
                }
            }
        }
    }
    // (9) 不可执行
    if ((!isExec) && num == 1) {
        if (dst->kind == work_var_::UNDEF) {
            if (wt_var.find(d) == wt_var.end()) {
                wt_var.insert(d);
            }
            dst->kind = work_var_::CONS;
            dst->cons = cons;
        }
    }
}

static void mc_compute(T_ir instr, unordered_map<Temp_temp, work_var>& var_state, unordered_set<Temp_temp>& wt_var) {
    // (7)
    Temp_tempList defs;
    defs = get_defs(instr);
    Temp_temp dst;
    dst = defs->head;
    work_var d;
    d = var_state[dst];
    if (d->kind != work_var_::NAC) {
        if (wt_var.find(dst) == wt_var.end()) {
            wt_var.insert(dst);
        }
        d->kind = work_var_::NAC;
    }
}
static void cjump_compute(T_ir instr, unordered_map<Temp_temp, work_var>& var_state, unordered_set<AS_block2>& wt_block, unordered_map<Temp_label, AS_block2>& label_block, unordered_map<AS_block2, pair<bool, int>>& block_state, unordered_map<T_ir, AS_block2>& find_block, bool isBlock, unordered_map<Temp_label, vector<pair<Temp_label, bool>>>& succ_Graph) {
    Temp_tempList uses;
    uses = get_uses(instr);
    Temp_temp src;
    src = uses->head;
    work_var s1;
    s1 = var_state[src];

    Temp_labelList labelList = instr->i->u.OPER.jumps->labels;
    Temp_label label_t, label_f;
    label_t = labelList->head;
    labelList = labelList->tail;
    label_f = labelList->head;
    AS_block2 block_now, block_t, block_f;
    block_now = find_block[instr];
    block_t = label_block[label_t];
    block_f = label_block[label_f];

    switch (s1->kind) {
        // (10)
        case work_var_::NAC: {
            if (!block_state[block_t].first || isBlock||!succ_Graph[block_now->label][0].second) {
                if (wt_block.find(block_t) == wt_block.end()) {
                    wt_block.insert(block_t);
                    block_state[block_t].second++;
                }
            }
            if (!block_state[block_f].first || isBlock||succ_Graph[block_now->label][1].second) {
                if (wt_block.find(block_f) == wt_block.end()) {
                    wt_block.insert(block_f);
                    block_state[block_f].second++;
                }
            }
            succ_Graph[block_now->label][0].second = true;
            succ_Graph[block_now->label][1].second = true;
            block_state[block_t].first = true;
            block_state[block_f].first = true;
        } break;
        // (11)
        case work_var_::CONS: {
            if (s1->cons.u.icons) {
                if (!block_state[block_t].first || isBlock||!succ_Graph[block_now->label][0].second) {
                    if (wt_block.find(block_t) == wt_block.end()) {
                        wt_block.insert(block_t);
                        block_state[block_t].second++;
                    }
                }
                succ_Graph[block_now->label][0].second = true;
                block_state[block_t].first = true;
            } else {
                if (!block_state[block_f].first || isBlock||!succ_Graph[block_now->label][1].second) {
                    if (wt_block.find(block_f) == wt_block.end()) {
                        wt_block.insert(block_f);
                        block_state[block_f].second++;
                    }
                }
                succ_Graph[block_now->label][1].second = true;
                block_state[block_f].first = true;
            }
        } break;
        // 必须是def的?
        // 好像不必须是def的
        case work_var_::UNDEF: {
            // AS_print_llvm(stdout, instr->i, Temp_name());
            // assert(0);
        } break;
    }
}
static void cjump_fix(T_ir instr, unordered_map<Temp_temp, work_var>& var_state, unordered_set<AS_block2>& wt_block, unordered_map<Temp_label, AS_block2>& label_block, unordered_map<AS_block2, pair<bool, int>>& block_state, unordered_map<T_ir, AS_block2>& find_block, unordered_map<Temp_label, vector<pair<Temp_label, bool>>>& succ_Graph) {
    AS_block2 block = find_block[instr];
    auto it = block->instrs->ilist.back();
    if (it->s->kind == llvm_T_stm_::T_CJUMP && block_state[block].first) {
        cjump_compute(it, var_state, wt_block, label_block, block_state, find_block, false, succ_Graph);
    }
}

static void delete_var(AS_block2List bl, unordered_map<T_ir, AS_block2>& find_block, unordered_map<Temp_temp, work_var>& var_state, unordered_map<Temp_label, AS_block2>& label_block) {
    unordered_set<T_ir> phi_table;
    for (auto var = var_state.begin(); var != var_state.end(); ++var) {
        Temp_temp temp = var->first;
        work_var temp_var = var->second;
        //  printf("%d %d\n",temp->num,temp_var->kind);
        if (temp_var->kind == work_var_::CONS) {
            T_ir def_instr = *temp_var->def;
            AS_block2 def_block = find_block[def_instr];
            // 删除def
            def_block->instrs->ilist.erase(temp_var->def);
            find_block.erase(def_instr);
            // cout << "删除def\n";
            // AS_print_llvm(stdout, def_instr->i, Temp_name());
            for (auto instrList = temp_var->use.begin(); instrList != temp_var->use.end(); ++instrList) {
                T_ir use_instr = *instrList;
                // use 的指令可能已经被删除
                if (find_block.find(use_instr) != find_block.end()) {
                    AS_operandList op_use = NULL;
                    switch (use_instr->i->kind) {
                        case AS_instr_::I_OPER: {
                            op_use = use_instr->i->u.OPER.src;
                        } break;
                        case AS_instr_::I_LABEL: {
                            assert(0);
                        } break;
                        // 这里可能给MOVE的src一个常数，但理论上后续dst也是常数，该MOVE指令也会被删除，
                        case AS_instr_::I_MOVE: {
                            op_use = use_instr->i->u.MOVE.src;
                        } break;
                    }
                    for (auto it = op_use; it; it = it->tail) {
                        auto head = it->head;
                        if (head->kind == AS_operand_::T_TEMP && head->u.TEMP == temp) {
                            // cout<<"use\n";
                            //  AS_print_llvm(stdout,use_instr->i,Temp_name());
                            if (temp_var->cons.kind == intOrfloat::ICONT) {
                                head->kind = AS_operand_::T_ICONST;
                                head->u.ICONST = temp_var->cons.u.icons;
                            } else if (temp_var->cons.kind == intOrfloat::FCONT) {
                                head->kind = AS_operand_::T_FCONST;
                                head->u.FCONST = temp_var->cons.u.fcons;
                            } else {
                                assert(0);
                            }

                            // AS_print_llvm(stdout,use_instr->i,Temp_name());
                            break;
                        }
                    }
                }
            }
        }
        // 删除phi function里面
        else if (temp_var->kind == work_var_::UNDEF) {
            T_ir def_instr = *temp_var->def;
            // cout << "undef\n";
            // AS_print_llvm(stdout, def_instr->i, Temp_name());
            for (auto instrList = temp_var->use.begin(); instrList != temp_var->use.end(); ++instrList) {
                T_ir use_instr = *instrList;
                //  该指令可能已经删除  ||  phi 已经改过
                if (find_block.find(use_instr) != find_block.end() && phi_table.find(use_instr) != phi_table.end()) {
                    continue;
                }
                if (use_instr->s->kind == llvm_T_stm_::T_PHI) {
                    phi_table.insert(use_instr);
                    AS_operandList tempList = use_instr->i->u.OPER.src;
                    Temp_labelList labelList = use_instr->i->u.OPER.jumps->labels;
                    list<AS_operand> list_temp;
                    list<Temp_label> list_label;
                    int num = 0;
                    for (; labelList && tempList; labelList = labelList->tail, tempList = tempList->tail) {
                        if (tempList->head->kind == AS_operand_::T_ICONST || tempList->head->kind == AS_operand_::T_FCONST) {
                            list_temp.push_back(tempList->head);
                            list_label.push_back(labelList->head);
                            num++;
                        } else if (tempList->head->kind == AS_operand_::T_TEMP) {
                            if (var_state[tempList->head->u.TEMP]->kind != work_var_::UNDEF) {
                                list_temp.push_back(tempList->head);
                                list_label.push_back(labelList->head);
                                num++;
                            }
                        } else {
                            assert(0);
                        }
                    }
                    if (num == 1) {
                        // 不一定是temp，也可能dst是undef，后续该指令会被删掉
                        // assert((*list_temp.begin())->kind == AS_operand_::T_TEMP);
                        AS_operand src = *list_temp.begin();
                        AS_instr instr;
                        AS_operand dst = use_instr->i->u.OPER.dst->head;
                        if (isFloatPtr(dst) || isIntPtr(dst)) {
                            instr = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        } else if (isFloat(dst)) {
                            instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        } else if (isInt(dst)) {
                            instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        }
                        LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Move(dst, src);
                        (*instrList) = (LLVM_IR::T_Ir(stm, instr));
                    } else {
                        AS_operandList new_tempList = NULL;
                        Temp_labelList new_labelList = NULL;
                        while (!list_temp.empty()) {
                            new_tempList = AS_OperandList(list_temp.back(), new_tempList);
                            list_temp.pop_back();
                        }
                        while (!list_label.empty()) {
                            new_labelList = Temp_LabelList(list_label.back(), new_labelList);
                            list_label.pop_back();
                        }
                        // AS_print_llvm(stdout, use_instr->i, Temp_name());
                        use_instr->i->u.OPER.src = new_tempList;
                        use_instr->i->u.OPER.jumps->labels = new_labelList;
                        // 重新生成string
                        char str_temp[50];
                        my_string str = use_instr->i->u.OPER.assem;
                        memset(str, 0, strlen(str));
                        switch (temp->type) {
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
                        for (int i = 0; i < num; i++) {
                            if (i == 0)
                                sprintf(str_temp, "[`s0, `j0]");
                            else
                                sprintf(str_temp, ", [`s%d, `j%d]", i, i);
                            strcat(str, str_temp);
                        }
                        //
                        use_instr->s = T_Phi(use_instr->s->u.PHI.dst, new_labelList, new_tempList);
                        // AS_print_llvm(stdout, use_instr->i, Temp_name());
                    }
                }
            }
        }
    }
}

static void delete_block(AS_block2List bl, unordered_map<AS_block2, pair<bool, int>>& block_state, unordered_map<Temp_label, AS_block2>& label_block) {
    unordered_map<Temp_label, vector<Temp_label>> del_table;
    for (list<AS_block2>::iterator tl = bl->blist.begin(); tl != bl->blist.end();) {
        AS_block2 block = *tl;
        // 删除死的block
        if (!block_state[block].first) {
            Temp_labelList labelList = block->succs;
            for (; labelList; labelList = labelList->tail) {
                Temp_label tmp = labelList->head;
                if (block_state[label_block[tmp]].first) {
                    del_table[tmp].push_back(block->label);
                }
            }
            tl = bl->blist.erase(tl);
            // printf("删除block %s\n", S_name(block->label));
        }
        // 替换已知的CJUMP成JUMP
        else {
            AS_instr2List instrsList = block->instrs;
            if (instrsList->ilist.back()->s->kind == llvm_T_stm_::T_CJUMP) {
                AS_instr instr = instrsList->ilist.back()->i;
                if (instr->u.OPER.src->head->kind == AS_operand_::T_ICONST) {
                    Temp_label label;
                    if (instr->u.OPER.src->head->u.ICONST) {
                        label = instrsList->ilist.back()->s->u.CJUMP.true_label;
                        Temp_label tmp = instrsList->ilist.back()->s->u.CJUMP.false_label;
                        if (block_state[label_block[tmp]].first) {
                            del_table[tmp].push_back(block->label);
                        }
                    } else {
                        label = instrsList->ilist.back()->s->u.CJUMP.false_label;
                        Temp_label tmp = instrsList->ilist.back()->s->u.CJUMP.true_label;
                        if (block_state[label_block[tmp]].first) {
                            del_table[tmp].push_back(block->label);
                        }
                    }
                    instrsList->ilist.pop_back();
                    instr = AS_Oper((my_string) "br label `j0", NULL, NULL, AS_Targets(Temp_LabelList(label, NULL)));
                    llvm_T_stm_* stm = LLVM_IR::T_Jump(label);
                    T_ir ir = T_Ir(stm, instr);
                    instrsList->ilist.push_back(ir);
                    (*tl)->succs = Temp_LabelList(label, NULL);
                    // printf("替换block %s\n", S_name(block->label));
                }
            }
            ++tl;
        }
    }
    // 1、 要将边也标记成是否可执行的，前驱可执行只是必要条件  ok
    // 2、phi 里面要删两种temp：undef的和前驱不会到达的
    for (list<AS_block2>::iterator tl = bl->blist.begin(); tl != bl->blist.end(); ++tl) {
        if (del_table.find((*tl)->label) != del_table.end()) {
            AS_instr2List instrsList = (*tl)->instrs;
            Temp_label now_label = (*tl)->label;
            for (list<T_ir>::iterator il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
                if ((*il)->s->kind == llvm_T_stm_::T_PHI) {
                    T_ir use_instr = *il;
                    AS_operand dst = use_instr->i->u.OPER.dst->head;
                    AS_operandList tempList = use_instr->i->u.OPER.src;
                    Temp_labelList labelList = use_instr->i->u.OPER.jumps->labels;
                    list<AS_operand> temp;
                    list<Temp_label> label;
                    int num = 0;
                    for (; labelList && tempList; labelList = labelList->tail, tempList = tempList->tail) {
                        bool x = false;
                        for (auto& item : del_table[now_label]) {
                            if (item == labelList->head) {
                                x = true;
                                break;
                            }
                        }
                        if (!x) {
                            temp.push_back(tempList->head);
                            label.push_back(labelList->head);
                            num++;
                        }
                    }
                    if (num == 1) {
                        // 如果是常量，该def会被删除;不可能是Name
                        assert((*temp.begin())->kind == AS_operand_::T_TEMP);
                        AS_operand src = *temp.begin();
                        AS_instr instr;
                        if (isFloatPtr(dst) || isIntPtr(dst)) {
                            instr = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        } else if (isFloat(dst)) {
                            instr = AS_Move(String("`d0 = bitcast float `s0 to float"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        } else if (isInt(dst)) {
                            instr = AS_Move(String("`d0 = bitcast i32 `s0 to i32"), AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        }
                        LLVM_IR::llvm_T_stm_* stm = LLVM_IR::T_Move(dst, src);
                        (*il) = (LLVM_IR::T_Ir(stm, instr));
                    } else {
                        AS_operandList new_tempList = NULL;
                        Temp_labelList new_labelList = NULL;
                        while (!temp.empty()) {
                            new_tempList = AS_OperandList(temp.back(), new_tempList);
                            temp.pop_back();
                        }
                        while (!label.empty()) {
                            new_labelList = Temp_LabelList(label.back(), new_labelList);
                            label.pop_back();
                        }
                        use_instr->i->u.OPER.src = new_tempList;
                        use_instr->i->u.OPER.jumps->labels = new_labelList;
                        // 重新生成string
                        char str_temp[50];
                        my_string str = use_instr->i->u.OPER.assem;
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
                        for (int i = 0; i < num; i++) {
                            if (i == 0)
                                sprintf(str_temp, "[`s0, `j0]");
                            else
                                sprintf(str_temp, ", [`s%d, `j%d]", i, i);
                            strcat(str, str_temp);
                        }
                        //
                        use_instr->s = T_Phi(use_instr->s->u.PHI.dst, new_labelList, new_tempList);
                    }
                }
            }
        }
    }
}
AS_block2List cc_propagation(AS_block2List bl, Temp_tempList argvs) {
    unordered_map<T_ir, AS_block2> find_block;
    unordered_map<AS_block2, pair<bool, int>> block_state;
    unordered_map<Temp_temp, work_var> var_state;
    unordered_map<Temp_label, AS_block2> label_block;
    unordered_map<Temp_label, vector<pair<Temp_label, bool>>> succ_Graph;
    // 工作表
    unordered_set<Temp_temp> wt_var;
    unordered_set<AS_block2> wt_block;
    for (list<AS_block2>::iterator tl = bl->blist.begin(); tl != bl->blist.end(); ++tl) {
        label_block[(*tl)->label] = *tl;
        block_state[*tl].first = false;
        block_state[*tl].second = 0;
        Temp_labelList succ = (*tl)->succs;
        for (; succ; succ = succ->tail) {
            succ_Graph[(*tl)->label].push_back({succ->head, false});
        }
        // (2)
        if (tl == bl->blist.begin()) {
            block_state[*tl].first = true;
            block_state[*tl].second = 1;
            wt_block.insert(*tl);
        }
        AS_instr2List instrsList = (*tl)->instrs;
        for (list<T_ir>::iterator il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
            find_block[*il] = *tl;
            T_ir instr = (*il);
            Temp_tempList defs, uses;
            defs = get_defs(instr);
            uses = get_uses(instr);
            for (Temp_tempList temp_l = defs; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (var_state.count(temp)) {
                    // 只能def一次
                    var_state[temp]->def = il;
                } else {
                    var_state[temp] = new struct work_var_();
                    var_state[temp]->temp = temp;
                    var_state[temp]->def = il;
                }
                var_state[temp]->kind = work_var_::UNDEF;
            }
            for (Temp_tempList temp_l = uses; temp_l; temp_l = temp_l->tail) {
                Temp_temp temp = temp_l->head;
                if (var_state.count(temp)) {
                    var_state[temp]->use.push_back(instr);
                } else {
                    var_state[temp] = new struct work_var_();
                    var_state[temp]->temp = temp;
                    var_state[temp]->use.push_back(instr);
                    // (1)
                    var_state[temp]->kind = work_var_::NAC;
                }
            }
        }
    }
    // 参数全是NAC
    for (auto it = argvs; it; it = it->tail) {
        var_state[it->head]->kind = work_var_::NAC;
    }
    // 开始分析
    while (!(wt_block.empty() && wt_var.empty())) {
        // 优先从block中选择
        // block表中的block都是可执行的
        if (!wt_block.empty()) {
            auto it = wt_block.begin();
            AS_block2 block = *it;
            wt_block.erase(it);
            // printf("1 block %s\n", S_name(block->label));
            bool isBadd = false;
            // (3)
            int x = 0;
            for (Temp_labelList tl = block->succs; tl; tl = tl->tail) {
                if (tl->head) {
                    x++;
                }
            }
            if (x == 1) {
                isBadd = TRUE;
            }
            if (isBadd) {
                Temp_label label = block->succs->head;
                AS_block2 succ_block = label_block[label];
                if (block_state[block].second == 1) {
                    if (wt_block.find(succ_block) == wt_block.end()) {
                        wt_block.insert(succ_block);
                        block_state[succ_block].second++;
                    }
                    block_state[succ_block].first = true;
                    succ_Graph[block->label][0].second = true;
                }
            }

            AS_instr2List instrsList = block->instrs;
            for (list<T_ir>::iterator il = instrsList->ilist.begin(); il != instrsList->ilist.end(); ++il) {
                T_ir instr = (*il);
                //  AS_print_llvm(stdout,instr->i,Temp_name());
                switch (instr->i->kind) {
                    case AS_instr_::I_OPER:
                        break;
                    case AS_instr_::I_LABEL:
                        continue;
                    case AS_instr_::I_MOVE:
                        break;
                }
                // (4)(5)
                if (is_operation(instr)) {
                    op_compute(instr, var_state, wt_var);
                }
                // (6)(8)(9)
                else if (instr->s->kind == llvm_T_stm_::T_PHI) {
                    phi_compute(instr, find_block, var_state, wt_var, label_block, block_state, true, succ_Graph);
                }
                // (7)
                else if (is_load(instr) || is_re_call(instr)) {
                    mc_compute(instr, var_state, wt_var);
                }
                // (10)(11)
                else if (instr->s->kind == llvm_T_stm_::T_CJUMP) {
                    cjump_compute(instr, var_state, wt_block, label_block, block_state, find_block, block_state[block].second == 1, succ_Graph);
                }
            }
        } else if (!wt_var.empty()) {
            auto it = wt_var.begin();
            Temp_temp temp = *it;
            wt_var.erase(it);
            // printf("2 temp %d\n", temp->num);
            work_var temp_var = var_state[temp];
            for (list<T_ir>::iterator il = temp_var->use.begin(); il != temp_var->use.end(); ++il) {
                T_ir instr = (*il);
                switch (instr->i->kind) {
                    case AS_instr_::I_OPER:
                        break;
                    case AS_instr_::I_LABEL:
                        continue;
                    case AS_instr_::I_MOVE:
                        break;
                }

                AS_block2 block = find_block[instr];
                bool isExec = block_state[block].first;
                if (isExec) {
                    // (4)(5)
                    if (is_operation(instr)) {
                        op_compute(instr, var_state, wt_var);
                        // block是可执行的，但分支不一定是可执行的
                        cjump_fix(instr, var_state, wt_block, label_block, block_state, find_block, succ_Graph);
                    }
                    // (6)(8) (9)true
                    else if (instr->s->kind == llvm_T_stm_::T_PHI) {
                        phi_compute(instr, find_block, var_state, wt_var, label_block, block_state, isExec, succ_Graph);
                    }
                    // (7)
                    else if (is_load(instr) || is_re_call(instr)) {
                        mc_compute(instr, var_state, wt_var);
                    }
                    // (10)(11)
                    else if (instr->s->kind == llvm_T_stm_::T_CJUMP) {
                        cjump_compute(instr, var_state, wt_block, label_block, block_state, find_block, false, succ_Graph);
                    }
                } else {
                    // (9) false
                    // 理论上不会影响结果，只是让速度变慢；也有可能不加会导致无法到达最小点——因为是从0开始增加，而不是删除
                    if (instr->s->kind == llvm_T_stm_::T_PHI) {
                        phi_compute(instr, find_block, var_state, wt_var, label_block, block_state, isExec, succ_Graph);
                    }
                }
            }
        } else {
            assert(0);
        }
    }
    // for (auto it = block_state.begin(); it != block_state.end(); ++it) {
    //     printf("block :%s  %d\n", S_name(it->first->label), it->second.first);
    // }
    // for (auto it = var_state.begin(); it != var_state.end(); ++it) {
    //     printf("temp :%d  %d\n", it->first->num, it->second->kind);
    // }
    delete_var(bl, find_block, var_state, label_block);
    delete_block(bl, block_state, label_block);
    return bl;
}
AS_block2 block_2_block2(LLVM_IR::llvm_AS_block b) {
    auto b_ = new AS_block2_();
    b_->label = b->label;
    b_->succs = b->succs;
    AS_instr2List instr2List = new AS_instr2List_();
    for (auto il = b->irs; il != nullptr; il = il->tail) {
        instr2List->ilist.push_back(il->head);
    }
    b_->instrs = instr2List;
    return b_;
}