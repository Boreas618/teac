#pragma once

#include "temp.h"
#include "graph.hpp"
#include "llvm_ir.h"

namespace FG_LLVM {

TempSet FG_def(GRAPH::Node<LLVMIR::L_block*>* n);
TempSet FG_use(GRAPH::Node<LLVMIR::L_block*>* n);
bool FG_isMove(GRAPH::Node<LLVMIR::L_block*>* n);
GRAPH::Graph<LLVMIR::L_block*>& FG_AssemFlowGraph(LLVM_IR::T_irList_ *il);

}



