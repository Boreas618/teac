#ifndef __MEM2REG__
#define __MEM2REG__

#include "fun_inline.h"
#include <unordered_map>
#include <string>

namespace mem2reg
{
std::unordered_map<std::string,std::unordered_map<Temp_label,std::unordered_set<int>>> mem2reg(std::unordered_map<std::string, P_funList> &fl);
AS_block2List deepcopy(AS_block2List bl);
void remove_mem(std::unordered_map<std::string, P_funList> &fl);
void addr2reg(std::unordered_map<std::string, P_funList> &fl);
}

#endif