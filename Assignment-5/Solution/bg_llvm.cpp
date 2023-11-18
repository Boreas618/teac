#include "bg_llvm.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unordered_map>
#include "graph.hpp"
#include "printLLVM.h"
#include "temp.h"
/* graph on AS_ basic blocks. This is useful to find dominance
   relations, etc. */

using namespace std;
using namespace LLVMIR;
using namespace GRAPH;

static Graph<L_block*> RA_bg;
static unordered_map<Temp_label*, L_block*> block_env;

Graph<L_block*>& Bg_graph() {
    return RA_bg;
}
unordered_map<Temp_label*, L_block*>& Bg_block_env() {
    return block_env;
}

Node<L_block*>* Look_bg(L_block* b) {
    Node<L_block*>* n1 = nullptr;
    for (auto n : *RA_bg.nodes()) {
        if (n.second->nodeInfo() == b) {
            n1 = n.second;
            break;
        }
    }
    if (n1 == nullptr)
        return RA_bg.addNode(b);
    else
        return n1;
}

static void Enter_bg(L_block* b1, L_block* b2) {
    Node<L_block*>* n1 = Look_bg(b1);
    Node<L_block*>* n2 = Look_bg(b2);
    RA_bg.addEdge(n1, n2);
    return;
}

/* input LLVMIR::L_block* *List after instruction selection for each block,
    generate a graph on the basic blocks */

Graph<L_block*>& Create_bg(list<L_block*>& bl) {
    RA_bg = Graph<L_block*>();
    block_env = unordered_map<Temp_label*, L_block*>();

    for (auto block : bl) {
        block_env.insert({block->label, block});
        RA_bg.addNode(block);
    }

    for (auto block : bl) {
        unordered_set<Temp_label*> succs = block->succs;
        for (auto label : succs) {
            Enter_bg(block, block_env[label]);
        }
    }
    return RA_bg;
}

static void DFS(Node<L_block*>* r, Graph<L_block*>& bg) {
    if (r->color == 1)
        return;
    r->color = 1;
    for (auto succ_id : r->succs) {
        auto succ = bg.mynodes[succ_id];
        DFS(succ, bg);
    }
}

void SingleSourceGraph(Node<L_block*>* r, Graph<L_block*>& bg) {
    DFS(r, bg);
    for (auto x = bg.mynodes.begin(); x != bg.mynodes.end();) {
        if (x->second->color == 0) {
            for (auto pred : x->second->preds) {
                bg.mynodes[pred]->succs.erase(x->second->mykey);
            }
            for (auto succ : x->second->succs) {
                bg.mynodes[succ]->preds.erase(x->second->mykey);
            }
            // printL_block(cout,x->second->info);
            x = bg.mynodes.erase(x);
        } else {
            ++x;
        }
    }
    for (auto& x : bg.mynodes) {
        x.second->color = 0;
    }
    return;
}
