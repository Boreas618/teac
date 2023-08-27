#ifndef __DOMTREE__
#define __DOMTREE__

#include "graph.h"
#include "assemblock.h"
#include "deadce.h"
#include <unordered_set>
#include <string>

namespace domtree
{
struct DomNode
{
    int depth;
    std::string name;
    std::string prev;
    std::unordered_set<std::string> succ;
    DomNode(int d,std::string name_):depth(d),name(name_),prev(),succ(){}
};


void gen_dom_tree(G_node node);
void add_depth(char *label);
void gen_label_block_map(AS_block2List bl);
void print_dom_tree(FILE *os,AS_block2 b);

}




#endif