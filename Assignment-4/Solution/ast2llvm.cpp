#include "ast2llvm.h"
#include <vector>
#include <unordered_map>
#include <string>
#include <cassert>
#include <list>

using namespace std;
using namespace LLVMIR;

static unordered_map<string,FuncType> funcReturnMap;
static unordered_map<string,StructInfo> structInfoMap;
static unordered_map<string,Name_name*> globalVarMap;
static unordered_map<string,Temp_temp*> localVarMap;
static list<L_stm*> emit_irs;

LLVMIR::L_prog* ast2llvm(aA_program p)
{
    auto defs = ast2llvmProg_first(p);
    auto funcs = ast2llvmProg_second(p);
    vector<L_func*> funcs_block;
    for(const auto &f : funcs)
    {
        funcs_block.push_back(ast2llvmFuncBlock(f));
    }
    for(auto &f : funcs_block)
    {
        ast2llvm_moveAlloca(f);
    }
    return new L_prog(defs,funcs_block);
}

int ast2llvmRightVal_first(aA_rightVal r)
{
    if(r == nullptr)
    {
        return 0;
    }
    switch (r->kind)
    {
    case A_arithExprValKind:
    {
        return ast2llvmArithExpr_first(r->u.arithExpr);
        break;
    }
    case A_boolExprValKind:
    {
        return ast2llvmBoolExpr_first(r->u.boolExpr);
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmBoolExpr_first(aA_boolExpr b)
{
    switch (b->kind)
    {
    case A_boolBiOpExprKind:
    {
        return ast2llvmBoolBiOpExpr_first(b->u.boolBiOpExpr);
        break;
    }
    case A_boolUnitKind:
    {
        return ast2llvmBoolUnit_first(b->u.boolUnit);
        break;
    }
    default:
         break;
    }
    return 0;
}

int ast2llvmBoolBiOpExpr_first(aA_boolBiOpExpr b)
{
    int l = ast2llvmBoolExpr_first(b->left);
    int r = ast2llvmBoolExpr_first(b->right);
    if(b->op == A_and)
    {
        return l && r;
    }
    else
    {
        return l || r;
    }
}

int ast2llvmBoolUOpExpr_first(aA_boolUOpExpr b)
{
    if(b->op == A_not)
    {
        return !ast2llvmBoolUnit_first(b->cond);
    }
    return 0;
}

int ast2llvmBoolUnit_first(aA_boolUnit b)
{
    switch (b->kind)
    {
    case A_comOpExprKind:
    {
        return ast2llvmComOpExpr_first(b->u.comExpr);
        break;
    }
    case A_boolExprKind:
    {
        return ast2llvmBoolExpr_first(b->u.boolExpr);
        break;
    }
    case A_boolUOpExprKind:
    {
        return ast2llvmBoolUOpExpr_first(b->u.boolUOpExpr);
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmComOpExpr_first(aA_comExpr c)
{
    auto l = ast2llvmExprUnit_first(c->left);
    auto r = ast2llvmExprUnit_first(c->right);
    switch (c->op)
    {
    case A_lt:
    {
        return l < r;
        break;
    }
    case A_le:
    {
        return l <= r;
        break;
    }
    case A_gt:
    {
        return l > r;
        break;
    }
    case A_ge:
    {
        return l >= r;
        break;
    }
    case A_eq:
    {
        return l == r;
        break;
    }
    case A_ne:
    {
        return l != r;
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmArithBiOpExpr_first(aA_arithBiOpExpr a)
{
    auto l= ast2llvmArithExpr_first(a->left);
    auto r = ast2llvmArithExpr_first(a->right);
    switch (a->op)
    {
    case A_add:
    {
        return l + r;
        break;
    }
    case A_sub:
    {
        return l - r;
        break;
    }
    case A_mul:
    {
        return l * r;
        break;
    }
    case A_div:
    {
        return l / r;
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmArithUExpr_first(aA_arithUExpr a)
{
    if(a->op == A_neg)
    {
        return -ast2llvmExprUnit_first(a->expr);
    }
    return 0;
}

int ast2llvmArithExpr_first(aA_arithExpr a)
{
    switch (a->kind)
    {
    case A_arithBiOpExprKind:
    {
        return ast2llvmArithBiOpExpr_first(a->u.arithBiOpExpr);
        break;
    }
    case A_exprUnitKind:
    {
        return ast2llvmExprUnit_first(a->u.exprUnit);
        break;
    }
    default:
        assert(0);
        break;
    }
    return 0;
}

int ast2llvmExprUnit_first(aA_exprUnit e)
{
    if(e->kind == A_numExprKind)
    {
        return e->u.num;
    }
    else if(e->kind == A_arithExprKind)
    {
        return ast2llvmArithExpr_first(e->u.arithExpr);
    }
    else if(e->kind == A_arithUExprKind)
    {
        return ast2llvmArithUExpr_first(e->u.arithUExpr);
    }
    else
    {
        assert(0);
    }
    return 0;
}

std::vector<LLVMIR::L_def*> ast2llvmProg_first(aA_program p)
{
    vector<L_def*> defs;
    defs.push_back(L_Funcdecl("getch",vector<TempDef>(),FuncType(ReturnType::INT_TYPE)));
    defs.push_back(L_Funcdecl("getint",vector<TempDef>(),FuncType(ReturnType::INT_TYPE)));
    defs.push_back(L_Funcdecl("putch",vector<TempDef>{TempDef(TempType::INT_TEMP)},FuncType(ReturnType::VOID_TYPE)));
    defs.push_back(L_Funcdecl("putint",vector<TempDef>{TempDef(TempType::INT_TEMP)},FuncType(ReturnType::VOID_TYPE)));
    defs.push_back(L_Funcdecl("putarray",vector<TempDef>{TempDef(TempType::INT_TEMP),TempDef(TempType::INT_PTR,-1)},FuncType(ReturnType::VOID_TYPE)));
    defs.push_back(L_Funcdecl("_sysy_starttime",vector<TempDef>{TempDef(TempType::INT_TEMP)},FuncType(ReturnType::VOID_TYPE)));
    defs.push_back(L_Funcdecl("_sysy_stoptime",vector<TempDef>{TempDef(TempType::INT_TEMP)},FuncType(ReturnType::VOID_TYPE)));
    for(const auto &v : p->programElements)
    {
        switch (v->kind)
        {
        case A_programNullStmtKind:
        {
            break;
        }
        case A_programVarDeclStmtKind:
        {
            if(v->u.varDeclStmt->kind == A_varDeclKind)
            {
                if(v->u.varDeclStmt->u.varDecl->kind == A_varDeclScalarKind)
                {
                    if(v->u.varDeclStmt->u.varDecl->u.declScalar->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,
                            Name_newname_struct(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declScalar->id),*v->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType));
                        TempDef def(TempType::STRUCT_TEMP,0,*v->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,
                            Name_newname_int(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declScalar->id)));
                        TempDef def(TempType::INT_TEMP,0);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,def,vector<int>()));
                    }
                }
                else if(v->u.varDeclStmt->u.varDecl->kind == A_varDeclArrayKind)
                {
                    if(v->u.varDeclStmt->u.varDecl->u.declArray->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declArray->id,
                            Name_newname_struct_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declArray->id),v->u.varDeclStmt->u.varDecl->u.declArray->len,*v->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType));
                        TempDef def(TempType::STRUCT_PTR,v->u.varDeclStmt->u.varDecl->u.declArray->len,*v->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declArray->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declArray->id,
                            Name_newname_int_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declArray->id),v->u.varDeclStmt->u.varDecl->u.declArray->len));
                        TempDef def(TempType::INT_PTR,v->u.varDeclStmt->u.varDecl->u.declArray->len);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declArray->id,def,vector<int>()));
                    }
                }
                else
                {
                    assert(0);
                }
            }
            else if(v->u.varDeclStmt->kind == A_varDefKind)
            {
                if(v->u.varDeclStmt->u.varDef->kind == A_varDefScalarKind)
                {
                    if(v->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defScalar->id,
                            Name_newname_struct(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defScalar->id),*v->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType));
                        TempDef def(TempType::STRUCT_TEMP,0,*v->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defScalar->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defScalar->id,
                            Name_newname_int(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defScalar->id)));
                        TempDef def(TempType::INT_TEMP,0);
                        vector<int> init;
                        init.push_back(ast2llvmRightVal_first(v->u.varDeclStmt->u.varDef->u.defScalar->val));
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defScalar->id,def,init));
                    }
                }
                else if(v->u.varDeclStmt->u.varDef->kind == A_varDefArrayKind)
                {
                    if(v->u.varDeclStmt->u.varDef->u.defArray->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defArray->id,
                            Name_newname_struct_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defArray->id),v->u.varDeclStmt->u.varDef->u.defArray->len,*v->u.varDeclStmt->u.varDef->u.defArray->type->u.structType));
                        TempDef def(TempType::STRUCT_PTR,v->u.varDeclStmt->u.varDef->u.defArray->len,*v->u.varDeclStmt->u.varDef->u.defArray->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defArray->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defArray->id,
                            Name_newname_int_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defArray->id),v->u.varDeclStmt->u.varDef->u.defArray->len));
                        TempDef def(TempType::INT_PTR,v->u.varDeclStmt->u.varDef->u.defArray->len);
                        vector<int> init;
                        for(auto &el : v->u.varDeclStmt->u.varDef->u.defArray->vals)
                        {
                            init.push_back(ast2llvmRightVal_first(el));
                        }
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defArray->id,def,init));
                    }
                }
                else
                {
                    assert(0);
                }
            }
            else
            {
                assert(0);
            }
            break;
        }
        case A_programStructDefKind:
        {
            StructInfo si;
            int off = 0;
            vector<TempDef> members;
            for(const auto &decl : v->u.structDef->varDecls)
            {
                if(decl->kind == A_varDeclScalarKind)
                {
                    if(decl->u.declScalar->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_TEMP,0,*decl->u.declScalar->type->u.structType);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declScalar->id,info);
                        members.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_TEMP,0);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declScalar->id,info);
                        members.push_back(def);
                    }
                }
                else if(decl->kind == A_varDeclArrayKind)
                {
                    if(decl->u.declArray->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,decl->u.declArray->len,*decl->u.declArray->type->u.structType);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declArray->id,info);
                        members.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_PTR,decl->u.declArray->len);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declArray->id,info);
                        members.push_back(def);
                    }
                }
                else
                {
                    assert(0);
                }
            }
            structInfoMap.emplace(*v->u.structDef->id,std::move(si));
            defs.push_back(L_Structdef(*v->u.structDef->id,members));
            break;
        }
        case A_programFnDeclStmtKind:
        {
            FuncType type;
            if(v->u.fnDeclStmt->fnDecl->type == nullptr)
            {
                type.type = ReturnType::VOID_TYPE;
            }
            if(v->u.fnDeclStmt->fnDecl->type->type == A_nativeTypeKind)
            {
                type.type = ReturnType::INT_TYPE;
            }
            else if(v->u.fnDeclStmt->fnDecl->type->type == A_structTypeKind)
            {
                type.type = ReturnType::STRUCT_TYPE;
                type.structname = *v->u.fnDeclStmt->fnDecl->type->u.structType;
            }
            else
            {
                assert(0);
            }
            if(funcReturnMap.find(*v->u.fnDeclStmt->fnDecl->id) == funcReturnMap.end())
                funcReturnMap.emplace(*v->u.fnDeclStmt->fnDecl->id,std::move(type));
            vector<TempDef> args;
            for(const auto & decl : v->u.fnDeclStmt->fnDecl->paramDecl->varDecls)
            {
                if(decl->kind == A_varDeclScalarKind)
                {
                    if(decl->u.declScalar->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,0,*decl->u.declScalar->type->u.structType);
                        args.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_TEMP,0);
                        args.push_back(def);
                    }
                }
                else if(decl->kind == A_varDeclArrayKind)
                {
                    if(decl->u.declArray->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,-1,*decl->u.declArray->type->u.structType);
                        args.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_PTR,-1);
                        args.push_back(def);
                    }
                }
                else
                {
                    assert(0);
                }
            }
            defs.push_back(L_Funcdecl(*v->u.fnDeclStmt->fnDecl->id,args,type));
            break;
        }
        case A_programFnDefKind:
        {
            if(funcReturnMap.find(*v->u.fnDef->fnDecl->id) == funcReturnMap.end())
            {
                FuncType type;
                if(v->u.fnDef->fnDecl->type == nullptr)
                {
                    type.type = ReturnType::VOID_TYPE;
                }
                else if(v->u.fnDef->fnDecl->type->type == A_nativeTypeKind)
                {
                    type.type = ReturnType::INT_TYPE;
                }
                else if(v->u.fnDef->fnDecl->type->type == A_structTypeKind)
                {
                    type.type = ReturnType::STRUCT_TYPE;
                    type.structname = *v->u.fnDef->fnDecl->type->u.structType;
                }
                else
                {
                    assert(0);
                }
                funcReturnMap.emplace(*v->u.fnDef->fnDecl->id,std::move(type));
            }
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    return defs;
}

