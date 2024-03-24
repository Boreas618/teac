#include "TypeCheck.h"

//global tabels
//typeMap func2retType; // function name to return type

// global token ids to type
typeMap g_token2Type; 

// local token ids to type, since func param can override global param
typeMap funcparam_token2Type;
vector<typeMap*> local_token2Type;


paramMemberMap func2Param;
paramMemberMap struct2Members;


// private util functions
void error_print(std::ostream& out, A_pos p, string info)
{
    out << "Typecheck error in line " << p->line << ", col " << p->col << ": " << info << std::endl;
    exit(0);
}


void print_token_map(typeMap* map){
    for(auto it = map->begin(); it != map->end(); it++){
        std::cout << it->first << " : ";
        switch (it->second->type->type)
        {
        case A_dataType::A_nativeTypeKind:
            switch (it->second->type->u.nativeType)
            {
            case A_nativeType::A_intTypeKind:
                std::cout << "int";
                break;
            default:
                break;
            }
            break;
        case A_dataType::A_structTypeKind:
            std::cout << *(it->second->type->u.structType);
            break;
        default:
            break;
        }
        switch(it->second->isVarArrFunc){
            case 0:
                std::cout << " scalar";
                break;
            case 1:
                std::cout << " array";
                break;
            case 2:
                std::cout << " function";
                break;
        }
        std::cout << std::endl;
    }
}


void print_token_maps(){
    std::cout << "global token2Type:" << std::endl;
    print_token_map(&g_token2Type);
    std::cout << "local token2Type:" << std::endl;
    print_token_map(&funcparam_token2Type);
}


bool find_token(string name){
    // find from the most inner codeblock
    for(auto it = local_token2Type.rbegin(); it != local_token2Type.rend(); it++){
        if((*it)->find(name) != (*it)->end()){
            return true;
        }
    }

    if(funcparam_token2Type.find(name) != funcparam_token2Type.end()){
        return true;
    }

    if(g_token2Type.find(name) != g_token2Type.end()){
        return true;
    }
    return false;
}


void set_token(string name, tc_type type){
    // insert to the most inner codeblock
    if (local_token2Type.size() > 0){
        local_token2Type.back()->insert({name, type});
        return;
    }

    g_token2Type[name] = type;
}


tc_type get_token_type(string name){
    // find from the most inner codeblock
    for(auto it = local_token2Type.rbegin(); it != local_token2Type.rend(); it++){
        if((*it)->find(name) != (*it)->end()){
            return (*it)->at(name);
        }
    }
    if(funcparam_token2Type.find(name) != funcparam_token2Type.end()){
        return funcparam_token2Type[name];
    }
    if(g_token2Type.find(name) != g_token2Type.end()){
        return g_token2Type[name];
    }
    return nullptr;
}


string& get_varDecl_id(aA_varDecl vd){
    if(vd->kind == A_varDeclType::A_varDeclScalarKind)
        return *vd->u.declScalar->id;
    else if(vd->kind == A_varDeclType::A_varDeclArrayKind)
        return *vd->u.declArray->id;
    return *(new string(""));
}


bool comp_aA_type(aA_type target, aA_type t){
    if(!target || !t)
        return false;
    if(target->type != t->type)
        return false;
    if(target->type == A_dataType::A_nativeTypeKind)
        if(target->u.nativeType != t->u.nativeType)
            return false;
    if(target->type == A_dataType::A_structTypeKind)
        if(target->u.structType != t->u.structType)
            return false;
    return true;
}


bool comp_tc_type(tc_type target, tc_type t){
    if(!target || !t)
        return false;
    
    // arr kind first
    if (target->isVarArrFunc & t->isVarArrFunc == 0)
        return false;
    
    // if target type is nullptr, alwayse ok
    return comp_aA_type(target->type, t->type);
}


