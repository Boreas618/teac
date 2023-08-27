#ifndef __REMOVE_LOAD__
#define __REMOVE_LOAD__

#include "deadce.h"
#include <variant>
#include <string>
#include "fun_inline.h"

namespace remove_load
{
using origin_type = std::variant<int,std::string>;
void remove_load(AS_block2List bl);
void remove_global_arr(std::unordered_map<std::string, P_funList> &fl);
void naive_remove_load(AS_block2List bl);
}



#endif