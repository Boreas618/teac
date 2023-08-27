#ifndef __FUN_INLINE
#define __FUN_INLINE
#include <list>
#include <string>
#include <unordered_set>
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

typedef struct P_funList_* P_funList;

struct P_funList_ {
    std::string name;
    Temp_tempList args;
    AS_block2List blockList;
    P_funList_() {}
    P_funList_(std::string name, Temp_tempList args, AS_block2List blockList) {
        this->name = name;
        this->args = args;
        this->blockList = blockList;
    }
};

void fun_inline(std::unordered_map<std::string,P_funList>&fun_list);
#endif