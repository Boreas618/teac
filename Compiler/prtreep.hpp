#ifndef PRINTTREE_H
#define PRINTTREE_H
/* function prototype from printtree.c */
#include "treep.hpp"
void pr_tree_exp(std::ostream &out, T_exp exp, int d);
void printStmList(std::ostream &out, T_stmList, int);
void printFuncDeclList(std::ostream &out, T_funcDeclList);
void printFuncDecl(std::ostream &out, T_funcDecl);
void pr_stm(std::ostream &out, T_stm stm, int d);

#endif