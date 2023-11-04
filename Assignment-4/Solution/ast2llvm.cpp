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
}

Func_local* ast2llvmFunc(aA_fnDef f)
{
    localVarMap.clear();
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
    for(const auto & t : f->fnDecl->paramDecl->varDecls)
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
    for(const auto &block : f->stmts)
    {
        ast2llvmBlock(block);
    }
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
        /*struct a{int b};
          struct a c[10];
          let d = c[0];
          d.b = 1;*/
        switch (b->u.assignStmt->leftVal->kind)
        {
        case A_varValKind:
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
            break;
        }
        case A_arrValKind:
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
                    auto id_temp = localVarMap[*b->u.assignStmt->leftVal->u.arrExpr->idx->u.id];
                    if(id_temp->type == TempType::INT_PTR)
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
            break;
        }
        case A_memberValKind:
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

    }
    else
    {
        
    }
}