tc_type check_LeftRightVal(std::ostream& out, tc_type left_type, aA_rightVal val){
    tc_type right_type = nullptr;
    switch (val->kind)
    {
    case A_rightValType::A_arithExprValKind:
        right_type = check_ArithExpr(out, val->u.arithExpr);
        break;
    case A_rightValType::A_boolExprValKind:
        error_print(out, val->pos, "The expression of right value doesn't match the given left type!");
        break;
    default:
        break;
    }
    if(left_type->type && !comp_tc_type(left_type, right_type)){
        error_print(out, val->pos, "The expression of right value doesn't match the given left type!");
    }
    return right_type;
}


tc_type tc_Type(aA_type t, uint isVarArrFunc){
    tc_type ret = new tc_type_;
    ret->type = t;
    ret->isVarArrFunc = isVarArrFunc;
    return ret;
}


tc_type tc_Type(aA_varDecl vd){
    if(vd->kind == A_varDeclType::A_varDeclScalarKind)
        return tc_Type(vd->u.declScalar->type, 0);
    else if(vd->kind == A_varDeclType::A_varDeclArrayKind)
        return tc_Type(vd->u.declArray->type, 1);
    return nullptr;
}


// public functions
void check_Prog(std::ostream& out, aA_program p)
{
    for (auto ele : p->programElements)
    {
        if(ele->kind == A_programVarDeclStmtKind){
            check_VarDecl(out, ele->u.varDeclStmt);
        }else if (ele->kind == A_programStructDefKind){
            check_StructDef(out, ele->u.structDef);
        }
    }
    
    for (auto ele : p->programElements){
        if(ele->kind == A_programFnDeclStmtKind){
            check_FnDeclStmt(out, ele->u.fnDeclStmt);
        }
        else if (ele->kind == A_programFnDefKind){
            check_FnDecl(out, ele->u.fnDef->fnDecl);
        }
    }

    for (auto ele : p->programElements){
        if(ele->kind == A_programFnDefKind){
            check_FnDef(out, ele->u.fnDef);
        }
        else if (ele->kind == A_programNullStmtKind){
            // do nothing
        }
    }

    out << "Typecheck passed!" << std::endl;
    return;
}


void check_VarDecl(std::ostream& out, aA_varDeclStmt vd)
{
    if (!vd)
        return;
    string name;
    if (vd->kind == A_varDeclStmtType::A_varDeclKind){
        // decl only
        aA_varDecl vdecl = vd->u.varDecl;
        if(vdecl->kind == A_varDeclType::A_varDeclScalarKind){
            name = *vdecl->u.declScalar->id;
            if (find_token(name))
                error_print(out, vdecl->pos, "This id is already defined!");
            // TODO：allow omit type
            set_token(name, tc_Type(vdecl->u.declScalar->type, 0));
        }else if (vdecl->kind == A_varDeclType::A_varDeclArrayKind){
            name = *vdecl->u.declArray->id;
            if (find_token(name))
                error_print(out, vdecl->pos, "This id is already defined!");
            // TODO：allow omit type
            set_token(name, tc_Type(vdecl->u.declArray->type, 1));
        }
    }
    else if (vd->kind == A_varDeclStmtType::A_varDefKind){
        // decl and def
        aA_varDef vdef = vd->u.varDef;
        if (vdef->kind == A_varDefType::A_varDefScalarKind){
            name = *vdef->u.defScalar->id;
            if (find_token(name))
                error_print(out, vdef->pos, "This id is already defined!");
            // TODO：allow omit type
            tc_type target_type = tc_Type(vdef->u.defScalar->type, 0);
            tc_type deduced_type = check_LeftRightVal(out, target_type, vdef->u.defScalar->val);
            if (target_type->type == nullptr)
                target_type->type = deduced_type->type;
            set_token(name, target_type);
        }else if (vdef->kind == A_varDefType::A_varDefArrayKind){
            name = *vdef->u.defArray->id;
            if (find_token(name))
                error_print(out, vdef->pos, "This id is already defined!");
            // TODO：allow omit type
            if (vdef->u.defArray->vals.size() > 0){
                tc_type target_type = tc_Type(vdef->u.defArray->type, 0);
                tc_type deduced_type = check_LeftRightVal(out, target_type, vdef->u.defArray->vals[0]);
                if (target_type->type == nullptr)
                    target_type->type = deduced_type->type;
                for(aA_rightVal rv : vdef->u.defArray->vals){
                    check_LeftRightVal(out, target_type, rv);
                }
                target_type->isVarArrFunc = 1;
                set_token(name, target_type);
            }
        }
    }
    return;
}


