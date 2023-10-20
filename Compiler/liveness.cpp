#include <stdio.h>
#include "util.h"
#include "oldtable.h"
#include "graph.hpp"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "flowgraph.h"
#include "liveness.h"
#include <assert.h>
#include <stack>
#include <unordered_map>
#include <string.h>

using std::stack;
using std::unordered_map;

//structure for in and out temps to attach to the flowgraph nodes
struct inOut_ {
    TempSet in;
    TempSet out;
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
static inOut InOut(TempSet in, TempSet out) {
    inOut info = new inOut_;
    info->in = in;
    info->out = out;
    return info;
}

TempSet FG_In(G_node n) {
    inOut io;
    io=INOUT_lookup(n);
    if (io!=NULL) return io->in;
    else return new TempSet_;
}

TempSet FG_Out(G_node n) {
    inOut io;
    io=INOUT_lookup(n);
    if (io!=NULL) return io->out;
    else return new TempSet_;
}

//initialize the INOUT info for a graph
static void init_INOUT_graph(G_nodeList l) {
    while ( l!=NULL ) {
        if (INOUT_lookup(l->head) == NULL) //If there is no io info yet, initialize one
            INOUT_enter(l->head, InOut(new TempSet_, new TempSet_));
        l=l->tail;
    }
}

static int gi=0;

static Bool LivenessIteration(G_nodeList gl) {
    Bool changed = FALSE;
    gi++;
    while ( gl!=NULL ) {
        G_node n=gl->head;

        //do in[n] = use[n] union (out[n] - def[n])
        TempSet n_out = FG_Out(n);
        TempSet n_def = FG_def(n);
        TempSet diff = TempSet_diff(n_out, n_def);
        TempSet n_use = FG_use(n);
        TempSet in=TempSet_union(n_use, diff);
    
        //Now do out[n]=union_s in succ[n] (in[s])
        G_nodeList s=G_succ(n);
        TempSet out; //out is an accumulator
        for (;s!=NULL;s=s->tail) {
            TempSet t_in = FG_In(s->head);
            out=TempSet_union(out, t_in);
        }
        //See if any in/out changed
        TempSet n_in = FG_In(n);
        if (!(TempSet_eq(n_in, in) && TempSet_eq(n_out, out)))
            changed=TRUE;
        //enter the new info
        G_enter(InOutTable, gl->head, InOut(in, out));
        gl=gl->tail;
    }
    return changed;
}

void Show_Liveness(FILE* out, G_nodeList l) {
    fprintf(out, "\n\nNumber of iterations=%d\n\n", gi);
    while ( l!=NULL ) {
        G_node n = l->head;
        fprintf(out, "----------------------\n");
        G_show(out, G_NodeList(n, NULL), NULL);
        fprintf(out, "def="); PrintTemps(out, FG_def(n)); fprintf(out, "\n");
        fprintf(out, "use="); PrintTemps(out, FG_use(n)); fprintf(out, "\n");
        fprintf(out, "In=");  PrintTemps(out, FG_In(n)); fprintf(out, "\n");
        fprintf(out, "Out="); PrintTemps(out, FG_Out(n)); fprintf(out, "\n");
        l=l->tail;
    }
}

G_nodeList Liveness(G_nodeList l) {
    init_INOUT(); //Initialize InOut table
    std::stack<G_node> workSet;
    for(G_nodeList tl=l; tl; tl=tl->tail){
        workSet.push(tl->head);
    }
    while(!workSet.empty()){
        G_node n = workSet.top();
        workSet.pop();

        //Now do out[n]=union_s in succ[n] (in[s])
        G_nodeList s=G_succ(n);
        TempSet out = new TempSet_; //out is an accumulator
        for (;s;s=s->tail) {
            TempSet t_in = FG_In(s->head);
            for(auto &it : *t_in){
                (*out).emplace(it);
            }
            // out=TempSet_union(out, t_in);
        }

        //do in[n] = use[n] union (out[n] - def[n])
        TempSet n_def = FG_def(n);
        TempSet diff = TempSet_diff(out, n_def);
        TempSet n_use = FG_use(n);
        TempSet in = TempSet_union(n_use, diff);    
        
        //See if any in/out changed
        TempSet n_in = FG_In(n);
        if (!(TempSet_eq(n_in, in))){
            G_nodeList p=G_pred(n);
            for (;p;p=p->tail) {
                assert(p->head != n);
                workSet.push(p->head);
            }
        }
        //enter the new info
        G_enter(InOutTable, n, InOut(in, out));
    }
    return l;
}

static unordered_map<Temp_label, TempSet> BBLiveIn;
static unordered_map<Temp_label, TempSet> BBLiveOut;

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



void makeBBInOut(G_nodeList l){
    BBLiveIn.clear();
    BBLiveOut.clear();
    bool inBB = false;
    Temp_label cur_label = nullptr;
    for(G_nodeList tl=l; tl; tl=tl->tail){
        G_node n = tl->head;
        AS_instr ins = (AS_instr)tl->head->info;
        if(ins->kind == AS_instr_::I_LABEL){
            // in a new BB
            assert(!inBB);
            assert(!cur_label);
            BBLiveIn.emplace(ins->u.LABEL.label, FG_In(n));
            inBB = true;
            cur_label = ins->u.LABEL.label;
        }else if(ins->kind == AS_instr_::I_OPER){
            if(isJump(ins) || isRetrun(ins)){
                // out current BB
                assert(inBB);
                assert(cur_label);
                BBLiveOut.emplace(cur_label, FG_Out(n));
                inBB = false;
                cur_label = nullptr;
            }
        }
    }
    assert(!inBB);
    assert(!cur_label);
}

TempSet BB_In(Temp_label label){
    if(BBLiveIn.find(label) != BBLiveIn.end()){
        return BBLiveIn.find(label)->second;
    }else{
        assert(0);
        return nullptr;
    }
}

TempSet BB_Out(Temp_label label){
    if(BBLiveOut.find(label) != BBLiveOut.end()){
        return BBLiveOut.find(label)->second;
    }else{
        assert(0);
        return nullptr;
    }
}
