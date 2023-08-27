#include <cstdio>
#include <unordered_map>
#include <stack>
#include <queue>
#include <algorithm>
#include <string>
#include <cassert>
#include <string.h>
#include <string>
#include "assem.h"
#include "temp.h"
#include "looptree.h"
#include "llvm_assem.h"
#include "llvm_assemblock.h"
#include "domtree.h"

using namespace std;
using namespace looptree;

unordered_map<AS_block2,BlockInfo*> block_map;
static queue<pair<BlockInfo*,BlockInfo*>> block_queue;
static unordered_map<AS_block2,LoopNode*> loop_map;
extern unordered_map<std::string,domtree::DomNode*> dom_map;
extern unordered_map<std::string,AS_block2> label_block_map;
unordered_map<std::string,int> label_depth_map;
unordered_map<std::string,AS_block2> first_loop_block;

static int block_count = 0;

static void block_dfs(G_node node)
{
    AS_block2 b = (AS_block2)node->info;
    if(block_map.find(b) != block_map.end())
    {
        return;
    }
    BlockInfo* bi = new BlockInfo(node,0,b);
    block_map.emplace(b,bi);
    for(G_nodeList m = G_succ(node);m != nullptr;m = m->tail)
    {
        G_node n = m->head;
        AS_block2 n_b = (AS_block2)n->info;
        block_dfs(n);
    }
    block_map[b]->preorder_number = block_count--;
}
static void find_loop(G_node node)
{
    AS_block2 b = (AS_block2)node->info;
    if(block_map[b]->visited)
    {
        return;
    }
    block_map[b]->visited = true;
    for(G_nodeList m = G_succ(node);m != nullptr;m = m->tail)
    {
        G_node n = m->head;
        AS_block2 n_b = (AS_block2)n->info;
        if(block_map[n_b]->preorder_number <= block_map[b]->preorder_number)
        {
            block_queue.push(make_pair(block_map[n_b],block_map[b]));
        }
    }
    for(G_nodeList m = G_succ(node);m != nullptr;m = m->tail)
    {
        G_node n = m->head;
        find_loop(n);
    }
}

static void clean_visit()
{
    for(auto &it : block_map)
    {
        it.second->visited = false;
    }
}

static void gen_loopnode(G_node node,LoopNode *loopnode)
{
    AS_block2 block = (AS_block2)node->info;
    auto it = block_map.find(block);
    if(it != block_map.end())
    {
        if(it->second->visited)
        {
            return;
        }
    }
    else
    {
        assert(0);
    }
    BlockInfo *bi = it->second;
    bi->visited = true;
    loopnode->loop_block.insert(block);
    if(auto it = loop_map.find(block);it != loop_map.end())
    {
        loopnode->inner_loop.emplace(it->second);
    }
    for(G_nodeList m = G_pred(node);m != nullptr;m = m->tail)
    {
        gen_loopnode(m->head,loopnode);
    }
}

static void combine_loop(AS_block2 b,LoopNode *n)
{
    auto m = loop_map[b];
    for(auto &v:n->inner_loop)
    {
        if(m->inner_loop.find(v) == m->inner_loop.end())
        {
            m->inner_loop.emplace(v);
        }
    }
    for(auto &v:n->loop_block)
    {
        if(m->loop_block.find(v) == m->loop_block.end())
        {
            m->loop_block.emplace(v);
        }
    }
}

