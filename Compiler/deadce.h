#ifndef __DEAD_C_E
#define __DEAD_C_E
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


typedef struct AS_block2List_* AS_block2List;
typedef struct AS_block2_* AS_block2;
typedef struct AS_instr2List_* AS_instr2List;


// 将链表改成双向的
struct AS_block2List_ {
    std::list<AS_block2> blist;
};

struct AS_block2_ {
    AS_instr2List instrs;
    Temp_label label;
    Temp_labelList succs;
};

struct AS_instr2List_ {
    std::list<LLVM_IR::T_ir> ilist;
};


Temp_tempList get_defs(LLVM_IR::T_ir instr);
Temp_tempList get_uses(LLVM_IR::T_ir instr);
Temp_tempList get_defs(AS_instr instr);
Temp_tempList get_uses(AS_instr instr);

LLVM_IR::llvm_AS_blockList double_2_single(AS_block2List bl);
AS_block2List single_2_double(LLVM_IR::llvm_AS_blockList bl);

// 条件常数传播
AS_block2List cc_propagation(AS_block2List bl,Temp_tempList argvs);
AS_block2 block_2_block2(LLVM_IR::llvm_AS_block b);

#endif