std::vector<Func_local*> ast2llvmProg_second(aA_program p)
{
    vector<Func_local*> funcs;
    for(const auto & v : p->programElements)
    {
        switch (v->kind)
        {
        case A_programNullStmtKind:
        {
            break;
        }
        case A_programVarDeclStmtKind:
        {
            break;
        }
        case A_programStructDefKind:
        {
            break;
        }
        case A_programFnDeclStmtKind:
        {
            break;
        }
        case A_programFnDefKind:
        {
            funcs.push_back(ast2llvmFunc(v->u.fnDef));
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    return funcs;
}

Func_local* ast2llvmFunc(aA_fnDef f)
{
    localVarMap.clear();
    emit_irs.clear();
    vector<Temp_temp*> args;
    string name(*f->fnDecl->id);
    FuncType ret;
    if(f->fnDecl->type == nullptr)
    {
        ret.type = ReturnType::VOID_TYPE;
    }
    else if(f->fnDecl->type->type == A_nativeTypeKind)
    {
        ret.type = ReturnType::INT_TYPE;
    }
    else if(f->fnDecl->type->type == A_structTypeKind)
    {
        ret.type = ReturnType::STRUCT_TYPE;
        ret.structname = *f->fnDecl->type->u.structType;
    }
    else
    {
        assert(0);
    }
    for(const auto &t : f->fnDecl->paramDecl->varDecls)
    {
        if(t->kind == A_varDeclScalarKind)
        {
            if(t->u.declScalar->type->type == A_nativeTypeKind)
            {
                Temp_temp *temp = Temp_newtemp_int();
                args.push_back(temp);
                Temp_temp *alloca_temp = Temp_newtemp_int_ptr(0);
                emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                emit_irs.push_back(L_Store(AS_Operand_Temp(temp),AS_Operand_Temp(alloca_temp)));
                localVarMap.emplace(*t->u.declScalar->id,alloca_temp);
            }
            else
            {
                Temp_temp *temp = Temp_newtemp_struct_ptr(0,*t->u.declScalar->type->u.structType);
                args.push_back(temp);
                localVarMap.emplace(*t->u.declScalar->id,temp);
            }
        }
        else
        {
            if(t->u.declArray->type->type == A_nativeTypeKind)
            {
                Temp_temp *temp = Temp_newtemp_int_ptr(-1);
                args.push_back(temp);
                localVarMap.emplace(*t->u.declArray->id,temp);
            }
            else
            {
                Temp_temp *temp = Temp_newtemp_struct_ptr(-1,*t->u.declArray->type->u.structType);
                args.push_back(temp);
                localVarMap.emplace(*t->u.declArray->id,temp);
            }
        }
    }
    emit_irs.push_back(L_Label(Temp_newlabel()));
    for(const auto &block : f->stmts)
    {
        ast2llvmBlock(block);
    }
    return new Func_local(name,ret,args,emit_irs);
}

void ast2llvmBlock(aA_codeBlockStmt b,Temp_label *con_label,Temp_label *bre_label)
{
    if(b == nullptr)
    {
        return;
    }
    switch (b->kind)
    {
    case A_nullStmtKind:
    {
        break;
    }
    case A_varDeclStmtKind:
    {
        if(b->u.varDeclStmt->kind == A_varDeclKind)
        {
            if(b->u.varDeclStmt->u.varDecl->kind == A_varDeclScalarKind)
            {
                if(b->u.varDeclStmt->u.varDecl->u.declScalar->type->type == A_nativeTypeKind)
                {
                    Temp_temp *alloca_temp = Temp_newtemp_int_ptr(0);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDecl->u.declScalar->id,alloca_temp);
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(0,*b->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDecl->u.declScalar->id,alloca_temp);
                }
            }
            else
            {
                if(b->u.varDeclStmt->u.varDecl->u.declArray->type->type == A_nativeTypeKind)
                {
                    Temp_temp *alloca_temp = Temp_newtemp_int_ptr(b->u.varDeclStmt->u.varDecl->u.declArray->len);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap[*b->u.varDeclStmt->u.varDecl->u.declArray->id]=alloca_temp;
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(b->u.varDeclStmt->u.varDecl->u.declArray->len,*b->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap[*b->u.varDeclStmt->u.varDecl->u.declArray->id]=alloca_temp;
                }
            }
        }
        else
        {
            if(b->u.varDeclStmt->u.varDef->kind == A_varDefScalarKind)
            {
                if(b->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_nativeTypeKind)
                {
                    Temp_temp *alloca_temp = Temp_newtemp_int_ptr(0);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    auto res = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defScalar->val);
                    emit_irs.push_back(L_Store(res,AS_Operand_Temp(alloca_temp)));
                    localVarMap[*b->u.varDeclStmt->u.varDef->u.defScalar->id]=alloca_temp;
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(0,*b->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap[*b->u.varDeclStmt->u.varDef->u.defScalar->id]=alloca_temp;
                }
            }
            else
            {
                if(b->u.varDeclStmt->u.varDef->u.defArray->type->type == A_nativeTypeKind)
                {
                    Temp_temp *alloca_temp = Temp_newtemp_int_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    for(int i = 0;i < b->u.varDeclStmt->u.varDef->u.defArray->vals.size();++i)
                    {
                        const auto &val = b->u.varDeclStmt->u.varDef->u.defArray->vals[i];
                        auto res = ast2llvmRightVal(val);
                        Temp_temp *gep_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Const(i)));
                        emit_irs.push_back(L_Store(res,AS_Operand_Temp(gep_temp)));
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defArray->id,alloca_temp);
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len,*b->u.varDeclStmt->u.varDef->u.defArray->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defArray->id,alloca_temp);
                }
            }
        }
        break;
    }
    case A_assignStmtKind:
    {
        auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
        auto left_op = ast2llvmLeftVal(b->u.assignStmt->leftVal);
        emit_irs.push_back(L_Store(right_temp,left_op));
        break;
    }
    case A_callStmtKind:
    {
        vector<AS_operand*> args;
        for(const auto & v : b->u.callStmt->fnCall->vals)
        {
            args.push_back(ast2llvmRightVal(v));
        }
        emit_irs.push_back(L_Voidcall(*b->u.callStmt->fnCall->fn,args));
        break;
    }
    case A_ifStmtKind:
    {
        auto true_label = Temp_newlabel();
        auto false_label = Temp_newlabel();
        auto end_label = Temp_newlabel();
        ast2llvmBoolExpr(b->u.ifStmt->boolExpr,true_label,false_label);
        emit_irs.push_back(L_Label(true_label));
        for(const auto &v : b->u.ifStmt->ifStmts)
        {
            ast2llvmBlock(v,con_label,bre_label);
        }
        emit_irs.push_back(L_Jump(end_label));
        emit_irs.push_back(L_Label(false_label));
        for(const auto &v : b->u.ifStmt->elseStmts)
        {
            ast2llvmBlock(v,con_label,bre_label);
        }
        emit_irs.push_back(L_Jump(end_label));
        emit_irs.push_back(L_Label(end_label));
        break;
    }
    case A_whileStmtKind:
    {
        auto test_label = Temp_newlabel();
        auto true_label = Temp_newlabel();
        auto false_label = Temp_newlabel();
        emit_irs.push_back(L_Label(test_label));
        ast2llvmBoolExpr(b->u.whileStmt->boolExpr,true_label,false_label);
        emit_irs.push_back(L_Label(true_label));
        for(const auto &v : b->u.whileStmt->whileStmts)
        {
            ast2llvmBlock(v,test_label,false_label);
        }
        emit_irs.push_back(L_Jump(test_label));
        emit_irs.push_back(L_Label(false_label));
        break;
    }
    case A_returnStmtKind:
    {
        auto ret_temp = ast2llvmRightVal(b->u.returnStmt->retVal);
        if(ret_temp == nullptr)
        {
            emit_irs.push_back(L_Ret(nullptr));
        }
        else
        {
            emit_irs.push_back(L_Ret(ret_temp));
        }
        break;
    }
    case A_continueStmtKind:
    {
        if(con_label == nullptr)
        {
            assert(0);
        }
        emit_irs.push_back(L_Jump(con_label));
        break;
    }
    case A_breakStmtKind:
    {
        if(bre_label == nullptr)
        {
            assert(0);
        }
        emit_irs.push_back(L_Jump(bre_label));
        break;
    }
    default:
        break;
    }
}

