#include "naive_merge_ins.h"
#include "data_chain.h"
#include "deadce.h"
#include <unordered_set>
#include <assert.h>
#include <unordered_map>
#include <memory>
#include "tempdsu.h"

using namespace std;

static unordered_map<Temp_temp,vector<LLVM_IR::T_ir>> du_chain;
static unordered_set<int> remove_ins;
static unordered_map<int,LLVM_IR::T_ir> insert_map;
static unordered_map<int,shared_ptr<unordered_set<Temp_temp>>> move_temp_map;
static TempDsu tempDsu;

static void init_move_temp_map(AS_block2List bl)
{
    // move_temp_map.clear();
    // for(auto &b : bl->blist)
    // {
    //     for(auto &ins : b->instrs->ilist)
    //     {
    //         if(ins->i->kind == AS_instr_::I_OPER)
    //         {
    //             for(auto tl = ins->i->u.OPER.dst;tl != nullptr;tl = tl->tail)
    //             {
    //                 if(tl->head->kind == AS_operand_::T_TEMP)
    //                 {
    //                     move_temp_map.emplace(tl->head->u.TEMP->num,make_shared<unordered_set<Temp_temp>>());
    //                     move_temp_map[tl->head->u.TEMP->num]->insert(tl->head->u.TEMP);
    //                 }
    //             }
    //         }
    //         else if(ins->i->kind == AS_instr_::I_MOVE)
    //         {
    //             for(auto tl = ins->i->u.MOVE.dst;tl != nullptr;tl = tl->tail)
    //             {
    //                 if(tl->head->kind == AS_operand_::T_TEMP)
    //                 {
    //                     move_temp_map.emplace(tl->head->u.TEMP->num,make_shared<unordered_set<Temp_temp>>());
    //                     move_temp_map[tl->head->u.TEMP->num]->insert(tl->head->u.TEMP);
    //                 }
    //             }
    //         }
    //     }
    // }
    // for(auto &b : bl->blist)
    // {
    //     for(auto &ins : b->instrs->ilist)
    //     {
    //         if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
    //         {
    //             if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
    //             {
    //                 move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num]->merge(*move_temp_map[ins->s->u.MOVE.src->u.TEMP->num]);
    //                 vector<Temp_temp> t_v(move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num]->begin(),move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num]->end());
    //                 for(auto &te : t_v)
    //                 {
    //                     move_temp_map[te->num] = move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num];
    //                 }
    //             }
    //             else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
    //             {
                    
    //             }
    //             else if(ins->s->u.MOVE.src->kind == AS_operand_::T_ICONST)
    //             {

    //             }
    //             else if(ins->s->u.MOVE.src->kind == AS_operand_::T_FCONST)
    //             {
                    
    //             }
    //             else
    //             {
    //                 assert(0);
    //             }
    //         }
    //     }
    // }
    tempDsu = TempDsu(getTempNumber(),bl);
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
            {
                if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
                {
                    tempDsu.unite(ins->s->u.MOVE.dst->u.TEMP->num,ins->s->u.MOVE.src->u.TEMP->num);
                }
                else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                {
                    
                }
                else if(ins->s->u.MOVE.src->kind == AS_operand_::T_ICONST)
                {
                    
                }
                else if(ins->s->u.MOVE.src->kind == AS_operand_::T_FCONST)
                {
                
                }
                else
                {
                    assert(0);
                }
            }
        }
    }
}

