#pragma once

#include "TeaplAst.h"
#include <string>
#include <vector>

using std::string;
using std::vector;

typedef struct aA_pos_* aA_pos; //position information
typedef struct aA_type_* aA_type;
typedef struct aA_varDecl_* aA_varDecl;
typedef struct aA_varDef_* aA_varDef;
typedef struct aA_rightVal_* aA_rightVal;
typedef struct aA_arithExpr_* aA_arithExpr;
typedef struct aA_condExpr_* aA_condExpr;
typedef struct aA_arithBiOpExpr_* aA_arithBiOpExpr;
typedef struct aA_arithUExpr_* aA_arithUExpr;
typedef struct aA_exprUnit_* aA_exprUnit;
typedef struct aA_fnCall_* aA_fnCall;
typedef struct aA_indexExpr_* aA_indexExpr;
typedef struct aA_arrayExpr_* aA_arrayExpr;
typedef struct aA_memberExpr_* aA_memberExpr;
typedef struct aA_condUnit_* aA_condUnit;
typedef struct aA_logicBiOpExpr_* aA_logicBiOpExpr;
typedef struct aA_logicUOpExpr_* aA_logicUOpExpr;
typedef struct aA_comExpr_* aA_comExpr;
typedef struct aA_rightVal_* aA_rightVal;
typedef struct aA_leftVal_* aA_leftVal;
typedef struct aA_assignStmt_* aA_assignStmt;
typedef struct aA_varDefScalar_* aA_varDefScalar;
typedef struct aA_varDefArray_* aA_varDefArray;
typedef struct aA_varDeclScalar_* aA_varDeclScalar;
typedef struct aA_varDeclArray_* aA_varDeclArray;
typedef struct aA_varDecl_* aA_varDecl;
typedef struct aA_varDef_* aA_varDef;
typedef struct aA_varDeclStmt_* aA_varDeclStmt;
typedef struct aA_structDef_* aA_structDef;
typedef struct aA_paramDecl_* aA_paramDecl;
typedef struct aA_fnDecl_* aA_fnDecl;
typedef struct aA_fnDef_* aA_fnDef;
typedef struct aA_codeBlockStmt_* aA_codeBlockStmt;
typedef struct aA_ifStmt_* aA_ifStmt;
typedef struct aA_whileStmt_* aA_whileStmt;
typedef struct aA_fnDeclStmt_* aA_fnDeclStmt;
typedef struct aA_callStmt_* aA_callStmt;
typedef struct aA_returnStmt_* aA_returnStmt;
typedef struct aA_programElement_* aA_programElement;

struct aA_pos_ {
    int line, col;
};

struct aA_type_ {
    aA_pos pos;
    A_dataType type;
    union {
        A_nativeType nativeType;
        string* structType;
    } u;
};

struct aA_fnCall_ {
    string* fn;
    vector<aA_rightVal> vals;
};

struct aA_indexExpr_ {
    A_indexExprKind kind;
    union {
        int num;
        string* id;
    } u;
};

struct aA_arrayExpr_ {
    string* arr;
    aA_indexExpr idx;
};

struct aA_memberExpr_ {
    string* structId;
    string* memberId;
};

struct aA_exprUnit_ {
    A_exprUnitType kind;
    union {
        int num;
        string* id;
        aA_arithExpr arithExpr;
        aA_fnCall callExpr;
        aA_arrayExpr arrayExpr;
        aA_memberExpr memberExpr;
        aA_arithUExpr arithUExpr;
    } u;
};

struct aA_arithBiOpExpr_ {
    A_arithBiOp op;
    aA_arithExpr left, right;
};

struct aA_arithUExpr_ {
    A_arithUOp op;
    aA_exprUnit expr;
};

struct aA_arithExpr_ {
    A_arithExprType kind;
    union {
        aA_arithBiOpExpr arithBiOpExpr;
        aA_exprUnit exprUnit;
    } u;
};

struct aA_logicBiOpExpr_ {
    A_logicBiOp op;
    aA_condExpr left;
    aA_condUnit right;
};

struct aA_logicUOpExpr_ {
    A_logicUOp op;
    aA_condUnit cond;
};

struct aA_condExpr_ {
    A_condExprType kind;
    union {
        aA_logicBiOpExpr logicBiOpExpr;
        aA_condUnit condUnit;
    } u;
};

struct aA_comExpr_ {
    aA_pos pos;
    A_comOp op;
    aA_exprUnit left, right;
};

struct aA_condUnit_ {
    A_condUnitType kind;
    union {
        aA_comExpr comExpr;
        aA_condExpr condExpr;
        aA_logicUOpExpr logicUOpExpr;
    } u;
};