AS_operand* ast2llvmRightVal(aA_rightVal r)
{
    if(r == nullptr)
    {
        return nullptr;
    }
    switch (r->kind)
    {
    case A_arithExprValKind:
    {
        return ast2llvmArithExpr(r->u.arithExpr);
        break;
    }
    case A_boolExprValKind:
    {
        return ast2llvmBoolExpr(r->u.boolExpr);
        break;
    }
    default:
        break;
    }
    return nullptr;
}

AS_operand* ast2llvmLeftVal(aA_leftVal l)
{
    switch (l->kind)
    {
    case A_varValKind:
    {
        if(localVarMap.find(*l->u.id) != localVarMap.end())
        {
            auto ptr_temp = localVarMap[*l->u.id];
            return AS_Operand_Temp(ptr_temp);
        }
        else if(globalVarMap.find(*l->u.id) != globalVarMap.end())
        {
            auto ptr_name = globalVarMap[*l->u.id];
            return AS_Operand_Name(ptr_name);
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_arrValKind:
    {
        auto ptr_op = ast2llvmLeftVal(l->u.arrExpr->arr);
        auto index_op = ast2llvmIndexExpr(l->u.arrExpr->idx);
        if(ptr_op->kind == OperandKind::TEMP)
        {
            if(ptr_op->u.TEMP->type == TempType::INT_PTR)
            {
                auto gep_temp = Temp_newtemp_int_ptr(0);
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,index_op));
                return AS_Operand_Temp(gep_temp);
            }
            else if(ptr_op->u.TEMP->type == TempType::STRUCT_PTR)
            {
                auto gep_temp = Temp_newtemp_struct_ptr(0,ptr_op->u.TEMP->structname);
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,index_op));
                return AS_Operand_Temp(gep_temp);
            }
            else
            {
                assert(0);
            }
        }
        else if(ptr_op->kind == OperandKind::NAME)
        {
            if(ptr_op->u.NAME->type == TempType::INT_PTR)
            {
                auto gep_temp = Temp_newtemp_int_ptr(0);
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,index_op));
                return AS_Operand_Temp(gep_temp);
            }
            else if(ptr_op->u.NAME->type == TempType::STRUCT_PTR)
            {
                auto gep_temp = Temp_newtemp_struct_ptr(0,ptr_op->u.NAME->structname);
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,index_op));
                return AS_Operand_Temp(gep_temp);
            }
            else
            {
                assert(0);
            }
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_memberValKind:
    {
        auto ptr_op = ast2llvmLeftVal(l->u.memberExpr->structId);
        if(ptr_op->kind == OperandKind::TEMP)
        {
            if(ptr_op->u.TEMP->type == TempType::STRUCT_PTR)
            {
                auto info = structInfoMap[ptr_op->u.TEMP->structname].memberinfos[*l->u.memberExpr->memberId];
                auto index = info.offset;
                Temp_temp *gep_temp = nullptr;
                if(info.def.kind == TempType::INT_TEMP)
                {
                    gep_temp = Temp_newtemp_int_ptr(0);
                }
                else if(info.def.kind == TempType::INT_PTR)
                {
                    gep_temp = Temp_newtemp_int_ptr(info.def.len);
                }
                else if(info.def.kind == TempType::STRUCT_TEMP)
                {
                    gep_temp = Temp_newtemp_struct_ptr(0,info.def.structname);
                }
                else
                {
                    gep_temp = Temp_newtemp_struct_ptr(info.def.len,info.def.structname);
                }
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,AS_Operand_Const(index)));
                return AS_Operand_Temp(gep_temp);
            }
            else
            {
                assert(0);
            }
        }
        else if(ptr_op->kind == OperandKind::NAME)
        {
            if(ptr_op->u.NAME->type == TempType::STRUCT_TEMP)
            {
                auto info = structInfoMap[ptr_op->u.NAME->structname].memberinfos[*l->u.memberExpr->memberId];
                auto index = info.offset;
                Temp_temp *gep_temp = nullptr;
                if(info.def.kind == TempType::INT_TEMP)
                {
                    gep_temp = Temp_newtemp_int_ptr(0);
                }
                else if(info.def.kind == TempType::INT_PTR)
                {
                    gep_temp = Temp_newtemp_int_ptr(info.def.len);
                }
                else if(info.def.kind == TempType::STRUCT_TEMP)
                {
                    gep_temp = Temp_newtemp_struct_ptr(0,info.def.structname);
                }
                else
                {
                    gep_temp = Temp_newtemp_struct_ptr(info.def.len,info.def.structname);
                }
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,AS_Operand_Const(index)));
                return AS_Operand_Temp(gep_temp);
            }
            else
            {
                assert(0);
            }
        }
        else
        {
            assert(0);
        }
        break;
    }
    default:
        break;
    }
}

