#ifndef __CONDITION_EXEC
#define __CONDITION_EXEC
#include <stdio.h>
#include <iostream>
#include <list>
#include <vector>
#include "assem.h"
#include "assemblock.h"
#include "bg.h"
#include "canon.h"
#include "graph.hpp"
#include "llvm_assemblock.h"
#include "symbol.h"
#include "temp.h"
#include "util.h"


typedef struct AS_armblock2List_* AS_armblock2List;
typedef struct AS_armblock2_* AS_armblock2;
typedef struct AS_arminstr2List_* AS_arminstr2List;

struct AS_armblock2List_ {
    std::list<AS_armblock2> blist;
};

struct AS_armblock2_ {
    AS_arminstr2List instrs;
    Temp_label label;
    Temp_labelList succs;
};

struct AS_arminstr2List_ {
    std::list<AS_instr> ilist;
};

AS_blockList condition_exec(AS_blockList bl);
AS_instrList condition_exec(AS_instrList il);
#endif