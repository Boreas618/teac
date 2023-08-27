#include "domtree.h"
#include <vector>
#include <unordered_map>
#include <assert.h>
#include <string>

using namespace std;
using namespace domtree;

extern int **idom;
extern vector< vector<int*> > children;
unordered_map<std::string,DomNode*> dom_map;
unordered_map<std::string,AS_block2> label_block_map;

static void init_dom_map(G_node node,int depth)
{
    AS_block b = (AS_block)node->info;
    DomNode* d = new DomNode(depth,Temp_labelstring(b->label));
    if(idom[node->mykey] != NULL)
    {
        auto ido = GetNode(idom[node->mykey]);
        auto ido_b = (AS_block)ido->info;
        d->prev = Temp_labelstring(ido_b->label);
    }
    for(auto &v : children[node->mykey])
    {
        auto ch = GetNode(v);
        auto ch_b = (AS_block)ch->info;
        d->succ.emplace(Temp_labelstring(ch_b->label));
        init_dom_map(ch,depth+1);
    }
    dom_map.emplace(Temp_labelstring(b->label),d);
}

void domtree::gen_dom_tree(G_node node)
{
    dom_map.clear();
    init_dom_map(node,0);
}

static void add_depth_helper(DomNode *node)
{
    node->depth++;
    for(auto &v:node->succ)
    {
        //printf("%s\n",v.c_str());
        add_depth_helper(dom_map[v]);
    }
}

void domtree::add_depth(char *label)
{
    auto it = dom_map.find(label);
    if(it == dom_map.end())
    {
        assert(0);
    }
    add_depth_helper(it->second);
}

void domtree::gen_label_block_map(AS_block2List bl)
{
    label_block_map.clear();
    for(auto &b:bl->blist)
    {
        label_block_map.emplace(Temp_labelstring(b->label),b);
    }
}

static void print_dom_node(FILE* os,DomNode *node)
{
    fprintf(os,"label:%s ",node->name.c_str());
    fprintf(os,"depth:%d    ",node->depth);
    fprintf(os,"prev: ");
    fprintf(os,"%s  ",node->prev.c_str());
    fprintf(os,"succ: ");
    for(auto &s:node->succ)
    {
        fprintf(os,"%s  ",s.c_str());
    }
    fprintf(os,"\n");
    for(auto &s:node->succ)
    {
        print_dom_node(os,dom_map[s]);
    }
}

void domtree::print_dom_tree(FILE* os,AS_block2 b)
{
    auto node = dom_map[Temp_labelstring(b->label)];
    print_dom_node(os,node);
}