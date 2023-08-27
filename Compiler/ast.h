#ifndef __AST__
#define __AST__

#include "util.h"

typedef struct A_pos_ *A_pos;
typedef struct A_prog_ *A_prog;
typedef struct A_compUnit_ *A_compUnit;
typedef struct A_compUnitList_ *A_compUnitList;
typedef struct A_decl_ *A_decl;
typedef struct A_funcDef_ *A_funcDef;
typedef struct A_declList_ *A_declList;
typedef struct A_funcDefList_ *A_funcDefList;
typedef struct A_constDecl_ *A_constDecl;
typedef struct A_varDecl_ *A_varDecl;
typedef struct A_constDef_ *A_constDef;
typedef struct A_constDefList_ *A_constDefList;
typedef struct A_constExp_ *A_constExp;
typedef struct A_constExpList_ *A_constExpList;
typedef struct A_varDef_ *A_varDef;
typedef struct A_varDefList_ *A_varDefList;
typedef struct A_funcFParams_ *A_funcFParams;
typedef struct A_funcFParam_ *A_funcFParam;
typedef struct A_funcFParamList_ *A_funcFParamList;
typedef struct A_block_ *A_block;
typedef struct A_blockItem_ *A_blockItem;
typedef struct A_blockItemList_ *A_blockItemList;
typedef struct A_stmt_ *A_stmt;
typedef struct A_exp_ *A_exp;
typedef struct A_expList_ *A_expList;
typedef struct A_initVal_ *A_initVal;
typedef struct A_arrayInit_ *A_arrayInit;
typedef struct A_initValList_ *A_initValList;

struct A_pos_
{
    int line, pos;
};

enum A_funcType
{
    f_int,
    f_float,
    f_void
};
struct A_prog_
{
    A_pos pos;
    A_compUnitList cul;
};

struct A_compUnit_
{
    A_pos pos;
    enum
    {
        comp_decl,
        comp_func
    } kind;
    union
    {
        A_decl d;
        A_funcDef fd;
    } u;
};

struct A_compUnitList_
{
    A_compUnit head;
    A_compUnitList tail;
};

struct A_declList_
{
    A_decl head;
    A_declList tail;
};

struct A_decl_
{
    A_pos pos;
    enum
    {
        constDecl,
        varDecl
    } kind;
    union
    {
        A_constDecl cd;
        A_varDecl vd;
    } u;
};

struct A_constDecl_
{
    A_pos pos;
    enum A_funcType type;
    A_constDefList cdl;
};

struct A_constDefList_
{
    A_constDef head;
    A_constDefList tail;
};

struct A_constDef_
{
    A_pos pos;
    string id;
    A_expList cel;
    A_initVal iv;
};

struct A_initVal_
{
    A_pos pos;
    enum
    {
        init_exp,
        init_array
    } kind;
    union
    {
        A_exp e;
        A_arrayInit ai;
    } u;
};

struct A_arrayInit_
{
    A_pos pos;
    A_initValList ivl;
};

struct A_initValList_
{
    A_initVal head;
    A_initValList tail;
};

struct A_constExp_
{
    A_pos pos;
    A_exp e;
};

struct A_constExpList_
{
    A_constExp head;
    A_constExpList tail;
};

struct A_varDecl_
{
    A_pos pos;
    enum A_funcType type;
    A_varDefList vdl;
};

struct A_varDefList_
{
    A_varDef head;
    A_varDefList tail;
};

struct A_varDef_
{
    A_pos pos;
    string id;
    A_expList cel;
    A_initVal iv;
};

struct A_expList_
{
    A_exp head;
    A_expList tail;
};

enum A_bType
{
    b_int,
    b_float
};

struct A_funcDef_
{
    A_pos pos;
    enum A_funcType type;
    string v;
    A_funcFParams ffp;
    A_block b;
};

struct A_funcFParams_
{
    A_pos pos;
    A_funcFParamList ffpl;
};

struct A_funcFParamList_
{
    A_funcFParam head;
    A_funcFParamList tail;
};

struct A_funcFParam_
{
    A_pos pos;
    enum A_funcType type;
    string id;
    int is_arr;
    A_expList el;
};

struct A_block_
{
    A_pos pos;
    A_blockItemList bil;
};

struct A_blockItemList_
{
    A_blockItem head;
    A_blockItemList tail;
};

struct A_blockItem_
{
    A_pos pos;
    enum
    {
        b_decl,
        b_stmt
    } kind;
    union
    {
        A_decl d;
        A_stmt s;
    } u;
};

typedef enum
{
    A_blockStm,
    A_ifStm,
    A_whileStm,
    A_assignStm,
    A_callStm,
    A_continue,
    A_break,
    A_return,
    A_putint,
    A_putarray,
    A_putch,
    A_starttime,
    A_stoptime,
    A_expStm,
    A_putfarray,
    A_putfloat,
    A_putf
} A_stmKind;

struct A_stmt_
{
    A_pos pos;
    A_stmKind kind;
    union
    {
        A_block b;
        struct
        {
            A_exp e;
            A_stmt s1, s2;
        } if_stat;
        struct
        {
            A_exp e;
            A_stmt s;
        } while_stat;
        struct
        {
            A_exp arr; // left must be a location for an array type
            // A_exp pos; //array position /* March 20, 2023
            // This is redundant due to erasure of redundant
            // rule in the grammar */
            A_exp value;
        } assign;
        struct
        {
            string fun;   // function name
            A_expList el; // parameters
        } call_stat;
        struct
        {
            A_exp e1, e2;
        } putarray;
        A_exp e;
        struct
        {
            string fmt;
            A_expList el;
        } putf;
    } u;
};

