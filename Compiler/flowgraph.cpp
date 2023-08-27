/* 
 * CS5161 Assignment 6
 * 
 * TIGER's Generation of Control Flow Graph
 *
 * Ming Zhou (4465225)
 * Kuo-shih Tseng (4436736)
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "util.h"
#include "oldtable.h"
#include "symbol.h"
#include "temp.h"
#include "flowgraph.h"
#include "graph.h"
#include "assem.h"

/* Interfaces */
struct _UDinfo {
	TempSet uses;
	TempSet defs;
	bool isMove;
};
typedef struct _UDinfo *UDinfo;

//Create a table mapping between node and UDinfo
static void UD_init();
//Enter a new node with UDinfo into the table
static void UD_enter(G_node n, UDinfo info);
//Retrieve info from the table
static UDinfo UD_lookup(G_node n);
//Create a UDInfo with given information
static UDinfo UDInfo(TempSet *uses, TempSet *defs, bool isMove);

//Get the Lable-Node table
static TAB_table LNTable();
//Enter a new entry into the label-node table
static void LT_enter(Temp_label l, G_node n);
//Look up a node using lable as key
static G_node LT_lookup(Temp_label l);

/* Implementation */
static G_table UDTable;

static void UD_init(){
	UDTable.clear();
}

static void UD_enter(G_node n, UDinfo info) {
	G_enter(UDTable, n, info);
}

static UDinfo UD_lookup(G_node n) {
	return (UDinfo)G_look(UDTable, n);
}

static UDinfo UDInfo(TempSet uses, TempSet defs, bool isMove) {
	UDinfo info = new _UDinfo;
	info->uses = uses;
	info->defs = defs;
	info->isMove = isMove;
	return info;
}

static TAB_table _lntable = NULL;

static TAB_table LNTable() {
	if (_lntable == NULL){
		_lntable = TAB_empty();
	}
	return _lntable;
}

static G_node LT_lookup(Temp_label l) {
	return (G_node)TAB_look(LNTable(), l);
}

static void LT_enter(Temp_label l, G_node n) {
	TAB_enter(LNTable(), l, n);
}

TempSet FG_def(G_node n) {
	return UD_lookup(n)->defs;
}

TempSet FG_use(G_node n) {
	return UD_lookup(n)->uses;
}

bool FG_isMove(G_node n) {
    return UD_lookup(n)->isMove;
}

void FG_Showinfo(FILE *out, AS_instr instr, Temp_map map) {
	char* cs;
	char* lb;
    char r[200]; /* result */
	switch(instr->kind) {
	case AS_instr_::I_OPER:
		cs = instr->u.OPER.assem;
		lb = strrchr(cs, '\n');
		if(lb!=NULL){
			*lb = '\0';
		}
		AS_format(r, cs, instr->u.OPER.dst, instr->u.OPER.src, instr->u.OPER.jumps, map);
		fprintf(out, "[%20s] ", r);//instr->u.OPER.assem);
		break;
	case AS_instr_::I_LABEL:
		cs = instr->u.LABEL.assem;
		lb = strrchr(cs, '\n');
		if(lb!=NULL){
			*lb = '\0';
		}
    	AS_format(r, cs, NULL, NULL, NULL, map);
		fprintf(out, "[%20s] ", r);
		break;
	case AS_instr_::I_MOVE:
		cs = instr->u.MOVE.assem;
		lb = strrchr(cs, '\n');
		if(lb!=NULL){
			*lb = '\0';
		}
   		AS_format(r, cs, instr->u.MOVE.dst, instr->u.MOVE.src, NULL, map);
		fprintf(out, "[%20s] ", r);
		break;
	}
}

static inline bool isRetrun(AS_instr ins){
	if(ins->kind == AS_instr_::I_OPER
	&& !strcmp(ins->u.OPER.assem, "pop {`d0, `d1}")){
		return true;
	}else{
		return false;
	}
}