AS_operand* ast2llvmIndexExpr(aA_indexExpr index)
{
    if(index->kind == A_numIndexKind)
    {
        return AS_Operand_Const(index->u.num);
    }
    else if(index->kind == A_idIndexKind)
    {
        if(localVarMap.find(*index->u.id) != localVarMap.end())
        {
            auto alloca_temp = localVarMap[*index->u.id];
            if(alloca_temp->type == TempType::INT_PTR)
            {
                auto load_temp = Temp_newtemp_int();
                emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Temp(alloca_temp)));
                return AS_Operand_Temp(load_temp);
            }
            else
            {
                assert(0);
            }
        }
        else if(globalVarMap.find(*index->u.id) != globalVarMap.end())
        {
            auto alloca_name = globalVarMap[*index->u.id];
            if(alloca_name->type == TempType::INT_TEMP)
            {
                auto load_temp = Temp_newtemp_int();
                emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Name(alloca_name)));
                return AS_Operand_Temp(load_temp);
            }
            else
            {
                assert(0);
            }
        }
        else
        {
            assert(0);
        }
    }
    else
    {
        assert(0);
    }
}

AS_operand* ast2llvmBoolExpr(aA_boolExpr b,Temp_label *true_label,Temp_label *false_label)
{
    if(true_label == nullptr)
    {
        auto _true_label = Temp_newlabel();
        auto _false_label = Temp_newlabel();
        auto _end_label = Temp_newlabel();
        auto alloca_temp = Temp_newtemp_int_ptr(0);
        emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
        auto dst_temp = Temp_newtemp_int();
        switch (b->kind)
        {
        case A_boolBiOpExprKind:
        {
            ast2llvmBoolBiOpExpr(b->u.boolBiOpExpr,_true_label,_false_label);
            break;
        }
        case A_boolUnitKind:
        {
            ast2llvmBoolUnit(b->u.boolUnit,_true_label,_false_label);
            break;
        }
        default:
            break;
        }
        emit_irs.push_back(L_Label(_true_label));
        emit_irs.push_back(L_Store(AS_Operand_Const(1),AS_Operand_Temp(alloca_temp)));
        emit_irs.push_back(L_Jump(_end_label));
        emit_irs.push_back(L_Label(_false_label));
        emit_irs.push_back(L_Store(AS_Operand_Const(0),AS_Operand_Temp(alloca_temp)));
        emit_irs.push_back(L_Jump(_end_label));
        emit_irs.push_back(L_Label(_end_label));
        emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(alloca_temp)));
        return AS_Operand_Temp(dst_temp);
    }
    else
    {
        switch (b->kind)
        {
        case A_boolBiOpExprKind:
        {
            ast2llvmBoolBiOpExpr(b->u.boolBiOpExpr,true_label,false_label);
            return nullptr;
            break;
        }
        case A_boolUnitKind:
        {
            ast2llvmBoolUnit(b->u.boolUnit,true_label,false_label);
            return nullptr;
            break;
        }
        default:
            break;
        }
    }
    return nullptr;
}

