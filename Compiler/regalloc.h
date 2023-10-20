#ifndef __REGALLOC
#define __REGALLOC
#include "graph.hpp"
#include "assem.h"
#include "treep.hpp"

void RegAlloc(AS_instrList ail, my_string func_name, Temp_tempList func_params);
Bool IsPrecolor(int num);
int getFuncLength(AS_instrList ail);
void init_colors(my_string func_name, int len);
void init_regalloc(string func_name);

#endif

