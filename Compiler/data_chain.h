#ifndef __DATACHAIN__
#define __DATACHAIN__

#include "deadce.h"
#include "temp.h"
#include "llvm_assem.h"
#include "llvm_assemblock.h"
#include <unordered_map>
#include <vector>

namespace datachain
{
std::unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> get_du_chain(AS_block2List bl);
std::unordered_map<Temp_temp,LLVM_IR::T_ir> get_ud_chain(AS_block2List bl);

void printDUChain(FILE *os,std::unordered_map<Temp_temp,std::vector<LLVM_IR::T_ir>> m);
void printUDChain(FILE *os,std::unordered_map<Temp_temp,LLVM_IR::T_ir> m);

}


#endif