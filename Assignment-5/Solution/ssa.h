#ifndef __SSA
#define __SSA


#include "temp.h"
#include "llvm_ir.h"

#include <vector>
#include <string>
#include <unordered_map>
#include <list>

LLVMIR::L_prog* SSA(LLVMIR::L_prog*prog);
void combine_addr(LLVMIR::L_func* fun);
void mem2reg(LLVMIR::L_func* fun);
#endif