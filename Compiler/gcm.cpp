#include <unordered_map>
#include "gcm.h"
#include "looptree.h"
#include "data_chain.h"
#include "assem.h"
#include "domtree.h"
#include <assert.h>
#include "translate.hpp"

using namespace std;
using namespace gcm;
using namespace looptree;
using namespace datachain;
using namespace domtree;

static unordered_map<LLVM_IR::T_ir, InsNode *> ins_map;
extern unordered_map<AS_block2, BlockInfo *> block_map;
static std::unordered_map<Temp_temp, std::vector<LLVM_IR::T_ir>> du_chain;
static std::unordered_map<Temp_temp, LLVM_IR::T_ir> ud_chain;
static AS_block2 root;
extern unordered_map<std::string, DomNode *> dom_map;
extern unordered_map<std::string, AS_block2> label_block_map;

static void init_map(AS_block2List bl)
{
    for (auto &b : bl->blist)
    {
        for (auto it = b->instrs->ilist.begin(); it != b->instrs->ilist.end(); it++)
        {
            ins_map.emplace(*it, new InsNode(b, it));
        }
    }
}

static void clean_visit()
{
    for (auto &it : ins_map)
    {
        it.second->visited = false;
    }
}

static void move_late(LLVM_IR::T_ir ins, AS_block2 b)
{
    auto it = ins_map[ins]->iter;
    b->instrs->ilist.erase(it);
    auto end_it = ----b->instrs->ilist.end();
    if((*end_it)->s->kind != LLVM_IR::llvm_T_stm_::T_CMP)
    {
        ++end_it;
    }
    ins_map[ins]->iter = b->instrs->ilist.insert(end_it,ins);
    ins_map[ins]->block = b;
}

static void move_early(LLVM_IR::T_ir ins, AS_block2 b)
{
    auto it = ins_map[ins]->iter;
    b->instrs->ilist.erase(it);
    auto iter = b->instrs->ilist.begin();
    while (iter != b->instrs->ilist.end())
    {
        auto i = *iter;
        if (i->s->kind != LLVM_IR::llvm_T_stm_::T_LABEL && i->s->kind != LLVM_IR::llvm_T_stm_::T_PHI)
        {
            break;
        }
        iter++;
    }
    ins_map[ins]->iter = b->instrs->ilist.insert(iter, ins);
    ins_map[ins]->block = b;
}

static bool is_pinned(LLVM_IR::T_ir i)
{
    if (i->s->kind == LLVM_IR::llvm_T_stm_::T_CJUMP)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_JUMP)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_RETURN)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
    {
        return true;
    }
    // func
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_CALL)
    {
        if (ispure(i->s->u.CALL.fun))
        {
            // printf("func:%s\n",i->s->u.CALL.fun);
            return false;
        }
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL)
    {
        if (ispure(i->s->u.VOID_CALL.fun))
        {
            // printf("void func:%s\n",i->s->u.VOID_CALL.fun);
            return false;
        }
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_CMP)
    {
        return true;
    }
    else if (i->s->kind == LLVM_IR::llvm_T_stm_::T_LABEL)
    {
        return true;
    }
    else
    {
        return false;
    }
}

static AS_block2 schedule_early(LLVM_IR::T_ir ins)
{
    if (ins_map[ins]->visited || is_pinned(ins))
    {
        return ins_map[ins]->block;
    }
    ins_map[ins]->visited = true;
    auto target = root;
    if (ins->i->kind == AS_instr_::I_OPER)
    {
        for (auto tl = ins->i->u.OPER.src; tl != nullptr; tl = tl->tail)
        {
            auto t = tl->head;
            if (t->kind == AS_operand_::T_TEMP)
            {
                auto use_ins = ud_chain[t->u.TEMP];
                auto res = schedule_early(use_ins);
                if (dom_map[Temp_labelstring(target->label)]->depth < dom_map[Temp_labelstring(res->label)]->depth)
                {
                    target = ins_map[use_ins]->block;
                }
            }
        }
    }
    else if (ins->i->kind == AS_instr_::I_MOVE)
    {
        for (auto tl = ins->i->u.MOVE.src; tl != nullptr; tl = tl->tail)
        {
            auto t = tl->head;
            if (t->kind == AS_operand_::T_TEMP)
            {
                // printf("temp %d\n",t->u.TEMP->num);
                auto use_ins = ud_chain[t->u.TEMP];
                auto res = schedule_early(use_ins);
                if (dom_map[Temp_labelstring(target->label)]->depth < dom_map[Temp_labelstring(res->label)]->depth)
                {
                    target = ins_map[use_ins]->block;
                }
            }
        }
    }
    // printf("target:%s,origin:%s\n",Temp_labelstring(target->label),Temp_labelstring(ins_map[ins]->block->label));
    if (!is_pinned(ins) && target != ins_map[ins]->block)
    {
        // printf("move\n");
        move_late(ins, target);
    }
    return ins_map[ins]->block;
}