static void process_bl(AS_block2List bl)
{
    remove_ins.clear();
    insert_map.clear();
    int ins_num = 0;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            ins->num = ins_num++;
        }
    }
    du_chain = datachain::get_du_chain(bl);
    for(auto &b : bl->blist)
    {
        for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
        {
            auto ins = *it;
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
            {
                if(ins->s->u.BINOP.op == LLVM_IR::T_plus)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    auto l_op = ins->s->u.BINOP.left;
                    auto r_op = ins->s->u.BINOP.right;
                    if(l_op->kind == AS_operand_::T_TEMP && (r_op->kind == AS_operand_::T_ICONST || r_op->kind == AS_operand_::T_FCONST))
                    {
                        auto use_temp = du_chain[dst_temp];
                        if(use_temp.size() == 1)
                        {
                            auto use_ins = use_temp[0];
                            if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                            {
                                if(use_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = r_op->u.ICONST + use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = r_op->u.FCONST + use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = r_op->u.ICONST + use_l_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = r_op->u.FCONST + use_l_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                                else if(use_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = r_op->u.ICONST - use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = r_op->u.FCONST - use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                            }
                        }
                    }
                    else if(r_op->kind == AS_operand_::T_TEMP && (l_op->kind == AS_operand_::T_ICONST || l_op->kind == AS_operand_::T_FCONST))
                    {
                        auto use_temp = du_chain[dst_temp];
                        if(use_temp.size() == 1)
                        {
                            auto use_ins = use_temp[0];
                            if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                            {
                                if(use_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = l_op->u.ICONST + use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = l_op->u.FCONST + use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = l_op->u.ICONST + use_l_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = l_op->u.FCONST + use_l_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                                else if(use_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = l_op->u.ICONST - use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = l_op->u.FCONST - use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(r_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,r_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                            }
                        }
                    }
                }
                else if(ins->s->u.BINOP.op == LLVM_IR::T_minus)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    auto l_op = ins->s->u.BINOP.left;
                    auto r_op = ins->s->u.BINOP.right;
                    if(l_op->kind == AS_operand_::T_TEMP && (r_op->kind == AS_operand_::T_ICONST || r_op->kind == AS_operand_::T_FCONST))
                    {
                        auto use_temp = du_chain[dst_temp];
                        if(use_temp.size() == 1)
                        {
                            auto use_ins = use_temp[0];
                            if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                            {
                                if(use_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = -r_op->u.ICONST + use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = -r_op->u.FCONST + use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = -r_op->u.ICONST + use_l_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_r_op->kind == AS_operand_::T_TEMP && use_l_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = -r_op->u.FCONST + use_l_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                                else if(use_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                                {
                                    auto use_dst_temp = use_ins->s->u.BINOP.dst->u.TEMP;
                                    auto use_l_op = use_ins->s->u.BINOP.left;
                                    auto use_r_op = use_ins->s->u.BINOP.right;
                                    if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_ICONST)
                                    {
                                        int new_ans = -r_op->u.ICONST - use_r_op->u.ICONST;
                                        //printf("%d\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_Const(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_Const(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub i32 `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                    else if(use_l_op->kind == AS_operand_::T_TEMP && use_r_op->kind == AS_operand_::T_FCONST)
                                    {
                                        float new_ans = -r_op->u.FCONST - use_r_op->u.FCONST;
                                        //printf("%f\n",new_ans);
                                        if(new_ans >= 0)
                                        {
                                            auto new_src_op = AS_Operand_FConst(new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = add float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        else
                                        {
                                            auto new_src_op = AS_Operand_FConst(-new_ans);
                                            use_ins->i = AS_Oper(String("`d0 = sub float `s0, `s1"),AS_OperandList(use_ins->s->u.BINOP.dst,nullptr),
                                                AS_OperandList(l_op,AS_OperandList(new_src_op,nullptr)),nullptr);
                                            use_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_minus,use_ins->s->u.BINOP.dst,l_op,new_src_op);
                                        }
                                        remove_ins.emplace(ins->num);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && ins->s->u.BINOP.op == LLVM_IR::T_plus && remove_ins.find(ins->num) == remove_ins.end() && insert_map.find(ins->num) == insert_map.end())
            {
                if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                {
                    auto acc_temp = ins->s->u.BINOP.left->u.TEMP;
                    auto origin_temp = ins->s->u.BINOP.right->u.TEMP;
                    auto next_temp = ins->s->u.BINOP.dst->u.TEMP;
                    int mul_size = 1;
                    auto prev_ins = ins;
                    LLVM_IR::T_ir next_ins = nullptr;
                    vector<LLVM_IR::T_ir> v;
                    while(du_chain[next_temp].size() == 1)
                    {
                        auto this_ins = du_chain[next_temp][0];
                        if(this_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && this_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                        {
                            if(this_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && this_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                            {
                                if(tempDsu.find(this_ins->s->u.BINOP.left->u.TEMP->num) == tempDsu.find(acc_temp->num) && this_ins->s->u.BINOP.right->u.TEMP->num == next_temp->num)
                                {
                                    next_ins = this_ins;
                                    ++mul_size;
                                    next_temp = next_ins->s->u.BINOP.dst->u.TEMP;
                                    v.push_back(prev_ins);
                                    prev_ins = next_ins;
                                }
                                else if(this_ins->s->u.BINOP.left->u.TEMP->num == next_temp->num && tempDsu.find(this_ins->s->u.BINOP.right->u.TEMP->num) == tempDsu.find(acc_temp->num))
                                {
                                    next_ins = this_ins;
                                    ++mul_size;
                                    next_temp = next_ins->s->u.BINOP.dst->u.TEMP;
                                    v.push_back(prev_ins);
                                    prev_ins = next_ins;
                                }
                                else
                                {
                                    break;
                                }
                            }
                            else
                            {
                                break;
                            }
                        }
                        // else if(this_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                        // {
                        //     next_temp = this_ins->s->u.MOVE.dst->u.TEMP;
                        // }
                        else
                        {
                            break;
                        }
                    }
                    if(mul_size > 1)
                    {
                        auto dst_temp = next_ins->s->u.BINOP.dst;
                        if(tempDsu.find(origin_temp->num) == tempDsu.find(acc_temp->num))
                        {
                            if(dst_temp->u.TEMP->type == INT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_Const(mul_size+1);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                next_ins->s = new_s;
                                next_ins->i = new_i;
                            }
                            else if(dst_temp->u.TEMP->type == FLOAT_TEMP)
                            {
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_FConst(mul_size+1);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::F_mul,dst_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul float `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                next_ins->s = new_s;
                                next_ins->i = new_i;
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        else
                        {
                            if(dst_temp->u.TEMP->type == INT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_Const(mul_size);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::T_mul,new_acc_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(new_acc_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                                auto origin_op = AS_Operand_Temp(origin_temp);
                                next_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,dst_temp,origin_op,new_acc_temp);
                                next_ins->i = AS_Oper(String("`d0 = add i32 `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(origin_op,AS_OperandList(new_acc_temp,nullptr)),nullptr);
                                insert_map.emplace(next_ins->num,new_ir);
                            }
                            else if(dst_temp->u.TEMP->type == FLOAT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewFloatTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_FConst(mul_size);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::F_mul,new_acc_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul float `s0,`s1"),AS_OperandList(new_acc_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                                auto origin_op = AS_Operand_Temp(origin_temp);
                                next_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,dst_temp,origin_op,new_acc_temp);
                                next_ins->i = AS_Oper(String("`d0 = add float `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(origin_op,AS_OperandList(new_acc_temp,nullptr)),nullptr);
                                insert_map.emplace(next_ins->num,new_ir);
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        for(auto &ri : v)
                        {
                            remove_ins.emplace(ri->num);
                        }
                        continue;
                    }
                    acc_temp = ins->s->u.BINOP.right->u.TEMP;
                    origin_temp = ins->s->u.BINOP.left->u.TEMP;
                    next_temp = ins->s->u.BINOP.dst->u.TEMP;
                    mul_size = 1;
                    prev_ins = ins;
                    next_ins = nullptr;
                    v.clear();
                    while(du_chain[next_temp].size() == 1)
                    {
                        auto this_ins = du_chain[next_temp][0];
                        if(this_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP  && this_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                        {
                            if(this_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && this_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                            {
                                if(tempDsu.find(this_ins->s->u.BINOP.left->u.TEMP->num) == tempDsu.find(acc_temp->num) && this_ins->s->u.BINOP.right->u.TEMP->num == next_temp->num)
                                {
                                    next_ins = this_ins;
                                    ++mul_size;
                                    next_temp = next_ins->s->u.BINOP.dst->u.TEMP;
                                    v.push_back(prev_ins);
                                    prev_ins = next_ins;
                                }
                                else if(this_ins->s->u.BINOP.left->u.TEMP->num == next_temp->num && tempDsu.find(this_ins->s->u.BINOP.right->u.TEMP->num) == tempDsu.find(acc_temp->num))
                                {
                                    next_ins = this_ins;
                                    ++mul_size;
                                    next_temp = next_ins->s->u.BINOP.dst->u.TEMP;
                                    v.push_back(prev_ins);
                                    prev_ins = next_ins;
                                }
                                else
                                {
                                    break;
                                }
                            }
                            else
                            {
                                break;
                            }
                        }
                        // else if(this_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                        // {
                        //     next_temp = this_ins->s->u.MOVE.dst->u.TEMP;
                        // }
                        else
                        {
                            break;
                        }
                    }
                    if(mul_size > 1)
                    {
                        auto dst_temp = next_ins->s->u.BINOP.dst;
                        if(tempDsu.find(origin_temp->num) == tempDsu.find(acc_temp->num))
                        {
                            if(dst_temp->u.TEMP->type == INT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_Const(mul_size+1);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                next_ins->s = new_s;
                                next_ins->i = new_i;
                            }
                            else if(dst_temp->u.TEMP->type == FLOAT_TEMP)
                            {
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_FConst(mul_size+1);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::F_mul,dst_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul float `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                next_ins->s = new_s;
                                next_ins->i = new_i;
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        else
                        {
                            if(dst_temp->u.TEMP->type == INT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_Const(mul_size);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::T_mul,new_acc_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(new_acc_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                                auto origin_op = AS_Operand_Temp(origin_temp);
                                next_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_plus,dst_temp,origin_op,new_acc_temp);
                                next_ins->i = AS_Oper(String("`d0 = add i32 `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(origin_op,AS_OperandList(new_acc_temp,nullptr)),nullptr);
                                insert_map.emplace(next_ins->num,new_ir);
                            }
                            else if(dst_temp->u.TEMP->type == FLOAT_TEMP)
                            {
                                auto new_acc_temp = AS_Operand_Temp_NewFloatTemp();
                                auto new_l = AS_Operand_Temp(acc_temp);
                                auto new_r = AS_Operand_FConst(mul_size);
                                auto new_s = LLVM_IR::T_Binop(LLVM_IR::F_mul,new_acc_temp,new_l,new_r);
                                auto new_i = AS_Oper(String("`d0 = mul float `s0,`s1"),AS_OperandList(new_acc_temp,nullptr),AS_OperandList(new_l,AS_OperandList(new_r,nullptr)),nullptr);
                                auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                                auto origin_op = AS_Operand_Temp(origin_temp);
                                next_ins->s = LLVM_IR::T_Binop(LLVM_IR::F_plus,dst_temp,origin_op,new_acc_temp);
                                next_ins->i = AS_Oper(String("`d0 = add float `s0,`s1"),AS_OperandList(dst_temp,nullptr),AS_OperandList(origin_op,AS_OperandList(new_acc_temp,nullptr)),nullptr);
                                insert_map.emplace(next_ins->num,new_ir);
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        for(auto &ri : v)
                        {
                            remove_ins.emplace(ri->num);
                        }
                        continue;
                    }
                }
            }
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && ins->s->u.BINOP.op == LLVM_IR::T_mul)
            {
                if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    while (du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                        {
                            dst_temp = use_ins->s->u.MOVE.dst->u.TEMP;
                        }
                        else
                        {
                            break;
                        }
                    }
                    
                    if(du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && use_ins->s->u.BINOP.op == LLVM_IR::T_div)
                        {
                            if(use_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && use_ins->s->u.BINOP.right->u.ICONST == ins->s->u.BINOP.right->u.ICONST)
                            {
                                auto d_op = use_ins->s->u.BINOP.dst;
                                use_ins->s = LLVM_IR::T_Move(d_op,ins->s->u.BINOP.left);
                                use_ins->i = AS_Move(String("`d0 = bitcast i32 `s0 to i32"),AS_OperandList(d_op,nullptr),AS_OperandList(ins->s->u.BINOP.left,nullptr));
                                remove_ins.emplace(ins->num);
                            }
                        }
                    }
                }
                else if(ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    while (du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                        {
                            dst_temp = use_ins->s->u.MOVE.dst->u.TEMP;
                        }
                        else
                        {
                            break;
                        }
                    }
                    if(du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && use_ins->s->u.BINOP.op == LLVM_IR::T_div)
                        {
                            if(use_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && use_ins->s->u.BINOP.right->u.ICONST == ins->s->u.BINOP.left->u.ICONST)
                            {
                                auto d_op = use_ins->s->u.BINOP.dst;
                                use_ins->s = LLVM_IR::T_Move(d_op,ins->s->u.BINOP.right);
                                use_ins->i = AS_Move(String("`d0 = bitcast i32 `s0 to i32"),AS_OperandList(d_op,nullptr),AS_OperandList(ins->s->u.BINOP.right,nullptr));
                                remove_ins.emplace(ins->num);
                            }
                        }
                    }
                }
            }
        }
    }
}

static void process_block2(AS_block2List bl)
{
    remove_ins.clear();
    insert_map.clear();
    int ins_num = 0;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            ins->num = ins_num++;
        }
    }
    du_chain = datachain::get_du_chain(bl);
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && remove_ins.find(ins->num) == remove_ins.end())
            {
                auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                if(du_chain[dst_temp].size() == 1)
                {
                    auto use_ins = du_chain[dst_temp][0];
                    if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                    {
                        if(use_ins->s->u.MOVE.dst->u.TEMP->type == dst_temp->type)
                        {
                            auto dst_op = use_ins->s->u.MOVE.dst;
                            ins->s->u.BINOP.dst = dst_op;
                            ins->i->u.OPER.dst->head = dst_op;
                            remove_ins.emplace(use_ins->num);
                        }
                    }
                }
            }
        }
    }
}

static void process_block3(AS_block2List bl)
{
    remove_ins.clear();
    insert_map.clear();
    int ins_num = 0;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            ins->num = ins_num++;
        }
    }
    du_chain = datachain::get_du_chain(bl);
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && ins->s->u.BINOP.op == LLVM_IR::T_mul)
            {
                if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    if(du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && use_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                        {
                            if(use_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && tempDsu.find(use_ins->s->u.BINOP.left->u.TEMP->num) == tempDsu.find(ins->s->u.BINOP.left->u.TEMP->num))
                            {
                                auto dst_op = use_ins->s->u.MOVE.dst;
                                auto new_const_op = AS_Operand_Const(ins->s->u.BINOP.right->u.ICONST + 1);
                                use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_op,ins->s->u.BINOP.left,new_const_op);
                                use_ins->i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_op,nullptr),AS_OperandList(ins->s->u.BINOP.left,AS_OperandList(new_const_op,nullptr)),nullptr);
                                remove_ins.emplace(ins->num);
                            }
                            else if(use_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && tempDsu.find(use_ins->s->u.BINOP.right->u.TEMP->num) == tempDsu.find(ins->s->u.BINOP.left->u.TEMP->num))
                            {
                                auto dst_op = use_ins->s->u.MOVE.dst;
                                auto new_const_op = AS_Operand_Const(ins->s->u.BINOP.right->u.ICONST + 1);
                                use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_op,ins->s->u.BINOP.left,new_const_op);
                                use_ins->i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_op,nullptr),AS_OperandList(ins->s->u.BINOP.left,AS_OperandList(new_const_op,nullptr)),nullptr);
                                remove_ins.emplace(ins->num);
                            }
                        }
                    } 
                }
                else if(ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST)
                {
                    auto dst_temp = ins->s->u.BINOP.dst->u.TEMP;
                    if(du_chain[dst_temp].size() == 1)
                    {
                        auto use_ins = du_chain[dst_temp][0];
                        if(use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && use_ins->s->u.BINOP.op == LLVM_IR::T_plus)
                        {
                            if(use_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && tempDsu.find(use_ins->s->u.BINOP.left->u.TEMP->num) == tempDsu.find(ins->s->u.BINOP.right->u.TEMP->num))
                            {
                                auto dst_op = use_ins->s->u.MOVE.dst;
                                auto new_const_op = AS_Operand_Const(ins->s->u.BINOP.left->u.ICONST + 1);
                                use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_op,ins->s->u.BINOP.right,new_const_op);
                                use_ins->i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_op,nullptr),AS_OperandList(ins->s->u.BINOP.right,AS_OperandList(new_const_op,nullptr)),nullptr);
                                remove_ins.emplace(ins->num);
                            }
                            else if(use_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && tempDsu.find(use_ins->s->u.BINOP.right->u.TEMP->num) == tempDsu.find(ins->s->u.BINOP.right->u.TEMP->num))
                            {
                                auto dst_op = use_ins->s->u.MOVE.dst;
                                auto new_const_op = AS_Operand_Const(ins->s->u.BINOP.left->u.ICONST + 1);
                                use_ins->s = LLVM_IR::T_Binop(LLVM_IR::T_mul,dst_op,ins->s->u.BINOP.right,new_const_op);
                                use_ins->i = AS_Oper(String("`d0 = mul i32 `s0,`s1"),AS_OperandList(dst_op,nullptr),AS_OperandList(ins->s->u.BINOP.right,AS_OperandList(new_const_op,nullptr)),nullptr);
                                remove_ins.emplace(ins->num);
                            }
                        }
                    } 
                }
            }
        }
    }
}