void ast2llvmBoolBiOpExpr(aA_boolBiOpExpr b,Temp_label *true_label,Temp_label *false_label)
{
    if(true_label == nullptr)
    {
        assert(0);
    }
    else
    {
        if(b->op == A_and)
        {
            Temp_label *and_label = Temp_newlabel();
            ast2llvmBoolExpr(b->left,and_label,false_label);
            emit_irs.push_back(L_Label(and_label));
            ast2llvmBoolExpr(b->right,true_label,false_label);
        }
        else
        {
            Temp_label *or_label = Temp_newlabel();
            ast2llvmBoolExpr(b->left,true_label,or_label);
            emit_irs.push_back(L_Label(or_label));
            ast2llvmBoolExpr(b->right,true_label,false_label);
        }
    }
}

void ast2llvmBoolUOpExpr(aA_boolUOpExpr b,Temp_label *true_label,Temp_label *false_label)
{
    if(true_label == nullptr)
    {
        assert(0);
    }  
    else
    {
        if(b->op == A_not)
        {
            ast2llvmBoolUnit(b->cond,false_label,true_label);
        }
    }
}

void ast2llvmBoolUnit(aA_boolUnit b,Temp_label *true_label,Temp_label *false_label)
{
    if(true_label == nullptr)
    {
        assert(0);
    }
    switch (b->kind)
    {
    case A_comOpExprKind:
    {
        ast2llvmComOpExpr(b->u.comExpr,true_label,false_label);
        break;
    }
    case A_boolExprKind:
    {
        ast2llvmBoolExpr(b->u.boolExpr,true_label,false_label);
        break;
    }
    case A_boolUOpExprKind:
    {
        ast2llvmBoolUOpExpr(b->u.boolUOpExpr,true_label,false_label);
        break;
    }
    default:
        break;
    }
}