static void schedule_early(AS_block2List bl)
{
    clean_visit();
    for (auto &b : bl->blist)
    {
        for (auto &ins : b->instrs->ilist)
        {
            if (ins_map[ins]->visited)
            {
                continue;
            }
            if (is_pinned(ins))
            {
                ins_map[ins]->visited = true;
                if (ins->i->kind == AS_instr_::I_OPER)
                {
                    for (auto tl = ins->i->u.OPER.src; tl != nullptr; tl = tl->tail)
                    {
                        auto t = tl->head;
                        // AS_print_llvm(stdout, ins->i, Temp_name());
                        if (t->kind == AS_operand_::T_TEMP)
                        {
                            // printf("temp %d\n",t->u.TEMP->num);
                            auto use_ins = ud_chain[t->u.TEMP];
                            schedule_early(use_ins);
                        }
                    }
                }
                else if (ins->i->kind == AS_instr_::I_MOVE)
                {
                    for (auto tl = ins->i->u.MOVE.src; tl != nullptr; tl = tl->tail)
                    {
                        auto t = tl->head;
                        if (t->kind == AS_operand_::T_TEMP)
                        {
                            auto use_ins = ud_chain[t->u.TEMP];
                            schedule_early(use_ins);
                        }
                    }
                }
            }
        }
    }
}

static AS_block2 find_lca(AS_block2 a, AS_block2 b)
{
    assert(a != nullptr);
    assert(b != nullptr);
    while (a != b)
    {
        if (dom_map[Temp_labelstring(a->label)]->depth > dom_map[Temp_labelstring(b->label)]->depth)
        {
            auto &a_s = dom_map[Temp_labelstring(a->label)]->prev;
            a = label_block_map[a_s];
        }
        else if (dom_map[Temp_labelstring(b->label)]->depth > dom_map[Temp_labelstring(a->label)]->depth)
        {
            auto &b_s = dom_map[Temp_labelstring(b->label)]->prev;
            b = label_block_map[b_s];
        }
        else
        {
            auto &a_s = dom_map[Temp_labelstring(a->label)]->prev;
            a = label_block_map[a_s];
            auto &b_s = dom_map[Temp_labelstring(b->label)]->prev;
            b = label_block_map[b_s];
        }
        assert(a != nullptr);
        assert(b != nullptr);
    }
    return a;
}

