#include <unordered_map>
#include "remove_load.h"
#include "data_chain.h"
#include <assert.h>
#include <map>
#include <set>

using namespace std;
using namespace remove_load;

static unordered_map<AS_operand,origin_type> origin_map;
static std::unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> du_chain;
static std::unordered_map<Temp_temp,LLVM_IR::T_ir> ud_chain;
static unordered_map<int,Temp_temp> num_temp_map;
extern unordered_map<std::string,AS_block2> first_loop_block;

static void gen_origin(AS_block2List bl)
{
    origin_map.clear();
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
            {
                if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
                {
                    origin_map.emplace(ins->s->u.GEP.base_ptr,origin_type(std::string(Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name))));
                }
                else if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP)
                {
                    if(origin_map.find(ins->s->u.GEP.base_ptr) != origin_map.end())
                    {
                        continue;
                    }
                    auto def_temp = ins->s->u.GEP.base_ptr->u.TEMP;
                    auto def_op = ins->s->u.GEP.base_ptr;
                    bool is_def = true;
                    while (ud_chain.find(def_temp) != ud_chain.end())
                    {
                        auto def_ins = ud_chain[def_temp];
                        if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_ALLOCA)
                        {
                            def_op = def_ins->s->u.ALLOCA.dst;
                            break;
                        }
                        else if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                        {
                            if(def_ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                            {
                                def_op = def_ins->s->u.MOVE.src;
                                break;
                            }
                            else if(def_ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
                            {
                                def_op = def_ins->s->u.MOVE.src;
                                def_temp = def_ins->s->u.MOVE.src->u.TEMP;
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        else if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_NULL)
                        {
                            is_def = false;
                            break;
                        }
                        else if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
                        {
                            is_def = false;
                            break;
                        }
                        else if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                        {
                            is_def = false;
                            break;
                        }
                        else
                        {
                            printf("%d\n",def_ins->s->kind);
                            assert(0);
                        }
                    }
                    if(is_def)
                    {
                        if(def_op->kind == AS_operand_::T_NAME)
                        {
                            origin_map.emplace(ins->s->u.GEP.base_ptr,Temp_labelstring(def_op->u.NAME.name));
                        }
                        else if(def_op->kind == AS_operand_::T_TEMP)
                        {
                            origin_map.emplace(ins->s->u.GEP.base_ptr,def_op->u.TEMP->num);
                        }
                        else
                        {
                            assert(0);
                        }
                    }
                }
            }
        }
    }
}

static void gen_num_temp_map(AS_block2List bl)
{
    num_temp_map.clear();
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->i->kind == AS_instr_::I_OPER)
            {
                for(auto tl = ins->i->u.OPER.dst;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        num_temp_map.emplace(tl->head->u.TEMP->num,tl->head->u.TEMP);
                    }
                }
            }
            else if(ins->i->kind == AS_instr_::I_MOVE)
            {
                for(auto tl = ins->i->u.MOVE.dst;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        num_temp_map.emplace(tl->head->u.TEMP->num,tl->head->u.TEMP);
                    }
                }
            }
        }
    }
}

static pair<origin_type,variant<int,int>> make_key(LLVM_IR::T_ir ins)
{
    origin_type l;
    auto it = origin_map.find(ins->s->u.GEP.base_ptr);
    if(it != origin_map.end())
    {
        l = it->second;
    }
    else
    {
        assert(0);
    }
    variant<int,int> r;
    if(ins->s->u.GEP.index->kind == AS_operand_::T_TEMP)
    {
        r.emplace<0>(ins->s->u.GEP.index->u.TEMP->num);
    }
    else if(ins->s->u.GEP.index->kind == AS_operand_::T_ICONST)
    {
        r.emplace<1>(ins->s->u.GEP.index->u.ICONST);
    }
    else
    {
        assert(0);
    }
    return make_pair(l,r);
}

