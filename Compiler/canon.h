#ifndef __CANON__
#define __CANON__

#include <iostream>
#include <string>
#include <vector>
#include <list>
#include "treep.hpp"
#include "temp.h"
#include "templabel.hpp"

namespace canon
{
struct C_stmExp
{
    T_stm s;
    T_exp e;
};

typedef struct C_stmListList_ *C_stmListList;
struct C_stmListList_
{
    T_stmList head;
    C_stmListList tail;
};
C_stmListList C_StmListList(T_stmList head,C_stmListList tail);

struct C_block
{
    C_stmListList llist;
    Temp_label_front label;
};
C_block C_Block(C_stmListList llist,Temp_label_front label);

T_stmList linearize(T_stm s);
C_block basicBlocks(T_stmList sl,std::string funcname);
T_stmList traceSchedule(C_block b);
void printCBlock(std::ostream &os,C_block b);

}


#endif