static AS_block2 schedule_late(LLVM_IR::T_ir ins)
{
    if (ins_map[ins]->visited)
    {
        return ins_map[ins]->block;
    }
    ins_map[ins]->visited = true;
    AS_block2 lca = nullptr;
    if (ins->i->kind == AS_instr_::I_OPER)
    {
        for (auto tl = ins->i->u.OPER.dst; tl != nullptr; tl = tl->tail)
        {
            auto t = tl->head;
            if (t->kind == AS_operand_::T_TEMP)
            {
                auto use_inslist = du_chain[t->u.TEMP];
                if (use_inslist.empty())
                {
                    return ins_map[ins]->block;
                }
                for (auto &use_ins : use_inslist)
                {
                    vector<AS_block2> res = {schedule_late(use_ins)};
                    if (use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
                    {
                        res.clear();
                        unordered_set<std::string> pre_block;
                        for (auto pl = use_ins->s->u.PHI.phis; pl != nullptr; pl = pl->tail)
                        {
                            if (pl->head->op->kind == AS_operand_::T_TEMP && pl->head->op->u.TEMP == ins->i->u.OPER.dst->head->u.TEMP)
                            {
                                pre_block.emplace(Temp_labelstring(pl->head->label));
                            }
                        }
                        assert(!pre_block.empty());
                        for (auto pred = G_pred(block_map[ins_map[use_ins]->block]->node); pred != nullptr; pred = pred->tail)
                        {
                            auto bb = (AS_block2)pred->head->info;
                            if (pre_block.find(Temp_labelstring(bb->label)) != pre_block.end())
                            {
                                res.push_back(bb);
                            }
                        }
                    }
                    for (auto &u : res)
                    {
                        if (lca == nullptr)
                        {
                            lca = u;
                        }
                        else
                        {
                            lca = find_lca(lca, u);
                        }
                    }
                }
            }
            else
            {
                return ins_map[ins]->block;
            }
        }
    }
    else if (ins->i->kind == AS_instr_::I_MOVE)
    {
        for (auto tl = ins->i->u.MOVE.dst; tl != nullptr; tl = tl->tail)
        {
            auto t = tl->head;
            if (t->kind == AS_operand_::T_TEMP)
            {
                // printf("%d\n",t->u.TEMP->num);
                auto use_inslist = du_chain[t->u.TEMP];
                if (use_inslist.empty())
                {
                    return ins_map[ins]->block;
                }
                for (auto &use_ins : use_inslist)
                {
                    vector<AS_block2> res = {schedule_late(use_ins)};
                    if (use_ins->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
                    {
                        res.clear();
                        unordered_set<std::string> pre_block;
                        for (auto pl = use_ins->s->u.PHI.phis; pl != nullptr; pl = pl->tail)
                        {
                            if (pl->head->op->kind == AS_operand_::T_TEMP && pl->head->op->u.TEMP == ins->i->u.MOVE.dst->head->u.TEMP)
                            {
                                pre_block.emplace(Temp_labelstring(pl->head->label));
                            }
                        }
                        assert(!pre_block.empty());
                        for (auto pred = G_pred(block_map[ins_map[use_ins]->block]->node); pred != nullptr; pred = pred->tail)
                        {
                            auto bb = (AS_block2)pred->head->info;
                            if (pre_block.find(Temp_labelstring(bb->label)) != pre_block.end())
                            {
                                res.push_back(bb);
                            }
                        }
                    }
                    // printf("size:%d\n",res.size());
                    for (auto &u : res)
                    {
                        if (lca == nullptr)
                        {
                            lca = u;
                        }
                        else
                        {
                            lca = find_lca(lca, u);
                        }
                    }
                }
            }
            else
            {
                return ins_map[ins]->block;
            }
        }
    }
    else
    {
        return ins_map[ins]->block;
    }
    if (is_pinned(ins))
    {
        return ins_map[ins]->block;
    }
    // printf("%d %d\n",ins->i->kind,ins->s->kind);
    assert(lca != nullptr);
    AS_block2 best = lca;
    AS_block2 cur = lca;
    if (dom_map[Temp_labelstring(lca->label)]->depth < dom_map[Temp_labelstring(ins_map[ins]->block->label)]->depth)
    {
        printf("lca wrong\n");
        return ins_map[ins]->block;
        ;
    }
    while (cur != ins_map[ins]->block)
    {
        if (block_map[cur]->nest_num < block_map[best]->nest_num)
        {
            best = cur;
        }
        auto &lca_s = dom_map[Temp_labelstring(cur->label)]->prev;
        // printf("lca:%s\n",lca_s.c_str());
        cur = label_block_map[lca_s];
    }
    // printf("lca:%s,best%s,origin%s\n",Temp_labelstring(lca->label),Temp_labelstring(best->label),Temp_labelstring(ins_map[ins]->block->label));
    if (best != ins_map[ins]->block)
        move_early(ins, best);
    return ins_map[ins]->block;
}

static void schedule_late(AS_block2List bl)
{
    clean_visit();
    for (auto &b : bl->blist)
    {
        for (auto &ins : b->instrs->ilist)
        {
            if (ins_map[ins]->visited)
            {
                continue;
            }
            // if(is_pinned(ins))
            {
                ins_map[ins]->visited = true;
                if (ins->i->kind == AS_instr_::I_OPER)
                {
                    for (auto tl = ins->i->u.OPER.dst; tl != nullptr; tl = tl->tail)
                    {
                        auto t = tl->head;
                        if (t->kind == AS_operand_::T_TEMP)
                        {
                            auto use_inslist = du_chain[t->u.TEMP];
                            for (auto &use_ins : use_inslist)
                            {
                                schedule_late(use_ins);
                            }
                        }
                    }
                }
                else if (ins->i->kind == AS_instr_::I_MOVE)
                {
                    for (auto tl = ins->i->u.MOVE.src; tl != nullptr; tl = tl->tail)
                    {
                        auto t = tl->head;
                        if (t->kind == AS_operand_::T_TEMP)
                        {
                            auto use_inslist = du_chain[t->u.TEMP];
                            for (auto &use_ins : use_inslist)
                            {
                                schedule_late(use_ins);
                            }
                        }
                    }
                }
            }
        }
    }
}

void gcm::gcm(AS_block2List bl, G_node node)
{
    root = bl->blist.front();
    du_chain = get_du_chain(bl);
    ud_chain = get_ud_chain(bl);
    // printUDChain(stdout,ud_chain);
    ins_map.clear();
    init_map(bl);
    schedule_early(bl);
    schedule_late(bl);
}