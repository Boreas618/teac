#include "TeaplAst.h"
#include "TeaplaAst.h"

aA_pos aA_Pos(A_pos pos){
    aA_pos p = (aA_pos)malloc(sizeof(*p));
    p->line = pos->line;
    p->col = pos->col;
    return p;
}

aA_type aA_Type(A_type type){
    aA_type p = (aA_type)malloc(sizeof(*p));
    p->pos = aA_Pos(type->pos);
    p->type = type->type;
    switch(type->type){
    case A_nullTypeKind:
    case A_nativeTypeKind:{
        p->u.nativeType = type->u.nativeType;
        break;
    }
    case A_structTypeKind:{
        p->u.structType = new string(type->u.structType);
        break;
    }
    }
    return p;
}

aA_fnCall aA_FnCall(A_fnCall fnCall){
    aA_fnCall p = (aA_fnCall)malloc(sizeof(*p));
    p->fn= new string(fnCall->fn);
    for(A_rightValList l=fnCall->vals; l; l=l->tail){
        p->vals.emplace_back(l->head);
    }
    return p;
}

aA_indexExpr aA_IndexExpr(A_indexExpr indexExpr){
    aA_indexExpr p = (aA_indexExpr)malloc(sizeof(*p));
    p->kind= indexExpr->kind;
    switch(indexExpr->kind){
    case A_numIndexKind:{
        p->u.num = indexExpr->u.num;
        break;
    }
    case A_idIndexKind:{
        p->u.id = new string(indexExpr->u.id);
        break;
    }
    }
    return p;
}

aA_arrayExpr aA_ArrayExpr(A_arrayExpr arrayExpr){
    aA_arrayExpr p = (aA_arrayExpr)malloc(sizeof(*p));
    p->arr= new string(arrayExpr->arr);
    p->idx = aA_IndexExpr(arrayExpr->idx);
    return p;
}

aA_memberExpr aA_MemberExpr(A_memberExpr memberExpr){
    aA_memberExpr p = (aA_memberExpr)malloc(sizeof(*p));
    p->structId= new string(memberExpr->structId);
    p->memberId = new string(memberExpr->memberId);
    return p;
}

aA_exprUnit aA_ExprUnit(A_exprUnit exprUnit){
    aA_exprUnit p = (aA_exprUnit)malloc(sizeof(*p));
    p->kind= exprUnit->kind;
    switch(exprUnit->kind){
    case A_numExprKind:{
        p->u.num = exprUnit->u.num;
        break;
    }
    case A_idExprKind:{
        p->u.id = new string(exprUnit->u.id);
        break;
    }
    case A_arithExprKind:{
        p->u.arithExpr = new string(indexExpr->u.id);
        break;
    }
    case A_fnCallKind:{
        p->u.callExpr = aA_FnCall(exprUnit->u.callExpr);
        break;
    }
    case A_arrayExprKind:{
        p->u.arrayExpr = aA_ArrayExpr(exprUnit->u.arrayExpr);
        break;
    }
    case A_memberExprKind:{
        p->u.memberExpr = aA_MemberExpr(exprUnit->u.memberExpr);
        break;
    }
    case A_arithUExprKind:{
        p->u.id = new string(indexExpr->u.id);
        break;
    }
    }
    return p;
}

aA_arithBiOpExpr aA_ArithBiOpExpr(A_arithBiOpExpr arithBiOpExpr){
    aA_arithBiOpExpr p = (aA_arithBiOpExpr)malloc(sizeof(*p));
    p->op= arithBiOpExpr->op;
    p->left = arithBiOpExpr->left;
    p->right = arithBiOpExpr->right;
    return p;
}

aA_arithUExpr aA_ArithUExpr(A_arithUExpr arithUExpr){
    aA_arithUExpr p = (aA_arithUExpr)malloc(sizeof(*p));
    p->op= arithUExpr->op;
    p->expr = aA_ExprUnit(arithUExpr->expr);
    return p;
}

aA_arithExpr aA_ArithExpr(A_arithExpr arithExpr){
    aA_arithExpr p = (aA_arithExpr)malloc(sizeof(*p));
    p->kind= arithExpr->kind;
    switch(arithExpr->kind){
    case A_arithBiOpExprKind:{
        p->u.arithBiOpExpr = aA_ArithBiOpExpr(arithExpr->u.arithBiOpExpr);
        break;
    }
    case A_exprUnitKind:{
        p->u.exprUnit = aA_ExprUnit(arithExpr->u.exprUnit);
        break;
    }
    }
    return p;
}

aA_logicBiOpExpr aA_LogicBiOpExpr(A_logicBiOpExpr logicBiOpExpr){
    aA_logicBiOpExpr p = (aA_logicBiOpExpr)malloc(sizeof(*p));
    p->op= logicBiOpExpr->op;
    p->left = logicBiOpExpr->left;
    p->right = logicBiOpExpr->right;
    return p;
}

aA_logicUOpExpr aA_LogicUOpExpr(A_logicUOpExpr logicUOpExpr){
    aA_logicUOpExpr p = (aA_logicUOpExpr)malloc(sizeof(*p));
    p->op= logicUOpExpr->op;
    p->cond = logicUOpExpr->cond;
    return p;
}