void check_StructDef(std::ostream& out, aA_structDef sd)
{
    if (!sd)
        return;
    string name = *sd->id;
    if (struct2Members.find(name) != struct2Members.end())
        error_print(out, sd->pos, "This id is already defined!");
    struct2Members[name] = &(sd->varDecls);
    return;
}


void check_FnDecl(std::ostream& out, aA_fnDecl fd)
{
    if (!fd)
        return;
    string name = *fd->id;

    // if already declared, should match
    if (func2Param.find(name) != func2Param.end()){
        // is function ret val matches
        if(!comp_aA_type(get_token_type(name)->type, fd->type))
            error_print(out, fd->pos, "The function return type doesn't match the declaration!");
        // is function params matches decl
        if(func2Param[name]->size() != fd->paramDecl->varDecls.size())
            error_print(out, fd->pos, "The function param list doesn't match the declaration!");
        for (int i = 0; i<func2Param[name]->size(); i++){
            if(!comp_aA_type(func2Param[name]->at(i)->u.declScalar->type, fd->paramDecl->varDecls[i]->u.declScalar->type))
                error_print(out, fd->pos, "The function param type doesn't match the declaration!");
        }
    }else{
        // if not defined as a function
        // if defined as a variable
        if(find_token(name))
            error_print(out, fd->pos, "This id is already defined as a variable!");
        else{
            // else, record this
            set_token(name, tc_Type(fd->type, 2));
            func2Param[name] = &fd->paramDecl->varDecls;
            // func param list should not duplicate
            for (int i = 0; i<fd->paramDecl->varDecls.size(); i++){
                for (int j = i+1; j<fd->paramDecl->varDecls.size(); j++){
                    if(get_varDecl_id(fd->paramDecl->varDecls[i]).compare(get_varDecl_id(fd->paramDecl->varDecls[j])) == 0)
                        error_print(out, fd->pos, "The function parameter list should not duplicate!");
                }
            }    
        }
        
    }
    return;
}


void check_FnDeclStmt(std::ostream& out, aA_fnDeclStmt fd)
{
    if (!fd)
        return;
    check_FnDecl(out, fd->fnDecl);
    return;
}


void check_FnDef(std::ostream& out, aA_fnDef fd)
{
    if (!fd)
        return;
    // should match if declared
    check_FnDecl(out, fd->fnDecl);
    // add params to local tokenmap
    for (aA_varDecl vd : fd->fnDecl->paramDecl->varDecls)
    {
        if(vd->kind == A_varDeclType::A_varDeclScalarKind)
            funcparam_token2Type[*vd->u.declScalar->id] = tc_Type(vd->u.declScalar->type, 0);
        else if(vd->kind == A_varDeclType::A_varDeclArrayKind)
            funcparam_token2Type[*vd->u.declArray->id] = tc_Type(vd->u.declArray->type, 1);
    }

    local_token2Type.push_back(new typeMap());
    for (aA_codeBlockStmt stmt : fd->stmts)
    {
        check_CodeblockStmt(out, stmt);
        // return value type should match
        if(stmt->kind == A_codeBlockStmtType::A_returnStmtKind)
            check_LeftRightVal(out, tc_Type(fd->fnDecl->type, 0), stmt->u.returnStmt->retVal);
        // else if (stmt->kind == A_codeBlockStmtType::A_varDeclStmtKind)
        //     local_vars.push_back(*stmt->u.varDeclStmt->u.varDecl->u.declArray->id);
    }
    local_token2Type.pop_back();

    // erase local vars defined in this function
    funcparam_token2Type.clear();
    return;
}