void ast2llvmComOpExpr(aA_comExpr c,Temp_label *true_label,Temp_label *false_label)
{
    auto left_temp = ast2llvmExprUnit(c->left);
    auto right_temp = ast2llvmExprUnit(c->right);
    auto dst_temp = Temp_newtemp_int();
    switch (c->op)
    {
    case A_lt:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_lt,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_le:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_le,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_gt:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_gt,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_ge:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_ge,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_eq:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_eq,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_ne:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_ne,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    default:
        break;
    }
    emit_irs.push_back(L_Cjump(AS_Operand_Temp(dst_temp),true_label,false_label));
}

AS_operand* ast2llvmArithBiOpExpr(aA_arithBiOpExpr a)
{
    auto left_temp = ast2llvmArithExpr(a->left);
    auto right_temp = ast2llvmArithExpr(a->right);
    auto dst_temp = Temp_newtemp_int();
    switch (a->op)
    {
    case A_add:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_plus,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_sub:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_minus,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_mul:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_mul,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_div:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_div,left_temp,right_temp,AS_Operand_Temp(dst_temp)));
        break;
    }
    default:
        break;
    }
    return AS_Operand_Temp(dst_temp);
}

AS_operand* ast2llvmArithUExpr(aA_arithUExpr a)
{
    if(a->op == A_neg)
    {
        auto dst_temp = Temp_newtemp_int();
        auto src_temp = ast2llvmExprUnit(a->expr);
        emit_irs.push_back(L_Binop(L_binopKind::T_minus,AS_Operand_Const(0),src_temp,AS_Operand_Temp(dst_temp)));
        return AS_Operand_Temp(dst_temp);
    }
    else
    {
        assert(0);
    }
    return nullptr;
}

