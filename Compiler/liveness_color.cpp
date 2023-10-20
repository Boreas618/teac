#include <stdio.h>
#include "util.h"
#include "oldtable.h"
#include "graph.hpp"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "flowgraph.h"
#include "liveness_color.h"
#include <assert.h>
#include <stack>
#include <unordered_map>
#include <string.h>

using std::stack;
using std::unordered_map;

//structure for in and out temps to attach to the flowgraph nodes
struct inOut_ {
    RegSet in;
    RegSet out;
};
typedef struct inOut_ *inOut;

//This is the (global) table for storing the in and out temps
static G_table InOutTable;

//initialize the table
static void init_INOUT() {
    InOutTable.clear();
}

//Attach the inOut info to the table
static void INOUT_enter(G_node n, inOut info) {
    G_enter(InOutTable, n, info);
}

//Lookup the inOut info
static inOut INOUT_lookup(G_node n) {
    return (inOut)G_look(InOutTable, n);
}

//inOut Constructor
static inOut InOut(RegSet in, RegSet out) {
    inOut info = new inOut_;
    info->in = in;
    info->out = out;
    return info;
}

RegSet FG_In_color(G_node n) {
    inOut io;
    io=INOUT_lookup(n);
    if (io!=NULL) return io->in;
    else return new RegSet_;
}

RegSet FG_Out_color(G_node n) {
    inOut io;
    io=INOUT_lookup(n);
    if (io!=NULL) return io->out;
    else return new RegSet_;
}

//initialize the INOUT info for a graph
static void init_INOUT_graph(G_nodeList l) {
    while ( l!=NULL ) {
        if (INOUT_lookup(l->head) == NULL) //If there is no io info yet, initialize one
            INOUT_enter(l->head, InOut(new RegSet_, new RegSet_));
        l=l->tail;
    }
}

static int gi=0;

RegSet TempSet2RegSet(TempSet ts){
    RegSet rs = new RegSet_;
    for(auto &it : *ts){
        rs->emplace(it->color);
    }
    return rs;
}

RegSet RegSet_diff(RegSet tl1, RegSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  RegSet diffSet = new RegSet_;
  for(auto &it : *tl1){
    (*diffSet).emplace(it);
  }
  for(auto &it : *tl2){
    (*diffSet).erase(it);
  }
  return diffSet;
}

RegSet RegSet_union(RegSet tl1, RegSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  RegSet unionSet = new RegSet_;
  for(auto &it : *tl1){
    (*unionSet).emplace(it);
  }
  for(auto &it : *tl2){
    (*unionSet).emplace(it);
  }
  return unionSet;
}

bool RegSet_contains(RegSet tl, int num){
  return (*tl).find(num) != (*tl).end();
}

bool RegSet_eq(RegSet tl1, RegSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  if((*tl1).size() != (*tl2).size()) return false;
  for(auto &it : *tl1){
    if(!RegSet_contains(tl2, it)) return false;
  }
  return true;
}

// static Bool LivenessIteration(G_nodeList gl) {
//     Bool changed = FALSE;
//     gi++;
//     while ( gl!=NULL ) {
//         G_node n=gl->head;

//         //do in[n] = use[n] union (out[n] - def[n])
//         RegSet n_out = FG_Out_color(n);
//         RegSet n_def = TempSet2RegSet(FG_def(n));
//         RegSet diff = RegSet_diff(n_out, n_def);
//         RegSet n_use = TempSet2RegSet(FG_use(n));
//         RegSet in=RegSet_union(n_use, diff);
    
//         //Now do out[n]=union_s in succ[n] (in[s])
//         G_nodeList s=G_succ(n);
//         RegSet out; //out is an accumulator
//         for (;s!=NULL;s=s->tail) {
//             RegSet t_in = FG_In_color(s->head);
//             out=RegSet_union(out, t_in);
//         }
//         //See if any in/out changed
//         RegSet n_in = FG_In_color(n);
//         if (!(RegSet_eq(n_in, in) && RegSet_eq(n_out, out)))
//             changed=TRUE;
//         //enter the new info
//         G_enter(InOutTable, gl->head, InOut(in, out));
//         gl=gl->tail;
//     }
//     return changed;
// }

void Show_Liveness_color(FILE* out, G_nodeList l) {
    fprintf(out, "\n\nNumber of iterations=%d\n\n", gi);
    while ( l!=NULL ) {
        G_node n = l->head;
        fprintf(out, "----------------------\n");
        G_show(out, G_NodeList(n, NULL), NULL);
        AS_print_colored(out, (AS_instr) n->info, Temp_name());
        fprintf(out, "def="); PrintTemps(out, FG_def(n)); fprintf(out, "\n");
        fprintf(out, "use="); PrintTemps(out, FG_use(n)); fprintf(out, "\n");
        fprintf(out, "In=");  PrintTemps_color(out, FG_In_color(n)); fprintf(out, "\n");
        fprintf(out, "Out="); PrintTemps_color(out, FG_Out_color(n)); fprintf(out, "\n");
        l=l->tail;
    }
}