static void replace_temp(Temp_temp src,Temp_temp dst)
{
    //printf("here src:%d dst:%d\n",src->num,dst->num);
    for(auto &ins : du_chain[src])
    {
        if(ins->i->kind == AS_instr_::I_OPER)
        {
            for(auto tl = ins->i->u.OPER.src;tl != nullptr;tl = tl->tail)
            {
                auto t = tl->head;
                if(t->kind == AS_operand_::T_TEMP)
                {
                    if(t->u.TEMP == src)
                    {
                        t->u.TEMP = dst;
                    }
                }
            }
        }
        else if(ins->i->kind == AS_instr_::I_MOVE)
        {
            for(auto tl = ins->i->u.MOVE.src;tl != nullptr;tl = tl->tail)
            {
                auto t = tl->head;
                if(t->kind == AS_operand_::T_TEMP)
                {
                    if(t->u.TEMP == src)
                    {
                        t->u.TEMP = dst;
                    }
                }
            }
        }
        switch (ins->s->kind)
        {
        case LLVM_IR::llvm_T_stm_::T_BINOP:
        {
            if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.left->u.TEMP == src)
            {
                ins->s->u.BINOP.left->u.TEMP = dst;
            }
            if(ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->u.TEMP == src)
            {
                ins->s->u.BINOP.right->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_CALL:
        {
            for(auto tl = ins->s->u.CALL.args;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->kind == AS_operand_::T_TEMP && tl->head->u.TEMP == src)
                {
                    tl->head->u.TEMP =dst;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_CMP:
        {
            if(ins->s->u.CMP.left->kind == AS_operand_::T_TEMP && ins->s->u.CMP.left->u.TEMP == src)
            {
                ins->s->u.CMP.left->u.TEMP = dst;
            }
            if(ins->s->u.CMP.right->kind == AS_operand_::T_TEMP && ins->s->u.CMP.right->u.TEMP == src)
            {
                ins->s->u.CMP.right->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_LOAD:
        {
            if(ins->s->u.LOAD.ptr->kind == AS_operand_::T_TEMP && ins->s->u.LOAD.ptr->u.TEMP == src)
            {
                ins->s->u.LOAD.ptr->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_MOVE:
        {
            if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP && ins->s->u.MOVE.src->u.TEMP == src)
            {
                ins->s->u.MOVE.src->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_PHI:
        {
            for(auto tl = ins->s->u.PHI.phis;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->op->kind == AS_operand_::T_TEMP && tl->head->op->u.TEMP == src)
                {
                    tl->head->op->u.TEMP = dst;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_RETURN:
        {
            if(ins->s->u.RET.ret->kind == AS_operand_::T_TEMP && ins->s->u.RET.ret->u.TEMP == src)
            {
                ins->s->u.RET.ret->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_STORE:
        {
            if(ins->s->u.STORE.ptr->kind == AS_operand_::T_TEMP && ins->s->u.STORE.ptr->u.TEMP == src)
            {
                ins->s->u.STORE.ptr->u.TEMP = dst;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_VOID_CALL:
        {
            for(auto tl = ins->s->u.VOID_CALL.args;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->kind == AS_operand_::T_TEMP && tl->head->u.TEMP == src)
                {
                    tl->head->u.TEMP =dst;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_GEP:
        {
            if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP && ins->s->u.GEP.base_ptr->u.TEMP == src)
            {
                ins->s->u.GEP.base_ptr->u.TEMP = dst;
            }
            if(ins->s->u.GEP.index->kind == AS_operand_::T_TEMP && ins->s->u.GEP.index->u.TEMP == src)
            {
                ins->s->u.GEP.index->u.TEMP = dst;
            }
        }
        default:
            break;
        }
    }
}

static void replace_temp_int(Temp_temp src,int dst)
{
    //printf("here src:%d dst:%d\n",src->num,dst->num);
    for(auto &ins : du_chain[src])
    {
        if(ins->i->kind == AS_instr_::I_OPER)
        {
            for(auto tl = ins->i->u.OPER.src;tl != nullptr;tl = tl->tail)
            {
                auto t = tl->head;
                if(t->kind == AS_operand_::T_TEMP)
                {
                    if(t->u.TEMP == src)
                    {
                        t->u.ICONST = dst;
                        t->kind = AS_operand_::T_ICONST;
                    }
                }
            }
        }
        else if(ins->i->kind == AS_instr_::I_MOVE)
        {
            for(auto tl = ins->i->u.MOVE.src;tl != nullptr;tl = tl->tail)
            {
                auto t = tl->head;
                if(t->kind == AS_operand_::T_TEMP)
                {
                    if(t->u.TEMP == src)
                    {
                        t->u.ICONST = dst;
                        t->kind = AS_operand_::T_ICONST;
                    }
                }
            }
        }
        switch (ins->s->kind)
        {
        case LLVM_IR::llvm_T_stm_::T_BINOP:
        {
            if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.left->u.TEMP == src)
            {
                ins->s->u.BINOP.left->u.ICONST = dst;
                ins->s->u.BINOP.left->kind = AS_operand_::T_ICONST;
            }
            if(ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->u.TEMP == src)
            {
                ins->s->u.BINOP.right->u.ICONST = dst;
                ins->s->u.BINOP.right->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_CALL:
        {
            for(auto tl = ins->s->u.CALL.args;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->kind == AS_operand_::T_TEMP && tl->head->u.TEMP == src)
                {
                    tl->head->u.ICONST = dst;
                    tl->head->kind = AS_operand_::T_ICONST;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_CMP:
        {
            if(ins->s->u.CMP.left->kind == AS_operand_::T_TEMP && ins->s->u.CMP.left->u.TEMP == src)
            {
                ins->s->u.CMP.left->u.ICONST = dst;
                ins->s->u.CMP.left->kind = AS_operand_::T_ICONST;
            }
            if(ins->s->u.CMP.right->kind == AS_operand_::T_TEMP && ins->s->u.CMP.right->u.TEMP == src)
            {
                ins->s->u.CMP.right->u.ICONST = dst;
                ins->s->u.CMP.right->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_LOAD:
        {
            if(ins->s->u.LOAD.ptr->kind == AS_operand_::T_TEMP && ins->s->u.LOAD.ptr->u.TEMP == src)
            {
                ins->s->u.LOAD.ptr->u.ICONST = dst;
                ins->s->u.LOAD.ptr->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_MOVE:
        {
            if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP && ins->s->u.MOVE.src->u.TEMP == src)
            {
                ins->s->u.MOVE.src->u.ICONST = dst;
                ins->s->u.MOVE.src->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_PHI:
        {
            for(auto tl = ins->s->u.PHI.phis;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->op->kind == AS_operand_::T_TEMP && tl->head->op->u.TEMP == src)
                {
                    tl->head->op->u.ICONST = dst;
                    tl->head->op->kind = AS_operand_::T_ICONST;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_RETURN:
        {
            if(ins->s->u.RET.ret->kind == AS_operand_::T_TEMP && ins->s->u.RET.ret->u.TEMP == src)
            {
                ins->s->u.RET.ret->u.ICONST = dst;
                ins->s->u.RET.ret->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_STORE:
        {
            if(ins->s->u.STORE.ptr->kind == AS_operand_::T_TEMP && ins->s->u.STORE.ptr->u.TEMP == src)
            {
                ins->s->u.STORE.ptr->u.ICONST = dst;
                ins->s->u.STORE.ptr->kind = AS_operand_::T_ICONST;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_VOID_CALL:
        {
            for(auto tl = ins->s->u.VOID_CALL.args;tl != nullptr;tl = tl->tail)
            {
                if(tl->head->kind == AS_operand_::T_TEMP && tl->head->u.TEMP == src)
                {
                    tl->head->u.ICONST = dst;
                    tl->head->kind = AS_operand_::T_ICONST;
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_GEP:
        {
            if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP && ins->s->u.GEP.base_ptr->u.TEMP == src)
            {
                ins->s->u.GEP.base_ptr->u.ICONST = dst;
                ins->s->u.GEP.base_ptr->kind = AS_operand_::T_ICONST;
            }
            if(ins->s->u.GEP.index->kind == AS_operand_::T_TEMP && ins->s->u.GEP.index->u.TEMP == src)
            {
                ins->s->u.GEP.index->u.ICONST = dst;
                ins->s->u.GEP.index->kind = AS_operand_::T_ICONST;
            }
        }
        default:
            break;
        }
    }
}

static map<pair<origin_type,variant<int,int>>,AS_operand> reset_map(map<pair<origin_type,variant<int,int>>,AS_operand>& m,pair<origin_type,variant<int,int>> &key,int num)
{
    map<pair<origin_type,variant<int,int>>,AS_operand> nm;
    for(auto &p : m)
    {
        if(p.second->kind == AS_operand_::T_TEMP && p.second->u.TEMP->num == num)
        {
            nm.insert(p);
        }
        else if(p.first.first != key.first)
        {
            nm.insert(p);
        }
        else
        {
            auto index = key.second.index();
            if(index == 0)
            {
                if(p.first.second.index() == 0)
                {
                    auto s_t = num_temp_map[get<0>(key.second)];
                    auto d_t = num_temp_map[get<0>(p.first.second)];
                    assert(s_t && d_t);
                    auto s_ins = ud_chain[s_t];
                    auto d_ins = ud_chain[d_t];
                    if(s_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP && d_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                    {
                        if(s_ins->s->u.BINOP.op == d_ins->s->u.BINOP.op)
                        {
                            if(s_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && d_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP)
                            {
                                if(s_ins->s->u.BINOP.left->u.TEMP->num == d_ins->s->u.BINOP.left->u.TEMP->num)
                                {
                                    if(s_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && d_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST)
                                    {
                                        if(s_ins->s->u.BINOP.right->u.ICONST != d_ins->s->u.BINOP.right->u.ICONST)
                                        {
                                            nm.insert(p);
                                        }
                                    }
                                }
                            }
                            else if(s_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && d_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                            {
                                if(s_ins->s->u.BINOP.right->u.TEMP->num == d_ins->s->u.BINOP.right->u.TEMP->num)
                                {
                                    if(s_ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST && d_ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST)
                                    {
                                        if(s_ins->s->u.BINOP.left->u.ICONST != d_ins->s->u.BINOP.left->u.ICONST)
                                        {
                                            nm.insert(p);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if(d_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                    {
                        if(d_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && d_ins->s->u.BINOP.left->u.TEMP->num == s_t->num)
                        {
                            if(d_ins->s->u.BINOP.op == LLVM_IR::T_plus || d_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                            {
                                if(d_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && d_ins->s->u.BINOP.right->u.ICONST != 0)
                                {
                                    nm.insert(p);
                                }
                            }
                            else if(d_ins->s->u.BINOP.op == LLVM_IR::T_mul || d_ins->s->u.BINOP.op == LLVM_IR::T_div)
                            {
                                if(d_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && d_ins->s->u.BINOP.right->u.ICONST != 1)
                                {
                                    nm.insert(p);
                                }
                            }
                        }
                        else if(d_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && d_ins->s->u.BINOP.right->u.TEMP->num == s_t->num)
                        {
                            if(d_ins->s->u.BINOP.op == LLVM_IR::T_plus || d_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                            {
                                if(d_ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST && d_ins->s->u.BINOP.left->u.ICONST != 0)
                                {
                                    nm.insert(p);
                                }
                            }
                        }
                    }
                    if(s_ins->s->kind == LLVM_IR::llvm_T_stm_::T_BINOP)
                    {
                        if(s_ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && s_ins->s->u.BINOP.left->u.TEMP->num == d_t->num)
                        {
                            if(s_ins->s->u.BINOP.op == LLVM_IR::T_plus || s_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                            {
                                if(s_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && s_ins->s->u.BINOP.right->u.ICONST != 0)
                                {
                                    nm.insert(p);
                                }
                            }
                            else if(s_ins->s->u.BINOP.op == LLVM_IR::T_mul || s_ins->s->u.BINOP.op == LLVM_IR::T_div)
                            {
                                if(s_ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST && s_ins->s->u.BINOP.right->u.ICONST != 1)
                                {
                                    nm.insert(p);
                                }
                            }
                        }
                        else if(s_ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP && s_ins->s->u.BINOP.right->u.TEMP->num == d_t->num)
                        {
                            if(s_ins->s->u.BINOP.op == LLVM_IR::T_plus || s_ins->s->u.BINOP.op == LLVM_IR::T_minus)
                            {
                                if(s_ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST && s_ins->s->u.BINOP.left->u.ICONST != 0)
                                {
                                    nm.insert(p);
                                }
                            }
                        }
                    }
                }
            }
            else if(key.second.index() == 1)
            {
                if(p.first.second.index() == 1)
                {
                    if(get<1>(key.second) != get<1>(p.first.second))
                    {
                        nm.insert(p);
                    }
                }
            }
        }
    }
    return nm;
}

static void process_block(AS_block2 b)
{
    map<pair<origin_type,variant<int,int>>,AS_operand> m;
    for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
    {
        auto &ins = *it;
        if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
        {
            if(ins->s->u.LOAD.ptr->kind == AS_operand_::T_TEMP)
            {
                auto def_ins = ud_chain[ins->s->u.LOAD.ptr->u.TEMP];
                if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                {
                    if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                    {
                        auto key = make_key(def_ins);
                        if(m.find(key) != m.end())
                        {
                            // printf("remove load\n");
                            if(m[key]->kind == AS_operand_::T_TEMP)
                            {
                                replace_temp(ins->s->u.LOAD.dst->u.TEMP,m[key]->u.TEMP);
                                it = b->instrs->ilist.erase(it);
                                --it;
                            }
                            else if(m[key]->kind == AS_operand_::T_ICONST)
                            {
                                replace_temp_int(ins->s->u.LOAD.dst->u.TEMP,m[key]->u.ICONST);
                                it = b->instrs->ilist.erase(it);
                                --it;
                            }
                            else
                            {
                                
                            }
                        }
                        else
                        {
                            m.emplace(key,ins->s->u.LOAD.dst);
                        }
                    }
                }
            }
        }
        else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
        {
            if(ins->s->u.STORE.ptr->kind == AS_operand_::T_TEMP)
            {
                auto def_ins = ud_chain[ins->s->u.STORE.ptr->u.TEMP];
                if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                {
                    if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                    {
                        auto key = make_key(def_ins);
                        if(auto it1 = m.find(key);it1 != m.end())
                        {
                            if(ins->s->u.STORE.src->kind == AS_operand_::T_TEMP && it1->second->kind == AS_operand_::T_TEMP && it1->second->u.TEMP == ins->s->u.STORE.src->u.TEMP)
                            {
                                // printf("remove store %d\n",it1->second->num);
                                it = b->instrs->ilist.erase(it);--it;
                                continue;
                            }
                        }
                        if(ins->s->u.STORE.src->kind == AS_operand_::T_TEMP)
                        {
                            m = reset_map(m,key,ins->s->u.STORE.src->u.TEMP->num);
                        }
                        else 
                            m = reset_map(m,key,-1);
                        m.emplace(key,ins->s->u.STORE.src);
                    }
                    else
                    {
                        m.clear();
                    }
                }
                else
                {
                    m.clear();
                }
            }
        }
        else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_CALL || ins->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL)
        {
            m.clear();
        }
    }
}

void move_store(AS_block2List bl)
{
    unordered_map<origin_type,unordered_set<int>> m;
    for(auto &b : bl->blist)
    {
        if(first_loop_block.find(Temp_labelstring(b->label)) != first_loop_block.end())
        {
            auto prev_block = first_loop_block[Temp_labelstring(b->label)];
            assert(prev_block);
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
                {
                    auto def_temp = ins->s->u.STORE.ptr;
                    if(def_temp->kind == AS_operand_::T_TEMP)
                    {
                        auto def_ins = ud_chain[def_temp->u.TEMP];
                        if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                        {
                            if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                            {
                                m.insert(make_pair(origin_map[def_ins->s->u.GEP.base_ptr],unordered_set<int>()));
                            }
                        }
                    }
                }
            }
        }
    }
    for(auto &b : bl->blist)
    {
        if(first_loop_block.find(Temp_labelstring(b->label)) != first_loop_block.end())
        {
            auto prev_block = first_loop_block[Temp_labelstring(b->label)];
            assert(prev_block);
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
                {
                    auto def_temp = ins->s->u.STORE.ptr;
                    if(def_temp->kind == AS_operand_::T_TEMP)
                    {
                        auto def_ins = ud_chain[def_temp->u.TEMP];
                        if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                        {
                            if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                            {
                                if(m.find(origin_map[def_ins->s->u.GEP.base_ptr]) != m.end())
                                {
                                    if(def_ins->s->u.GEP.index->kind == AS_operand_::T_ICONST)
                                    {
                                        if(m[origin_map[def_ins->s->u.GEP.base_ptr]].find(def_ins->s->u.GEP.index->u.ICONST) == m[origin_map[def_ins->s->u.GEP.base_ptr]].end())
                                        {
                                            m[origin_map[def_ins->s->u.GEP.base_ptr]].insert(def_ins->s->u.GEP.index->u.ICONST);
                                        }
                                        else
                                        {
                                            m.erase(origin_map[def_ins->s->u.GEP.base_ptr]);
                                        }
                                    }
                                    else
                                    {
                                        m.erase(origin_map[def_ins->s->u.GEP.base_ptr]);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

void remove_load::remove_load(AS_block2List bl)
{
    du_chain = datachain::get_du_chain(bl);
    ud_chain = datachain::get_ud_chain(bl);
    gen_num_temp_map(bl);
    gen_origin(bl);
    for(auto &b : bl->blist)
    {
        process_block(b);
    }
}

void remove_load::remove_global_arr(std::unordered_map<std::string, P_funList> &fl)
{
    unordered_set<origin_type> remove_map;
    for(auto &p : fl)
    {
        gen_origin(p.second->blockList);
        for(auto &b : p.second->blockList->blist)
        {
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                {
                    if(origin_map.find(ins->s->u.GEP.base_ptr) != origin_map.end())
                    {
                        remove_map.emplace(origin_map[ins->s->u.GEP.base_ptr]);
                    }
                }
            }
        }
    }
    for(auto &p : fl)
    {
        gen_origin(p.second->blockList);
        ud_chain = datachain::get_ud_chain(p.second->blockList);
        for(auto &b : p.second->blockList->blist)
        {
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
                {
                    auto def_temp = ins->s->u.LOAD.ptr;
                    if(def_temp->kind == AS_operand_::T_TEMP)
                    {
                        auto def_ins = ud_chain[def_temp->u.TEMP];
                        if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                        {
                            if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                            {
                                remove_map.erase(origin_map[def_ins->s->u.GEP.base_ptr]);
                            }
                        }
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_CALL)
                {
                    for(auto tl = ins->s->u.CALL.args;tl != nullptr;tl = tl->tail)
                    {
                        if(tl->head->kind == AS_operand_::T_TEMP)
                        {
                            origin_type o(tl->head->u.TEMP->num);
                            remove_map.erase(o);
                        }
                        else if(tl->head->kind == AS_operand_::T_NAME)
                        {
                            origin_type o(Temp_labelstring(tl->head->u.NAME.name));
                            remove_map.erase(o);
                        }
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL)
                {
                    for(auto tl = ins->s->u.VOID_CALL.args;tl != nullptr;tl = tl->tail)
                    {
                        if(tl->head->kind == AS_operand_::T_TEMP)
                        {
                            origin_type o(tl->head->u.TEMP->num);
                            remove_map.erase(o);
                        }
                        else if(tl->head->kind == AS_operand_::T_NAME)
                        {
                            origin_type o(Temp_labelstring(tl->head->u.NAME.name));
                            remove_map.erase(o);
                        }
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                {
                    if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
                    {
                        origin_type o(ins->s->u.MOVE.src->u.TEMP->num);
                        remove_map.erase(o);
                    }
                    else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                    {
                        origin_type o(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name));
                        remove_map.erase(o);
                    }
                    if(ins->s->u.MOVE.dst->kind == AS_operand_::T_TEMP)
                    {
                        origin_type o(ins->s->u.MOVE.dst->u.TEMP->num);
                        remove_map.erase(o);
                    }
                    else if(ins->s->u.MOVE.dst->kind == AS_operand_::T_NAME)
                    {
                        origin_type o(Temp_labelstring(ins->s->u.MOVE.dst->u.NAME.name));
                        remove_map.erase(o);
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
                {
                    for(auto tl = ins->s->u.PHI.phis;tl != nullptr;tl = tl->tail)
                    {
                        if(tl->head->op->kind == AS_operand_::T_TEMP)
                        {
                            origin_type o(tl->head->op->u.TEMP->num);
                            remove_map.erase(o);
                        }
                        else if(tl->head->op->kind == AS_operand_::T_NAME)
                        {
                            origin_type o(Temp_labelstring(tl->head->op->u.NAME.name));
                            remove_map.erase(o);
                        }
                    }
                }
            }
        }
    }
    for(auto &p : fl)
    {
        gen_origin(p.second->blockList);
        ud_chain = datachain::get_ud_chain(p.second->blockList);
        for(auto &b : p.second->blockList->blist)
        {
            for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
            {
                auto &ins = *it;
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
                {
                    auto def_temp = ins->s->u.STORE.ptr;
                    if(def_temp->kind == AS_operand_::T_TEMP)
                    {
                        auto def_ins = ud_chain[def_temp->u.TEMP];
                        if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                        {
                            if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                            {
                                auto ori = origin_map[def_ins->s->u.GEP.base_ptr];
                                if(remove_map.find(ori) != remove_map.end())
                                {
                                    // if(ori.index() == 0)
                                    //     printf("remove temp%d\n",get<0>(ori));
                                    // else
                                    //     printf("remove %s\n",get<1>(ori).c_str());
                                    it = b->instrs->ilist.erase(it);--it;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

void remove_load::naive_remove_load(AS_block2List bl)
{
    ud_chain = datachain::get_ud_chain(bl);
    gen_origin(bl);
    map<pair<origin_type,int>,AS_operand> m;
    unordered_set<origin_type> not_m;
    for(auto &b : bl->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
            {
                auto def_temp = ins->s->u.STORE.ptr;
                if(def_temp->kind == AS_operand_::T_TEMP)
                {
                    auto def_ins = ud_chain[def_temp->u.TEMP];
                    if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                    {
                        if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                        {
                            auto ori = origin_map[def_ins->s->u.GEP.base_ptr];
                            if(def_ins->s->u.GEP.index->kind == AS_operand_::T_ICONST)
                            {
                                auto p = make_pair(ori,def_ins->s->u.GEP.index->u.ICONST);
                                if(m.find(p) != m.end())
                                {
                                    m[p] = nullptr;
                                }
                                else
                                {
                                    m.emplace(p,ins->s->u.STORE.src);
                                }
                            }
                            else
                            {
                                not_m.emplace(ori);
                            }
                        }
                        else
                        {
                            return;
                        }
                    }
                    // else
                    // {
                    //     return;
                    // }
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_CALL)
            {
                for(auto tl = ins->s->u.CALL.args;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        origin_type o(tl->head->u.TEMP->num);
                        not_m.insert(o);
                    }
                    else if(tl->head->kind == AS_operand_::T_NAME)
                    {
                        origin_type o(Temp_labelstring(tl->head->u.NAME.name));
                        not_m.insert(o);
                    }
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL)
            {
                for(auto tl = ins->s->u.VOID_CALL.args;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->kind == AS_operand_::T_TEMP)
                    {
                        origin_type o(tl->head->u.TEMP->num);
                        not_m.insert(o);
                    }
                    else if(tl->head->kind == AS_operand_::T_NAME)
                    {
                        origin_type o(Temp_labelstring(tl->head->u.NAME.name));
                        not_m.insert(o);
                    }
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
            {
                if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
                {
                    origin_type o(ins->s->u.MOVE.src->u.TEMP->num);
                    not_m.insert(o);
                }
                else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                {
                    origin_type o(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name));
                    not_m.insert(o);
                }
                if(ins->s->u.MOVE.dst->kind == AS_operand_::T_TEMP)
                {
                    origin_type o(ins->s->u.MOVE.dst->u.TEMP->num);
                    not_m.insert(o);
                }
                else if(ins->s->u.MOVE.dst->kind == AS_operand_::T_NAME)
                {
                    origin_type o(Temp_labelstring(ins->s->u.MOVE.dst->u.NAME.name));
                    not_m.insert(o);
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
            {
                for(auto tl = ins->s->u.PHI.phis;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head->op->kind == AS_operand_::T_TEMP)
                    {
                        origin_type o(tl->head->op->u.TEMP->num);
                        not_m.insert(o);
                    }
                    else if(tl->head->op->kind == AS_operand_::T_NAME)
                    {
                        origin_type o(Temp_labelstring(tl->head->op->u.NAME.name));
                        not_m.insert(o);
                    }
                }
            }
        }
    }
    for(auto &b : bl->blist)
    {
        for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
        {
            auto ins = *it;
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
            {
                auto def_temp = ins->s->u.LOAD.ptr;
                if(def_temp->kind == AS_operand_::T_TEMP)
                {
                    auto def_ins = ud_chain[def_temp->u.TEMP];
                    if(def_ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                    {
                        if(origin_map.find(def_ins->s->u.GEP.base_ptr) != origin_map.end())
                        {
                            auto ori = origin_map[def_ins->s->u.GEP.base_ptr];
                            if(def_ins->s->u.GEP.index->kind == AS_operand_::T_ICONST)
                            {
                                auto p = make_pair(ori,def_ins->s->u.GEP.index->u.ICONST);
                                if(m[p] != nullptr && not_m.find(ori) == not_m.end())
                                {
                                    auto temp = m[p];
                                    // printf("here\n");
                                    if(temp->kind == AS_operand_::T_TEMP)
                                    {
                                        // printf("remove temp%d\n",temp->u.TEMP->num);
                                        replace_temp(ins->s->u.LOAD.dst->u.TEMP,temp->u.TEMP);
                                        it = b->instrs->ilist.erase(it);--it;
                                    }
                                    else if(temp->kind == AS_operand_::T_ICONST)
                                    {
                                        // printf("remove %d\n",temp->u.ICONST);
                                        replace_temp_int(ins->s->u.LOAD.dst->u.TEMP,temp->u.ICONST);
                                        it = b->instrs->ilist.erase(it);--it;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
