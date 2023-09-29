#pragma once

typedef struct A_pos_* A_pos; //position information
typedef struct A_type_* A_type;
typedef struct A_varDecl_* A_varDecl;
typedef struct A_varDef_* A_varDef;
typedef struct A_rightVal_* A_rightVal;
typedef struct A_arithExpr_* A_arithExpr;
typedef struct A_condExpr_* A_condExpr;
typedef struct A_arithBiOpExpr_* A_arithBiOpExpr;
typedef struct A_arithUExpr_* A_arithUExpr;
typedef struct A_exprUnit_* A_exprUnit;
typedef struct A_fnCall_* A_fnCall;
typedef struct A_indexExpr_* A_indexExpr;
typedef struct A_arrayExpr_* A_arrayExpr;
typedef struct A_memberExpr_* A_memberExpr;
typedef struct A_condUnit_* A_condUnit;
typedef struct A_logicBiOpExpr_* A_logicBiOpExpr;
typedef struct A_logicUOpExpr_* A_logicUOpExpr;
typedef struct A_comExpr_* A_comExpr;
typedef struct A_rightVal_* A_rightVal;
typedef struct A_leftVal_* A_leftVal;
typedef struct A_assignStmt_* A_assignStmt;
typedef struct A_rightValList_* A_rightValList;
typedef struct A_varDefScalar_* A_varDefScalar;
typedef struct A_varDefArray_* A_varDefArray;
typedef struct A_varDeclScalar_* A_varDeclScalar;
typedef struct A_varDeclArray_* A_varDeclArray;
typedef struct A_varDecl_* A_varDecl;
typedef struct A_varDef_* A_varDef;
typedef struct A_varDeclStmt_* A_varDeclStmt;
typedef struct A_varDeclList_* A_varDeclList;
typedef struct A_structDef_* A_structDef;
typedef struct A_paramDecl_* A_paramDecl;
typedef struct A_fnDecl_* A_fnDecl;
typedef struct A_fnDef_* A_fnDef;
typedef struct A_codeBlockStmt_* A_codeBlockStmt;
typedef struct A_ifStmt_* A_ifStmt;
typedef struct A_whileStmt_* A_whileStmt;
typedef struct A_fnDeclStmt_* A_fnDeclStmt;
typedef struct A_callStmt_* A_callStmt;
typedef struct A_returnStmt_* A_returnStmt;
typedef struct A_programElement_* A_programElement;
typedef struct A_codeBlockStmtList_* A_codeBlockStmtList;
typedef struct A_programElementList_* A_programElementList;

struct A_pos_ {
    int line, col;
};

typedef enum {
    A_nullTypeKind,
    A_nativeTypeKind,
    A_structTypeKind
} A_dataType;

typedef enum {
    A_intTypeKind
} A_nativeType;

struct A_type_ {
    A_pos pos;
    A_dataType type;
    union {
        A_nativeType nativeType;
        char* structType;
    } u;
};

struct A_rightValList_ {
    A_rightVal head;
    A_rightValList tail;
};

struct A_fnCall_ {
    char* fn;
    A_rightValList vals;
};

typedef enum {
    A_numIndexKind,
    A_idIndexKind
} A_indexExprKind;

struct A_indexExpr_ {
    A_indexExprKind kind;
    union {
        int num;
        char* id;
    } u;
};

struct A_arrayExpr_ {
    char* arr;
    A_indexExpr idx;
};

struct A_memberExpr_ {
    char* structId;
    char* memberId;
};

typedef enum {
    A_numExprKind,
    A_idExprKind,
    A_arithExprKind,
    A_fnCallKind,
    A_arrayExprKind,
    A_memberExprKind,
    A_arithUExprKind
} A_exprUnitType;

struct A_exprUnit_ {
    A_exprUnitType kind;
    union {
        int num;
        char* id;
        A_arithExpr arithExpr;
        A_fnCall callExpr;
        A_arrayExpr arrayExpr;
        A_memberExpr memberExpr;
        A_arithUExpr arithUExpr;
    } u;
};