struct aA_rightVal_ {
    aA_pos pos;
    A_rightValType kind;
    union {
        aA_arithExpr arithExpr;
        aA_condExpr condExpr;
    } u;
};

struct aA_leftVal_ {
    aA_pos pos;
    A_leftValType kind;
    union {
        string* id;
        aA_arrayExpr arrExpr;
        aA_memberExpr memberExpr;
    } u;
};

struct aA_assignStmt_ {
    aA_pos pos;
    aA_leftVal leftVal;
    aA_rightVal rightVal;
};

struct aA_varDeclScalar_ {
    aA_pos pos;
    string* id;
    aA_type type;
};

struct aA_varDeclArray_ {
    aA_pos pos;
    string* id;
    int len;
    aA_type type;
};

struct aA_varDecl_ {
    aA_pos pos;
    A_varDeclType kind;
    union {
        aA_varDeclScalar declScalar;
        aA_varDeclArray declArray;
    } u;
};

struct aA_varDefScalar_ {
    aA_pos pos;
    string* id;
    aA_type type;
    aA_rightVal val;
};

struct aA_varDefArray_ {
    aA_pos pos;
    string* id;
    int len;
    aA_type type;
    vector<aA_rightVal> vals;
};

struct aA_varDef_ {
    aA_pos pos;
    A_varDefType kind;
    union {
        aA_varDefScalar defScalar;
        aA_varDefArray defArray;
    } u;
};

struct aA_varDeclStmt_ {
    A_varDeclStmtType kind;
    union {
        aA_varDecl varDecl;
        aA_varDef varDef;
    } u;
};

struct aA_structDef_ {
    string* id;
    vector<aA_varDecl> varDecls;
};

struct aA_fnDecl_ {
    string* id;
    aA_paramDecl paramDecl;
    aA_type type;
};

struct aA_paramDecl_ {
    vector<aA_varDecl> varDecls;
};

struct aA_fnDef_ {
    aA_fnDecl fnDecl;
    vector<aA_codeBlockStmt> stmts;
};

struct aA_ifStmt_ {
    aA_condExpr condExpr;
    vector<aA_codeBlockStmt> ifStmts, elseStmts;
};

struct aA_whileStmt_ {
    aA_condExpr condExpr;
    vector<aA_codeBlockStmt> whileStmts;
};

struct aA_callStmt_ {
    aA_fnCall fnCall;
};

struct aA_returnStmt_ {
    aA_rightVal retval;
};

struct aA_codeBlockStmt_ {
    aA_pos pos;
    A_codeBlockStmtType kind;
    union {
        aA_varDeclStmt varDeclStmt;
        aA_assignStmt assignStmt;
        aA_callStmt callStmt;
        aA_ifStmt ifStmt;
        aA_whileStmt whileStmt;
        aA_returnStmt returnStmt;
        // continue and break do not need other info
    } u;
};

struct aA_fnDeclStmt_ {
    aA_fnDecl fnDecl;
};

struct aA_programElement_ {
    aA_pos pos;
    A_programElementType kind;
    union {
        aA_varDeclStmt varDeclStmt;
        aA_structDef structDef;
        aA_fnDeclStmt fnDecl;
        aA_fnDef fnDef;
    } u;
};


