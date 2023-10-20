#ifndef __SSA
#define __SSA
#include "graph.hpp"
#include "temp.h"
#include "assem.h"
#include "assemblock.h"
#include "llvm_assemblock.h"
#include <vector>
#include <unordered_map>

void Dominators(G_graph g);
void computeDF(G_node n);
void getDF();
void printDF();
void PlacePhiFunc(G_graph g);
void PlacePhiFunc(G_graph g, std::unordered_map<Temp_label,std::unordered_set<int>>& phiTempMap);
void Rename(G_node n);
void RenameAll();
void getInOut(G_nodeList lg);
LLVM_IR::llvm_AS_block_ *gen_dummy_head(LLVM_IR::llvm_AS_blockList_ *abl, Temp_tempList def);
void AddDefAll();
void SingleSourceGraph(G_node r, G_graph g);
void eliminatePhiFunc(G_graph g);
std::vector<std::vector<int *>>&get_DF_array();
void resetRename(Temp_tempList args);

#endif