AS_operand* ast2llvmArithExpr(aA_arithExpr a)
{
    switch (a->kind)
    {
    case A_arithBiOpExprKind:
    {
        return ast2llvmArithBiOpExpr(a->u.arithBiOpExpr);
        break;
    }
    case A_exprUnitKind:
    {
        return ast2llvmExprUnit(a->u.exprUnit);
        break;
    }
    default:
        assert(0);
        break;
    }
    return nullptr;
}

AS_operand* ast2llvmExprUnit(aA_exprUnit e)
{
    switch (e->kind)
    {
    case A_numExprKind:
    {
        return AS_Operand_Const(e->u.num);
        break;
    }
    case A_idExprKind:
    {
        if(localVarMap.find(*e->u.id) != localVarMap.end())
        {
            auto alloca_temp = localVarMap[*e->u.id];
            if(alloca_temp->type == TempType::INT_PTR)
            {
                if(alloca_temp->len == 0)
                {
                    auto dst_temp = Temp_newtemp_int();
                    emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(alloca_temp)));
                    return AS_Operand_Temp(dst_temp);
                }
                else
                {
                    return AS_Operand_Temp(alloca_temp);
                }
            }
            else if(alloca_temp->type == TempType::STRUCT_PTR)
            {
                return AS_Operand_Temp(alloca_temp);
            }
            else
            {
                assert(0);
            }
        }
        else if(globalVarMap.find(*e->u.id) != globalVarMap.end())
        {
            auto var_name = globalVarMap[*e->u.id];
            if(var_name->type == TempType::INT_TEMP)
            {
                auto dst_temp = Temp_newtemp_int();
                emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Name(var_name)));
                return AS_Operand_Temp(dst_temp);
            }
            else
            {
                return AS_Operand_Name(var_name);
            }
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_arithExprKind:
    {
        return ast2llvmArithExpr(e->u.arithExpr);
        break;
    }
    case A_fnCallKind:
    {
        vector<AS_operand*> args;
        for(const auto &v : e->u.callExpr->vals)
        {
            args.push_back(ast2llvmRightVal(v));
        }
        auto dst_temp = Temp_newtemp_int();
        emit_irs.push_back(L_Call(*e->u.callExpr->fn,AS_Operand_Temp(dst_temp),args));
        return AS_Operand_Temp(dst_temp);
        break;
    }
    case A_arrayExprKind:
    {
        auto left_op = ast2llvmLeftVal(e->u.arrayExpr->arr);
        auto index_op = ast2llvmIndexExpr(e->u.arrayExpr->idx);
        auto gep_temp = Temp_newtemp_int_ptr(0);
        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),left_op,index_op));
        if(left_op->kind == OperandKind::TEMP)
        {
            Temp_temp *load_temp = nullptr;
            if(left_op->u.TEMP->type == TempType::INT_PTR)
            {
                load_temp = Temp_newtemp_int();
            }
            else
            {
                assert(0);
            }
            emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Temp(gep_temp)));
            return AS_Operand_Temp(load_temp);
        }
        else if(left_op->kind == OperandKind::NAME)
        {
            Temp_temp *load_temp = nullptr;
            if(left_op->u.NAME->type == TempType::INT_PTR)
            {
                load_temp = Temp_newtemp_int();
            }
            else
            {
                assert(0);
            }
            emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Temp(gep_temp)));
            return AS_Operand_Temp(load_temp);
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_memberExprKind:
    {
        auto ptr_op = ast2llvmLeftVal(e->u.memberExpr->structId);
        if(ptr_op->kind == OperandKind::TEMP)
        {
            if(ptr_op->u.TEMP->type == TempType::STRUCT_PTR)
            {
                auto info = structInfoMap[ptr_op->u.TEMP->structname].memberinfos[*e->u.memberExpr->memberId];
                auto index = info.offset;
                Temp_temp *gep_temp = nullptr;
                Temp_temp *load_temp;
                if(info.def.kind == TempType::INT_TEMP)
                {
                    gep_temp = Temp_newtemp_int_ptr(0);
                    load_temp = Temp_newtemp_int();
                }
                else
                {
                    assert(0);
                }
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,AS_Operand_Const(index)));
                emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Temp(gep_temp)));
                return AS_Operand_Temp(load_temp);
            }
            else
            {
                assert(0);
            }
        }
        else if(ptr_op->kind == OperandKind::NAME)
        {
            if(ptr_op->u.NAME->type == TempType::STRUCT_TEMP)
            {
                auto info = structInfoMap[ptr_op->u.NAME->structname].memberinfos[*e->u.memberExpr->memberId];
                auto index = info.offset;
                Temp_temp *gep_temp = nullptr;
                Temp_temp *load_temp;
                if(info.def.kind == TempType::INT_TEMP)
                {
                    gep_temp = Temp_newtemp_int_ptr(0);
                    load_temp = Temp_newtemp_int();
                }
                else
                {
                    assert(0);
                }
                emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),ptr_op,AS_Operand_Const(index)));
                emit_irs.push_back(L_Load(AS_Operand_Temp(load_temp),AS_Operand_Temp(gep_temp)));
                return AS_Operand_Temp(load_temp);
            }
            else
            {
                assert(0);
            }
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_arithUExprKind:
    {
        return ast2llvmArithUExpr(e->u.arithUExpr);
        break;
    }
    default:
        break;
    }
}