typedef enum
{
    A_and,
    A_or,
    A_less,
    A_le,
    A_greater,
    A_ge,
    A_eq,
    A_ne,
    A_plus,
    A_minus,
    A_times,
    A_div,
    A_mod
} A_binop;

typedef enum
{
    A_opExp,
    A_arrayExp,
    A_callExp,
    A_classVarExp,
    A_boolConst,
    A_intConst,
    A_floatConst,
    A_idExp,
    A_notExp,
    A_minusExp,
    A_escExp,
    A_getint,
    A_getch,
    A_getfloat,
    A_getarray,
    A_getfarray
} A_expKind;

struct A_exp_
{
    A_pos pos;
    A_expKind kind;
    union
    {
        struct
        {
            A_exp left;
            A_binop oper;
            A_exp right;
        } op;
        struct
        {
            A_exp arr; // this must evaluate to an array
            A_expList arr_pos;
        } array_pos;
        struct
        {
            string fun; // this is the name of the function if present
            A_expList el;
        } call;
        int inum;
        string fnum;
        string v;
        A_exp e;
    } u;
};

A_pos A_Pos(int line, int pos);
A_prog A_Prog(A_pos pos, A_compUnitList cul);
A_compUnit A_CompUnitDecl(A_pos pos, A_decl d);
A_compUnit A_CompUnitFuncDef(A_pos pos, A_funcDef fd);
A_compUnitList A_CompUnitList(A_compUnit head, A_compUnitList tail);
A_decl A_DeclConst(A_pos pos, A_constDecl cd);
A_decl A_DeclVar(A_pos pos, A_varDecl vd);
A_declList A_DeclList(A_decl head, A_declList tail);
A_constDecl A_ConstDecl(A_pos pos, enum A_funcType type, A_constDefList cdl);
A_constDefList A_ConstDefList(A_constDef head, A_constDefList tail);
A_constDef A_ConstDef(A_pos pos, string id, A_expList cel, A_initVal iv);
A_constExp A_ConstExp(A_pos pos, A_exp e);
A_constExpList A_ConstExpList(A_constExp head, A_constExpList tail);
A_varDecl A_VarDecl(A_pos pos, enum A_funcType type, A_varDefList vdl);
A_varDefList A_VarDefList(A_varDef head, A_varDefList tail);
A_varDef A_VarDef(A_pos pos, string id, A_expList cel, A_initVal iv);
A_expList A_ExpList(A_exp head, A_expList tail);
A_funcDef A_FuncDef(A_pos pos, enum A_funcType type, string v, A_funcFParams ffp, A_block b);
A_funcFParams A_FuncFParams(A_pos pos, A_funcFParamList ffpl);
A_funcFParamList A_FuncFParamList(A_funcFParam head, A_funcFParamList tail);
A_funcFParam A_FuncFParam(A_pos pos, enum A_funcType type, string id, A_expList el, int is_arr);
A_block A_Block(A_pos pos, A_blockItemList bil);
A_blockItem A_BlockItemDecl(A_pos pos, A_decl d);
A_blockItem A_BlockItemStmt(A_pos pos, A_stmt s);
A_blockItemList A_BlockItemList(A_blockItem head, A_blockItemList tail);
A_stmt A_BlockStm(A_pos pos, A_block b);
A_stmt A_IfStm(A_pos pos, A_exp e, A_stmt s1, A_stmt s2); // if the second A_stm is not empty, then there is an else part
A_stmt A_WhileStm(A_pos pos, A_exp e, A_stmt s);
A_stmt A_AssignStm(A_pos pos, A_exp left, A_exp right); // Updated March 20, 2023. Removed second exp: OLD: if second A_exp is not empty, then it's array position assignment
A_stmt A_CallStm(A_pos pos, string id, A_expList el);
A_stmt A_Continue(A_pos pos);
A_stmt A_Break(A_pos pos);
A_stmt A_Return(A_pos pos, A_exp e);
A_stmt A_Putint(A_pos pos, A_exp e);
A_stmt A_Putch(A_pos pos, A_exp e);
A_stmt A_Putfloat(A_pos pos, A_exp e);
A_stmt A_Putarray(A_pos pos, A_exp e1, A_exp e2);
A_stmt A_Starttime(A_pos pos);
A_stmt A_Stoptime(A_pos pos);
A_stmt A_ExpStm(A_pos pos, A_exp e);

A_exp A_OpExp(A_pos pos, A_exp left, A_binop op, A_exp right);
A_exp A_ArrayExp(A_pos pos, A_exp e1, A_expList el);
A_exp A_CallExp(A_pos pos, string id, A_expList el);
A_exp A_IntConst(A_pos pos, int num);
A_exp A_FloatConst(A_pos pos, string num);
A_exp A_IdExp(A_pos pos, string v);
A_exp A_NotExp(A_pos pos, A_exp e);
A_exp A_MinusExp(A_pos pos, A_exp e);
A_exp A_Getint(A_pos pos);
A_exp A_Getch(A_pos pos);
A_exp A_Getfloat(A_pos pos);
A_exp A_Getarray(A_pos pos, A_exp e);
A_exp A_Getfarray(A_pos pos, A_exp e);

A_stmt A_Putfarray(A_pos pos, A_exp e1, A_exp e2);
A_stmt A_Putf(A_pos pos, string fmt, A_expList el);

A_initVal A_InitValExp(A_pos pos, A_exp e);
A_initVal A_InitValArray(A_pos pos, A_arrayInit ai);
A_arrayInit A_ArrayInit(A_pos pos, A_initValList ivl);
A_initValList A_InitValList(A_initVal head, A_initValList tail);
enum A_funcType A_FuncType(int i);

#endif