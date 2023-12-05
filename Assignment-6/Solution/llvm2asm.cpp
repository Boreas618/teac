#include "llvm_ir.h"
#include "asm_arm.h"
#include "temp.h"
#include "llvm2asm.h"

#include <iostream>
#include <queue>
#include <cassert>

using namespace std;
using namespace LLVMIR;
using namespace ASM;

// 结构体体里只有整型
// 只有结构体数组
static int stack_frame;
// spOffset Map is used for record the specific pair, this pair map the reg in llvm ir to the location of stack frame
// Note: the offset is only for reg_sp
// e.g., the reg in llvm ir has no limitation, in this lab all data has been stored in the stack frame
// as it to say, we do not use libc::malloc to get the heap chuck
// thus
// + sp + offset
static unordered_map<int, int> spOffsetMap;
static unordered_map<int, AS_relopkind> condMap;
static unordered_map<string, int> structLayout;

static priority_queue<int> regSet;

// x4~x20 is supplied to users
void regSegInit() {
    for (int i = 9; i<=15; i++) {
        regSet.emplace(i);
    }
    for (int i = 19; i<=28; i++) {
        regSet.emplace(i);
    }
}

void structLayoutInit(vector<L_def*> &defs) {
    for (const auto &def : defs) {
        switch (def->kind) {
            case L_DefKind::SRT: {
                auto name = def->u.SRT->name;
                int member_len = def->u.SRT->members.size();
                cout<<member_len<<endl;
                structLayout.emplace(name, member_len);
            }
            case L_DefKind::GLOBAL: {
                break;
            }
            case L_DefKind::FUNC: {
                break;
            }
        }
    }
}

void set_stack(L_func &func) {
    stack_frame = 0;

    for (const auto &block : func.blocks) {
        for (const auto &stm : block->instrs) {
            if (stm->type == L_StmKind::T_ALLOCA) {
                int reg = stm->u.ALLOCA->dst->u.TEMP->num;
                spOffsetMap.emplace(reg, stack_frame);
                if (stm->u.ALLOCA->dst->u.TEMP->len == 0) {
                    stack_frame += 4;
                } else {
                    stack_frame += 4 * stm->u.ALLOCA->dst->u.TEMP->len;
                }
            }
        }
    }

    if (stack_frame % 16 != 0) {
        stack_frame = (stack_frame / 16 + 1) * 16;
    }

    for (const auto &block : func.blocks) {
        for (const auto &stm : block->instrs) {
            if (stm->type == L_StmKind::T_ALLOCA) {
                int reg = stm->u.ALLOCA->dst->u.TEMP->num;
                int final_offset = stack_frame - spOffsetMap.at(reg);
                spOffsetMap.erase(reg);
                spOffsetMap.emplace(reg, final_offset);
//                cout << "reg " << reg << " " << final_offset <<"\n";
            }
        }
    }

}

void new_frame(list<AS_stm*> &as_list) {
    AS_reg* left = new AS_reg(-1, -1);
    AS_reg* right = new AS_reg(-3, stack_frame);
    AS_reg* dst = new AS_reg(-1, -1);

    as_list.push_back(AS_Binop(AS_binopkind::SUB_, left, right, dst));
}

void free_frame(list<AS_stm*> &as_list) {
    AS_reg* left = new AS_reg(-1, -1);
    AS_reg* right = new AS_reg(-3, stack_frame);
    AS_reg* dst = new AS_reg(-1, -1);

    as_list.push_back(AS_Binop(AS_binopkind::ADD_, left, right, dst));
}