LLVMIR::L_func* ast2llvmFuncBlock(Func_local *f)
{
    std::list<L_stm*> block_list;
    std::list<L_block*> blocks;
    bool in_block = false;
    for(auto it = f->irs.begin();it != f->irs.end();)
    {
        auto ir = *it;
        if(in_block)
        {
            if(ir->type == L_StmKind::T_CJUMP || ir->type == L_StmKind::T_JUMP || ir->type == L_StmKind::T_RETURN)
            {
                in_block = false;
                block_list.push_back(ir);
                blocks.push_back(L_Block(block_list));
                block_list.clear();
                ++it;
            }
            else if(ir->type == L_StmKind::T_LABEL)
            {
                block_list.push_back(L_Jump(ir->u.LABEL->label));
                blocks.push_back(L_Block(block_list));
                block_list.clear();
                block_list.push_back(ir);
                ++it;
            }
            else
            {
                block_list.push_back(ir);
                ++it;
            }
        }
        else
        {
            if(ir->type == L_StmKind::T_LABEL)
            {
                in_block = true;
                block_list.push_back(ir);
                ++it;
            }
            else
            {
                auto label = Temp_newlabel();
                in_block = true;
                block_list.push_back(L_Label(label));
            }
        }
    }
    if(in_block)
    {
        if(funcReturnMap[f->name].type == ReturnType::VOID_TYPE)
        {
            block_list.push_back(L_Ret(nullptr));
        }
        else
        {
            block_list.push_back(L_Ret(AS_Operand_Const(0)));
        }
        blocks.push_back(L_Block(block_list));
    }
    return new L_func(f->name,f->ret,f->args,blocks);
}

void ast2llvm_moveAlloca(LLVMIR::L_func *f)
{
    auto first_block = f->blocks.front();
    for(auto i = ++f->blocks.begin();i != f->blocks.end();++i)
    {
        for(auto it = (*i)->instrs.begin();it != (*i)->instrs.end();)
        {
            if((*it)->type == L_StmKind::T_ALLOCA)
            {
                first_block->instrs.insert(++first_block->instrs.begin(),*it);
                it = (*i)->instrs.erase(it);
            }
            else
            {
                ++it;
            }
        }
    }
}