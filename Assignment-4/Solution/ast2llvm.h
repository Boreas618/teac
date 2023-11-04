#ifndef __AST2LLVM
#define __AST2LLVM

#include "temp.h"
#include "llvm_ir.h"
#include "TeaplaAst.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <list>

struct MemberInfo
{
    int offset;
    TempDef def;
    MemberInfo(int off,TempDef d)
        : offset(off), def(d) {}
};

struct StructInfo
{
    std::unordered_map<std::string,MemberInfo> memberinfos;
};

struct Func_local
{
    std::string name;
    FuncType ret;
    std::vector<Temp_temp*> args;
    std::list<LLVMIR::L_stm*> irs;
};

std::vector<LLVMIR::L_def*> ast2llvmProg_first(aA_program p);
std::vector<Func_local*> ast2llvmProg_second(aA_program p);
Func_local* ast2llvmFunc(aA_fnDef f);
void ast2llvmBlock(aA_codeBlockStmt b,Temp_label *con_label = nullptr,Temp_label *bre_label = nullptr);
Temp_temp* ast2llvmRightVal(aA_rightVal r);
Temp_temp* ast2llvmBoolExpr(aA_boolExpr b,Temp_label *true_label = nullptr,Temp_label *false_label = nullptr);

#endif