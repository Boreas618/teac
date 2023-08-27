#include "ast.h"
#include "util.h"
#include <stdio.h>

A_pos A_Pos(int line, int pos)
{
    A_pos p = (A_pos)checked_malloc(sizeof(*p));
    p->line = line;
    p->pos = pos;
    return p;
}

A_prog A_Prog(A_pos pos, A_compUnitList cul)
{
    A_prog p = (A_prog)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->cul = cul;
    return p;
}

A_compUnit A_CompUnitDecl(A_pos pos, A_decl d)
{
    A_compUnit p = (A_compUnit)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_compUnit_::comp_decl;
    p->u.d = d;
    return p;
}

A_compUnit A_CompUnitFuncDef(A_pos pos, A_funcDef fd)
{
    A_compUnit p = (A_compUnit)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_compUnit_::comp_func;
    p->u.fd = fd;
    return p;
}

A_compUnitList A_CompUnitList(A_compUnit head, A_compUnitList tail)
{
    A_compUnitList p = (A_compUnitList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_decl A_DeclConst(A_pos pos, A_constDecl cd)
{
    A_decl p = (A_decl)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_decl_::constDecl;
    p->u.cd = cd;
    return p;
}

A_decl A_DeclVar(A_pos pos, A_varDecl vd)
{
    A_decl p = (A_decl)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_decl_::varDecl;
    p->u.vd = vd;
    return p;
}

A_declList A_DeclList(A_decl head, A_declList tail)
{
    A_declList p = (A_declList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_constDecl A_ConstDecl(A_pos pos, enum A_funcType type, A_constDefList cdl)
{
    A_constDecl p = (A_constDecl)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->type = type;
    p->cdl = cdl;
    return p;
}

A_constDefList A_ConstDefList(A_constDef head, A_constDefList tail)
{
    A_constDefList p = (A_constDefList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_constDef A_ConstDef(A_pos pos, string id, A_expList cel, A_initVal iv)
{
    A_constDef p = (A_constDef)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->id = id;
    p->cel = cel;
    p->iv = iv;
    return p;
}

A_constExp A_ConstExp(A_pos pos, A_exp e)
{
    A_constExp p = (A_constExp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->e = e;
    return p;
}

A_constExpList A_ConstExpList(A_constExp head, A_constExpList tail)
{
    A_constExpList p = (A_constExpList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_varDecl A_VarDecl(A_pos pos, enum A_funcType type, A_varDefList vdl)
{
    A_varDecl p = (A_varDecl)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->type = type;
    p->vdl = vdl;
    return p;
}

A_varDefList A_VarDefList(A_varDef head, A_varDefList tail)
{
    A_varDefList p = (A_varDefList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_varDef A_VarDef(A_pos pos, string id, A_expList cel, A_initVal iv)
{
    A_varDef p = (A_varDef)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->id = id;
    p->cel = cel;
    p->iv = iv;
    return p;
}

A_expList A_ExpList(A_exp head, A_expList tail)
{
    A_expList p = (A_expList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_funcDef A_FuncDef(A_pos pos, enum A_funcType type, string v, A_funcFParams ffp, A_block b)
{
    A_funcDef p = (A_funcDef)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->type = type;
    p->v = v;
    p->ffp = ffp;
    p->b = b;
    return p;
}

A_funcFParams A_FuncFParams(A_pos pos, A_funcFParamList ffpl)
{
    A_funcFParams p = (A_funcFParams)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->ffpl = ffpl;
    return p;
}

A_funcFParamList A_FuncFParamList(A_funcFParam head, A_funcFParamList tail)
{
    A_funcFParamList p = (A_funcFParamList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_funcFParam A_FuncFParam(A_pos pos, enum A_funcType type, string id, A_expList el, int is_arr)
{
    A_funcFParam p = (A_funcFParam)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->type = type;
    p->el = el;
    p->id = id;
    p->is_arr = is_arr;
    return p;
}

A_block A_Block(A_pos pos, A_blockItemList bil)
{
    A_block p = (A_block)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->bil = bil;
    return p;
}

A_blockItem A_BlockItemDecl(A_pos pos, A_decl d)
{
    A_blockItem p = (A_blockItem)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_blockItem_::b_decl;
    p->u.d = d;
    return p;
}

A_blockItem A_BlockItemStmt(A_pos pos, A_stmt s)
{
    A_blockItem p = (A_blockItem)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_blockItem_::b_stmt;
    p->u.s = s;
    return p;
}

A_blockItemList A_BlockItemList(A_blockItem head, A_blockItemList tail)
{
    A_blockItemList p = (A_blockItemList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

A_stmt A_BlockStm(A_pos pos, A_block b)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_blockStm;
    p->u.b = b;
    return p;
}

A_stmt A_IfStm(A_pos pos, A_exp e, A_stmt s1, A_stmt s2)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_ifStm;
    p->u.if_stat.e = e;
    p->u.if_stat.s1 = s1;
    p->u.if_stat.s2 = s2;
    return p;
}

A_stmt A_WhileStm(A_pos pos, A_exp e, A_stmt s)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_whileStm;
    p->u.while_stat.e = e;
    p->u.while_stat.s = s;
    return p;
}

A_stmt A_AssignStm(A_pos pos, A_exp left, A_exp right)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_assignStm;
    p->u.assign.arr = left;
    p->u.assign.value = right;
    return p;
}

A_stmt A_CallStm(A_pos pos, string id, A_expList el)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_callStm;
    p->u.call_stat.fun = id;
    p->u.call_stat.el = el;
    return p;
}

A_stmt A_Continue(A_pos pos)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_continue;
    return p;
}

A_stmt A_Break(A_pos pos)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_break;
    return p;
}

A_stmt A_Return(A_pos pos, A_exp e)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_return;
    p->u.e = e;
    return p;
}

A_stmt A_Putint(A_pos pos, A_exp e)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putint;
    p->u.e = e;
    return p;
}

A_stmt A_Putch(A_pos pos, A_exp e)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putch;
    p->u.e = e;
    return p;
}

A_stmt A_Putfloat(A_pos pos, A_exp e)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putfloat;
    p->u.e = e;
    return p;
}

A_stmt A_Putarray(A_pos pos, A_exp e1, A_exp e2)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putarray;
    p->u.putarray.e1 = e1;
    p->u.putarray.e2 = e2;
    return p;
}

A_stmt A_Putfarray(A_pos pos, A_exp e1, A_exp e2)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putfarray;
    p->u.putarray.e1 = e1;
    p->u.putarray.e2 = e2;
    return p;
}

A_stmt A_Putf(A_pos pos, string fmt, A_expList el)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_putf;
    p->u.putf.fmt = fmt;
    p->u.putf.el = el;
    return p;
}

A_stmt A_Starttime(A_pos pos)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_starttime;
    return p;
}

A_stmt A_Stoptime(A_pos pos)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_stoptime;
    return p;
}

A_stmt A_ExpStm(A_pos pos, A_exp e)
{
    A_stmt p = (A_stmt)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_stmKind::A_expStm;
    p->u.e = e;
    return p;
}

A_exp A_OpExp(A_pos pos, A_exp left, A_binop op, A_exp right)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_opExp;
    p->u.op.left = left;
    p->u.op.oper = op;
    p->u.op.right = right;
    return p;
}

