#ifndef _TREEP
#define _TREEP

#include "templabel.hpp"
#include "temp.h"
#include <stdio.h>

/*
 * treep.h - Definitions for intermediate representation (IR) plus trees.
 *
 * This tree.h is an extension of tiger IR with the following
 * additional concepts and constructs:
 *
 * 1. Function declarations are explicitly list given.
 * 2. Two built-in functions: alloca and phi (as in LLVM IR).
 */

/* A piece of code (in a file) is a list of function declarations,
 * which includes a (unique) main function declaration
 */

/* The following is to define statements and expressions */
typedef struct T_stm_ *T_stm;
typedef struct T_exp_ *T_exp;

typedef struct T_expList_ *T_expList;
struct T_expList_
{
    T_exp head;
    T_expList tail;
};

typedef struct T_stmList_ *T_stmList;
struct T_stmList_
{
    T_stm head;
    T_stmList tail;
};

/* A function is a list of temps as arguments, and a list of statements */
typedef struct T_funcDecl_ *T_funcDecl;
typedef struct T_funcDeclList_ *T_funcDeclList;
struct T_funcDecl_
{
    std::string name;
    Temp_tempList args;
    T_stm stm;
};
struct T_funcDeclList_
{
    T_funcDecl head;
    T_funcDeclList tail;
};

typedef enum
{
    T_plus,
    T_minus,
    T_mul,
    T_div,
    T_mod,
    F_plus,
    F_minus,
    F_mul,
    F_div
} T_binOp;

typedef enum
{
    T_eq,
    T_ne,
    T_lt,
    T_gt,
    T_le,
    T_ge,
    F_eq,
    F_ne,
    F_lt,
    F_gt,
    F_le,
    F_ge
} T_relOp;

T_relOp commute(T_relOp op);
T_relOp notRel(T_relOp op);
typedef enum
{
    T_SEQ,
    T_LABEL,
    T_JUMP,
    T_CJUMP,
    T_MOVE,
    T_EXP,
    T_RETURN
} stmkind;
typedef struct SEQ
{
    T_stm left, right;
    SEQ() {}
} SEQ_;
typedef struct JUMP
{
    Temp_label_front jump;
    JUMP() {}
} JUMP_;
typedef struct CJUMP
{
    T_relOp op;
    T_exp left, right;
    Temp_label_front t, f;
    CJUMP() {}
} CJUMP_;
typedef struct MOVE
{
    T_exp dst, src;
    MOVE() {}
} MOVE_;
struct T_stm_
{
    stmkind kind;
    // union
    // {
    SEQ_ SEQ;
    Temp_label_front LABEL;
    JUMP_ JUMP;
    CJUMP_ CJUMP;
    MOVE_ MOVE;
    T_exp EXP;
    // } u;
    T_stm_() {}
};
typedef enum
{
    T_BINOP,
    T_MEM,
    T_TEMP,
    T_ESEQ,
    T_NAME,
    T_CONST,
    T_FCONST,
    T_CALL
} expkind;

typedef struct
{
    T_stm stm;
    T_exp exp;
} ESEQ_;
typedef struct
{
    T_binOp op;
    T_exp left, right;
} BINOP_;
typedef struct
{
    std::string id;
    T_expList args;
} CALL_;
typedef struct
{
    std::string extfun;
    T_expList args;
} ExtCALL_;
typedef struct
{
    Temp_label_front label;
    TempType type;
} NAME_;
struct T_exp_
{
    expkind kind;
    // union
    // {
    BINOP_ BINOP;
    T_exp MEM;
    Temp_temp TEMP;
    ESEQ_ ESEQ;
    NAME_ NAME;
    int ICONST;
    float FCONST;
    CALL_ CALL;
    ExtCALL_ ExtCALL;
    // } u;
    T_exp_() {}
};

T_expList T_ExpList(T_exp head, T_expList tail);
T_stmList T_StmList(T_stm head, T_stmList tail);

T_funcDeclList T_FuncDeclList(T_funcDecl, T_funcDeclList);
T_funcDecl T_FuncDecl(std::string &, Temp_tempList, T_stm);

T_stm T_Seq(T_stm left, T_stm right);
T_stm T_Label(const Temp_label_front &);
T_stm T_Jump(Temp_label_front &);
T_stm T_Cjump(T_relOp op, T_exp left, T_exp right, const Temp_label_front &t, const Temp_label_front &f);
T_stm T_Move(T_exp, T_exp);
T_stm T_Exp(T_exp);
T_stm T_Return(T_exp);

T_exp T_Binop(T_binOp, T_exp, T_exp);
T_exp T_Mem(T_exp);
T_exp T_Temp(Temp_temp);
T_exp T_Eseq(T_stm, T_exp);
T_exp T_Name(Temp_label_front &, TempType);
T_exp T_Const(int);
T_exp T_FConst(float);
T_exp T_Call(const std::string &, T_expList);

T_relOp T_notRel(T_relOp);  /* a op b    ==     not(a notRel(op) b)  */
T_relOp T_commute(T_relOp); /* a op b    ==    b commute(op) a       */

static inline T_stm make_seq(T_stm x, T_stm y)
{
    if (x == NULL)
        return y;
    if (y == NULL)
        return x;
    return T_Seq(x, y);
}

#endif