void check_CodeblockStmt(std::ostream& out, aA_codeBlockStmt cs){
    if(!cs)
        return;
    // variables declared in a code block should not duplicate with outer ones.
    switch (cs->kind)
    {
    case A_codeBlockStmtType::A_varDeclStmtKind:
        check_VarDecl(out, cs->u.varDeclStmt);
        break;
    case A_codeBlockStmtType::A_assignStmtKind:
        check_AssignStmt(out, cs->u.assignStmt);
        break;
    case A_codeBlockStmtType::A_ifStmtKind:
        check_IfStmt(out, cs->u.ifStmt);
        break;
    case A_codeBlockStmtType::A_whileStmtKind:
        check_WhileStmt(out, cs->u.whileStmt);
        break;
    case A_codeBlockStmtType::A_callStmtKind:
        check_CallStmt(out, cs->u.callStmt);
        break;
    case A_codeBlockStmtType::A_returnStmtKind:
        check_ReturnStmt(out, cs->u.returnStmt);
        break;
    default:
        break;
    }
    return;
}


void check_AssignStmt(std::ostream& out, aA_assignStmt as){
    if(!as)
        return;
    string name;
    tc_type deduced_type;
    switch (as->leftVal->kind)
    {
        case A_leftValType::A_varValKind:{
            name = *as->leftVal->u.id;
            if(!find_token(name))
                error_print(out, as->pos, "Variable is not defined!");
            tc_type orig_type = get_token_type(name);
            if (orig_type->isVarArrFunc > 1){
                error_print(out, as->pos, "This id is not a scalar!");
            }
            deduced_type = check_LeftRightVal(out, orig_type, as->rightVal);
            if (orig_type->type == nullptr){
                orig_type->type = deduced_type->type;
            }
        }
            break;
        case A_leftValType::A_arrValKind:{
            name = *as->leftVal->u.arrExpr->arr->u.id;
            check_ArrayExpr(out, as->leftVal->u.arrExpr);
            tc_type arr_type = get_token_type(name);
            deduced_type = check_LeftRightVal(out, arr_type, as->rightVal);
            if (arr_type == nullptr){
                arr_type->type = deduced_type->type;
            }
        }
            break;
        case A_leftValType::A_memberValKind:{
            // id should be defined
            tc_type type = check_MemberExpr(out, as->leftVal->u.memberExpr);
            // assign should be the same type
            check_LeftRightVal(out, type, as->rightVal);
        }
            break;
    }
    return;
}