static void gen_padding(G_node node,LoopNode *loopnode,AS_block2List bl,G_graph g)
{
    AS_block2 block = (AS_block2)node->info;
    Temp_label label = Temp_newlabel();
    char as[100];
    sprintf(as,"%s:",Temp_labelstring(label));
    AS_instr ins_label = AS_Label(String(as),label);
    auto t_label = LLVM_IR::T_Ir(LLVM_IR::T_Label(label),ins_label);
    sprintf(as,"br label `j0");
    AS_instr ins_jump = AS_Oper(String(as),nullptr,nullptr,AS_Targets(Temp_LabelList(block->label,nullptr)));
    auto t_jump = LLVM_IR::T_Ir(LLVM_IR::T_Jump(block->label),ins_jump);
    auto ins_list = LLVM_IR::T_IrList(t_label,LLVM_IR::T_IrList(t_jump,nullptr));
    auto new_block_ = LLVM_IR::AS_Block(ins_list);
    auto new_block = block_2_block2(new_block_);
    //G_node new_node = G_Node(g,new_block);
    //G_addEdge(new_node,node);

    label_block_map.emplace(Temp_labelstring(label),new_block);
    auto s_dom_node = dom_map[Temp_labelstring(block->label)];
    auto dom_node = new domtree::DomNode(s_dom_node->depth,Temp_labelstring(label));
    dom_node->prev = s_dom_node->prev;
    dom_node->succ.emplace(Temp_labelstring(block->label));
    dom_map.emplace(Temp_labelstring(label),dom_node);
    auto p_dom_node = dom_map[s_dom_node->prev];
    s_dom_node->prev = Temp_labelstring(label);
    p_dom_node->succ.erase(Temp_labelstring(block->label));
    p_dom_node->succ.emplace(Temp_labelstring(label));
    domtree::add_depth(Temp_labelstring(block->label));
    first_loop_block.emplace(Temp_labelstring(block->label),new_block);

    unordered_set<Temp_label> pre_label;
    for(auto m = G_pred(node);m != nullptr;m = m->tail)
    {
        auto b_ = (AS_block2)m->head->info;
        if(loop_map[block]->loop_block.find(b_) == loop_map[block]->loop_block.end())
        {
            pre_label.emplace(b_->label);
            for(auto tl = b_->succs;tl != nullptr;tl = tl->tail)
            {
                if(tl->head == block->label)
                {
                    tl->head = label;
                }
            }
        }
    }

    for(auto &i:block->instrs->ilist)
    {
        if(i->s->kind == LLVM_IR::llvm_T_stm_::T_PHI)
        {
            int count = 0;
            int flag = false;
            char as[20000] = {0};
            char as_[10000];
            AS_operandList t_list = nullptr,t_last = nullptr;
            Temp_labelList l_list = nullptr,l_last = nullptr;
            for(auto p = i->s->u.PHI.phis;p != nullptr;p = p->tail)
            {
                if(pre_label.find(p->head->label) != pre_label.end())
                {
                    //printf("here\n");
                    if(flag)
                    {
                        continue;
                    }
                    p->head->label = label;
                    flag = true;
                }
                if(count == 0)
                    sprintf(as_,"[`s0, `j0]");
                else
                    sprintf(as_,", [`s%d, `j%d]",count,count);
                strcat(as,as_);
                if(t_last)
                {
                    t_last = t_last->tail = AS_OperandList(p->head->op,nullptr);
                }
                else
                {
                    t_last = t_list = AS_OperandList(p->head->op,nullptr);
                }
                if(l_last)
                {
                    l_last = l_last->tail = Temp_LabelList(p->head->label,nullptr);
                }
                else
                {
                    l_last = l_list = Temp_LabelList(p->head->label,nullptr);
                }
                count++;
            }
            auto dst = i->s->u.PHI.dst;
            char as_buf[20000];
            switch (dst->u.TEMP->type)
            {
            case INT_TEMP:
            {
                sprintf(as_buf, "`d0 = phi i32 %s", as);
                break;
            }
            case FLOAT_TEMP:
            {
                sprintf(as_buf, "`d0 = phi float %s", as);
                break;
            }
            case INT_PTR:
            case FLOAT_PTR:
            {
                sprintf(as_buf, "`d0 = phi ptr %s", as);
                break;
            }
            default:
            {
                assert(0);
                break;
            }
            }
            i->s = LLVM_IR::T_Phi(dst, l_list, t_list);
            i->i = AS_Oper(String(as_buf),AS_OperandList(dst, nullptr),t_list,AS_Targets(l_list));
        }
    }

    for(G_nodeList m = G_pred(node);m != nullptr;m = m->tail)
    {
        G_node n = m->head;
        AS_block2 prev_block = (AS_block2)n->info;
        if(loopnode->loop_block.find(prev_block) == loopnode->loop_block.end())
        {
            auto last_ins = prev_block->instrs->ilist.back();
            if(last_ins->s->kind == LLVM_IR::llvm_T_stm_::T_JUMP)
            {
                for(auto tl = last_ins->i->u.OPER.jumps->labels;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head == block->label)
                    {
                        tl->head = label;
                    }
                }
                assert(last_ins->s->u.JUMP.jump == block->label);
                last_ins->s->u.JUMP.jump = label;
                //G_rmEdge(n,node);
                //G_addEdge(n,new_node);
            }
            else if(last_ins->s->kind == LLVM_IR::llvm_T_stm_::T_CJUMP)
            {
                for(auto tl = last_ins->i->u.OPER.jumps->labels;tl != nullptr;tl = tl->tail)
                {
                    if(tl->head == block->label)
                    {
                        tl->head = label;
                    }
                }
                if(last_ins->s->u.CJUMP.false_label == block->label)
                {
                    last_ins->s->u.CJUMP.false_label = label;
                }
                else if(last_ins->s->u.CJUMP.true_label == block->label)
                {
                    last_ins->s->u.CJUMP.true_label = label;
                }
                else
                {
                    assert(0);
                }
                //G_rmEdge(n,node);
                //G_addEdge(n,new_node);
            }
            else
            {
                assert(0);
            }
            for(auto l = prev_block->succs;l != nullptr;l = l->tail)
            {
                if(l->head == block->label)
                {
                    l->head = label;
                }
            }
        }
    }
    block_map.emplace(new_block,new BlockInfo(nullptr,0,new_block));
    block_map[new_block]->iter = bl->blist.insert(block_map[block]->iter,new_block);
    block_map[new_block]->nest_num = block_map[block]->nest_num - 1;
    //bl->blist.push_back(new_block);
}