A_exp A_ArrayExp(A_pos pos, A_exp e1, A_expList el)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_arrayExp;
    p->u.array_pos.arr = e1;
    p->u.array_pos.arr_pos = el;
    return p;
}

A_exp A_CallExp(A_pos pos, string id, A_expList el)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_callExp;
    p->u.call.fun = id;
    p->u.call.el = el;
    return p;
}

A_exp A_IntConst(A_pos pos, int num)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_intConst;
    p->u.inum = num;
    return p;
}

A_exp A_FloatConst(A_pos pos, string num)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_floatConst;
    p->u.fnum = num;
    return p;
}

A_exp A_IdExp(A_pos pos, string v)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_idExp;
    p->u.v = v;
    return p;
}

A_exp A_NotExp(A_pos pos, A_exp e)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_notExp;
    p->u.e = e;
    return p;
}

A_exp A_MinusExp(A_pos pos, A_exp e)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_minusExp;
    p->u.e = e;
    return p;
}

A_exp A_Getint(A_pos pos)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_getint;
    return p;
}

A_exp A_Getch(A_pos pos)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_getch;
    return p;
}

A_exp A_Getfloat(A_pos pos)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_getfloat;
    return p;
}

A_exp A_Getarray(A_pos pos, A_exp e)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_getarray;
    p->u.e = e;
    return p;
}

A_exp A_Getfarray(A_pos pos, A_exp e)
{
    A_exp p = (A_exp)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_expKind::A_getfarray;
    p->u.e = e;
    return p;
}

A_initVal A_InitValExp(A_pos pos, A_exp e)
{
    A_initVal p = (A_initVal)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_initVal_::init_exp;
    p->u.e = e;
    return p;
}

A_initVal A_InitValArray(A_pos pos, A_arrayInit ai)
{
    A_initVal p = (A_initVal)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->kind = A_initVal_::init_array;
    p->u.ai = ai;
    return p;
}

A_arrayInit A_ArrayInit(A_pos pos, A_initValList ivl)
{
    A_arrayInit p = (A_arrayInit)checked_malloc(sizeof(*p));
    p->pos = pos;
    p->ivl = ivl;
    return p;
}

A_initValList A_InitValList(A_initVal head, A_initValList tail)
{
    A_initValList p = (A_initValList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

enum A_funcType A_FuncType(int i)
{
    return (enum A_funcType)(i);
}