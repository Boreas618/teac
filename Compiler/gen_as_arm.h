#pragma once

#include "llvm_assem.h"
#include "treep.hpp"
#include "assemblock.h"
#include "llvm_assemblock.h"

AS_instrList gen_asList_arm(LLVM_IR::T_irList sl);
AS_instrList gen_prolog_arm(string method_name, Temp_tempList args);
AS_instrList gen_epilog_arm();
// void reset_sp (AS_instrList ail, int local_offset);
void reset_sp (int local_offset);

AS_blockList gen_arm_bgl(LLVM_IR::llvm_AS_blockList_ *bgabl);

void reset_localOffset_before_gen_arm();
int get_localOffset();