// left/right in binop can be reg: %r / instant #0 (add/sub only)
// for mul/sdiv, you need to move instant into x2 (left), x3 (right)
// dst in load can be only reg: %r
void llvm2asmBinop(list<AS_stm*> &as_list, L_stm* binop_stm) {
    AS_reg* left;
    AS_reg* right;
    AS_reg* dst;
    AS_binopkind op;

    switch (binop_stm->u.BINOP->op) {
        case L_binopKind::T_plus: {
            op = AS_binopkind::ADD_;
            switch (binop_stm->u.BINOP->left->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->left->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(2, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    left = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->left->u.TEMP->num;
                    left = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            switch (binop_stm->u.BINOP->right->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->right->u.ICONST;
                    right = new AS_reg(-3, instant);
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->right->u.TEMP->num;
                    right = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            break;
        }
        case L_binopKind::T_minus: {
            op = AS_binopkind::SUB_;

            switch (binop_stm->u.BINOP->left->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->left->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(2, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    left = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->left->u.TEMP->num;
                    left = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            switch (binop_stm->u.BINOP->right->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->right->u.ICONST;
                    right = new AS_reg(-3, instant);
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->right->u.TEMP->num;
                    right = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            break;
        }
        case L_binopKind::T_mul: {
            op = AS_binopkind::MUL_;

            switch (binop_stm->u.BINOP->left->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->left->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(2, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    left = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->left->u.TEMP->num;
                    left = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            switch (binop_stm->u.BINOP->right->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->right->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(3, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    right = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->right->u.TEMP->num;
                    right = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            break;
        }
        case L_binopKind::T_div: {
            op = AS_binopkind::SDIV_;

            switch (binop_stm->u.BINOP->left->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->left->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(2, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    left = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->left->u.TEMP->num;
                    left = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }

            switch (binop_stm->u.BINOP->right->kind) {
                case OperandKind::ICONST: {
                    // store from the const: str #1, ...
                    int instant = binop_stm->u.BINOP->right->u.ICONST;
                    AS_reg* src_mov = new AS_reg(-3, instant);
                    AS_reg* dst_mov = new AS_reg(3, 0);
                    as_list.push_back(AS_Mov(src_mov, dst_mov));
                    right = dst_mov;
                    break;
                }
                case OperandKind::TEMP: {
                    // store from the reg: str x, ...
                    int src_num = binop_stm->u.BINOP->right->u.TEMP->num;
                    right = new AS_reg(src_num, 0);
                    break;
                }
                case OperandKind::NAME: {
                    assert(0);
                }
            }
            break;
        }
    }

    int dst_num = binop_stm->u.BINOP->dst->u.TEMP->num;
    dst = new AS_reg(dst_num, 0);

    as_list.push_back(AS_Binop(op, left, right, dst));

}

// src in load can be reg: %r / global @a
// dst in load can be only reg: %r
void llvm2asmLoad(list<AS_stm*> &as_list, L_stm* load_stm) {
    AS_reg* src;
    AS_reg* dst;

    switch (load_stm->u.LOAD->ptr->kind) {
        case OperandKind::ICONST: {
            assert(0);
        }
        case OperandKind::TEMP: {
            // load from the stack frame
            if (spOffsetMap.find(load_stm->u.LOAD->ptr->u.TEMP->num) != spOffsetMap.end() ) {
                // load from the stack frame, which is from alloc: ldr ..., [sp, #n]
                int offset = spOffsetMap.at(load_stm->u.LOAD->ptr->u.TEMP->num);
                src = new AS_reg(-1, offset);
            } else {
                // load from the reg directly: ldr ..., w
                int src_num = load_stm->u.LOAD->ptr->u.TEMP->num;
                src = new AS_reg(src_num, -1);
            }
            break;
        }
        case OperandKind::NAME: {
            // load from the global: adrp NAME; ldr x21,
            auto label = new AS_label(load_stm->u.LOAD->ptr->u.NAME->name->name);
            src = new AS_reg(3, 0);
            as_list.push_back(AS_Adrp(label, src));
            break;
        }
    }

    int dst_num = load_stm->u.LOAD->dst->u.TEMP->num;
    dst = new AS_reg(dst_num, 0);

    as_list.push_back(AS_Ldr(dst, src));
}

// the src in store can be reg: %r
// for ldr, you need to move instant into x2
// the dst in store can be reg: %r / global @a
void llvm2asmStore(list<AS_stm*> &as_list, L_stm* store_stm) {
    AS_reg* src;
    AS_reg* dst;

    switch (store_stm->u.STORE->src->kind) {
        case OperandKind::ICONST: {
            // store from the const: str #1, ...
            int instant = store_stm->u.STORE->src->u.ICONST;
            AS_reg* src_mov = new AS_reg(-3, instant);
            AS_reg* dst_mov = new AS_reg(2, 0);
            as_list.push_back(AS_Mov(src_mov, dst_mov));
            src = dst_mov;
            break;
        }
        case OperandKind::TEMP: {
            // store from the reg: str x, ...
            int src_num = store_stm->u.STORE->src->u.TEMP->num;
            src = new AS_reg(src_num, 0);
            break;
        }
        case OperandKind::NAME: {
            assert(0);
        }
    }

    switch (store_stm->u.STORE->ptr->kind) {
        case OperandKind::ICONST: {
            assert(0);
        }
        case OperandKind::TEMP: {
            // store to the stack frame
            if (spOffsetMap.find(store_stm->u.STORE->ptr->u.TEMP->num) != spOffsetMap.end() ) {
                // store to the stack frame, which is from alloc: str ...,[sp, #n]
                int offset = spOffsetMap.at(store_stm->u.STORE->ptr->u.TEMP->num);
                dst = new AS_reg(-1, offset);
            } else {
                // store to the reg directly: ldr ..., w
                int dst_num = store_stm->u.STORE->ptr->u.TEMP->num;
                dst = new AS_reg(dst_num, -1);
            }
            break;
        }
        case OperandKind::NAME: {
            auto label = new AS_label(store_stm->u.STORE->ptr->u.NAME->name->name);
            AS_reg* dst_adrp = new AS_reg(3, 0);
            dst = new AS_reg(3, -1);
            as_list.push_back(AS_Adrp(label, dst_adrp));
            break;
        }
    }

    as_list.push_back(AS_Str(dst, src));
}

// src in load can be reg: %r / global @a
// dst in load can be only reg: %r
void llvm2asmCmp(list<AS_stm*> &as_list, L_stm* cmp_stm) {
    AS_reg* left;
    AS_reg* right;

    int dst_num = cmp_stm->u.CMP->dst->u.TEMP->num;

    switch (cmp_stm->u.CMP->op) {
        case L_relopKind::T_eq: {
            condMap.emplace(dst_num, AS_relopkind::EQ_);
        }
        case L_relopKind::T_ne: {
            condMap.emplace(dst_num, AS_relopkind::NE_);
        }
        case L_relopKind::T_lt: {
            condMap.emplace(dst_num, AS_relopkind::LT_);
        }
        case L_relopKind::T_gt: {
            condMap.emplace(dst_num, AS_relopkind::GT_);
        }
        case L_relopKind::T_le: {
            condMap.emplace(dst_num, AS_relopkind::LE_);
        }
        case L_relopKind::T_ge: {
            condMap.emplace(dst_num, AS_relopkind::GE_);
        }
    }

    switch (cmp_stm->u.CMP->left->kind) {
        case OperandKind::ICONST: {
            // store from the const: str #1, ...
            int instant = cmp_stm->u.CMP->left->u.ICONST;
            AS_reg* src_mov = new AS_reg(-3, instant);
            AS_reg* dst_mov = new AS_reg(2, 0);
            as_list.push_back(AS_Mov(src_mov, dst_mov));
            left = dst_mov;
            break;
        }
        case OperandKind::TEMP: {
            // store from the reg: str x, ...
            int src_num = cmp_stm->u.CMP->left->u.TEMP->num;
            left = new AS_reg(src_num, 0);
            break;
        }
        case OperandKind::NAME: {
            assert(0);
        }
    }

    switch (cmp_stm->u.CMP->right->kind) {
        case OperandKind::ICONST: {
            // store from the const: str #1, ...
            int instant = cmp_stm->u.CMP->right->u.ICONST;
            right = new AS_reg(-3, instant);
            break;
        }
        case OperandKind::TEMP: {
            // store from the reg: str x, ...
            int src_num = cmp_stm->u.CMP->right->u.TEMP->num;
            right = new AS_reg(src_num, 0);
            break;
        }
        case OperandKind::NAME: {
            assert(0);
        }
    }

    as_list.push_back(AS_Cmp(left, right));
}

// src in load can be reg: %r / global @a
// dst in load can be only reg: %r
void llvm2asmCJmp(list<AS_stm*> &as_list, L_stm* cjmp_stm) {
    int reg_num = cjmp_stm->u.CJUMP->dst->u.TEMP->num;
    AS_relopkind op = condMap.at(reg_num);
    auto true_label = new AS_label(cjmp_stm->u.CJUMP->true_label->name);
    auto false_label = new AS_label(cjmp_stm->u.CJUMP->false_label->name);
    as_list.push_back(AS_BCond(op, true_label));
    as_list.push_back(AS_B(false_label));
}

void llvm2asmCall(list<AS_stm*> &as_list, L_stm* call_stm) {
    auto args = call_stm->u.CALL->args;

    for (int i = 0; i < args.size(); i++) {
        AS_reg* src;
        AS_reg* dst = new AS_reg(i, 0);

        switch (args[i]->kind) {
            case OperandKind::ICONST: {
                // store from the const: str #1, ...
                int instant = args[i]->u.ICONST;
                src = new AS_reg(-3, instant);
                break;
            }
            case OperandKind::TEMP: {
                // store from the reg: str x, ...
                int src_num = args[i]->u.TEMP->num;
                src = new AS_reg(src_num, 0);
                break;
            }
            case OperandKind::NAME: {
                assert(0);
            }
        }
        as_list.push_back(AS_Mov(src, dst));
    }

    auto label =  new AS_label(call_stm->u.CALL->fun);
    as_list.push_back(AS_Bl(label));
}

void llvm2asmVoidCall(list<AS_stm*> &as_list, L_stm* call_stm) {
    auto args = call_stm->u.VOID_CALL->args;

    for (int i = 0; i < args.size(); i++) {
        AS_reg* src;
        AS_reg* dst = new AS_reg(i, 0);

        switch (args[i]->kind) {
            case OperandKind::ICONST: {
                // store from the const: str #1, ...
                int instant = args[i]->u.ICONST;
                src = new AS_reg(-3, instant);
                break;
            }
            case OperandKind::TEMP: {
                // store from the reg: str x, ...
                int src_num = args[i]->u.TEMP->num;
                src = new AS_reg(src_num, 0);
                break;
            }
            case OperandKind::NAME: {
                // Fixme mov global call void (@)
                cout << args[i]->u.NAME->structname << "\n";
                return;
                assert(0);
            }
        }
        as_list.push_back(AS_Mov(src, dst));
    }

    auto label =  new AS_label(call_stm->u.VOID_CALL->fun);
    as_list.push_back(AS_Bl(label));
}

void llvm2asmRet(list<AS_stm*> &as_list, L_stm* ret_stm) {

    if (ret_stm->u.RET->ret != nullptr) {
        AS_reg* src_mov;
        AS_reg* dst_mov = new AS_reg(0, 0);
        switch (ret_stm->u.RET->ret->kind) {
            case OperandKind::ICONST: {
                // store from the const: str #1, ...
                int instant = ret_stm->u.RET->ret->u.ICONST;
                src_mov = new AS_reg(-3, instant);
                break;
            }
            case OperandKind::TEMP: {
                // store from the reg: str x, ...
                int src_num = ret_stm->u.RET->ret->u.TEMP->num;
                src_mov = new AS_reg(src_num, 0);
                break;
            }
            case OperandKind::NAME: {
                assert(0);
            }
        }
        as_list.push_back(AS_Mov(src_mov, dst_mov));
    }

    as_list.push_back(AS_Ret());
}

void llvm2asmGep(list<AS_stm*> &as_list, L_stm* gep_stm) {
    int array_index = 0;
    int array_base = 0;
    int field_index = 0;
    int field_base = 0;

    switch (gep_stm->u.GEP->base_ptr->kind) {
        case OperandKind::TEMP: {
            switch (gep_stm->u.GEP->base_ptr->u.TEMP->type) {
                case TempType::INT_PTR: {
                    array_base = 4;
                    array_index = gep_stm->u.GEP->index->u.ICONST;
//                    if(gep_stm->u.GEP->base_ptr->u.TEMP->len == -1 || gep_stm->u.GEP->base_ptr->u.TEMP->len == 0) {
//                        array_base = 4;
//                        array_index = gep_stm->u.GEP->index->u.ICONST;
//                    } else {
//
//                    }
                    break;
                }
                case TempType::STRUCT_PTR: {
                    if (gep_stm->u.GEP->base_ptr->u.TEMP->len == 0 ) {
                        field_index = gep_stm->u.GEP->index->u.ICONST;
                        field_base = 4;
                    } else if (gep_stm->u.GEP->base_ptr->u.TEMP->len != -1) {
                        array_index = gep_stm->u.GEP->index->u.ICONST;
                        array_base = structLayout.at(gep_stm->u.GEP->base_ptr->u.TEMP->structname) * 4;
                    } else {
                        assert(0);
                    }
                    break;
                }
                case TempType::INT_TEMP: {
                    assert(0);
                }
                case TempType::STRUCT_TEMP: {
                    assert(0);
                }
            }

            // store to the stack frame
            if (spOffsetMap.find(gep_stm->u.GEP->base_ptr->u.TEMP->num) != spOffsetMap.end() ) {
                // store to the stack frame, which is from alloc: str ...,[sp, #n]
                int offset = spOffsetMap.at(gep_stm->u.GEP->base_ptr->u.TEMP->num);
                offset += array_base * array_index + field_base * field_index;
                spOffsetMap.emplace(gep_stm->u.GEP->new_ptr->u.TEMP->num, offset);
            } else {
                // store to the reg directly: ldr ..., w
                int offset = array_base * array_index + field_base * field_index;
                AS_reg* src_mov = new AS_reg(gep_stm->u.GEP->base_ptr->u.TEMP->num, 0);
                AS_reg* dst_mov = new AS_reg(gep_stm->u.GEP->new_ptr->u.TEMP->num, 0);
                as_list.push_back(AS_Mov(src_mov, dst_mov));
                AS_reg* instant = new AS_reg(-3, offset);
                as_list.push_back(AS_Binop(AS_binopkind::ADD_, dst_mov, instant, dst_mov));
            }

            break;
        }
        case OperandKind::NAME: {
            switch (gep_stm->u.GEP->base_ptr->u.NAME->type) {
                case TempType::INT_PTR: {
                    array_base = 4;
                    array_index = gep_stm->u.GEP->index->u.ICONST;
                    break;
                }
                case TempType::STRUCT_PTR: {
                    if (gep_stm->u.GEP->base_ptr->u.NAME->len == 0 ) {
                        field_index = gep_stm->u.GEP->index->u.ICONST;
                        field_base = 4;
                    } else if (gep_stm->u.GEP->base_ptr->u.NAME->len != -1) {
                        array_index = gep_stm->u.GEP->index->u.ICONST;
                        array_base = structLayout.at(gep_stm->u.GEP->base_ptr->u.NAME->structname) * 4;
                    } else {
                        assert(0);
                    }
                    break;
                }
                case TempType::STRUCT_TEMP: {
                    break;
                }
                case TempType::INT_TEMP: {
                    assert(0);
                }
            }

            auto label = new AS_label(gep_stm->u.GEP->base_ptr->u.NAME->name->name);
            AS_reg* mov_src = new AS_reg(3, 0);
            as_list.push_back(AS_Adrp(label, mov_src));

            int offset = array_base * array_index + field_base * field_index;
            AS_reg* instant = new AS_reg(-3, offset);
            as_list.push_back(AS_Binop(AS_binopkind::ADD_, mov_src, instant, mov_src));

            AS_reg* mov_dst = new AS_reg(gep_stm->u.GEP->new_ptr->u.TEMP->num, 0);
            as_list.push_back(AS_Mov(mov_src, mov_dst));
            break;
        }
        case OperandKind::ICONST: {
            assert(0);
        }
    }
}

void llvm2asmStm(list<AS_stm*> &as_list, L_stm &stm) {
    switch (stm.type) {
        case L_StmKind::T_BINOP: {
            llvm2asmBinop(as_list, &stm);
            break;
        }
        case L_StmKind::T_LOAD: {
            llvm2asmLoad(as_list, &stm);
            break;
        }
        case L_StmKind::T_STORE: {
            llvm2asmStore(as_list, &stm);
            break;
        }
        case L_StmKind::T_LABEL: {
            auto label = new AS_label(stm.u.LABEL->label->name);
            as_list.push_back(AS_Label(label));
            break;
        }
        case L_StmKind::T_JUMP: {
            auto label = new AS_label(stm.u.JUMP->jump->name);
            as_list.push_back(AS_B(label));
            break;
        }
        case L_StmKind::T_CMP: {
            llvm2asmCmp(as_list, &stm);
            break;
        }
        case L_StmKind::T_CJUMP: {
            llvm2asmCJmp(as_list, &stm);
            break;
        }
        case L_StmKind::T_MOVE: {
            // Do nothing
            break;
        }
        case L_StmKind::T_CALL: {
            llvm2asmCall(as_list, &stm);
            break;
        }
        case L_StmKind::T_VOID_CALL: {
            llvm2asmVoidCall(as_list, &stm);
            break;
        }
        case L_StmKind::T_RETURN: {
            llvm2asmRet(as_list, &stm);
            break;
        }
        case L_StmKind::T_ALLOCA: {
            // Do nothing
            break;
        }
        case L_StmKind::T_GEP: {
            llvm2asmGep(as_list, &stm);
            break;
        }
        case L_StmKind::T_PHI: {
            // Do nothing
            break;
        }
        case L_StmKind::T_NULL: {
            // Do nothing
            break;
        }
    }
}

AS_func* llvm2asmFunc(L_func &func) {
    list<AS_stm*> stms;

    auto p = new AS_func(stms);
    auto func_label = new AS_label(func.name);
    p->stms.push_back(AS_Label(func_label));

    for(const auto &block : func.blocks) {
        for (const auto &instr : block->instrs) {
            llvm2asmStm(p->stms, *instr);
        }
    }

    return p;
}

void llvm2asmGlobal(vector<AS_global*> &globals, L_def &def) {
    switch (def.kind) {
        case L_DefKind::GLOBAL: {
            switch (def.u.GLOBAL->def.kind) {
                case TempType::INT_TEMP: {
                    AS_label* label = new AS_label(def.u.GLOBAL->name);
                    int init;
                    if(def.u.GLOBAL->init.size() == 1) {
                        init = def.u.GLOBAL->init[0];
                    } else {
                        init = 0;
                    }
                    auto global = new AS_global(label, init, 1);
                    globals.push_back(global);
                    break;
                }
                case TempType::INT_PTR: {
                    AS_label* label = new AS_label(def.u.GLOBAL->name);
                    auto global = new AS_global(label, 0, def.u.GLOBAL->def.len);
                    globals.push_back(global);
                    break;
                }
                case TempType::STRUCT_TEMP: {
                    AS_label* label = new AS_label(def.u.GLOBAL->name);
                    int struct_len = structLayout.at(def.u.GLOBAL->def.structname);
                    auto global = new AS_global(label, 0, struct_len);
                    globals.push_back(global);
                    break;
                }
                case TempType::STRUCT_PTR: {
                    AS_label* label = new AS_label(def.u.GLOBAL->name);
                    int struct_len = structLayout.at(def.u.GLOBAL->def.structname);
                    int sum_len = def.u.GLOBAL->def.len * struct_len;
                    auto global = new AS_global(label, 0, sum_len);
                    globals.push_back(global);
                    break;
                }
            }
            break;
        }
        case L_DefKind::FUNC: {
            return;
        }
        case L_DefKind::SRT: {
            return;
        }
    }
}

AS_prog* llvm2asm(L_prog &prog) {
    regSegInit();

    std::vector<AS_global*> globals;
    std::vector<AS_func*> func_list;

    auto as_prog = new AS_prog(globals, func_list);

    structLayoutInit(prog.defs);
    for(const auto &def : prog.defs) {
        llvm2asmGlobal(as_prog->globals, *def);
    }

    for(const auto &func : prog.funcs) {
        set_stack(*func);
        as_prog->funcs.push_back(llvm2asmFunc(*func));
    }

    return as_prog;
}
