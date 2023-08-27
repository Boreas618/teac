#pragma once

#include "llvm_assem.h"
#include "temp.h"
#include "assem.h"

namespace LLVM_IR {

typedef  struct llvm_AS_block_*llvm_AS_block;
typedef struct llvm_AS_blockList_*llvm_AS_blockList;

struct llvm_AS_block_ {T_irList_ *irs; Temp_label label; Temp_labelList succs;};
struct llvm_AS_blockList_ { llvm_AS_block_ *head; llvm_AS_blockList_ *tail;};

llvm_AS_blockList_ *AS_BlockList(llvm_AS_block_ *head, llvm_AS_blockList_ *tail);
llvm_AS_block_ * AS_Block(T_irList_ *irs);

AS_instrList irBlock_to_insBlock(LLVM_IR::llvm_AS_blockList_ * bl);


T_irList_ *AS_traceSchedule(llvm_AS_blockList_ *bl,
        T_irList_ *prolog, T_irList_ *epilog, Bool optimize);

}