typedef enum {
    A_neg
} A_arithUOp;

typedef enum {
    A_add,
    A_sub,
    A_mul,
    A_div
} A_arithBiOp;

typedef enum {
    A_not
} A_logicUOp;

typedef enum {
    A_and,
    A_or
} A_logicBiOp;

typedef enum {
    A_lt, // less than
    A_le, // less equal
    A_gt,
    A_ge,
    A_eq,
    A_ne
} A_comOp;

typedef enum {
    A_arithBiOpExprKind,
    A_exprUnitKind
} A_arithExprType;

typedef enum {
    A_logicBiOpExprKind,
    A_condUnitKind
} A_condExprType;

typedef enum {
    A_comOpExprKind,
    A_condExprKind,
    A_logicUOpExprKind
} A_condUnitType;

typedef enum {
    A_arithExprValKind,
    A_condExprValKind
} A_rightValType;

typedef enum {
    A_varValKind,
    A_arrValKind,
    A_memberValKind
} A_leftValType;

typedef enum {
    A_varDeclKind,
    A_varDefKind
} A_varDeclStmtType;

typedef enum {
    A_varDeclScalarKind,
    A_varDeclArrayKind
} A_varDeclType;

typedef enum {
    A_varDefScalarKind,
    A_varDefArrayKind
} A_varDefType;

typedef enum {
    A_programVarDeclStmtKind,
    A_programStructDefKind,
    A_programFnDeclStmtKind,
    A_programFnDefKind
} A_programElementType;

struct A_arithBiOpExpr_ {
    A_arithBiOp op;
    A_arithExpr left, right;
};

struct A_arithUExpr_ {
    A_arithUOp op;
    A_exprUnit expr;
};

struct A_arithExpr_ {
    A_arithExprType kind;
    union {
        A_arithBiOpExpr arithBiOpExpr;
        A_exprUnit exprUnit;
    } u;
};

struct A_logicBiOpExpr_ {
    A_logicBiOp op;
    A_condExpr left;
    A_condUnit right;
};

struct A_logicUOpExpr_ {
    A_logicUOp op;
    A_condUnit cond;
};

struct A_condExpr_ {
    A_condExprType kind;
    union {
        A_logicBiOpExpr logicBiOpExpr;
        A_condUnit condUnit;
    } u;
};

struct A_comExpr_ {
    A_pos pos;
    A_comOp op;
    A_exprUnit left, right;
};

struct A_condUnit_ {
    A_condUnitType kind;
    union {
        A_comExpr comExpr;
        A_condExpr condExpr;
        A_logicUOpExpr logicUOpExpr;
    } u;
};

struct A_rightVal_ {
    A_pos pos;
    A_rightValType kind;
    union {
        A_arithExpr arithExpr;
        A_condExpr condExpr;
    } u;
};

struct A_leftVal_ {
    A_pos pos;
    A_leftValType kind;
    union {
        char* id;
        A_arrayExpr arrExpr;
        A_memberExpr memberExpr;
    } u;
};

struct A_assignStmt_ {
    A_pos pos;
    A_leftVal leftVal;
    A_rightVal rightVal;
};

struct A_varDeclScalar_ {
    A_pos pos;
    char* id;
    A_type type;
};

struct A_varDeclArray_ {
    A_pos pos;
    char* id;
    int len;
    A_type type;
};

struct A_varDecl_ {
    A_pos pos;
    A_varDeclType kind;
    union {
        A_varDeclScalar declScalar;
        A_varDeclArray declArray;
    } u;
};

struct A_varDefScalar_ {
    A_pos pos;
    char* id;
    A_type type;
    A_rightVal val;
};

struct A_varDefArray_ {
    A_pos pos;
    char* id;
    int len;
    A_type type;
    A_rightValList vals;
};

struct A_varDef_ {
    A_pos pos;
    A_varDefType kind;
    union {
        A_varDefScalar defScalar;
        A_varDefArray defArray;
    } u;
};