static AS_block2List merge_ins1(AS_block2List bl)
{
    process_bl(bl);
    auto new_bl = new AS_block2List_();
    decltype(new_bl->blist) blist;
    for(auto &b : bl->blist)
    {
        auto new_b = new AS_block2_();
        decltype(new_b->instrs->ilist) ilist;
        new_b->label = b->label;
        new_b->succs = b->succs;
        for(auto &ins : b->instrs->ilist)
        {
            if(remove_ins.find(ins->num) == remove_ins.end())
            {
                if(insert_map.find(ins->num) != insert_map.end())
                {
                    ilist.push_back(insert_map[ins->num]);
                }
                ilist.push_back(ins);
            }
        }
        auto inst = new AS_instr2List_();
        inst->ilist = std::move(ilist);
        new_b->instrs = inst;
        blist.push_back(new_b);
    }
    new_bl->blist = std::move(blist);
    return new_bl;
}

AS_block2List naive_merge_ins::merge_ins2(AS_block2List bl)
{
    init_move_temp_map(bl);
    process_block2(bl);
    auto new_bl = new AS_block2List_();
    decltype(new_bl->blist) blist;
    for(auto &b : bl->blist)
    {
        auto new_b = new AS_block2_();
        decltype(new_b->instrs->ilist) ilist;
        new_b->label = b->label;
        new_b->succs = b->succs;
        for(auto &ins : b->instrs->ilist)
        {
            if(remove_ins.find(ins->num) == remove_ins.end())
            {
                if(insert_map.find(ins->num) != insert_map.end())
                {
                    ilist.push_back(insert_map[ins->num]);
                }
                ilist.push_back(ins);
            }
        }
        auto inst = new AS_instr2List_();
        inst->ilist = std::move(ilist);
        new_b->instrs = inst;
        blist.push_back(new_b);
    }
    new_bl->blist = std::move(blist);
    return new_bl;
}

AS_block2List naive_merge_ins::merge_ins3(AS_block2List bl)
{
    init_move_temp_map(bl);
    process_block3(bl);
    auto new_bl = new AS_block2List_();
    decltype(new_bl->blist) blist;
    for(auto &b : bl->blist)
    {
        auto new_b = new AS_block2_();
        decltype(new_b->instrs->ilist) ilist;
        new_b->label = b->label;
        new_b->succs = b->succs;
        for(auto &ins : b->instrs->ilist)
        {
            if(remove_ins.find(ins->num) == remove_ins.end())
            {
                if(insert_map.find(ins->num) != insert_map.end())
                {
                    ilist.push_back(insert_map[ins->num]);
                }
                ilist.push_back(ins);
            }
        }
        auto inst = new AS_instr2List_();
        inst->ilist = std::move(ilist);
        new_b->instrs = inst;
        blist.push_back(new_b);
    }
    new_bl->blist = std::move(blist);
    return new_bl;
}

AS_block2List naive_merge_ins::merge_ins(AS_block2List bl)
{
    init_move_temp_map(bl);
    // auto bl_ = merge_ins2(bl);
    // bl_ = merge_ins3(bl_);
    return merge_ins1(bl);
}