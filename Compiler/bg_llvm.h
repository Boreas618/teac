#pragma once

#include "llvm_assemblock.h"
#include "graph.h"
#include "temp.h"

/* Block graph */
namespace BG_LLVM {

G_nodeList Create_bg(LLVM_IR::llvm_AS_blockList_ *); /* create bg from blocklist */
void Show_bg(FILE *, G_nodeList);
G_graph Bg_graph(); /* get the block graph */
S_table Bg_block_env(); /* get the bg_block_env */
// G_node Look_bg(LLVM_IR::AS_block_ *b);
int getNodeByLabel(Temp_label);

}




