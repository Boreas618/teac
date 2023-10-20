#ifndef __LOOPTREE__
#define __LOOPTREE__


#include "deadce.h"
#include "graph.hpp"
#include "bg_llvm.h"
#include "flowgraph_llvm.h"
#include "assemblock.h"
#include <vector>
#include <unordered_set>
#include <list>
#include <stdio.h>

namespace looptree
{
struct BlockInfo
{
    G_node node;
    int preorder_number;
    AS_block2 block;
    bool visited;
    int nest_num = -1;
    std::list<AS_block2>::iterator iter; 
    BlockInfo(G_node _node,int num,AS_block2 b):node(_node),preorder_number(num),block(b),visited(false),iter() {}
};

struct LoopNode
{
    AS_block2 header;
    std::unordered_set<AS_block2> loop_block;
    std::unordered_set<LoopNode*> inner_loop;
    LoopNode():header(nullptr),loop_block(),inner_loop() {}
};

LoopNode* gen_looptree(G_nodeList node,AS_block2List bl,G_graph g);

void printLoopInfo(FILE *os,LoopNode* node);
void update_blockmap(G_node node);
void gen_ins_nest_map(AS_block2List bl);

}


#endif