static void compute_nest(LoopNode *node)
{
    for(auto &b : node->loop_block)
    {
        block_map[b]->nest_num++;
    }
    for(auto &l : node->inner_loop)
    {
        compute_nest(l);
    }
}

LoopNode* looptree::gen_looptree(G_nodeList node,AS_block2List bl,G_graph g)
{
    block_map.clear();
    block_count = bl->blist.size();
    loop_map.clear();
    block_dfs(node->head);
    find_loop(node->head);
    clean_visit();
    for(auto it = bl->blist.begin();it != bl->blist.end();it++)
    {
        block_map[*it]->iter = it;
    }
    while (!block_queue.empty())
    {
        auto p = block_queue.front();
        block_queue.pop();
        clean_visit();
        block_map[p.first->block]->visited = true;
        auto loopnode = new LoopNode();
        loopnode->header = p.first->block;
        loopnode->loop_block.emplace(p.first->block);
        gen_loopnode(p.second->node,loopnode);
        if(loop_map.find(p.first->block) == loop_map.end())
        {
            loop_map.emplace(p.first->block,loopnode);
        }
        else
        {
            combine_loop(p.first->block,loopnode);
        }
    }
    auto root = new LoopNode();
    root->header = (AS_block2)node->head->info;
    for(auto &it : block_map)
    {
        root->loop_block.insert(it.first);
    }
    for(auto &it : loop_map)
    {
        root->inner_loop.emplace(it.second);
    }
    compute_nest(root);
    for(auto &it : loop_map)
    {
        auto node = block_map[it.first]->node;
        gen_padding(node,it.second,bl,g);
    }
    return root;
}

static void printLoopNode(FILE* os,LoopNode* node)
{
    fprintf(os,"header label:%s\n",Temp_labelstring(node->header->label));
    fprintf(os,"loop block:\n");
    for(auto &b : node->loop_block)
    {
        fprintf(os,"%s  ",Temp_labelstring(b->label));
    }
    fprintf(os,"\n");
    fprintf(os,"inner loop:\n");
    for(auto &m : node->inner_loop)
    {
        fprintf(os,"%s  ",Temp_labelstring(m->header->label));
    }
    fprintf(os,"\n");
    for(auto &m : node->inner_loop)
    {
        printLoopNode(os,m);
    }
}

void looptree::printLoopInfo(FILE *os,LoopNode* node)
{
    fprintf(os,"------------------Block Loop-------------------\n");
    printLoopNode(os,node);
    fprintf(os,"\n");
    for(auto &b : block_map)
    {
        fprintf(os,"%s nest num is %d\n",Temp_labelstring(b.second->block->label),b.second->nest_num);
    }
}

static void update_map(G_node node)
{
    auto b = (AS_block2)node->info;
    if(block_map[b]->visited)
    {
        return;
    }
    block_map[b]->visited = true;
    block_map[b]->node = node;
    label_depth_map.emplace(Temp_labelstring(b->label),block_map[b]->nest_num);
    for(auto m = G_succ(node);m != nullptr;m = m->tail)
    {
        update_map(m->head);
    }
}

void looptree::update_blockmap(G_node node)
{
    clean_visit();
    update_map(node);
}

void looptree::gen_ins_nest_map(AS_block2List bl)
{
    for(auto &b : bl->blist)
    {
        std::string block_label = Temp_labelstring(b->label);
        int depth = label_depth_map[block_label];
        for(auto &ins : b->instrs->ilist)
        {
            ins->i->nest_depth = depth;
        }
    }
}