#include <stdio.h>
#include "util.h"
#include "oldtable.h"
#include "graph.hpp"
#include "symbol.h"
#include "temp.h"
#include "assem.h"
#include "flowgraph_llvm.h"
#include "liveness_llvm.h"
#include <unordered_set>
#include <stack>
#include <assert.h>

using namespace LI_LLVM;

using std::stack;

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

TempSet LI_LLVM::FG_In(G_node n) {
    inOut io;
    io=INOUT_lookup(n);
    if (io!=NULL) return io->in;
    else return new TempSet_;
}

TempSet LI_LLVM::FG_Out(G_node n) {
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

// static Temp_tempList TempList_union_FG_in(G_nodeList s){
//     Temp_tempList ans = NULL;
//     std::unordered_set<Temp_temp> set;
//     for (; s != NULL; s = s->tail) {
//         Temp_tempList tmp = LI_LLVM::FG_In(s->head);
//         for (Temp_tempList tl = tmp; tl; tl = tl->tail) {
//             set.insert(tl->head);
//         }
//     }
//     for (auto& it : set) {
//         ans = Temp_TempList(it, ans);
//     }
//     return ans;
// }
// static Bool LivenessIteration(G_nodeList gl) {
//     Bool changed = FALSE;
//     gi++;
//     while ( gl!=NULL ) {
//         G_node n=gl->head;

//         //do in[n] = use[n] union (out[n] - def[n])
//         Temp_tempList in=TempList_union(FG_LLVM::FG_use(n), TempList_diff(LI_LLVM::FG_Out(n), FG_LLVM::FG_def(n)));
//         // printf("FG_in(n):\n");
//         // printTempList(LI_LLVM::FG_In(n));
//         // printf("\n");
//         // printf("in:\n");
//         // printTempList(in);
//         // printf("\n");
    
//         //Now do out[n]=union_s in succ[n] (in[s])
//         G_nodeList s=G_succ(n);
//         Temp_tempList out=TempList_union_FG_in(s); //out is an accumulator
//         // for (;s!=NULL;s=s->tail) {
//         //     out=TempList_union(out, LI_LLVM::FG_In(s->head));
//         // }
//         // printf("FG_Out(n):\n");
//         // printTempList(LI_LLVM::FG_Out(n));
//         // printf("\n");
//         // printf("out:\n");
//         // printTempList(out);
//         // printf("\n");

//         //See if any in/out changed
//         // if (!(TempList_eq(LI_LLVM::FG_In(n), in) && TempList_eq(LI_LLVM::FG_Out(n), out)))
//         //     changed=TRUE;
//         if (!TempList_eq(LI_LLVM::FG_In(n), in)){
//             // printf("here1\n");
//             changed = TRUE;
//         } 
//         if(!changed&&!TempList_eq(LI_LLVM::FG_Out(n), out)){
//             // printf("here2\n");
//             changed = TRUE;
//         }
            
//         //enter the new info
//         G_enter(InOutTable, gl->head, InOut(in, out));
//         gl=gl->tail;
//     }
//     return changed;
// }

void show_IR(void *p_ir, FILE* out){
    AS_print_llvm(out, ((LLVM_IR::T_ir_ *)p_ir)->i, Temp_name());
}

void LI_LLVM::Show_Liveness(FILE* out, G_nodeList l) {
    fprintf(out, "\n\nNumber of iterations=%d\n\n", gi);
    while ( l!=NULL ) {
        G_node n = l->head;
        fprintf(out, "----------------------\n");
        G_show(out, G_NodeList(n, NULL), show_IR);
        fprintf(out, "def="); PrintTemps(out, FG_LLVM::FG_def(n)); fprintf(out, "\n");
        fprintf(out, "use="); PrintTemps(out, FG_LLVM::FG_use(n)); fprintf(out, "\n");
        fprintf(out, "In=");  PrintTemps(out, LI_LLVM::FG_In(n)); fprintf(out, "\n");
        fprintf(out, "Out="); PrintTemps(out, LI_LLVM::FG_Out(n)); fprintf(out, "\n");
        l=l->tail;
    }
}

static int counter;

G_nodeList LI_LLVM::Liveness(G_nodeList l) {
    init_INOUT(); //Initialize InOut table
    std::stack<G_node> workSet;
    for(G_nodeList tl=l; tl; tl=tl->tail){
        workSet.push(tl->head);
    }
    while(!workSet.empty()){
        G_node n = workSet.top();
        workSet.pop();
        ++counter;
        // printf("counter %d\n", counter);
        // AS_print(stdout, ((LLVM_IR::T_ir_ *)n->info)->i, Temp_name());
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
        TempSet n_def = FG_LLVM::FG_def(n);
        TempSet diff = TempSet_diff(out, n_def);
        TempSet n_use = FG_LLVM::FG_use(n);
        TempSet in = TempSet_union(n_use, diff);

        // if(n->mykey == 26){
        //     printf("in:\n");
        //     printTempList(in);
        //     printf("\n");
        //     printf("diff:\n");
        //     printTempList(TempList_diff(LI_LLVM::FG_Out(n), FG_LLVM::FG_def(n)));
        //     printf("\n");
        //     printf("def:\n");
        //     printTempList(FG_LLVM::FG_def(n));
        //     printf("\n");
        //     printf("out:\n");
        //     printTempList(out);
        //     printf("\n");
        // }
        
        // printf("in:");
        // for(auto &it : *in){
        //     printf(" %d", it->num);
        // }
        // printf("\n");
    
        
        //See if any in/out changed
        TempSet n_in = FG_In(n);

        // printf("n_in:\n");
        // for(auto &it : *n_in){
        //     printf(" %d", it->num);
        // }
        // printf("\n");

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
    // LI_LLVM::Show_Liveness(stdout, l);
    // Bool changed = TRUE;
    // while(changed) changed = LivenessIteration(l);
    // assert(LivenessIteration(l) == FALSE);
    return l;
}
