#include "ssa.h"
#include <cassert>
#include <list>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using namespace std;
using namespace LLVMIR;

LLVMIR::L_prog* SSA(LLVMIR::L_prog* prog) {
    prog = combine_addr(prog);
    prog = mem2reg(prog);
    return prog;
}

static bool is_mem_variable(L_stm* stm) {
    return stm->type == L_StmKind::T_ALLOCA && stm->u.ALLOCA->dst->kind == OperandKind::TEMP && stm->u.ALLOCA->dst->u.TEMP->type == TempType::INT_PTR && stm->u.ALLOCA->dst->u.TEMP->len == 0;
}

static list<AS_operand**> get_all_AS_operand(L_stm* stm) {
    list<AS_operand**> AS_operand_list;
    switch (stm->type) {
        case L_StmKind::T_BINOP: {
            AS_operand_list.push_back(&(stm->u.BINOP->left));
            AS_operand_list.push_back(&(stm->u.BINOP->right));
            AS_operand_list.push_back(&(stm->u.BINOP->dst));

        } break;
        case L_StmKind::T_LOAD: {
            AS_operand_list.push_back(&(stm->u.LOAD->dst));
            AS_operand_list.push_back(&(stm->u.LOAD->ptr));
        } break;
        case L_StmKind::T_STORE: {
            AS_operand_list.push_back(&(stm->u.STORE->src));
            AS_operand_list.push_back(&(stm->u.STORE->ptr));
        } break;
        case L_StmKind::T_LABEL: {
        } break;
        case L_StmKind::T_JUMP: {
        } break;
        case L_StmKind::T_CJUMP: {
            AS_operand_list.push_back(&(stm->u.CJUMP->dst));
        } break;
        case L_StmKind::T_MOVE: {
            AS_operand_list.push_back(&(stm->u.MOVE->src));
            AS_operand_list.push_back(&(stm->u.MOVE->dst));
        } break;
        case L_StmKind::T_CALL: {
            AS_operand_list.push_back(&(stm->u.CALL->res));
            for (auto& arg : stm->u.CALL->args) {
                AS_operand_list.push_back(&arg);
            }
        } break;
        case L_StmKind::T_VOID_CALL: {
            for (auto& arg : stm->u.VOID_CALL->args) {
                AS_operand_list.push_back(&arg);
            }
        } break;
        case L_StmKind::T_RETURN: {
            AS_operand_list.push_back(&(stm->u.RET->ret));
        } break;
        case L_StmKind::T_PHI: {
            AS_operand_list.push_back(&(stm->u.PHI->dst));
            for (auto& phi : stm->u.PHI->phis) {
                AS_operand_list.push_back(&(phi.first));
            }
        } break;
        case L_StmKind::T_ALLOCA: {
            AS_operand_list.push_back(&(stm->u.ALLOCA->dst));
        } break;
        case L_StmKind::T_GEP: {
            AS_operand_list.push_back(&(stm->u.GEP->new_ptr));
            AS_operand_list.push_back(&(stm->u.GEP->base_ptr));
            AS_operand_list.push_back(&(stm->u.GEP->index));
        } break;
        default:
            assert(0);
    }
    return AS_operand_list;
}

LLVMIR::L_prog* combine_addr(LLVMIR::L_prog* prog) {
    for (const auto& fun : prog->funcs) {
        unordered_map<Temp_temp*, unordered_set<AS_operand**>> temp_set;
        unordered_map<Name_name*, unordered_set<AS_operand**>> name_set;
        for (auto& block : fun->blocks) {
            for (auto& stm : block->instrs) {
                auto AS_operand_list=get_all_AS_operand(stm);
                for(auto AS_op:AS_operand_list){
                    if((*AS_op)->kind==OperandKind::TEMP){
                        temp_set[(*AS_op)->u.TEMP].insert(AS_op);
                    }
                    else if((*AS_op)->kind==OperandKind::NAME){
                        name_set[(*AS_op)->u.NAME].insert(AS_op);
                    }
                }
            }
        }
        for(auto temp:temp_set){
            AS_operand* fi_AS_op=**temp.second.begin();
            for(auto AS_op:temp.second){
                *AS_op=fi_AS_op;
            }
        }
        for(auto name:name_set){
            AS_operand* fi_AS_op=**name.second.begin();
            for(auto AS_op:name.second){
                *AS_op=fi_AS_op;
            }
        }
    }
    return prog;
}

LLVMIR::L_prog* mem2reg(LLVMIR::L_prog* prog) {
    for (const auto& fun : prog->funcs) {
        if (fun->blocks.empty())
            continue;
        // 找到所有的alloca标量
        unordered_map<AS_operand*, AS_operand*> variables;
        auto fi_block = fun->blocks.front();
        for (auto stm = fi_block->instrs.begin(); stm != fi_block->instrs.end();) {
            if (is_mem_variable(*stm)) {
                variables.insert({(*stm)->u.ALLOCA->dst, AS_Operand_Temp(Temp_newtemp_int())});
                stm = fi_block->instrs.erase(stm);
            } else {
                ++stm;
            }
        }
        // 删除冗余load和store
        unordered_map<AS_operand*, AS_operand*> alias_var;
        for (auto& block : fun->blocks) {
            for (auto stm = block->instrs.begin(); stm != block->instrs.end();) {
                if ((*stm)->type == L_StmKind::T_STORE && (*stm)->u.STORE->ptr->kind == OperandKind::TEMP && (*stm)->u.STORE->ptr->u.TEMP->type == TempType::INT_PTR && (*stm)->u.STORE->ptr->u.TEMP->len == 0) {
                    assert(variables.find((*stm)->u.STORE->ptr) != variables.end());
                    alias_var.insert({(*stm)->u.STORE->src, variables[(*stm)->u.STORE->ptr]});
                    stm = block->instrs.erase(stm);
                } else if ((*stm)->type == L_StmKind::T_LOAD && (*stm)->u.LOAD->ptr->kind == OperandKind::TEMP && (*stm)->u.LOAD->ptr->u.TEMP->type == TempType::INT_PTR && (*stm)->u.LOAD->ptr->u.TEMP->len == 0) {
                    assert(variables.find((*stm)->u.LOAD->ptr) != variables.end());
                    alias_var.insert({(*stm)->u.LOAD->dst, variables[(*stm)->u.LOAD->dst]});
                    stm = block->instrs.erase(stm);
                } else {
                    ++stm;
                }
            }
        }
        // 替换所有的别名
        for (auto& block : fun->blocks) {
            for (auto& stm : block->instrs) {
            }
        }
    }
    return prog;
}