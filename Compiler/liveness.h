#ifndef __LIVENESS
#define __LIVENESS

#include "temp.h"
#include "graph.h"

G_nodeList Liveness(G_nodeList);
void Show_Liveness(FILE*, G_nodeList);
TempSet FG_Out(G_node);
TempSet FG_In(G_node);
void makeBBInOut(G_nodeList l);
TempSet BB_In(Temp_label);
TempSet BB_Out(Temp_label);

#endif