aA_pos aA_Pos(int, int);
aA_pos aA_Pos(aA_pos);
aA_type aA_NullType(aA_pos pos);
aA_type aA_NativeType(aA_pos pos, A_nativeType ntype);
aA_type aA_StructType(aA_pos pos, string* stype);
aA_fnCall aA_FnCall(string* fn, A_rightValList vals);
aA_indexExpr aA_NumIndexExpr(int num);
aA_indexExpr aA_IdIndexExpr(string* id);
aA_arrayExpr aA_ArrayExpr(string* arr, aA_indexExpr idx);
aA_memberExpr aA_MemberExpr(string* structId, string* memberId);
aA_exprUnit aA_NumExprUnit(int num);
aA_exprUnit aA_IdExprUnit(string* id);
aA_exprUnit aA_ArithExprUnit(aA_arithExpr arithExpr);
aA_exprUnit aA_CallExprUnit(aA_fnCall callExpr);
aA_exprUnit aA_ArrayExprUnit(aA_arrayExpr arrayExpr);
aA_exprUnit aA_MemberExprUnit(aA_memberExpr memberExpr);
aA_exprUnit aA_ArithUExprUnit(aA_arithUExpr arithUExpr);
aA_arithBiOpExpr aA_ArithBiOpExpr(aA_arithBiOp op, aA_arithExpr left, aA_arithExpr right);
aA_arithUExpr aA_ArithUExpr(aA_arithUOp op, aA_exprUnit expr);
aA_arithExpr aA_ArithBiOpExpr(aA_arithBiOpExpr arithBiOpExpr);
aA_arithExpr aA_ExprUnit(aA_exprUnit exprUnit);
aA_logicBiOpExpr aA_LogicBiOpExpr(aA_logicBiOp op, aA_condExpr left, aA_condUnit right);
aA_logicUOpExpr aA_LogicUOpExpr(aA_logicUOp op, aA_condUnit cond);
aA_condExpr aA_LogicBiOpExpr(aA_logicBiOpExpr logicBiOpExpr);
aA_condExpr aA_CondExpr(aA_condUnit condUnit);
aA_comExpr aA_ComExpr(aA_pos pos, aA_comOp op, aA_exprUnit left, aA_exprUnit right);
aA_condUnit aA_ComExprUnit(aA_comExpr comExpr);
aA_condUnit aA_CondExprUnit(aA_condExpr condExpr);
aA_condUnit aA_LogicUOpExprUnit(aA_logicUOpExpr logicUOpExpr);
aA_rightVal aA_ArithExprRVal(aA_pos pos, aA_arithExpr arithExpr);
aA_rightVal aA_CondExprRVal(aA_pos pos, aA_condExpr condExpr);
aA_leftVal aA_IdExprLVal(aA_pos pos, string* id);
aA_leftVal aA_ArrExprLVal(aA_pos pos, aA_arrayExpr arrExpr);
aA_leftVal aA_MemberExprLVal(aA_pos pos, aA_memberExpr memberExpr);
aA_assignStmt aA_AssignStmt(aA_pos pos, aA_leftVal leftVal, aA_rightVal rightVal);
aA_varDeclScalar aA_VarDeclScalar(aA_pos pos, string* id, aA_type type);
aA_varDeclArray aA_VarDeclArray(aA_pos pos, string* id, int len, aA_type type);
aA_varDecl aA_VarDeclScalar(aA_pos pos, aA_varDeclScalar declScalar);
aA_varDecl aA_VarDeclArray(aA_pos pos, aA_varDeclArray declArray);
aA_varDefScalar aA_VarDefScalar(aA_pos pos, string* id, aA_type type, aA_rightVal val);
aA_varDefArray aA_VarDefArray(aA_pos pos, string* id, int len, aA_type type, aA_rightValList vals);
aA_varDef aA_VarDefScalar(aA_pos pos, aA_varDefScalar defScalar);
aA_varDef aA_VarDefArray(aA_pos pos, aA_varDefArray defArray);
aA_varDeclStmt aA_VarDecl(aA_varDecl varDecl);
aA_varDeclStmt aA_VarDef(aA_varDef varDef);
aA_structDef aA_StructDef(string* id, aA_varDeclList varDecls);
aA_fnDecl aA_FnDecl(string* id, aA_paramDecl paramDecl, aA_type type);
aA_paramDecl aA_ParamDecl(aA_varDeclList varDecls);
aA_fnDef aA_FnDef(aA_fnDecl fnDecl, aA_codeBlockStmtList stmts);
aA_ifStmt aA_IfStmt(aA_condExpr condExpr, aA_codeBlockStmtList ifStmts, aA_codeBlockStmtList elseStmts);
aA_whileStmt aA_WhileStmt(aA_condExpr condExpr, aA_codeBlockStmtList whileStmts);
aA_codeBlockStmt aA_VarDeclStmt(aA_pos pos, aA_varDeclStmt varDeclStmt);
aA_codeBlockStmt aA_AssignStmt(aA_pos pos, aA_assignStmt assignStmt);
aA_codeBlockStmt aA_FnCall(aA_pos pos, aA_callStmt callStmt);
aA_codeBlockStmt aA_IfStmt(aA_pos pos, aA_ifStmt ifStmt);
aA_codeBlockStmt aA_WhileStmt(aA_pos pos, aA_whileStmt whileStmt);
aA_codeBlockStmt aA_ReturnStmt(aA_pos pos, aA_returnStmt returnStmt);
aA_programElement aA_ProgramVarDeclStmt(aA_pos pos, aA_varDeclStmt varDeclStmt);
aA_programElement aA_ProgramStructDef(aA_pos pos, aA_structDef structDef);
aA_programElement aA_ProgramFnDeclStmt(aA_pos pos, aA_fnDeclStmt fnDecl);
aA_programElement aA_ProgramFnDef(aA_pos pos, aA_fnDef fnDef);