struct A_varDeclStmt_ {
    A_varDeclStmtType kind;
    union {
        A_varDecl varDecl;
        A_varDef varDef;
    } u;
};

struct A_varDeclList_ {
    A_varDecl head;
    A_varDeclList tail;
};

struct A_structDef_ {
    char* id;
    A_varDeclList varDecls;
};

struct A_fnDecl_ {
    char* id;
    A_paramDecl paramDecl;
    A_type type;
};

struct A_paramDecl_ {
    A_varDeclList varDecls;
};

struct A_fnDef_ {
    A_fnDecl fnDecl;
    A_codeBlockStmtList stmts;
};

struct A_ifStmt_ {
    A_condExpr condExpr;
    A_codeBlockStmtList ifStmts, elseStmts;
};

struct A_whileStmt_ {
    A_condExpr condExpr;
    A_codeBlockStmtList whileStmts;
};

struct A_callStmt_ {
    A_fnCall fnCall;
};

struct A_returnStmt_ {
    A_rightVal retval;
};

typedef enum {
    A_nullStmtKind,
    A_varDeclStmtKind,
    A_assignStmtKind,
    A_callStmtKind,
    A_ifStmtKind,
    A_whileStmtKind,
    A_returnStmtKind,
    A_continueStmtKind,
    A_breakStmtKind
} A_codeBlockStmtType;

struct A_codeBlockStmt_ {
    A_pos pos;
    A_codeBlockStmtType kind;
    union {
        A_varDeclStmt varDeclStmt;
        A_assignStmt assignStmt;
        A_callStmt callStmt;
        A_ifStmt ifStmt;
        A_whileStmt whileStmt;
        A_returnStmt returnStmt;
        // continue and break do not need other info
    } u;
};

struct A_codeBlockStmtList_ {
    A_codeBlockStmt head;
    A_codeBlockStmtList tail;
};

struct A_fnDeclStmt_ {
    A_fnDecl fnDecl;
};

struct A_programElement_ {
    A_pos pos;
    A_programElementType kind;
    union {
        A_varDeclStmt varDeclStmt;
        A_structDef structDef;
        A_fnDeclStmt fnDecl;
        A_fnDef fnDef;
    } u;
};

struct A_programElementList_ {
    A_programElement head;
    A_programElementList tail;
};

