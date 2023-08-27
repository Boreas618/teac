#ifndef __BG
#define __BG

#include "assemblock.h"
#include "graph.h"

/* Block graph */

G_nodeList Create_bg(AS_blockList); /* create bg from blocklist */
void Show_bg(FILE *, G_nodeList);
G_graph Bg_graph(); /* get the block graph */
S_table Bg_block_env(); /* get the bg_block_env */
G_node Look_bg(AS_block b);

#endif