aA_condExpr aA_CondExpr(A_condExpr condExpr){
    aA_condExpr p = (aA_condExpr)malloc(sizeof(*p));
    p->kind= condExpr->kind;
    switch(condExpr->kind){
    case A_logicBiOpExprKind:{
        p->u.logicBiOpExpr = aA_LogicBiOpExpr(condExpr->u.logicBiOpExpr);
        break;
    }
    case A_condUnitKind:{
        p->u.condUnit = aA_CondUnit(condExpr->u.condUnit);
        break;
    }
    }
    return p;
}

aA_comExpr aA_ComExpr(A_comExpr comExpr){
    aA_comExpr p = (aA_comExpr)malloc(sizeof(*p));
    p->pos= aA_Pos(comExpr->pos);
    p->op = comExpr->op;
    p->left = aA_ExprUnit(comExpr->left);
    p->right = aA_ExprUnit(comExpr->right);
    return p;
}

aA_condUnit aA_CondUnit(A_condUnit condUnit){
    aA_condUnit p = (aA_condUnit)malloc(sizeof(*p));
    p->kind= condUnit->kind;
    switch(condUnit->kind){
    case A_comOpExprKind:{
        p->u.comExpr = aA_ComExpr(condUnit->u.comExpr);
        break;
    }
    case A_condExprKind:{
        p->u.condExpr = aA_CondExpr(condUnit->u.condExpr);
        break;
    }
    case A_logicUOpExprKind:{
        p->u.logicUOpExpr = aA_LogicUOpExpr(condUnit->u.logicUOpExpr);
        break;
    }
    }
    return p;
}

aA_rightVal aA_ArithExprRVal(aA_pos pos, aA_arithExpr arithExpr){
    aA_rightVal p = (aA_rightVal)malloc(sizeof(*p));
    p->pos = pos;
    p->kind= aA_arithExprValKind;
    p->u.arithExpr = arithExpr;
    return p;
}

aA_rightVal aA_CondExprRVal(aA_pos pos, aA_condExpr condExpr){
    aA_rightVal p = (aA_rightVal)malloc(sizeof(*p));
    p->pos = pos;
    p->kind= aA_condExprValKind;
    p->u.condExpr = condExpr;
    return p;
}

aA_leftVal aA_IdExprLVal(aA_pos pos, char* id){
    aA_leftVal p = (aA_leftVal)malloc(sizeof(*p));
    p->pos = pos;
    p->kind= aA_varValKind;
    p->u.id = id;
    return p;
}

aA_leftVal aA_ArrExprLVal(aA_pos pos, aA_arrayExpr arrExpr){
    aA_leftVal p = (aA_leftVal)malloc(sizeof(*p));
    p->pos = pos;
    p->kind= aA_arrValKind;
    p->u.arrExpr = arrExpr;
    return p;
}

aA_leftVal aA_MemberExprLVal(aA_pos pos, aA_memberExpr memberExpr){
    aA_leftVal p = (aA_leftVal)malloc(sizeof(*p));
    p->pos = pos;
    p->kind= aA_memberValKind;
    p->u.memberExpr = memberExpr;
    return p;
}

