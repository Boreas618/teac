#include <stdio.h>
#include "util.h"
#include "treep.hpp"
#include <assert.h>
#include <string>
#include <iostream>
T_relOp commute(T_relOp op)
{
    switch (op)
    {
    case T_eq:
        return T_eq;
    case T_ne:
        return T_ne;
    case T_lt:
        return T_gt;
    case T_ge:
        return T_le;
    case T_gt:
        return T_lt;
    case T_le:
        return T_ge;
    case F_eq:
        return F_eq;
    case F_ne:
        return F_ne;
    case F_lt:
        return F_gt;
    case F_ge:
        return F_le;
    case F_gt:
        return F_lt;
    case F_le:
        return F_ge;
    }
}

T_funcDecl T_FuncDecl(std::string &name, Temp_tempList tl, T_stm s)
{
    T_funcDecl p = new T_funcDecl_();
    p->name = name;
    p->args = tl;
    p->stm = s;
    return p;
}

T_funcDeclList T_FuncDeclList(T_funcDecl head, T_funcDeclList tail)
{
    T_funcDeclList p = (T_funcDeclList)checked_malloc(sizeof *p);
    if (head == NULL)
        return NULL;
    p->head = head;
    p->tail = tail;
    return p;
}

T_expList T_ExpList(T_exp head, T_expList tail)
{
    T_expList p = (T_expList)checked_malloc(sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

T_stmList T_StmList(T_stm head, T_stmList tail)
{
    T_stmList p = (T_stmList)checked_malloc(sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

T_stm T_Seq(T_stm left, T_stm right)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    if (left == NULL)
        return right;
    if (right == NULL)
        return left;
    p->kind = T_SEQ;
    p->SEQ.left = left;
    p->SEQ.right = right;
    return p;
}

T_stm T_Label(const Temp_label_front &label)
{
    //     // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_LABEL;
    p->LABEL = label;
    return p;
}

T_stm T_Jump(Temp_label_front &label)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_JUMP;
    p->JUMP.jump = label;
    return p;
}

T_stm T_Cjump(T_relOp op, T_exp left, T_exp right,
              const Temp_label_front &t, const Temp_label_front &f)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_CJUMP;
    p->CJUMP.op = op;
    p->CJUMP.left = left;
    p->CJUMP.right = right;
    p->CJUMP.t = t;
    p->CJUMP.f = f;
    return p;
}

T_stm T_Move(T_exp dst, T_exp src)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_MOVE;
    p->MOVE.dst = dst;
    p->MOVE.src = src;
    return p;
}

T_stm T_Return(T_exp exp)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_RETURN;
    p->EXP = exp;
    return p;
}

T_stm T_Exp(T_exp exp)
{
    // T_stm p = (T_stm)checked_malloc(sizeof *p);
    T_stm p = new T_stm_();
    p->kind = T_EXP;
    p->EXP = exp;
    return p;
}

T_exp T_Binop(T_binOp op, T_exp left, T_exp right)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_BINOP;
    p->BINOP.op = op;
    p->BINOP.left = left;
    p->BINOP.right = right;
    return p;
}

T_exp T_Mem(T_exp exp)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_MEM;
    p->MEM = exp;
    return p;
}

T_exp T_Temp(Temp_temp temp)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_TEMP;
    p->TEMP = temp;
    return p;
}

T_exp T_Eseq(T_stm stm, T_exp exp)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    if (stm == nullptr)
        return exp;
    T_exp p = new T_exp_();
    p->kind = T_ESEQ;
    p->ESEQ.stm = stm;
    p->ESEQ.exp = exp;
    return p;
}

T_exp T_Name(Temp_label_front &name, TempType type)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_NAME;
    p->NAME.label = name;
    p->NAME.type = type;
    return p;
}

T_exp T_Const(int consti)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_CONST;
    p->ICONST = consti;
    return p;
}

T_exp T_FConst(float constf)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_FCONST;
    p->FCONST = constf;
    return p;
}

T_exp T_Call(const std::string &id, T_expList args)
{
    // T_exp p = (T_exp)checked_malloc(sizeof *p);
    T_exp p = new T_exp_();
    p->kind = T_CALL;
    p->CALL.id = id;
    p->CALL.args = args;
    return p;
}

T_relOp T_notRel(T_relOp r)
{
    switch (r)
    {
    case T_eq:
        return T_ne;
    case T_ne:
        return T_eq;
    case T_lt:
        return T_ge;
    case T_ge:
        return T_lt;
    case T_gt:
        return T_le;
    case T_le:
        return T_gt;
    case F_eq:
        return F_ne;
    case F_ne:
        return F_eq;
    case F_lt:
        return F_ge;
    case F_ge:
        return F_lt;
    case F_gt:
        return F_le;
    case F_le:
        return F_gt;
    }
    assert(0);
    return T_eq;
}
