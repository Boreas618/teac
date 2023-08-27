#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "util.h"
#include "oldtable.h"
#include "graph.h"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "flowgraph.h"
#include "liveness.h"
#include "ig.h"
#include "regalloc.h"
#include <vector>
#include <unordered_map>
#include <map>
#include <stack>
#include <utility>

using std::unordered_map;
using std::map;
using std::pair;
using std::make_pair;

static G_graph RA_ig;

extern unordered_map<AS_instr, AS_instr> worklistMoves;
extern unordered_map<int, AS_instrList> moveList;

extern map<pair<int, int>, int> edgeSet;
extern unordered_map<int, TempSet> adjList;
extern map<pair<int, int>, int> simplifiedEdge;
extern unordered_map<int, int> initial;

void Ig_empty() {
    RA_ig=G_Graph();
}

G_graph Ig_graph() {
    return RA_ig;
}

G_node Look_ig(Temp_temp t) {
    G_node n1=NULL;
    for (G_nodeList n=G_nodes(RA_ig); n!=NULL; n=n->tail) {
        if ((Temp_temp)G_nodeInfo(n->head) == t) {
            n1=n->head;
            break;
        }
    }
    if (n1==NULL) return(G_Node(RA_ig, t));
    else return n1;
}

void Enter_ig(Temp_temp t1, Temp_temp t2) {
    G_node n1=Look_ig(t1);
    G_node n2=Look_ig(t2);
    G_addEdge(n1, n2);
    return;
}

//input flowgraph after liveness analysis (so FG_In and FG_Out are available)

static bool isUseAble(int num){
    return num != 11 && num != 13 && num != 15;
}

void AddEdge(Temp_temp u, Temp_temp v) {
    pair<int, int> edge_key = make_pair(u->num, v->num);
    if((edgeSet.find(edge_key) == edgeSet.end()) && (u != v)){
        // add edge (u, v) and (v, u)
        edgeSet.emplace(edge_key, 1);
        edge_key = make_pair(v->num, u->num);
        edgeSet.emplace(edge_key, 1);
        if(!IsPrecolor(u->num)){
            // add v into adjList[u]
            if(adjList.find(u->num) != adjList.end()){
                TempSet_add(adjList.find(u->num)->second, v);
            }
            else{
                TempSet ntl = new TempSet_;
                (*ntl).emplace(v);
                adjList.emplace(u->num, ntl);
            }
            
            if(v->type == FLOAT_TEMP && u->type == FLOAT_TEMP){
                u->fp_degree++;
            }
            else if(v->type != FLOAT_TEMP && u->type != FLOAT_TEMP){
                u->gp_degree++;
            }
        }
        if(!IsPrecolor(v->num)){
            // add u into adjList[v]
            if(adjList.find(v->num) != adjList.end()){
                TempSet_add(adjList.find(v->num)->second, u);
            }
            else{
                TempSet ntl = new TempSet_;
                (*ntl).emplace(u);
                adjList.emplace(v->num, ntl);
            }
            
            if(v->type == FLOAT_TEMP && u->type == FLOAT_TEMP){
                v->fp_degree++;
            }
            else if(v->type != FLOAT_TEMP && u->type != FLOAT_TEMP){
                v->gp_degree++;
            }
        }
    }
    return;
}

