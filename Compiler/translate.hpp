#ifndef TRANSLATE_H
#define TRANSLATE_H

#include "ast.h"
#include "table.hpp"
#include "templabel.hpp"
#include "temp.h"
#include "treep.hpp"
#include "ty.hpp"
#include "util.h"
#include <stdio.h>

/* structs */

typedef struct Tr_exp_ *Tr_exp;
typedef struct Tr_expList_ *Tr_expList;

bool ispure(std::string name);
bool isglobalarr(std::string name);
bool ispurecache(std::string name);

class ExpTy
{
public:
    Tr_exp exp;
    TY::Type *ty;
    ExpTy(Tr_exp _exp, TY::Type *_ty) : exp(_exp), ty(_ty) {}
    ExpTy() {}
};

struct constvar
{
    int intvalue;
    float floatvalue;
};

/* translate */
std::pair<bool, int> getidxinit(std::string);
T_funcDeclList ast2irCompUnitList2(A_compUnitList list, FILE *llvmout, FILE *armout);
T_funcDeclList ast2irCompUnitList(A_compUnitList list, FILE *llvmout, FILE *armout);
T_funcDecl ast2irCompUnit(A_compUnit unit);
T_stm ast2irConstDecl(A_constDecl cdl, Temp_label_front name);
T_stm ast2irConstDef(A_funcType type, A_constDef cdf, Temp_label_front name);
T_stm ast2irVarDecl(A_varDecl vdl, Temp_label_front name);
T_stm ast2irVarDef(A_funcType type, A_varDef vdf, Temp_label_front name);
T_funcDecl ast2irFuncDef(A_funcDef e, Temp_label_front brelabel, Temp_label_front conlabel, Temp_label_front name);
T_stm ast2irBlock(A_block block, Temp_label_front brelabel, Temp_label_front conlabel,
                  Temp_label_front name);
T_stm ast2irStm(A_stmt stm, Temp_label_front brelabel, Temp_label_front conlabel,
                Temp_label_front name);
ExpTy ast2irExp(A_exp exp, Temp_label_front name);
ExpTy ExpcalArray(A_exp e, T_exp addr, int noff, TY::Type *ty, Temp_label_front name);
ExpTy InitcalArray(A_initValList initv, T_exp addr, int noff, TY::Type *ty, Temp_label_front name);
ExpTy InitfcalArray(A_initValList initv, T_exp addr, int noff, TY::Type *ty, Temp_label_front name);
T_expList ast2irExpList(A_expList el, TY::EnFunc func, Temp_label_front name);
ExpTy ast2irBinop(A_exp e, Temp_label_front name);
ExpTy ast2irRelop(A_exp e, Temp_label_front name);
// methods
// T_funcDeclList Tr_FuncDeclList(T_funcDecl fd, T_funcDeclList fdl);
// T_funcDeclList Tr_ChainFuncDeclList(T_funcDeclList first, T_funcDeclList
// second); T_funcDecl Tr_MainMethod(Tr_exp vdl, Tr_exp sl); T_funcDecl
// Tr_ClassMethod(string name, Temp_tempList paras, Tr_exp vdl, Tr_exp sl);

// stms

#endif