A_pos A_Pos(int, int);
A_pos A_Pos(A_pos);
A_type A_NullType(A_pos pos);
A_type A_NativeType(A_pos pos, A_nativeType ntype);
A_type A_StructType(A_pos pos, char* stype);
A_rightValList A_RightValList(A_rightVal head, A_rightValList tail);
A_fnCall A_FnCall(char* fn, A_rightValList vals);
A_indexExpr A_NumIndexExpr(int num);
A_indexExpr A_IdIndexExpr(char* id);
A_arrayExpr A_ArrayExpr(char* arr, A_indexExpr idx);
A_memberExpr A_MemberExpr(char* structId, char* memberId);
A_exprUnit A_NumExprUnit(int num);
A_exprUnit A_IdExprUnit(char* id);
A_exprUnit A_ArithExprUnit(A_arithExpr arithExpr);
A_exprUnit A_CallExprUnit(A_fnCall callExpr);
A_exprUnit A_ArrayExprUnit(A_arrayExpr arrayExpr);
A_exprUnit A_MemberExprUnit(A_memberExpr memberExpr);
A_exprUnit A_ArithUExprUnit(A_arithUExpr arithUExpr);
A_arithBiOpExpr A_ArithBiOpExpr(A_arithBiOp op, A_arithExpr left, A_arithExpr right);
A_arithUExpr A_ArithUExpr(A_arithUOp op, A_exprUnit expr);
A_arithExpr A_ArithBiOpExpr(A_arithBiOpExpr arithBiOpExpr);
A_arithExpr A_ExprUnit(A_exprUnit exprUnit);
A_logicBiOpExpr A_LogicBiOpExpr(A_logicBiOp op, A_condExpr left, A_condUnit right);
A_logicUOpExpr A_LogicUOpExpr(A_logicUOp op, A_condUnit cond);
A_condExpr A_LogicBiOpExpr(A_logicBiOpExpr logicBiOpExpr);
A_condExpr A_CondExpr(A_condUnit condUnit);
A_comExpr A_ComExpr(A_pos pos, A_comOp op, A_exprUnit left, A_exprUnit right);
A_condUnit A_ComExprUnit(A_comExpr comExpr);
A_condUnit A_CondExprUnit(A_condExpr condExpr);
A_condUnit A_LogicUOpExprUnit(A_logicUOpExpr logicUOpExpr);
A_rightVal A_ArithExprRVal(A_pos pos, A_arithExpr arithExpr);
A_rightVal A_CondExprRVal(A_pos pos, A_condExpr condExpr);
A_leftVal A_IdExprLVal(A_pos pos, char* id);
A_leftVal A_ArrExprLVal(A_pos pos, A_arrayExpr arrExpr);
A_leftVal A_MemberExprLVal(A_pos pos, A_memberExpr memberExpr);
A_assignStmt A_AssignStmt(A_pos pos, A_leftVal leftVal, A_rightVal rightVal);
A_varDeclScalar A_VarDeclScalar(A_pos pos, char* id, A_type type);
A_varDeclArray A_VarDeclArray(A_pos pos, char* id, int len, A_type type);
A_varDecl A_VarDeclScalar(A_pos pos, A_varDeclScalar declScalar);
A_varDecl A_VarDeclArray(A_pos pos, A_varDeclArray declArray);
A_varDefScalar A_VarDefScalar(A_pos pos, char* id, A_type type, A_rightVal val);
A_varDefArray A_VarDefArray(A_pos pos, char* id, int len, A_type type, A_rightValList vals);
A_varDef A_VarDefScalar(A_pos pos, A_varDefScalar defScalar);
A_varDef A_VarDefArray(A_pos pos, A_varDefArray defArray);
A_varDeclStmt A_VarDecl(A_varDecl varDecl);
A_varDeclStmt A_VarDef(A_varDef varDef);
A_varDeclList A_VarDeclList(A_varDecl head, A_varDeclList tail);
A_structDef A_StructDef(char* id, A_varDeclList varDecls);
A_fnDecl A_FnDecl(char* id, A_paramDecl paramDecl, A_type type);
A_paramDecl A_ParamDecl(A_varDeclList varDecls);
A_fnDef A_FnDef(A_fnDecl fnDecl, A_codeBlockStmtList stmts);
A_ifStmt A_IfStmt(A_condExpr condExpr, A_codeBlockStmtList ifStmts, A_codeBlockStmtList elseStmts);
A_whileStmt A_WhileStmt(A_condExpr condExpr, A_codeBlockStmtList whileStmts);
A_codeBlockStmt A_VarDeclStmt(A_pos pos, A_varDeclStmt varDeclStmt);
A_codeBlockStmt A_AssignStmt(A_pos pos, A_assignStmt assignStmt);
A_codeBlockStmt A_FnCall(A_pos pos, A_callStmt callStmt);
A_codeBlockStmt A_IfStmt(A_pos pos, A_ifStmt ifStmt);
A_codeBlockStmt A_WhileStmt(A_pos pos, A_whileStmt whileStmt);
A_codeBlockStmt A_ReturnStmt(A_pos pos, A_returnStmt returnStmt);
A_programElement A_ProgramVarDeclStmt(A_pos pos, A_varDeclStmt varDeclStmt);
A_programElement A_ProgramStructDef(A_pos pos, A_structDef structDef);
A_programElement A_ProgramFnDeclStmt(A_pos pos, A_fnDeclStmt fnDecl);
A_programElement A_ProgramFnDef(A_pos pos, A_fnDef fnDef);