G_nodeList Create_ig(G_nodeList flowgraph) {    
    RA_ig=G_Graph();
    
    simplifiedEdge.clear();
    edgeSet.clear();
    adjList.clear();
    moveList.clear();

    for(unordered_map<int, int>::iterator it = initial.begin(); it != initial.end(); ++it){
        // printf("adjList in %d\n", it->first);
        adjList.emplace(it->first, new TempSet_);
        moveList.emplace(it->first, nullptr);
        if(IsPrecolor(it->second))
            it = initial.erase(it);
    }
    
    G_nodeList flg=flowgraph;
    TempSet use = nullptr;
    TempSet def = nullptr;
    while (flg != NULL) {
        G_node n=flg->head;
        bool is_m;
        //prepare to handle the move case
        if ( (is_m=FG_isMove(n)) ) {
            use=FG_use(n);
            def=FG_def(n);
            for(auto &it : *use){
                // tl->head is n
                AS_instrList *pil = NULL;
                AS_instr instr = (AS_instr)n->info;
                // add instr to movList[tl->head]
                if(moveList.find(it->num) != moveList.end()){
                    AS_instrList oil = moveList.find(it->num)->second;
                    moveList.erase(it->num);
                    moveList.emplace(it->num, AS_InstrList(instr, oil));
                }
                else
                    moveList.emplace(it->num, AS_InstrList(instr, NULL));
            }
            for(auto &it : *def){
                // tl->head is n
                AS_instrList *pil = NULL;
                AS_instr instr = (AS_instr)n->info;
                // add instr to movList[tl->head]
                if(moveList.find(it->num) != moveList.end()){
                    AS_instrList oil = moveList.find(it->num)->second;
                    moveList.erase(it->num);
                    moveList.emplace(it->num, AS_InstrList(instr, oil));
                }
                else
                    moveList.emplace(it->num, AS_InstrList(instr, NULL));
            }
            // add n to worklistMoves
            worklistMoves.emplace((AS_instr)n->info, (AS_instr)n->info);
            assert(use != nullptr);
        } else use = nullptr;
        
        //for each instruction, find the conflict from def to liveout
        AS_instr ins = AS_instr(n->info);
        // AS_printInstrList(stdout, AS_InstrList(ins, nullptr), Temp_name());
        TempSet tSet1 = FG_def(n);
        TempSet tSet2 = FG_Out(n);
        // printf("def:");
        // for (auto &it1 : *tSet1){
        //     printf("%d ", it1->num);
        // }
        // printf("\n");
        // printf("out:");
        // for (auto &it2 : *tSet2){
        //     printf("%d ", it2->num);
        // }
        // printf("\n");
        for (auto &it1 : *tSet1){
            for (auto &it2 : *tSet2) {
                if ((!(is_m && it2 == *(use->begin()))) && (it1 != it2)) {
                    if((it1->type == FLOAT_TEMP && it2->type == FLOAT_TEMP)
                    || (it1->type != FLOAT_TEMP && it2->type != FLOAT_TEMP))
                        if(isUseAble(it1->num) && isUseAble(it2->num)){
                            // we only put reg that is useable into interference graph
                            AddEdge(it1, it2);
                        }
                }
            }
        }
            
        flg=flg->tail;
    }
    return G_nodes(RA_ig);
}

static void show_temp(void* t, FILE *stream) {
    fprintf(stream, "%s, ", Temp_look(Temp_name(), (Temp_temp)t));
}

void Show_ig(FILE* out, G_nodeList l) {
    //while ( l!=NULL ) {
        //G_node n = l->head;
      //  fprintf(out, "----------------------\n");
        G_show(out, l, show_temp);
        //l=l->tail;
    //}
}

//The following procedure prints out the ig create code from a given ig data structure
//so this code may be used for testing register allocation (from ig generated from
//liveness analysis etc)

void Create_ig_Code(FILE* out, G_nodeList ig) {
    G_nodeList s;
    
    fprintf(out, "G_nodeList Create_ig1() {\n");
    
    for (s=ig; s; s=s->tail) {
        Temp_temp t = (Temp_temp)G_nodeInfo(s->head);
        string s=Temp_look(Temp_name(), t);
        if (atoi(s)>=100)
            fprintf(out, "\tTemp_temp t%s=Temp_newtemp();\n", s);
        else {
            fprintf(out, "\tTemp_temp t%s=F_Ri(%s);\n", s, &s[1]);
        }
    }
    
    fprintf(out, "\n\tIg_empty();\n\n");

    G_nodeList succ;
    for (s=ig; s; s=s->tail) {
        G_node n=s->head;
        Temp_temp t_fr=(Temp_temp) G_nodeInfo(n);
        string fr = Temp_look(Temp_name(), t_fr);
        if( (succ=G_succ(n)) ) {
            for (; succ; succ=succ->tail) {
                string to=Temp_look(Temp_name(), (Temp_temp) G_nodeInfo(succ->head));
                fprintf(out, "\tEnter_ig(t%s, t%s);\n", fr, to);
            }
        }
    }
    
    fprintf(out, "\n\treturn G_nodes(Ig_graph());\n}\n");
    return;
}
