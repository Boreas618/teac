#ifndef __GCM__
#define __GCM__

#include "graph.h"
#include "llvm_assem.h"
#include "llvm_assemblock.h"
#include "deadce.h"
#include <list>
#include <vector>

// map ins to block
// compute dom depth
// map ins to iter

namespace gcm
{

struct InsNode
{
    AS_block2 block;
    std::list<LLVM_IR::T_ir>::iterator iter;
    bool visited;
    InsNode(AS_block2 b,std::list<LLVM_IR::T_ir>::iterator it):block(b),iter(it),visited(false) {} 
};

void gcm(AS_block2List bl,G_node node);


}


#endif