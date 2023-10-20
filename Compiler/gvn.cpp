#include "gvn.h"
#include "graph.hpp"
#include "deadce.h"
#include <stack>
#include <unordered_map>
#include <cassert>
#include <list>
#include <optional>
#include <unordered_set>
#include <map>
#include "data_chain.h"
#include "translate.hpp"
#include <memory>
#include "tempdsu.h"

using namespace std;
using namespace gvn;

static stack<AS_block2> postorder_stack;
static map<tuple<LLVM_IR::T_binOp,opt_type,opt_type>,Temp_temp> binary_map;
static unordered_map<int,scalar_type> temp_scalar_map;
static unordered_map<scalar_type,Temp_temp> scalar_temp_map;
static unordered_set<G_node> visted;
static map<pair<index_type,opt_type>,Temp_temp> index_map;
static unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> du_chain;
static unordered_map<int,shared_ptr<unordered_set<Temp_temp>>> move_temp_map;
static map<pair<std::string,vector<opt_type>>,Temp_temp> purefunc_map;
static TempDsu tempDsu;

static bool is_modify = false;

static int type_compute_int(LLVM_IR::T_binOp op,const int& l,const int& r)
{
    switch (op)
    {
    case LLVM_IR::T_plus:
        return l + r;
    case LLVM_IR::T_minus:
        return l - r;
    case LLVM_IR::T_mul:
        return l * r;
    case LLVM_IR::T_div:
        return l / r;
    case LLVM_IR::T_mod:
        return l % r;
    default:
        assert(0);
        break;
    }
}

static float type_compute_float(LLVM_IR::T_binOp op,const float& l,const float& r)
{
    switch (op)
    {
    case LLVM_IR::F_plus:
        return l + r;
    case LLVM_IR::F_minus:
        return l - r;
    case LLVM_IR::F_mul:
        return l * r;
    case LLVM_IR::F_div:
        return l / r;
    default:
        assert(0);
        break;
    }
}

static scalar_type compute(LLVM_IR::T_binOp op,const scalar_type& l,const scalar_type& r)
{
    if(auto as_int1 = get_if<int>(&l);as_int1)
    {
        if(auto as_int2 = get_if<int>(&r);as_int2)
        {
            return type_compute_int(op,*as_int1,*as_int2);
        }
    }
    if(auto as_float1 = get_if<float>(&l);as_float1)
    {
        if(auto as_float2 = get_if<float>(&r);as_float2)
        {
            return type_compute_float(op,*as_float1,*as_float2);
        }
    }
    assert(0);
    return scalar_type(0);
}

static bool is_compute_useless(LLVM_IR::T_binOp op,const std::optional<scalar_type>& l,const std::optional<scalar_type>& r)
{
    switch (op)
    {
    case LLVM_IR::T_plus:
        return l == scalar_type(0) || r == scalar_type(0);
    case LLVM_IR::T_minus:
        return r == scalar_type(0);
    case LLVM_IR::T_mul:
        return l == scalar_type(1) || r == scalar_type(1);
    case LLVM_IR::T_div:
        return r == scalar_type(1);
    case LLVM_IR::T_mod:
        return false;
    case LLVM_IR::F_plus:
        return l == scalar_type(-0.0f) || r == scalar_type(-0.0f);
    case LLVM_IR::F_minus:
        return r == scalar_type(0.0f);
    case LLVM_IR::F_mul:
        return l == scalar_type(1.0f) || r == scalar_type(1.0f);
    case LLVM_IR::F_div:
        return r == scalar_type(1.0f);
    default:
        assert(0);
        break;
    }
    return false;
}

static bool is_commutable(LLVM_IR::T_binOp op)
{
    switch (op)
    {
    case LLVM_IR::T_plus:
        return true;
    case LLVM_IR::T_minus:
        return false;
    case LLVM_IR::T_mul:
        return true;
    case LLVM_IR::T_div:
        return false;
    case LLVM_IR::T_mod:
        return false;
    case LLVM_IR::F_plus:
        return true;
    case LLVM_IR::F_minus:
        return false;
    case LLVM_IR::F_mul:
        return true;
    case LLVM_IR::F_div:
        return false;
    default:
        assert(0);
        break;
    }
    return false;
}

