#pragma once

#include "temp.h"
#include "graph.h"

namespace LI_LLVM {
    
G_nodeList Liveness(G_nodeList);
void Show_Liveness(FILE*, G_nodeList);
TempSet FG_Out(G_node);
TempSet FG_In(G_node);

}