void check_ArrayExpr(std::ostream& out, aA_arrayExpr ae){
    if(!ae)
        return;
    string name = *ae->arr->u.id;
    // check array name
    if(!find_token(name))
        error_print(out, ae->pos, "Array name is not defined!");
    tc_type arr_type = get_token_type(name);
    if(arr_type->isVarArrFunc != 1)
        error_print(out, ae->pos, "This id is not an array!");
    // check index
    if(ae->idx->kind == A_indexExprKind::A_idIndexKind){
        // if index is id, should be int
        string idx_name = *ae->idx->u.id;
        if(!find_token(idx_name))
            error_print(out, ae->pos, "The arrat index id is not defined!");
        tc_type idx_type = get_token_type(idx_name);
        if( idx_type->isVarArrFunc > 0 ||
            idx_type->type->type != A_dataType::A_nativeTypeKind || 
            idx_type->type->u.nativeType != A_nativeType::A_intTypeKind)
            error_print(out, ae->pos, "This array index is not an int!");
    }else if (ae->idx->kind == A_indexExprKind::A_numIndexKind){
        // in index is num, should be >= 0
        // if(ae->idx->u.num < 0)
        //     error_print(out, ae->pos, "Array index should be a positive int!");
    }
    return;
}

 
tc_type check_MemberExpr(std::ostream& out, aA_memberExpr me){
    // check if the member exists and return the tyep of the member
    if(!me)
        return nullptr;
    string name = *me->structId->u.id;
    // check struct name
    if(!find_token(name))
        error_print(out, me->pos, "This id is not defined!");
    tc_type id_type = get_token_type(name);
    if(id_type->isVarArrFunc != 0 || id_type->type->type != A_dataType::A_structTypeKind)
        error_print(out, me->pos, "This id is not a struct!");
    string struct_type = *id_type->type->u.structType;
    string member_name = *me->memberId;
    if(struct2Members.find(struct_type) == struct2Members.end())
        error_print(out, me->pos, "This struct is not defined!");
    vector<aA_varDecl>* members = struct2Members[struct_type];
    // check member name
    for(auto it = members->begin(); it != members->end(); it++){
        if((*it)->u.declScalar->id->compare(member_name) == 0){
            if ((*it)->kind == A_varDeclType::A_varDeclScalarKind)
            {
                return tc_Type((*it)->u.declScalar->type, 0);
            }
            else if ((*it)->kind == A_varDeclType::A_varDeclArrayKind)
            {
                return tc_Type((*it)->u.declArray->type, 1);
            }
        }
    }
    error_print(out, me->pos, "This member is not defined!");
    return nullptr;
}


void check_IfStmt(std::ostream& out, aA_ifStmt is){
    if(!is)
        return;
    check_BoolExpr(out, is->boolExpr);
    local_token2Type.push_back(new typeMap());
    for(aA_codeBlockStmt s : is->ifStmts){
        check_CodeblockStmt(out, s);
    }
    local_token2Type.pop_back();

    local_token2Type.push_back(new typeMap());
    for(aA_codeBlockStmt s : is->elseStmts){
        check_CodeblockStmt(out, s);
    }
    local_token2Type.pop_back();
    return;
}


void check_BoolExpr(std::ostream& out, aA_boolExpr be){
    if(!be)
        return;
    switch (be->kind)
    {
    case A_boolExprType::A_boolBiOpExprKind:
        check_BoolExpr(out, be->u.boolBiOpExpr->left);
        check_BoolExpr(out, be->u.boolBiOpExpr->right);
        break;
    case A_boolExprType::A_boolUnitKind:
        check_BoolUnit(out, be->u.boolUnit);
        break;
    default:
        break;
    }
    return;
}


void check_BoolUnit(std::ostream& out, aA_boolUnit bu){
    if(!bu)
        return;
    switch (bu->kind)
    {
        case A_boolUnitType::A_comOpExprKind:{
            tc_type leftTyep = check_ExprUnit(out, bu->u.comExpr->left);
            tc_type rightTyep = check_ExprUnit(out, bu->u.comExpr->right);
            if(leftTyep->type->type != A_dataType::A_nativeTypeKind || rightTyep->type->type != A_dataType::A_nativeTypeKind)
                error_print(out, bu->pos, "None native type are not comparable!");
            comp_aA_type(leftTyep->type, rightTyep->type);
        }
            break;
        case A_boolUnitType::A_boolExprKind:
            check_BoolExpr(out, bu->u.boolExpr);
            break;
        case A_boolUnitType::A_boolUOpExprKind:
            check_BoolUnit(out, bu->u.boolUOpExpr->cond);
            break;
        default:
            break;
    }
    return;
}


