#ifndef __LIVENESS
#define __LIVENESS

#include <list>
#include <unordered_map>
#include <unordered_set>
#include "graph.hpp"
#include "llvm_ir.h"
#include "temp.h"

void Liveness(GRAPH::Node<LLVMIR::L_block*>* r, GRAPH::Graph<LLVMIR::L_block*>& bg, std::vector<Temp_temp*>& args);
TempSet_& FG_Out(GRAPH::Node<LLVMIR::L_block*>* r);
TempSet_& FG_In(GRAPH::Node<LLVMIR::L_block*>* r);
TempSet_& FG_def(GRAPH::Node<LLVMIR::L_block*>* r);
TempSet_& FG_use(GRAPH::Node<LLVMIR::L_block*>* r);
std::list<Temp_temp*> get_def(LLVMIR::L_stm* stm);
std::list<Temp_temp*> get_use(LLVMIR::L_stm* stm);
#endif