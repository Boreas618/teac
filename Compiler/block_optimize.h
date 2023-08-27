#ifndef __BLOCK_OPTIMIZE
#define __BLOCK_OPTIMIZE
#include "assem.h"
#include "assemblock.h"
#include "bg.h"
#include "canon.h"
#include "deadce.h"
#include "graph.h"
#include "llvm_assemblock.h"
#include "symbol.h"
#include "temp.h"
#include "util.h"

// 基本块优化
AS_block2List block_Optimize(AS_block2List bl);
#endif