tc_type check_ExprUnit(std::ostream& out, aA_exprUnit eu){
    // return the aA_type of expr eu
    if(!eu)
        return nullptr;
    tc_type ret;
    switch (eu->kind)
    {
        case A_exprUnitType::A_idExprKind:{
            string name = *eu->u.id;
            if(!find_token(name))
                error_print(out, eu->pos, "This id is not defined!");
            tc_type type = get_token_type(name);
            if (type->isVarArrFunc > 0)
                error_print(out, eu->pos, "This id is a function or array!");
            ret = type;
        }
            break;
        case A_exprUnitType::A_numExprKind:{
            aA_type numt = new aA_type_;
            numt->pos = eu->pos;
            numt->type = A_dataType::A_nativeTypeKind;
            numt->u.nativeType = A_nativeType::A_intTypeKind;
            ret = tc_Type(numt, 0);
        }
            break;
        case A_exprUnitType::A_fnCallKind:{
            check_FuncCall(out, eu->u.callExpr);
            // check_FuncCall will check if the function is defined
            ret = get_token_type(*eu->u.callExpr->fn);
        }
            break;
        case A_exprUnitType::A_arrayExprKind:{
            check_ArrayExpr(out, eu->u.arrayExpr);
            ret = get_token_type(*eu->u.arrayExpr->arr->u.id);
        }
            break;
        case A_exprUnitType::A_memberExprKind:{
            ret = check_MemberExpr(out, eu->u.memberExpr);
        }
            break;
        case A_exprUnitType::A_arithExprKind:{
            ret = check_ArithExpr(out, eu->u.arithExpr);
        }
            break;
        case A_exprUnitType::A_arithUExprKind:{
            ret = check_ExprUnit(out, eu->u.arithUExpr->expr);
        }
            break;
    }
    return ret;
}


tc_type check_ArithExpr(std::ostream& out, aA_arithExpr ae){
    if(!ae)
        return nullptr;
    tc_type ret;
    switch (ae->kind)
    {
        case A_arithExprType::A_arithBiOpExprKind:{
            ret = check_ArithExpr(out, ae->u.arithBiOpExpr->left);
            tc_type rightTyep = check_ArithExpr(out, ae->u.arithBiOpExpr->right);
            if(ret->type->type > 0 || ret->type->type != A_dataType::A_nativeTypeKind || ret->type->u.nativeType != A_nativeType::A_intTypeKind ||
            rightTyep->type->type > 0 || rightTyep->type->type != A_dataType::A_nativeTypeKind || rightTyep->type->u.nativeType != A_nativeType::A_intTypeKind)
                error_print(out, ae->pos, "Only int can be arithmetic expression operation values!");
        }
            break;
        case A_arithExprType::A_exprUnitKind:
            ret = check_ExprUnit(out, ae->u.exprUnit);
            break;
    }
    return ret;
}


void check_FuncCall(std::ostream& out, aA_fnCall fc){
    if(!fc)
        return;
    // function defined
    string func_name = *fc->fn;
    if (func2Param.find(func_name) == func2Param.end())
        error_print(out, fc->pos, "Function not defined!");

    // parameter list matches
    if (func2Param[func_name]->size() != fc->vals.size())
        error_print(out, fc->pos, "The number of arguments doesn't match!");
    for(int i = 0; i < fc->vals.size(); i++){
        if(func2Param[func_name]->at(i)->kind == A_varDeclType::A_varDeclScalarKind)
            check_LeftRightVal(out, tc_Type(func2Param[func_name]->at(i)), fc->vals[i]);
        else if(func2Param[func_name]->at(i)->kind == A_varDeclType::A_varDeclArrayKind)
            check_LeftRightVal(out, tc_Type(func2Param[func_name]->at(i)), fc->vals[i]);
    }
    return ;
}


void check_WhileStmt(std::ostream& out, aA_whileStmt ws){
    if(!ws)
        return;
    check_BoolExpr(out, ws->boolExpr);
    local_token2Type.push_back(new typeMap());
    for(aA_codeBlockStmt s : ws->whileStmts){
        check_CodeblockStmt(out, s);
    }
    local_token2Type.pop_back();
    return;
}


void check_CallStmt(std::ostream& out, aA_callStmt cs){
    if(!cs)
        return;
    check_FuncCall(out, cs->fnCall);
    return;
}


void check_ReturnStmt(std::ostream& out, aA_returnStmt rs){
    if(!rs)
        return;
    return;
}