static bool isPhi(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        int len = strlen(instr->u.OPER.assem);
        for (int i = 0; i < len; ++i)
            if (*(instr->u.OPER.assem + i) == 'p' && *(instr->u.OPER.assem + i + 1) == 'h' && *(instr->u.OPER.assem + i + 2) == 'i')
                return true;
    }
    return false;
}

#define IT_COMMON 0
#define IT_JUMP 1
#define IT_MOVE 2
#define IT_RETURN 3
G_graph FG_AssemFlowGraph(AS_instrList il) {
	UD_init();

	//(I) Iterate over the entire instruction list
	AS_instr instr = NULL;
	G_node prev = NULL;
	G_node curr = NULL;
	G_graph graph = G_Graph();
	G_nodeList jumpList = NULL;
	G_nodeList jumpListHead = NULL;
	TempSet defs = nullptr;
	TempSet uses = nullptr;
	for(; il!=NULL; il=il->tail){
		instr = il->head;
		if(instr!=NULL){
			//1) create a node (and put it into the graph), using the 
			//   instruction as the associated info.
			curr = G_Node(graph, instr);

			//2) special handling
			int type = IT_COMMON;
			switch(instr->kind) {
			case AS_instr_::I_OPER:
				// Check if it's a JUMP instruction
				// We do this check here by looking if As_target is null, 
				// instead of inspecting the assembly op (j, beq, ...)
				if(instr->u.OPER.jumps!=NULL &&
					instr->u.OPER.jumps->labels!=NULL){
					type = IT_JUMP;
					// put this instruction into a separate list
					if(jumpList==NULL){
						jumpList = G_NodeList(curr, NULL);
						jumpListHead = jumpList;
					} else {
						jumpList->tail = G_NodeList(curr, NULL);
						jumpList = jumpList->tail;
					}
				}

				if(isRetrun(instr)){
					type = IT_RETURN;
				}
				if(isPhi(instr)){
					type = IT_COMMON;
				}
				defs = makeTempSet(instr->u.OPER.dst);
				uses = makeTempSet(instr->u.OPER.src);
				break;
			case AS_instr_::I_LABEL:
				//2.2) label should be also saved in the label-node list for (II)
				defs = makeTempSet(nullptr);
				uses = makeTempSet(nullptr);
				LT_enter(instr->u.LABEL.label, curr);
				break;
			case AS_instr_::I_MOVE:
				//2.3) it's a move instruction
				type = IT_MOVE;
				defs = makeTempSet(instr->u.MOVE.dst);
				uses = makeTempSet(instr->u.MOVE.src);
				break;
			}
			
			//3) put information into table
			UD_enter(curr, UDInfo(uses, defs, type == IT_MOVE));

			//4) link with the previous node for falling through, if possible.
			//   Note that prev is NULL if the previous instruction is a JUMP.
			if(prev!=NULL){
                G_addEdge(prev, curr);
			}

			//5) set as previous node for next time of iteration
			prev = (type!=IT_JUMP && type!=IT_RETURN)?curr:NULL;
		}
	}

	//(II) Iterate over the list that has all the JUMP instruction collected.
	Temp_labelList labels;
	for(; jumpListHead!=NULL; jumpListHead=jumpListHead->tail){
		curr = jumpListHead->head;
		labels = ((AS_instr)G_nodeInfo(curr))->u.OPER.jumps->labels;//no need to check its nullity again
		Temp_label label;
		G_node dest;
		// for each target it may jump to, add a corresponding edge in the graph
		for(;labels!=NULL;labels=labels->tail){
			label = labels->head;
			if(label!=NULL){
				// quickly retieve the target node using the label-node table
				dest = LT_lookup(label);
				// establish edge between this node and its jump target
				G_addEdge(curr, dest);
			}
		}
	}

	return graph;
}
#undef IT_COMMON
#undef IT_JUMP
#undef IT_MOVE
#undef IT_RETURN
