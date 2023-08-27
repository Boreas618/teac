#ifndef __GVN__
#define __GVN__

#include "temp.h"
#include "deadce.h"
#include "graph.h"
#include "assem.h"
#include <unordered_map>
#include <variant>

namespace gvn
{
using scalar_type = std::variant<int,float>;
using opt_type = std::variant<int,int,float>;
using index_type = std::variant<int,std::string>;

bool gvn(AS_block2List bl,G_node node);
}




#endif