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
    return new L_prog(defs,funcs_block);
}

std::vector<LLVMIR::L_def*> ast2llvmProg_first(aA_program p)
{
    vector<L_def*> defs;
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
                        //
                        init.push_back(v->u.varDeclStmt->u.varDef->u.defScalar->val->u.arithExpr->u.exprUnit->u.num);
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
                        TempDef def(TempType::INT_PTR,v->u.varDeclStmt->u.varDecl->u.declArray->len);
                        vector<int> init;
                        for(auto &el : v->u.varDeclStmt->u.varDef->u.defArray->vals)
                        {
                            //
                            init.push_back(el->u.arithExpr->u.exprUnit->u.num);
                        }
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declArray->id,def,init));
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
                if(v->u.fnDef->fnDecl->type->type == A_nativeTypeKind)
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
    if(f->fnDecl->type->type == A_nativeTypeKind)
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
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDecl->u.declArray->id,alloca_temp);
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(b->u.varDeclStmt->u.varDecl->u.declArray->len,*b->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDecl->u.declArray->id,alloca_temp);
                }
            }
        }
        else
        {
            if(b->u.varDeclStmt->u.varDef->kind = A_varDefScalarKind)
            {
                if(b->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_nativeTypeKind)
                {
                    Temp_temp *alloca_temp = Temp_newtemp_int_ptr(0);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    Temp_temp *res = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defScalar->val);
                    emit_irs.push_back(L_Store(AS_Operand_Temp(res),AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defScalar->id,alloca_temp);
                }
                else
                {
                    Temp_temp *alloca_temp = Temp_newtemp_struct_ptr(0,*b->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(alloca_temp)));
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defScalar->id,alloca_temp);
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
                        Temp_temp *res = ast2llvmRightVal(val);
                        Temp_temp *gep_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Const(i)));
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
        switch (b->u.assignStmt->leftVal->kind)
        {
        case A_varValKind:
        {
            if(localVarMap.find(*b->u.assignStmt->leftVal->u.id) != localVarMap.end())
            {
                auto ptr_temp = localVarMap[*b->u.assignStmt->leftVal->u.id];
                if(ptr_temp->type == TempType::INT_PTR)
                {
                    auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                    emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Temp(ptr_temp)));
                }
                else
                {
                    assert(0);
                }
            }
            else if(globalVarMap.find(*b->u.assignStmt->leftVal->u.id) != globalVarMap.end())
            {
                auto ptr_name = globalVarMap[*b->u.assignStmt->leftVal->u.id];
                if(ptr_name->type == TempType::INT_TEMP)
                {
                    auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                    emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Name(ptr_name)));
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
        case A_arrValKind:
        {
            if(localVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->arr) != localVarMap.end())
            {
                auto ptr_temp = localVarMap[*b->u.assignStmt->leftVal->u.arrExpr->arr];
                if(ptr_temp->type == TempType::INT_PTR)
                {
                    auto left_temp = Temp_newtemp_int_ptr(0);
                    if(b->u.assignStmt->leftVal->u.arrExpr->idx->kind == A_numIndexKind)
                    {
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Temp(ptr_temp),AS_Operand_Const(b->u.assignStmt->leftVal->u.arrExpr->idx->u.num)));
                    }
                    else
                    {
                        if(localVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id) != localVarMap.end())
                        {
                            auto id_temp = localVarMap[*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id];
                            if(id_temp->type == TempType::INT_TEMP)
                            {
                                auto index_temp = Temp_newtemp_int();
                                emit_irs.push_back(L_Load(AS_Operand_Temp(index_temp),AS_Operand_Temp(id_temp)));
                                emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Temp(ptr_temp),AS_Operand_Temp(index_temp)));
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        else if(globalVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id) != globalVarMap.end())
                        {
                            auto id_name = globalVarMap[*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id];
                            if(id_name->type == TempType::INT_TEMP)
                            {
                                auto index_temp = Temp_newtemp_int();
                                emit_irs.push_back(L_Load(AS_Operand_Temp(index_temp),AS_Operand_Name(id_name)));
                                emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Temp(ptr_temp),AS_Operand_Temp(index_temp)));
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                    }
                    auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                    emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Temp(left_temp)));
                }
                else if(ptr_temp->type == TempType::STRUCT_PTR)
                {
                    assert(0);
                }
                else
                {
                    assert(0);
                }
            }
            else if(globalVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->arr) != globalVarMap.end())
            {
                auto ptr_name = globalVarMap[*b->u.assignStmt->leftVal->u.arrExpr->arr];
                if(ptr_name->type == TempType::INT_PTR)
                {
                    auto left_temp = Temp_newtemp_int_ptr(0);
                    if(b->u.assignStmt->leftVal->u.arrExpr->idx->kind == A_numIndexKind)
                    {
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Name(ptr_name),AS_Operand_Const(b->u.assignStmt->leftVal->u.arrExpr->idx->u.num)));
                    }
                    else
                    {
                        if(localVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id) != localVarMap.end())
                        {
                            auto id_temp = localVarMap[*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id];
                            if(id_temp->type == TempType::INT_TEMP)
                            {
                                auto index_temp = Temp_newtemp_int();
                                emit_irs.push_back(L_Load(AS_Operand_Temp(index_temp),AS_Operand_Temp(id_temp)));
                                emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Name(ptr_name),AS_Operand_Temp(index_temp)));
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                        else if(globalVarMap.find(*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id) != globalVarMap.end())
                        {
                            auto id_name = globalVarMap[*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id];
                            if(id_name->type == TempType::INT_TEMP)
                            {
                                auto index_temp = Temp_newtemp_int();
                                emit_irs.push_back(L_Load(AS_Operand_Temp(index_temp),AS_Operand_Name(id_name)));
                                emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Name(ptr_name),AS_Operand_Temp(index_temp)));
                            }
                            else
                            {
                                assert(0);
                            }
                        }
                    }
                    auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                    emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Temp(left_temp)));
                }
                else if(ptr_name->type == TempType::STRUCT_PTR)
                {
                    assert(0);
                }
                else
                {
                    assert(0);
                }
            }
            break;
        }
        case A_memberValKind:
        {
            if(localVarMap.find(*b->u.assignStmt->leftVal->u.memberExpr->structId) != localVarMap.end())
            {
                auto ptr_temp = localVarMap[*b->u.assignStmt->leftVal->u.memberExpr->structId];
                if(ptr_temp->type == TempType::STRUCT_PTR)
                {
                    auto info = structInfoMap[ptr_temp->structname].memberinfos[*b->u.assignStmt->leftVal->u.memberExpr->memberId];
                    int index = info.offset;
                    if(info.def.kind == TempType::INT_TEMP)
                    {
                        auto left_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Temp(ptr_temp),AS_Operand_Const(index)));
                        auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                        emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Temp(left_temp)));
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
            else if(globalVarMap.find(*b->u.assignStmt->leftVal->u.memberExpr->structId) != globalVarMap.end())
            {
                auto ptr_name = globalVarMap[*b->u.assignStmt->leftVal->u.memberExpr->structId];
                if(ptr_name->type == TempType::STRUCT_PTR)
                {
                    auto info = structInfoMap[ptr_name->structname].memberinfos[*b->u.assignStmt->leftVal->u.memberExpr->memberId];
                    int index = info.offset;
                    if(info.def.kind == TempType::INT_TEMP)
                    {
                        auto left_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(left_temp),AS_Operand_Name(ptr_name),AS_Operand_Const(index)));
                        auto right_temp = ast2llvmRightVal(b->u.assignStmt->rightVal);
                        emit_irs.push_back(L_Store(AS_Operand_Temp(right_temp),AS_Operand_Temp(left_temp)));
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
            break;
        }
        default:
            break;
        }
        break;
    }
    case A_callStmtKind:
    {
        vector<AS_operand*> args;
        for(const auto & v : b->u.callStmt->fnCall->vals)
        {
            args.push_back(AS_Operand_Temp(ast2llvmRightVal(v)));
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
        emit_irs.push_back(L_Ret(AS_Operand_Temp(ret_temp)));
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

Temp_temp* ast2llvmRightVal(aA_rightVal r)
{
    if(r == nullptr)
    {
        return nullptr;
    }
    switch (r->kind)
    {
    case A_arithExprValKind:
    {

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

Temp_temp* ast2llvmBoolExpr(aA_boolExpr b,Temp_label *true_label,Temp_label *false_label)
{
    if(true_label == nullptr)
    {
        auto _true_label = Temp_newlabel();
        auto _false_label = Temp_newlabel();
        auto _end_label = Temp_newlabel();
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
        emit_irs.push_back(L_Move(AS_Operand_Const(1),AS_Operand_Temp(dst_temp)));
        emit_irs.push_back(L_Jump(_end_label));
        emit_irs.push_back(L_Label(_false_label));
        emit_irs.push_back(L_Move(AS_Operand_Const(0),AS_Operand_Temp(dst_temp)));
        emit_irs.push_back(L_Jump(_end_label));
        emit_irs.push_back(L_Label(_end_label));
        return dst_temp;
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
        emit_irs.push_back(L_Cmp(L_relopKind::T_lt,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_le:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_le,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_gt:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_gt,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_ge:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_ge,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_eq:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_eq,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_ne:
    {
        emit_irs.push_back(L_Cmp(L_relopKind::T_ne,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    default:
        break;
    }
    emit_irs.push_back(L_Cjump(AS_Operand_Temp(dst_temp),true_label,false_label));
}

Temp_temp* ast2llvmArithBiOpExpr(aA_arithBiOpExpr a)
{
    auto left_temp = ast2llvmArithExpr(a->left);
    auto right_temp = ast2llvmArithExpr(a->right);
    auto dst_temp = Temp_newtemp_int();
    switch (a->op)
    {
    case A_add:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_plus,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_sub:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_minus,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_mul:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_mul,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    case A_div:
    {
        emit_irs.push_back(L_Binop(L_binopKind::T_div,AS_Operand_Temp(left_temp),AS_Operand_Temp(right_temp),AS_Operand_Temp(dst_temp)));
        break;
    }
    default:
        break;
    }
    return dst_temp;
}

Temp_temp* ast2llvmArithUExpr(aA_arithUExpr a)
{
    if(a->op == A_neg)
    {
        auto dst_temp = Temp_newtemp_int();
        auto src_temp = ast2llvmExprUnit(a->expr);
        emit_irs.push_back(L_Binop(L_binopKind::T_minus,AS_Operand_Const(0),AS_Operand_Temp(src_temp),AS_Operand_Temp(dst_temp)));
        return dst_temp;
    }
    else
    {
        assert(0);
    }
    return nullptr;
}

Temp_temp* ast2llvmArithExpr(aA_arithExpr a)
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

Temp_temp* ast2llvmExprUnit(aA_exprUnit e)
{
    switch (e->kind)
    {
    case A_numExprKind:
    {
        auto dst_temp = Temp_newtemp_int();
        emit_irs.push_back(L_Move(AS_Operand_Const(e->u.num),AS_Operand_Temp(dst_temp)));
        return dst_temp;
        break;
    }
    case A_idExprKind:
    {
        if(localVarMap.find(*e->u.id) != localVarMap.end())
        {
            auto alloca_temp = localVarMap[*e->u.id];
            if(alloca_temp->type == TempType::INT_PTR)
            {
                auto dst_temp = Temp_newtemp_int();
                emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(alloca_temp)));
                return dst_temp;
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
                return dst_temp;
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
            args.push_back(AS_Operand_Temp(ast2llvmRightVal(v)));
        }
        auto dst_temp = Temp_newtemp_int();
        emit_irs.push_back(L_Call(*e->u.callExpr->fn,AS_Operand_Temp(dst_temp),args));
        return dst_temp;
        break;
    }
    case A_arrayExprKind:
    {
        if(localVarMap.find(*e->u.arrayExpr->arr) != localVarMap.end())
        {
            auto alloca_temp = localVarMap[*e->u.arrayExpr->arr];
            if(alloca_temp->type == TempType::INT_PTR)
            {
                auto dst_temp = Temp_newtemp_int();
                Temp_temp *gep_temp = Temp_newtemp_int_ptr(-1);
                if(e->u.arrayExpr->idx->kind == A_numIndexKind)
                {
                    emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Const(e->u.arrayExpr->idx->u.num)));
                }
                else
                {
                    if(localVarMap.find(*e->u.arrayExpr->idx->u.id) != localVarMap.end())
                    {
                        auto t = localVarMap[*e->u.arrayExpr->idx->u.id];
                        auto tt = Temp_newtemp_int();
                        emit_irs.push_back(L_Load(AS_Operand_Temp(tt),AS_Operand_Temp(t)));
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Temp(tt)));
                    }
                    else if(globalVarMap.find(*e->u.arrayExpr->idx->u.id) != globalVarMap.end())
                    {
                        auto t = globalVarMap[*e->u.arrayExpr->idx->u.id];
                        auto tt = Temp_newtemp_int();
                        emit_irs.push_back(L_Load(AS_Operand_Temp(tt),AS_Operand_Name(t)));
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Temp(tt)));
                    }
                    else
                    {
                        assert(0);
                    }
                }
                emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(gep_temp)));
                return dst_temp;
            }
            else
            {
                assert(0);
            }
        }
        else if(globalVarMap.find(*e->u.arrayExpr->arr) != globalVarMap.end())
        {
            auto var_name = globalVarMap[*e->u.arrayExpr->arr];
            if(var_name->type == TempType::INT_PTR)
            {
                auto dst_temp = Temp_newtemp_int();
                auto gep_temp = Temp_newtemp_int_ptr(-1);
                if(e->u.arrayExpr->idx->kind == A_numIndexKind)
                {
                    emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Name(var_name),AS_Operand_Const(e->u.arrayExpr->idx->u.num)));
                }
                else
                {
                    if(localVarMap.find(*e->u.arrayExpr->idx->u.id) != localVarMap.end())
                    {
                        auto t = localVarMap[*e->u.arrayExpr->idx->u.id];
                        auto tt = Temp_newtemp_int();
                        emit_irs.push_back(L_Load(AS_Operand_Temp(tt),AS_Operand_Temp(t)));
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Name(var_name),AS_Operand_Temp(tt)));
                    }
                    else if(globalVarMap.find(*e->u.arrayExpr->idx->u.id) != globalVarMap.end())
                    {
                        auto t = globalVarMap[*e->u.arrayExpr->idx->u.id];
                        auto tt = Temp_newtemp_int();
                        emit_irs.push_back(L_Load(AS_Operand_Temp(tt),AS_Operand_Name(t)));
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Name(var_name),AS_Operand_Temp(tt)));
                    }
                    else
                    {
                        assert(0);
                    }
                }
                emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(gep_temp)));
                return dst_temp;
            }
            else
            {
                assert(0);
            }
            return nullptr;
        }
        else
        {
            assert(0);
        }
        break;
    }
    case A_memberExprKind:
    {
        if(localVarMap.find(*e->u.memberExpr->structId) != localVarMap.end())
        {
            auto alloca_temp = localVarMap[*e->u.memberExpr->structId];
            if(alloca_temp->type == TempType::STRUCT_PTR)
            {
                if(structInfoMap[alloca_temp->structname].memberinfos.find(*e->u.memberExpr->memberId) != structInfoMap[alloca_temp->structname].memberinfos.end())
                {
                    auto info = structInfoMap[alloca_temp->structname].memberinfos[*e->u.memberExpr->memberId];
                    auto gep_temp = Temp_newtemp_int_ptr(0);
                    emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Temp(alloca_temp),AS_Operand_Const(info.offset)));
                    auto dst_temp = Temp_newtemp_int();
                    emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(gep_temp)));
                    return dst_temp;
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
        else if(globalVarMap.find(*e->u.memberExpr->structId) != globalVarMap.end())
        {
            auto var_name = globalVarMap[*e->u.memberExpr->structId];
            if(var_name->type == TempType::STRUCT_PTR)
            {
                if(structInfoMap[var_name->structname].memberinfos.find(*e->u.memberExpr->memberId) != structInfoMap[var_name->structname].memberinfos.end())
                {
                    auto info = structInfoMap[var_name->structname].memberinfos[*e->u.memberExpr->memberId];
                    auto gep_temp = Temp_newtemp_int_ptr(0);
                    emit_irs.push_back(L_Gep(AS_Operand_Temp(gep_temp),AS_Operand_Name(var_name),AS_Operand_Const(info.offset)));
                    auto dst_temp = Temp_newtemp_int();
                    emit_irs.push_back(L_Load(AS_Operand_Temp(dst_temp),AS_Operand_Temp(gep_temp)));
                    return dst_temp;
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
        return nullptr;
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
    for(const auto &ir : f->irs)
    {
        if(in_block)
        {
            if(ir->type == L_StmKind::T_CJUMP || ir->type == L_StmKind::T_JUMP || ir->type == L_StmKind::T_RETURN)
            {
                in_block = false;
                block_list.push_back(ir);
                blocks.push_back(L_Block(block_list));
                block_list.clear();
            }
            else if(ir->type == L_StmKind::T_LABEL)
            {
                auto label = Temp_newlabel();
                block_list.push_back(L_Jump(label));
                blocks.push_back(L_Block(block_list));
                block_list.clear();
                block_list.push_back(L_Label(label));
            }
            else
            {
                block_list.push_back(ir);
            }
        }
        else
        {
            if(ir->type == L_StmKind::T_LABEL)
            {
                in_block = true;
                block_list.push_back(ir);
            }
            else
            {
                auto label = Temp_newlabel();
                in_block = true;
                block_list.push_back(L_Label(label));
                block_list.push_back(ir);
            }
        }
    }
    return new L_func(f->name,f->ret,f->args,blocks);
}