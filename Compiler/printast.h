#ifndef __PRINTAST__
#define __PRINTAST__

#include <iostream>
#include "ast.h"

namespace printast
{
void printProg(std::ostream &os,A_prog p);
void printCompUnit(std::ostream &os,A_compUnit cu);
void printDecl(std::ostream &os,A_decl d);
void printConstDecl(std::ostream &os,A_constDecl cd);
void printVarDecl(std::ostream &os,A_varDecl vd);
void printFuncDef(std::ostream &os,A_funcDef fd);
void printFuncType(std::ostream &os,enum A_funcType type);
void printConstDef(std::ostream &os,A_constDef cd);
void printVarDef(std::ostream &os,A_varDef vd);
void printExp(std::ostream &os,A_exp e);
void printInitVal(std::ostream &os,A_initVal iv);
void printArrayInit(std::ostream &os,A_arrayInit ai);
void printFuncFParams(std::ostream &os,A_funcFParams ffp);
void printFuncFParam(std::ostream &os,A_funcFParam ffp);
void printBlock(std::ostream &os,A_block b);
void printBlockItem(std::ostream &os,A_blockItem bi);
void printStmt(std::ostream &os,A_stmt s);
}

#endif