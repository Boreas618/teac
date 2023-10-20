#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "oldtable.h"
#include "graph.hpp"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "bg_llvm.h"
#include <assert.h>
#include <unordered_map>

/* graph on AS_ basic blocks. This is useful to find dominance 
   relations, etc. */

using namespace BG_LLVM;
using std::unordered_map;

static G_graph RA_bg;
static S_table block_env;

static unordered_map<Temp_label, int> labelNodeMap;

static void Bg_empty() {
    RA_bg=G_Graph();
}

G_graph BG_LLVM::Bg_graph() {
    return RA_bg;
}

S_table BG_LLVM::Bg_block_env(){
    return block_env;
}

G_node Look_bg(LLVM_IR::llvm_AS_block_ *b){
    G_node n1=NULL;
    for (G_nodeList n=G_nodes(RA_bg); n!=NULL; n=n->tail) {
        if ((LLVM_IR::llvm_AS_block_ *)G_nodeInfo(n->head) == b) {
            n1=n->head;
            break;
        }
    }
    if (n1==NULL){
        G_node newNode = G_Node(RA_bg, b);
        labelNodeMap.emplace(b->label, newNode->mykey);
        return newNode;
    }
    else return n1;
}

static void Enter_bg(LLVM_IR::llvm_AS_block_ *b1, LLVM_IR::llvm_AS_block_ *b2) {
    G_node n1=Look_bg(b1);
    G_node n2=Look_bg(b2);
    G_addEdge(n1, n2);
    return;
}

int BG_LLVM::getNodeByLabel(Temp_label label){
    if(labelNodeMap.find(label) == labelNodeMap.end()){
        return -1; // not found
    }else{
        return labelNodeMap.find(label)->second;
    }
}

/* input LLVM_IR::AS_block_ *List after instruction selection for each block 
   in the C_Block, generate a graph on the basic blocks */


G_nodeList BG_LLVM::Create_bg(LLVM_IR::llvm_AS_blockList_ *bl) {
    LLVM_IR::llvm_AS_blockList_ *list=bl;

    RA_bg=G_Graph(); // prepare the empty graph
    block_env = S_empty(); //build a table of label -> block
    labelNodeMap.clear();

    for (LLVM_IR::llvm_AS_blockList_ *l=bl; l; l=l->tail) {
      S_enter(block_env, l->head->label, l->head);
      Look_bg(l->head); /* enter the block into graph as a node */
    }

    for (LLVM_IR::llvm_AS_blockList_ *l=bl; l; l=l->tail) {
      Temp_labelList tl = l->head->succs;
      while (tl) {
        LLVM_IR::llvm_AS_block_ *succ = (LLVM_IR::llvm_AS_block_ *)S_look(block_env, tl->head);
    //if the succ label doesn't have a block, assume it's the "exit label",
    //then this doesn't form an edge in the bg graph
        if (succ) Enter_bg(l->head, succ); 
        tl=tl->tail;
      }
    }
    return G_nodes(RA_bg);
}

static void show_AS_Block (void *b, FILE *out) {
    fprintf(out, "%s, ", Temp_labelstring(((LLVM_IR::llvm_AS_block_ *)b)->label));
}

void BG_LLVM::Show_bg(FILE* out, G_nodeList l) {
    G_show(out, l, show_AS_Block);
}

