/*
 * printtree.c - functions to print out intermediate representation (IR) trees.
 *
 */
#include <stdio.h>
#include "util.h"
#include <iostream>
#include "temp.h"
#include "prtreep.hpp"
#include <string>
#include <assert.h>
#include <cstring>

using namespace std;
/* local function prototype */
void pr_tree_exp(std::ostream &out, T_exp exp, int d);

static void indent(std::ostream &out, int d)
{
    int i;
    if (d >= 30)
        d = 30;
    for (i = 0; i <= d; i++)
        out << " ";
}

static std::string bin_oper[] = {
    "T_plus", "T_minus", "T_mul", "T_div", "T_mod",
    "F_plus", "F_minus", "F_mul", "F_div", "F_mod"};

static std::string rel_oper[] = {
    "T_eq", "T_ne", "T_lt", "T_gt", "T_le", "T_ge",
    "F_eq", "F_ne", "F_lt", "F_gt", "F_le", "F_ge"};
void pr_stm(std::ostream &out, T_stm stm, int d)
{
    if (!stm)
        return;
    if (d == 50000)
        cat_used_memory();
    switch (stm->kind)
    {
    case T_SEQ:
        indent(out, d);
        out << "T_Seq(\n";
        pr_stm(out, stm->SEQ.left, d + 1);
        out << ",\n";
        pr_stm(out, stm->SEQ.right, d + 1);
        out << ")";
        break;
    case T_LABEL:
        indent(out, d);
        out << "T_Label(Temp_namedlabel(\"" << (stm->LABEL) << "\"))";
        break;
    case T_JUMP:
        indent(out, d);
        out << "T_Jump(";
        out << "Temp_namedlabel(\"" << stm->JUMP.jump << ")";
        out << ")";
        break;
    case T_CJUMP:
        indent(out, d);
        out << "T_Cjump(" << rel_oper[stm->CJUMP.op] << ",\n";
        pr_tree_exp(out, stm->CJUMP.left, d + 1);
        out << ",\n";
        pr_tree_exp(out, stm->CJUMP.right, d + 1);
        out << ",\n";
        indent(out, d + 1);
        out << "Temp_namedlabel(\"" << stm->CJUMP.t << "\"),";
        out << "Temp_namedlabel(\"" << stm->CJUMP.f << "\")";
        out << ")";
        break;
    case T_MOVE:
        indent(out, d);
        out << "T_Move(\n";
        pr_tree_exp(out, stm->MOVE.dst, d + 1);
        out << ",\n";
        pr_tree_exp(out, stm->MOVE.src, d + 1);
        out << ")";
        break;
    case T_EXP:
        indent(out, d);
        out << "T_Exp(\n";
        pr_tree_exp(out, stm->EXP, d + 1);
        out << ")";
        break;
    case T_RETURN:
        indent(out, d);
        out << "T_Return(\n";
        pr_tree_exp(out, stm->EXP, d + 1);
        out << ")";
        break;
    }
}

static void pr_templist(std::ostream &out, Temp_tempList tl, int d)
{
    indent(out, d);
    if (!tl)
    {
        out << "NULL";
        return;
    }
    out << "Temp_TempList(";
    out << "\"t" << tl->head->num << "\"";
    tl = tl->tail;
    if (tl)
        out << ",\n";
    else
        out << ", ";
    pr_templist(out, tl, d);
    out << ")";
    return;
}

static void pr_explist(std::ostream &out, T_expList el, int d)
{
    if (!el)
    {
        out << "NULL";
        return;
    }
    indent(out, d);
    out << "T_ExpList(";
    pr_tree_exp(out, el->head, -1);
    el = el->tail;
    if (el)
        out << ",\n";
    else
        out << ", ";
    pr_explist(out, el, d);
    out << ")";
    return;
}

void pr_tree_exp(std::ostream &out, T_exp exp, int d)
{
    if (!exp)
        return;

    switch (exp->kind)
    {
    case T_BINOP:
        indent(out, d);
        out << "T_Binop(" << bin_oper[exp->BINOP.op] << ",\n";
        pr_tree_exp(out, exp->BINOP.left, d + 1);
        out << ",\n";
        pr_tree_exp(out, exp->BINOP.right, d + 1);
        out << ")";
        break;
    case T_MEM:
        indent(out, d);
        out << "T_Mem";
        out << "(\n";
        pr_tree_exp(out, exp->MEM, d + 1);
        out << ")";
        break;
    case T_TEMP:
        indent(out, d);
        out << "T_Temp(\"t" << exp->TEMP->num << "\")";
        break;
    case T_ESEQ:
        indent(out, d);
        out << "T_Eseq(\n";
        pr_stm(out, exp->ESEQ.stm, d + 1);
        out << ",\n";
        pr_tree_exp(out, exp->ESEQ.exp, d + 1);
        out << ")";
        break;
    case T_NAME:
        indent(out, d);
        out << "T_Name(Temp_namedlabel(\"" << exp->NAME.label << "\"))";
        break;
    case T_CONST:
        indent(out, d);
        out << "T_Const(" << exp->ICONST << ")";
        break;
    case T_FCONST:
        indent(out, d);
        out << "T_FConst(" << exp->FCONST << ")";
        break;
    case T_CALL:
    {
        T_expList args = exp->CALL.args;
        indent(out, d);
        out << "T_Call(\"" << exp->CALL.id << "\",\n";
        if (args)
            pr_explist(out, args, d);
        else
            out << "NULL)";
        out << ")";
    }
    break;
    default:
        assert(0);
    } /* end of switch */
}

void printStmList(std::ostream &out, T_stmList stmList, int d)
{
    T_stmList l = stmList;
    if (l)
    {
        indent(out, d);
        out << "T_StmList(\n";
        pr_stm(out, l->head, d);
        l = l->tail;
        if (l)
            out << ",\n";
        printStmList(out, l, d);
        out << ")";
    }
    else
    {
        indent(out, d);
        out << ", NULL";
    }
    return;
}

void printFuncDecl(std::ostream &out, T_funcDecl funcDecl)
{
    if (!funcDecl)
        return;
    Temp_tempList t = funcDecl->args;
    T_stm sl = funcDecl->stm;

    out << "T_FuncDecl(\"" << funcDecl->name << "\",\n";

    if (t)
        pr_templist(out, t, 0);
    else
    {
        out << "NULL";
    }

    out << ",\n";

    if (sl)
    {
        pr_stm(out, sl, 0);
    }
    else
        out << " NULL";

    out << ")";
    return;
}

void printFuncDeclList(std::ostream &out, T_funcDeclList funcDeclList)
{
    T_funcDeclList l = funcDeclList;
    if (l)
    {
        out << "T_FuncDeclList(\n";
        printFuncDecl(out, l->head);
        l = l->tail;
        out << ",\n";
        printFuncDeclList(out, l);
        out << ")";
    }
    else
    {
        out << "NULL\n";
    }
    return;
}