static void reverse_poseorder(G_node node)
{
    if(visted.find(node) != visted.end())
    {
        return;
    }
    visted.emplace(node);
    for(auto m = G_succ(node);m != nullptr;m = m->tail)
    {
        reverse_poseorder(m->head);
    }
    postorder_stack.push((AS_block2)node->info);
}

static tuple<LLVM_IR::T_binOp,opt_type,opt_type> get_key(LLVM_IR::llvm_T_stm_ *s)
{
    opt_type l,r;
    switch (s->u.BINOP.left->kind)
    {
    case AS_operand_::T_ICONST:
    {
        l.emplace<1>(s->u.BINOP.left->u.ICONST);
        break;
    }
    case AS_operand_::T_TEMP:
    {
        l.emplace<0>(s->u.BINOP.left->u.TEMP->num);
        break;
    }
    case AS_operand_::T_FCONST:
    {
        l.emplace<2>(s->u.BINOP.left->u.FCONST);
        break;
    }
    default:
        assert(0);
        break;
    }
    switch (s->u.BINOP.right->kind)
    {
    case AS_operand_::T_ICONST:
    {
        r.emplace<1>(s->u.BINOP.right->u.ICONST);
        break;
    }
    case AS_operand_::T_TEMP:
    {
        r.emplace<0>(s->u.BINOP.right->u.TEMP->num);
        break;
    }
    case AS_operand_::T_FCONST:
    {
        r.emplace<2>(s->u.BINOP.right->u.FCONST);
        break;
    }
    default:
        assert(0);
        break;
    }
    return make_tuple(s->u.BINOP.op,l,r);
}

