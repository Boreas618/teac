#include <stdio.h>
#include <stdlib.h>
#include "util.h"
//#include "table.h"
#include "graph.hpp"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "bg2.h"
#include <assert.h>

/* graph on AS_ basic blocks. This is useful to find dominance 
   relations, etc. */

using namespace BG_LLVM_2;

static G_graph RA_bg;
static S_table block_env;

static void Bg_empty() {
    RA_bg=G_Graph();
}

G_graph BG_LLVM_2::Bg_graph() {
    return RA_bg;
}

S_table BG_LLVM_2::Bg_block_env(){
    return block_env;
}

G_node Look_bg(AS_block2 b){
    G_node n1=NULL;
    for (G_nodeList n=G_nodes(RA_bg); n!=NULL; n=n->tail) {
        if ((AS_block2)G_nodeInfo(n->head) == b) {
            n1=n->head;
            break;
        }
    }
    if (n1==NULL) return(G_Node(RA_bg, b));
    else return n1;
}

static void Enter_bg(AS_block2 b1, AS_block2 b2) {
    G_node n1=Look_bg(b1);
    G_node n2=Look_bg(b2);
    G_addEdge(n1, n2);
    return;
}

/* input LLVM_IR::AS_block_ *List after instruction selection for each block 
   in the C_Block, generate a graph on the basic blocks */


G_nodeList BG_LLVM_2::Create_bg(AS_block2List bl) {
    auto list=bl;

    RA_bg=G_Graph(); // prepare the empty graph
    block_env = S_empty(); //build a table of label -> block

    for (auto &l:bl->blist) {
      S_enter(block_env, l->label, l);
      Look_bg(l); /* enter the block into graph as a node */
    }

    for (auto &l:bl->blist) {
      Temp_labelList tl = l->succs;
      while (tl) {
        auto succ = (AS_block2)S_look(block_env, tl->head);
    //if the succ label doesn't have a block, assume it's the "exit label",
    //then this doesn't form an edge in the bg graph
        if (succ) Enter_bg(l, succ); 
        tl=tl->tail;
      }
    }
    return G_nodes(RA_bg);
}

static void show_AS_Block (void *b, FILE *out) {
    fprintf(out, "%s, ", Temp_labelstring(((AS_block2)b)->label));
}

void BG_LLVM_2::Show_bg(FILE* out, G_nodeList l) {
    G_show(out, l, show_AS_Block);
}

