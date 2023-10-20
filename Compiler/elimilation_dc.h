#ifndef __ELIMILATION_DC
#define __ELIMILATION_DC
#include <list>
#include <string>
#include <unordered_set>
#include "assem.h"
#include "assemblock.h"
#include "bg.h"
#include "canon.h"
#include "deadce.h"
#include "graph.hpp"
#include "llvm_assemblock.h"
#include "symbol.h"
#include "temp.h"
#include "util.h"

// 简单死代码删除
AS_block2List simple_DeadCD(AS_block2List bl,Temp_tempList argvs);
AS_block2List elimilation_DeadCD(AS_block2List bl);
#endif