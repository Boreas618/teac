
#pragma once
#include "temp.h"
#include "graph.hpp"
#include "assem.h"



TempSet FG_def(G_node n);
TempSet FG_use(G_node n);
bool FG_isMove(G_node n);
G_graph FG_AssemFlowGraph(AS_instrList il);
void FG_Showinfo(FILE*, AS_instr, Temp_map);