static pair<index_type,opt_type> get_index_key(LLVM_IR::llvm_T_stm_ *s)
{
    index_type l = 0;
    if(s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP)
    {
        l = s->u.GEP.base_ptr->u.TEMP->num;
    }
    else if(s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
    {
        l = Temp_labelstring(s->u.GEP.base_ptr->u.NAME.name);
    }
    else
    {
        assert(0);
    }
    opt_type r;
    if(s->u.GEP.index->kind == AS_operand_::T_TEMP)
    {
        r.emplace<0>(s->u.GEP.index->u.TEMP->num);
    }
    else if(s->u.GEP.index->kind == AS_operand_::T_ICONST)
    {
        r.emplace<1>(s->u.GEP.index->u.ICONST);
    }
    else
    {
        assert(0);
    }
    return make_pair(l,r);
}

static void init_move_temp_map(AS_block2List bl)
{
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

static void replace_temp(Temp_temp src,Temp_temp dst)
{
    is_modify = true;
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

static bool opt_eq(AS_operand op1,AS_operand op2)
{
    if(op1->kind != op2->kind)
    {
        return false;
    }
    switch (op1->kind)
    {
    case AS_operand_::T_ICONST:
        return op1->u.ICONST == op2->u.ICONST;
    case AS_operand_::T_TEMP:
        return op1->u.TEMP->num == op2->u.TEMP->num;
    case AS_operand_::T_NAME:
        return op1->u.NAME.name == op2->u.NAME.name;
    case AS_operand_::T_FCONST:
        return op1->u.FCONST == op2->u.FCONST;
    default:
        assert(0);
        break;
    }
    return false;
}

static pair<std::string,vector<opt_type>> make_func_key(LLVM_IR::T_ir ins)
{
    std::string name = ins->s->u.CALL.fun;
    vector<opt_type> v;
    for(auto tl = ins->s->u.CALL.args;tl != nullptr;tl = tl->tail)
    {
        auto t = tl->head;
        switch (t->kind)
        {
        case AS_operand_::T_TEMP:
        {
            opt_type val;
            val.emplace<0>(t->u.TEMP->num);
            v.push_back(val);
            break;
        }
        case AS_operand_::T_ICONST:
        {
            opt_type val;
            val.emplace<1>(t->u.ICONST);
            v.push_back(val);
            break;
        }
        case AS_operand_::T_FCONST:
        {
            opt_type val;
            val.emplace<2>(t->u.FCONST);
            v.push_back(val);
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    return make_pair(name,v);
}

static void modify_ins(LLVM_IR::T_ir ins,scalar_type computed)
{
    is_modify = true;
    auto dst_temp = ins->s->u.BINOP.dst;
    if(auto i_value = get_if<int>(&computed);i_value)
    {

        char as[1000];
        sprintf(as,"`d0 = bitcast i32 `s0 to i32");
        auto src_temp = AS_Operand_Const(*i_value);
        // if(dst_temp->u.TEMP->num == 373)
        // {
        //     printf("value:%d\n",*i_value);
        // }
        auto d_l = AS_OperandList(dst_temp,nullptr);
        auto s_l = AS_OperandList(src_temp,nullptr);
        ins->i = AS_Oper(String(as),d_l,s_l,nullptr);
        ins->s = LLVM_IR::T_Move(dst_temp,src_temp);
    }
    else if(auto f_value = get_if<float>(&computed);f_value)
    {
        char as[1000];
        sprintf(as,"`d0 = bitcast float `s0 to float");
        auto src_temp = AS_Operand_FConst(*f_value);
        auto d_l = AS_OperandList(dst_temp,nullptr);
        auto s_l = AS_OperandList(src_temp,nullptr);
        ins->i = AS_Oper(String(as),d_l,s_l,nullptr);
        ins->s = LLVM_IR::T_Move(dst_temp,src_temp);
    }
    else
    {
        assert(0);
    }
}

static void process_block(AS_block2 b)
{
    for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();it++)
    {
        auto ins = *it;
        switch (ins->s->kind)
        {
        case LLVM_IR::llvm_T_stm_::T_GEP:
        {
            auto index_key = get_index_key(ins->s);
            if(index_map.find(index_key) != index_map.end())
            {
                //printf("remove elem\n");
                replace_temp(ins->s->u.GEP.new_ptr->u.TEMP,index_map[index_key]);
                it = b->instrs->ilist.erase(it);--it;
            }
            else
            {
                if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
                {
                    if(ins->s->u.GEP.index->kind == AS_operand_::T_TEMP)
                    {
                        // for(auto &use_temp : *move_temp_map[ins->s->u.GEP.index->u.TEMP->num])
                        for(auto &use_temp : *tempDsu.getSet(ins->s->u.GEP.index->u.TEMP->num))
                        {
                            get<1>(index_key).emplace<0>(use_temp->num);
                            index_map[index_key] = ins->s->u.GEP.new_ptr->u.TEMP;
                        }
                    }
                    else
                    {
                        index_map[index_key] = ins->s->u.GEP.new_ptr->u.TEMP;
                    }
                }
                else if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP)
                {
                    if(ins->s->u.GEP.index->kind == AS_operand_::T_TEMP)
                    {
                        // for(auto &use_temp1 : *move_temp_map[ins->s->u.GEP.base_ptr->u.TEMP->num])
                        for(auto &use_temp1 : *tempDsu.getSet(ins->s->u.GEP.base_ptr->u.TEMP->num))
                        {
                            // for(auto &use_temp2 : *move_temp_map[ins->s->u.GEP.index->u.TEMP->num])
                            for(auto &use_temp2 : *tempDsu.getSet(ins->s->u.GEP.index->u.TEMP->num))
                            {
                                get<0>(index_key).emplace<0>(use_temp1->num);
                                get<1>(index_key).emplace<0>(use_temp2->num);
                                index_map[index_key] = ins->s->u.GEP.new_ptr->u.TEMP;
                            }
                        }
                    }
                    else
                    {
                        // for(auto &use_temp1 : *move_temp_map[ins->s->u.GEP.base_ptr->u.TEMP->num])
                        for(auto &use_temp1 : *tempDsu.getSet(ins->s->u.GEP.base_ptr->u.TEMP->num))
                        {
                            get<0>(index_key).emplace<0>(use_temp1->num);
                            index_map[index_key] = ins->s->u.GEP.new_ptr->u.TEMP;
                        }
                    }
                }
                else
                {
                    assert(0);
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_BINOP:
        {
            auto key = get_key(ins->s);
            auto left = ins->s->u.BINOP.left;
            auto right = ins->s->u.BINOP.right;
            if(binary_map.find(key) != binary_map.end())
            {
                auto temp = binary_map[key];
                replace_temp(ins->s->u.BINOP.dst->u.TEMP,temp);
                ins->i->u.OPER.dst->head->u.TEMP = temp;
                it = b->instrs->ilist.erase(it);--it;
            }
            else
            {
                if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP && ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                {
                    if(temp_scalar_map.find(left->u.TEMP->num) != temp_scalar_map.end() && 
                        temp_scalar_map.find(right->u.TEMP->num) != temp_scalar_map.end())
                    {
                        auto l_v = temp_scalar_map[left->u.TEMP->num];
                        auto r_v = temp_scalar_map[right->u.TEMP->num];
                        auto computed = compute(ins->s->u.BINOP.op,l_v,r_v);
                        if(scalar_temp_map.find(computed) != scalar_temp_map.end())
                        {
                            replace_temp(ins->s->u.BINOP.dst->u.TEMP,scalar_temp_map[computed]);
                            ins->i->u.OPER.dst->head->u.TEMP = scalar_temp_map[computed];
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto eq_temp : *move_temp_map[ins->s->u.BINOP.dst->u.TEMP->num])
                            for(auto eq_temp : *tempDsu.getSet(ins->s->u.BINOP.dst->u.TEMP->num))
                            {
                                temp_scalar_map[eq_temp->num] = computed;
                                scalar_temp_map[computed] = eq_temp;
                            }
                            //todo:modify ins
                            modify_ins(ins,computed);
                        }
                    }
                    else
                    {
                        optional<scalar_type> l_v = nullopt;
                        optional<scalar_type> r_v = nullopt;
                        if(temp_scalar_map.find(left->u.TEMP->num) != temp_scalar_map.end())
                        {
                            l_v = temp_scalar_map[left->u.TEMP->num];
                        }
                        if(temp_scalar_map.find(right->u.TEMP->num) != temp_scalar_map.end())
                        {
                            r_v = temp_scalar_map[right->u.TEMP->num];
                        }
                        if(is_compute_useless(ins->s->u.BINOP.op,l_v,r_v))
                        {
                            if(l_v.has_value())
                            {
                                replace_temp(ins->s->u.BINOP.dst->u.TEMP,ins->s->u.BINOP.right->u.TEMP);
                                ins->i->u.OPER.dst->head->u.TEMP = ins->s->u.BINOP.right->u.TEMP;
                            }
                            else if(r_v.has_value())
                            {
                                replace_temp(ins->s->u.BINOP.dst->u.TEMP,ins->s->u.BINOP.left->u.TEMP);
                                ins->i->u.OPER.dst->head->u.TEMP = ins->s->u.BINOP.left->u.TEMP;
                            }
                            else
                            {
                                assert(0);
                            }
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto temp1 : *move_temp_map[ins->s->u.BINOP.left->u.TEMP->num])
                            for(auto temp1 : *tempDsu.getSet(ins->s->u.BINOP.left->u.TEMP->num))
                            {
                                // for(auto temp2 : *move_temp_map[ins->s->u.BINOP.right->u.TEMP->num])
                                for(auto temp2 : *tempDsu.getSet(ins->s->u.BINOP.right->u.TEMP->num))
                                {
                                    auto new_key = key;
                                    get<1>(new_key).emplace<0>(temp1->num);
                                    get<2>(new_key).emplace<0>(temp2->num);
                                    binary_map[new_key] = ins->s->u.BINOP.dst->u.TEMP;
                                    auto key2 = new_key;
                                    get<1>(key2) = get<2>(new_key);
                                    get<2>(key2) = get<1>(new_key);
                                    if(get<1>(new_key) != get<2>(new_key) && is_commutable(ins->s->u.BINOP.op))
                                    {
                                        binary_map[key2] = ins->s->u.BINOP.dst->u.TEMP;
                                    }
                                }
                            }
                            // binary_map[key] = ins->s->u.BINOP.dst->u.TEMP;
                            // auto key2 = key;
                            // get<1>(key2) = get<2>(key);
                            // get<2>(key2) = get<1>(key);
                            // if(get<1>(key) != get<2>(key) && is_commutable(ins->s->u.BINOP.op))
                            // {
                            //     binary_map[key2] = ins->s->u.BINOP.dst->u.TEMP;
                            // }
                        }
                    }
                }
                else if(ins->s->u.BINOP.left->kind == AS_operand_::T_ICONST && ins->s->u.BINOP.right->kind == AS_operand_::T_ICONST)
                {
                    scalar_type l_v = left->u.ICONST;
                    scalar_type r_v = right->u.ICONST;
                    auto computed = compute(ins->s->u.BINOP.op,l_v,r_v);
                    if(scalar_temp_map.find(computed) != scalar_temp_map.end())
                    {
                        replace_temp(ins->s->u.BINOP.dst->u.TEMP,scalar_temp_map[computed]);
                        ins->i->u.OPER.dst->head->u.TEMP = scalar_temp_map[computed];
                        it = b->instrs->ilist.erase(it);--it;
                    }
                    else
                    {
                        // for(auto eq_temp : *move_temp_map[ins->s->u.BINOP.dst->u.TEMP->num])
                        for(auto eq_temp : *tempDsu.getSet(ins->s->u.BINOP.dst->u.TEMP->num))
                        {
                            temp_scalar_map[eq_temp->num] = computed;
                            scalar_temp_map[computed] = eq_temp;
                        }
                        //todo:modify ins
                        modify_ins(ins,computed);
                    }
                }
                else if(ins->s->u.BINOP.left->kind == AS_operand_::T_FCONST && ins->s->u.BINOP.right->kind == AS_operand_::T_FCONST)
                {
                    scalar_type l_v = left->u.FCONST;
                    scalar_type r_v = right->u.FCONST;
                    auto computed = compute(ins->s->u.BINOP.op,l_v,r_v);
                    if(scalar_temp_map.find(computed) != scalar_temp_map.end())
                    {
                        replace_temp(ins->s->u.BINOP.dst->u.TEMP,scalar_temp_map[computed]);
                        ins->i->u.OPER.dst->head->u.TEMP = scalar_temp_map[computed];
                        it = b->instrs->ilist.erase(it);--it;
                    }
                    else
                    {
                        // for(auto eq_temp : *move_temp_map[ins->s->u.BINOP.dst->u.TEMP->num])
                        for(auto eq_temp : *tempDsu.getSet(ins->s->u.BINOP.dst->u.TEMP->num))
                        {
                            temp_scalar_map[eq_temp->num] = computed;
                            scalar_temp_map[computed] = eq_temp;
                        }
                        //todo:modify ins
                        modify_ins(ins,computed);
                    }
                }
                else if(ins->s->u.BINOP.left->kind == AS_operand_::T_TEMP)
                {
                    if(temp_scalar_map.find(left->u.TEMP->num) != temp_scalar_map.end())
                    {
                        auto l_v = temp_scalar_map[left->u.TEMP->num];
                        auto r_v = scalar_type(0);
                        if(right->kind == AS_operand_::T_ICONST)
                        {
                            r_v = right->u.ICONST;
                        }
                        else if(right->kind == AS_operand_::T_FCONST)
                        {
                            r_v = right->u.FCONST;
                        }
                        else
                        {
                            assert(0);
                        }
                        auto computed = compute(ins->s->u.BINOP.op,l_v,r_v);
                        if(scalar_temp_map.find(computed) != scalar_temp_map.end())
                        {
                            replace_temp(ins->s->u.BINOP.dst->u.TEMP,scalar_temp_map[computed]);
                            ins->i->u.OPER.dst->head->u.TEMP = scalar_temp_map[computed];
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto eq_temp : *move_temp_map[ins->s->u.BINOP.dst->u.TEMP->num])
                            for(auto eq_temp : *tempDsu.getSet(ins->s->u.BINOP.dst->u.TEMP->num))
                            {
                                temp_scalar_map[eq_temp->num] = computed;
                                scalar_temp_map[computed] = eq_temp;
                            }
                            //todo:modify ins
                            modify_ins(ins,computed);
                        }
                    }
                    else
                    {
                        optional<scalar_type> l_v = nullopt;
                        optional<scalar_type> r_v = nullopt;
                        if(right->kind == AS_operand_::T_ICONST)
                        {
                            r_v = right->u.ICONST;
                        }
                        else if(right->kind == AS_operand_::T_FCONST)
                        {
                            r_v = right->u.FCONST;
                        }
                        else
                        {
                            assert(0);
                        }
                        if(is_compute_useless(ins->s->u.BINOP.op,l_v,r_v))
                        {
                            replace_temp(ins->s->u.BINOP.dst->u.TEMP,ins->s->u.BINOP.left->u.TEMP);
                            ins->i->u.OPER.dst->head->u.TEMP = ins->s->u.BINOP.left->u.TEMP;
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto temp1 : *move_temp_map[ins->s->u.BINOP.left->u.TEMP->num])
                            for(auto temp1 : *tempDsu.getSet(ins->s->u.BINOP.left->u.TEMP->num))
                            {
                                opt_type op1;
                                op1.emplace<0>(temp1->num);
                                decltype(key) new_key = make_tuple(ins->s->u.BINOP.op,op1,get<2>(key));
                                binary_map.emplace(new_key,ins->s->u.BINOP.dst->u.TEMP);
                                decltype(key) key2 = make_tuple(get<0>(new_key),get<2>(new_key),get<1>(new_key));
                                if(get<1>(new_key) != get<2>(new_key) && is_commutable(ins->s->u.BINOP.op))
                                {
                                    binary_map.emplace(key2,ins->s->u.BINOP.dst->u.TEMP);
                                }
                            }
                            // binary_map[key] = ins->s->u.BINOP.dst->u.TEMP;
                            // auto key2 = key;
                            // get<1>(key2) = get<2>(key);
                            // get<2>(key2) = get<1>(key);
                            // if(get<1>(key) != get<2>(key) && is_commutable(ins->s->u.BINOP.op))
                            // {
                            //     binary_map[key2] = ins->s->u.BINOP.dst->u.TEMP;
                            // }
                        }
                    }
                }
                else if(ins->s->u.BINOP.right->kind == AS_operand_::T_TEMP)
                {
                    if(temp_scalar_map.find(right->u.TEMP->num) != temp_scalar_map.end())
                    {
                        auto r_v = temp_scalar_map[right->u.TEMP->num];
                        auto l_v = scalar_type(0);
                        if(left->kind == AS_operand_::T_ICONST)
                        {
                            l_v = left->u.ICONST;
                        }
                        else if(left->kind == AS_operand_::T_FCONST)
                        {
                            l_v = left->u.FCONST;
                        }
                        else
                        {
                            assert(0);
                        }
                        auto computed = compute(ins->s->u.BINOP.op,l_v,r_v);
                        if(scalar_temp_map.find(computed) != scalar_temp_map.end())
                        {
                            replace_temp(ins->s->u.BINOP.dst->u.TEMP,scalar_temp_map[computed]);
                            ins->i->u.OPER.dst->head->u.TEMP = scalar_temp_map[computed];
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto eq_temp : *move_temp_map[ins->s->u.BINOP.dst->u.TEMP->num])
                            for(auto eq_temp : *tempDsu.getSet(ins->s->u.BINOP.dst->u.TEMP->num))
                            {
                                temp_scalar_map[eq_temp->num] = computed;
                                scalar_temp_map[computed] = eq_temp;
                            }
                            //todo:modify ins
                            modify_ins(ins,computed);
                        }
                    }
                    else
                    {
                        optional<scalar_type> r_v = nullopt;
                        optional<scalar_type> l_v = nullopt;
                        if(left->kind == AS_operand_::T_ICONST)
                        {
                            l_v = left->u.ICONST;
                        }
                        else if(left->kind == AS_operand_::T_FCONST)
                        {
                            l_v = left->u.FCONST;
                        }
                        else
                        {
                            assert(0);
                        }
                        if(is_compute_useless(ins->s->u.BINOP.op,l_v,r_v))
                        {
                            replace_temp(ins->s->u.BINOP.dst->u.TEMP,ins->s->u.BINOP.right->u.TEMP);
                            ins->i->u.OPER.dst->head->u.TEMP = ins->s->u.BINOP.right->u.TEMP;
                            it = b->instrs->ilist.erase(it);--it;
                        }
                        else
                        {
                            // for(auto temp2 : *move_temp_map[ins->s->u.BINOP.right->u.TEMP->num])
                            for(auto temp2 : *tempDsu.getSet(ins->s->u.BINOP.right->u.TEMP->num))
                            {
                                auto new_key = key;
                                get<2>(new_key).emplace<0>(temp2->num);
                                binary_map[new_key] = ins->s->u.BINOP.dst->u.TEMP;
                                auto key2 = new_key;
                                get<1>(key2) = get<2>(new_key);
                                get<2>(key2) = get<1>(new_key);
                                if(get<1>(new_key) != get<2>(new_key) && is_commutable(ins->s->u.BINOP.op))
                                {
                                    binary_map[key2] = ins->s->u.BINOP.dst->u.TEMP;
                                }
                            }
                            // binary_map[key] = ins->s->u.BINOP.dst->u.TEMP;
                            // auto key2 = key;
                            // get<1>(key2) = get<2>(key);
                            // get<2>(key2) = get<1>(key);
                            // if(get<1>(key) != get<2>(key) && is_commutable(ins->s->u.BINOP.op))
                            // {
                            //     binary_map[key2] = ins->s->u.BINOP.dst->u.TEMP;
                            // }
                        }
                    }
                }
                else
                {
                    assert(0);
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_PHI:
        {
            bool is_same = true;
            Phi_pair prev = nullptr;
            for(auto pl = ins->s->u.PHI.phis;pl != nullptr;pl = pl->tail)
            {
                if(prev == nullptr)
                {
                    prev = pl->head;
                }
                else
                {
                    if(!opt_eq(prev->op,pl->head->op))
                    {
                        is_same = false;
                        break;
                    }
                }
            }
            if(is_same)
            {
                if(prev->op->kind == AS_operand_::T_TEMP)
                {
                    if(prev->op->u.TEMP->type == INT_TEMP || prev->op->u.TEMP->type == FLOAT_TEMP)
                    {
                        //printf("remove phi ins\n");
                        replace_temp(ins->s->u.PHI.dst->u.TEMP,prev->op->u.TEMP);
                    }
                    else if(prev->op->u.TEMP->type == INT_PTR || prev->op->u.TEMP->type == FLOAT_PTR)
                    {
                        assert(0);
                    }
                    else
                    {
                        assert(0);
                    }
                    is_modify = true;
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    assert(0);
                }
            }
            //todo
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_VOID_CALL:
        {
            if(ispure(ins->s->u.VOID_CALL.fun))
            {
                //printf("void pure func remove\n");
                is_modify = true;
                it = b->instrs->ilist.erase(it);--it;
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_CALL:
        {
            if(ispure(ins->s->u.CALL.fun))
            {
                auto key = make_func_key(ins);
                if(purefunc_map.find(key) != purefunc_map.end())
                {
                    replace_temp(ins->s->u.CALL.res->u.TEMP,purefunc_map[key]);
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    purefunc_map.emplace(key,ins->s->u.CALL.res->u.TEMP);
                }
            }
            break;
        }
        case LLVM_IR::llvm_T_stm_::T_MOVE:
        {
            if(ins->s->u.MOVE.src->kind == AS_operand_::T_ICONST)
            {
                scalar_type va(ins->s->u.MOVE.src->u.ICONST);
                if(scalar_temp_map.find(va) != scalar_temp_map.end())
                {
                    replace_temp(ins->s->u.MOVE.dst->u.TEMP,scalar_temp_map[va]);
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    scalar_temp_map.emplace(va,ins->s->u.MOVE.dst->u.TEMP);
                    temp_scalar_map.emplace(ins->s->u.MOVE.dst->u.TEMP->num,va);
                }
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_FCONST)
            {
                scalar_type va(ins->s->u.MOVE.src->u.FCONST);
                if(scalar_temp_map.find(va) != scalar_temp_map.end())
                {
                    replace_temp(ins->s->u.MOVE.dst->u.TEMP,scalar_temp_map[va]);
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    scalar_temp_map.emplace(va,ins->s->u.MOVE.dst->u.TEMP);
                    temp_scalar_map.emplace(ins->s->u.MOVE.dst->u.TEMP->num,va);
                }
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
            {
                // move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num]->merge(*move_temp_map[ins->s->u.MOVE.src->u.TEMP->num]);
                // move_temp_map[ins->s->u.MOVE.src->u.TEMP->num] = move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num];
                // replace_temp(ins->s->u.MOVE.dst->u.TEMP,ins->s->u.MOVE.src->u.TEMP);
                // it = b->instrs->ilist.erase(it);--it;
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
            {
                
            }
            else
            {
                assert(0);
            }
            break;
        }
        default:
            break;
        }
    }
}

static void process_block2(AS_block2 b)
{
    for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();it++)
    {
        auto ins = *it;
        if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
        {
            if(ins->s->u.MOVE.src->kind == AS_operand_::T_ICONST)
            {
                scalar_type va(ins->s->u.MOVE.src->u.ICONST);
                if(scalar_temp_map.find(va) != scalar_temp_map.end())
                {
                    replace_temp(ins->s->u.MOVE.dst->u.TEMP,scalar_temp_map[va]);
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    scalar_temp_map.emplace(va,ins->s->u.MOVE.dst->u.TEMP);
                    temp_scalar_map.emplace(ins->s->u.MOVE.dst->u.TEMP->num,va);
                }
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_FCONST)
            {
                scalar_type va(ins->s->u.MOVE.src->u.FCONST);
                if(scalar_temp_map.find(va) != scalar_temp_map.end())
                {
                    replace_temp(ins->s->u.MOVE.dst->u.TEMP,scalar_temp_map[va]);
                    it = b->instrs->ilist.erase(it);--it;
                }
                else
                {
                    scalar_temp_map.emplace(va,ins->s->u.MOVE.dst->u.TEMP);
                    temp_scalar_map.emplace(ins->s->u.MOVE.dst->u.TEMP->num,va);
                }
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_TEMP)
            {
                // move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num]->merge(*move_temp_map[ins->s->u.MOVE.src->u.TEMP->num]);
                // move_temp_map[ins->s->u.MOVE.src->u.TEMP->num] = move_temp_map[ins->s->u.MOVE.dst->u.TEMP->num];
                replace_temp(ins->s->u.MOVE.dst->u.TEMP,ins->s->u.MOVE.src->u.TEMP);
                it = b->instrs->ilist.erase(it);--it;
            }
            else if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
            {
                
            }
            else
            {
                assert(0);
            }
        }
    }
}

bool gvn::gvn(AS_block2List bl,G_node node)
{
    is_modify = false;
    visted.clear();
    binary_map.clear();
    temp_scalar_map.clear();
    scalar_temp_map.clear();
    index_map.clear();
    move_temp_map.clear();
    purefunc_map.clear();
    init_move_temp_map(bl);
    du_chain = datachain::get_du_chain(bl);
    reverse_poseorder(node);
    while (!postorder_stack.empty())
    {
        auto b = postorder_stack.top();
        postorder_stack.pop();
        process_block(b);
    }
    // visted.clear();
    // binary_map.clear();
    // temp_scalar_map.clear();
    // scalar_temp_map.clear();
    // index_map.clear();
    // move_temp_map.clear();
    // purefunc_map.clear();
    // init_move_temp_map(bl);
    // du_chain = datachain::get_du_chain(bl);
    // reverse_poseorder(node);
    // while (!postorder_stack.empty())
    // {
    //     auto b = postorder_stack.top();
    //     postorder_stack.pop();
    //     process_block(b);
    // }
    return is_modify;
}