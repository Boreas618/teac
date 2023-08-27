#include <vector>
#include <unordered_map>
#include "data_chain.h"

using namespace std;

std::unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> datachain::get_du_chain(AS_block2List bl)
{
    unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> du_chain;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->i->kind == AS_instr_::I_OPER)
            {
                // for(auto tl = ins->i->u.OPER.dst;tl != nullptr;tl = tl->tail)
                // {
                //     auto t = tl->head;
                //     if(t->kind == AS_operand_::T_TEMP)
                //     {
                //         //du_chain.emplace(t->u.TEMP,vector<LLVM_IR::T_ir>());
                //     }
                // }
                for(auto tl = ins->i->u.OPER.src;tl != nullptr;tl = tl->tail)
                {
                    auto t = tl->head;
                    if(t->kind == AS_operand_::T_TEMP)
                    {
                        du_chain[t->u.TEMP].push_back(ins);
                    }
                }
            }
            else if(ins->i->kind == AS_instr_::I_MOVE)
            {
                // for(auto tl = ins->i->u.MOVE.dst;tl != nullptr;tl = tl->tail)
                // {
                //     auto t = tl->head;
                //     if(t->kind == AS_operand_::T_TEMP)
                //     {
                //         du_chain.emplace(t->u.TEMP,vector<LLVM_IR::T_ir>());
                //     }
                // }
                for(auto tl = ins->i->u.MOVE.src;tl != nullptr;tl = tl->tail)
                {
                    auto t = tl->head;
                    if(t->kind == AS_operand_::T_TEMP)
                    {
                        du_chain[t->u.TEMP].push_back(ins);
                    }
                }
            }
        }
    }
    return du_chain;
}

std::unordered_map<Temp_temp,LLVM_IR::T_ir> datachain::get_ud_chain(AS_block2List bl)
{
    unordered_map<Temp_temp,LLVM_IR::T_ir> ud_chain;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->i->kind == AS_instr_::I_OPER)
            {
                for(auto tl = ins->i->u.OPER.dst;tl != nullptr;tl = tl->tail)
                {
                    auto t = tl->head;
                    if(t->kind == AS_operand_::T_TEMP)
                    {
                        ud_chain.emplace(t->u.TEMP,ins);
                    }
                }
            }
            else if(ins->i->kind == AS_instr_::I_MOVE)
            {
                for(auto tl = ins->i->u.MOVE.dst;tl != nullptr;tl = tl->tail)
                {
                    auto t = tl->head;
                    if(t->kind == AS_operand_::T_TEMP)
                    {
                        ud_chain.emplace(t->u.TEMP,ins);
                    }
                }
            }
        }
    }
    return ud_chain;
}

void datachain::printDUChain(FILE *os,std::unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> m)
{
    fprintf(os,"-----------duchain----------------\n");
    for(auto &it : m)
    {
        fprintf(os,"temp %d:\n",it.first->num);
        for(auto &ins : it.second)
        {
            AS_print_llvm(os, ins->i, Temp_name());
            fprintf(os,"\n");
        }
    }
}
void datachain::printUDChain(FILE *os,std::unordered_map<Temp_temp,LLVM_IR::T_ir> m)
{
    fprintf(os,"-----------udchain----------------\n");
    for(auto &it : m)
    {
        fprintf(os,"temp %d:\n",it.first->num);
        AS_print_llvm(os, it.second->i, Temp_name());
        fprintf(os,"\n");
    }
}