aA_assignStmt aA_AssignStmt(aA_pos pos, aA_leftVal leftVal, aA_rightVal rightVal){
    aA_assignStmt p = (aA_assignStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->leftVal= leftVal;
    p->rightVal = rightVal;
    return p;
}

aA_varDeclScalar aA_VarDeclScalar(aA_pos pos, char* id, aA_type type){
    aA_varDeclScalar p = (aA_varDeclScalar)malloc(sizeof(*p));
    p->pos = pos;
    p->id= id;
    p->type = type;
    return p;
}

aA_varDeclArray aA_VarDeclArray(aA_pos pos, char* id, int len, aA_type type){
    aA_varDeclArray p = (aA_varDeclArray)malloc(sizeof(*p));
    p->pos = pos;
    p->id= id;
    p->len = len;
    p->type = type;
    return p;
}

aA_varDecl aA_VarDeclScalar(aA_pos pos, aA_varDeclScalar declScalar){
    aA_varDecl p = (aA_varDecl)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_varDeclScalarKind;
    p->u.declScalar = declScalar;
    return p;
}

aA_varDecl aA_VarDeclArray(aA_pos pos, aA_varDeclArray declArray){
    aA_varDecl p = (aA_varDecl)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_varDeclArrayKind;
    p->u.declArray = declArray;
    return p;
}

aA_varDefScalar aA_VarDefScalar(aA_pos pos, char* id, aA_type type, aA_rightVal val){
    aA_varDefScalar p = (aA_varDefScalar)malloc(sizeof(*p));
    p->pos = pos;
    p->id= id;
    p->type = type;
    p->val = val;
    return p;
}

aA_varDefArray aA_VarDefArray(aA_pos pos, char* id, int len, aA_type type, aA_rightValList vals){
    aA_varDefArray p = (aA_varDefArray)malloc(sizeof(*p));
    p->pos = pos;
    p->id= id;
    p->len = len;
    p->type = type;
    p->vals = vals;
    return p;
}

aA_varDef aA_VarDefScalar(aA_pos pos, aA_varDefScalar defScalar){
    aA_varDef p = (aA_varDef)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_varDefScalarKind;
    p->u.defScalar = defScalar;
    return p;
}

aA_varDef aA_VarDefArray(aA_pos pos, aA_varDefArray defArray){
    aA_varDef p = (aA_varDef)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_varDefArrayKind;
    p->u.defArray = defArray;
    return p;
}

aA_varDeclStmt aA_VarDecl(aA_varDecl varDecl){
    aA_varDeclStmt p = (aA_varDeclStmt)malloc(sizeof(*p));
    p->kind = aA_varDeclKind;
    p->u.varDecl = varDecl;
    return p;

}

aA_varDeclStmt aA_VarDef(aA_varDef varDef){
    aA_varDeclStmt p = (aA_varDeclStmt)malloc(sizeof(*p));
    p->kind = aA_varDefKind;
    p->u.varDef = varDef;
    return p;
}

aA_varDeclList aA_VarDeclList(aA_varDecl head, aA_varDeclList tail){
    aA_varDeclList p = (aA_varDeclList)malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

aA_structDef aA_StructDef(char* id, aA_varDeclList varDecls){
    aA_structDef p = (aA_structDef)malloc(sizeof(*p));
    p->id = id;
    p->varDecls = varDecls;
    return p;
}

aA_fnDecl aA_FnDecl(char* id, aA_paramDecl paramDecl, aA_type type){
    aA_fnDecl p = (aA_fnDecl)malloc(sizeof(*p));
    p->id = id;
    p->paramDecl = paramDecl;
    p->type = type;
    return p;
}

aA_paramDecl aA_ParamDecl(aA_varDeclList varDecls){
    aA_paramDecl p = (aA_paramDecl)malloc(sizeof(*p));
    p->varDecls = varDecls;
    return p;
}

aA_fnDef aA_FnDef(aA_fnDecl fnDecl, aA_codeBlockStmtList stmts){
    aA_fnDef p = (aA_fnDef)malloc(sizeof(*p));
    p->fnDecl = fnDecl;
    p->stmts = stmts;
    return p;
}

aA_ifStmt aA_IfStmt(aA_condExpr condExpr, aA_codeBlockStmtList ifStmts, aA_codeBlockStmtList elseStmts){
    aA_ifStmt p = (aA_ifStmt)malloc(sizeof(*p));
    p->condExpr = condExpr;
    p->ifStmts = ifStmts;
    p->elseStmts = elseStmts;
    return p;
}

aA_whileStmt aA_WhileStmt(aA_condExpr condExpr, aA_codeBlockStmtList whileStmts){
    aA_whileStmt p = (aA_whileStmt)malloc(sizeof(*p));
    p->condExpr = condExpr;
    p->whileStmts = whileStmts;
    return p;
}

aA_codeBlockStmt aA_VarDeclStmt(aA_pos pos, aA_varDeclStmt varDeclStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.varDeclStmt = varDeclStmt;
    return p;
}

aA_codeBlockStmt aA_AssignStmt(aA_pos pos, aA_assignStmt assignStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.assignStmt = assignStmt;
    return p;
}

aA_codeBlockStmt aA_FnCall(aA_pos pos, aA_callStmt callStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.callStmt = callStmt;
    return p;
}

aA_codeBlockStmt aA_IfStmt(aA_pos pos, aA_ifStmt ifStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.ifStmt = ifStmt;
    return p;
}

aA_codeBlockStmt aA_WhileStmt(aA_pos pos, aA_whileStmt whileStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.whileStmt = whileStmt;
    return p;
}

aA_codeBlockStmt aA_ReturnStmt(aA_pos pos, aA_returnStmt returnStmt){
    aA_codeBlockStmt p = (aA_codeBlockStmt)malloc(sizeof(*p));
    p->pos = pos;
    p->u.returnStmt = returnStmt;
    return p;
}

aA_programElement aA_ProgramVarDeclStmt(aA_pos pos, aA_varDeclStmt varDeclStmt){
    aA_programElement p = (aA_programElement)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_programVarDeclStmtKind;
    p->u.varDeclStmt = varDeclStmt;
    return p;
}

aA_programElement aA_ProgramStructDef(aA_pos pos, aA_structDef structDef){
    aA_programElement p = (aA_programElement)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_programStructDefKind;
    p->u.structDef = structDef;
    return p;
}

aA_programElement aA_ProgramFnDeclStmt(aA_pos pos, aA_fnDeclStmt fnDecl){
    aA_programElement p = (aA_programElement)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_programFnDeclStmtKind;
    p->u.fnDecl = fnDecl;
    return p;
}

aA_programElement aA_ProgramFnDef(aA_pos pos, aA_fnDef fnDef){
    aA_programElement p = (aA_programElement)malloc(sizeof(*p));
    p->pos = pos;
    p->kind = aA_programFnDefKind;
    p->u.fnDef = fnDef;
    return p;
}