static unordered_map<AS_instr, RegSet> InsLiveIn;
static unordered_map<AS_instr, RegSet> InsLiveOut;

G_nodeList Liveness_color(G_nodeList l) {
    init_INOUT(); //Initialize InOut table
    InsLiveIn.clear();
    InsLiveOut.clear();
    std::stack<G_node> workSet;
    for(G_nodeList tl=l; tl; tl=tl->tail){
        workSet.push(tl->head);
    }
    while(!workSet.empty()){
        G_node n = workSet.top();
        workSet.pop();

        //Now do out[n]=union_s in succ[n] (in[s])
        G_nodeList s=G_succ(n);
        RegSet out = new RegSet_; //out is an accumulator
        for (;s;s=s->tail) {
            RegSet t_in = FG_In_color(s->head);
            for(auto &it : *t_in){
                (*out).emplace(it);
            }
            // out=RegSet_union(out, t_in);
        }

        //do in[n] = use[n] union (out[n] - def[n])
        RegSet n_def = TempSet2RegSet(FG_def(n));
        RegSet diff = RegSet_diff(out, n_def);
        RegSet n_use = TempSet2RegSet(FG_use(n));
        RegSet in = RegSet_union(n_use, diff);    
        
        //See if any in/out changed
        RegSet n_in = FG_In_color(n);
        if (!(RegSet_eq(n_in, in))){
            G_nodeList p=G_pred(n);
            for (;p;p=p->tail) {
                assert(p->head != n);
                workSet.push(p->head);
            }
        }
        //enter the new info
        G_enter(InOutTable, n, InOut(in, out));
        AS_instr n_instr = (AS_instr) n->info;
        InsLiveIn[n_instr] = in;
        InsLiveOut[n_instr] = out;
        // assert(InsLiveIn.emplace(n_instr, in).second);
        // assert(InsLiveOut.emplace(n_instr, out).second);
    }
    return l;
}

RegSet getInsLiveIn(AS_instr ins){
    assert(InsLiveIn.find(ins) != InsLiveIn.end());
    return InsLiveIn.find(ins)->second;
}

RegSet getInsLiveOut(AS_instr ins){
    assert(InsLiveOut.find(ins) != InsLiveOut.end());
    return InsLiveOut.find(ins)->second;
}

static unordered_map<Temp_label, RegSet> BBLiveIn;
static unordered_map<Temp_label, RegSet> BBLiveOut;

static inline bool isRetrun(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER
	&& !strcmp(ins->u.OPER.assem, "pop {`d0, `d1}")){
		return true;
	}else{
		return false;
	}
}

static inline bool isJump(AS_instr ins){
    if(ins->kind == AS_instr_::I_OPER && ins->u.OPER.jumps!=NULL && ins->u.OPER.jumps->labels!=NULL){
        return true;
    }else{
        return false;
    }
}



void makeBBInOut_color(G_nodeList l){
    BBLiveIn.clear();
    BBLiveOut.clear();
    bool inBB = false;
    Temp_label cur_label = nullptr;
    for(G_nodeList tl=l; tl; tl=tl->tail){
        G_node n = tl->head;
        AS_instr ins = (AS_instr)tl->head->info;
        if(ins->kind == AS_instr_::I_LABEL){
            // in a new BB
            // assert(!inBB);
            // assert(!cur_label);
            BBLiveIn.emplace(ins->u.LABEL.label, FG_In_color(n));
            if(!inBB){
                inBB = true;
                cur_label = ins->u.LABEL.label;
            }
        }else if(ins->kind == AS_instr_::I_OPER){
            if(isJump(ins) || isRetrun(ins)){
                // out current BB
                assert(inBB);
                assert(cur_label);
                BBLiveOut.emplace(cur_label, FG_Out_color(n));
                inBB = false;
                cur_label = nullptr;
            }
        }
    }
    assert(!inBB);
    assert(!cur_label);
}

RegSet BB_In_color(Temp_label label){
    if(BBLiveIn.find(label) != BBLiveIn.end()){
        return BBLiveIn.find(label)->second;
    }else{
        assert(0);
        return nullptr;
    }
}

RegSet BB_Out_color(Temp_label label){
    if(BBLiveOut.find(label) != BBLiveOut.end()){
        return BBLiveOut.find(label)->second;
    }else{
        assert(0);
        return nullptr;
    }
}
