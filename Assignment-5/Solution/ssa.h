#ifndef __SSA
#define __SSA


#include "temp.h"
#include "llvm_ir.h"

#include <vector>
#include <string>
#include <unordered_map>
#include <list>

LLVMIR::L_prog* SSA(LLVMIR::L_prog*prog);
LLVMIR::L_prog* combine_addr(LLVMIR::L_prog* prog);
LLVMIR::L_prog* mem2reg(LLVMIR::L_prog* prog);
#endif