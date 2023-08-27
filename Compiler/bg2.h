#pragma once

#include "deadce.h"
#include "graph.h"

/* Block graph */
namespace BG_LLVM_2 {

G_nodeList Create_bg(AS_block2List); /* create bg from blocklist */
void Show_bg(FILE *, G_nodeList);
G_graph Bg_graph(); /* get the block graph */
S_table Bg_block_env(); /* get the bg_block_env */
// G_node Look_bg(LLVM_IR::AS_block_ *b);

}




