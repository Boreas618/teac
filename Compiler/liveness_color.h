#pragma once

#include "temp.h"
#include "graph.h"
#include "assem.h"

typedef std::unordered_set<int> RegSet_;
typedef RegSet_* RegSet;

G_nodeList Liveness_color(G_nodeList);
void Show_Liveness_color(FILE* out, G_nodeList l);
RegSet FG_Out_color(G_node);
RegSet FG_In_color(G_node);
void makeBBInOut_color(G_nodeList l);
RegSet BB_In_color(Temp_label);
RegSet BB_Out_color(Temp_label);
RegSet getInsLiveIn(AS_instr ins);
RegSet getInsLiveOut(AS_instr ins);