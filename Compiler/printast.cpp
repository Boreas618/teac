#include <iostream>
#include <fstream>
#include "printast.h"
#include "ast.h"

namespace printast
{
void printProg(std::ostream &os,A_prog p)
{
    if( p == nullptr) return;
    A_compUnitList cul = p->cul;
    while (cul != nullptr)
    {
        A_compUnit cu = cul->head;
        printCompUnit(os,cu);
        cul = cul->tail;
    }
}

void printCompUnit(std::ostream &os,A_compUnit cu)
{
    if(cu == nullptr) return;
    switch (cu->kind)
    {
    case A_compUnit_::comp_decl:
    {
        printDecl(os,cu->u.d);
        break;
    }
    case A_compUnit_::comp_func:
    {
        printFuncDef(os,cu->u.fd);
        break;
    }
    default:
        break;
    }
}

void printDecl(std::ostream &os,A_decl d)
{
    if(d == nullptr) return;
    switch (d->kind)
    {
    case A_decl_::constDecl:
    {
        printConstDecl(os,d->u.cd);
        break;
    }
    case A_decl_::varDecl:
    {
        printVarDecl(os,d->u.vd);
        break;
    }
    default:
        break;
    }
}

void printConstDecl(std::ostream &os,A_constDecl cd)
{
    if(cd == nullptr) return;
    os << "const ";
    printFuncType(os,cd->type);
    os << " ";
    A_constDefList cdl = cd->cdl;
    bool init = true;
    while (cdl != nullptr)
    {
        if(!init)
        {
            os << ",";
        }
        init = false;
        A_constDef head = cdl->head;
        printConstDef(os,head);
        cdl = cdl->tail;
    }
    os << ";\n";
}

void printVarDecl(std::ostream &os,A_varDecl vd)
{
    if(vd == nullptr) return;
    printFuncType(os,vd->type);
    os << " ";
    A_varDefList vdl = vd->vdl;
    bool init = true;
    while (vdl != nullptr)
    {
        if(!init)
        {
            os << ",";
        }
        init = false;
        A_varDef head = vdl->head;
        printVarDef(os,head);
        vdl = vdl->tail;
    }
    os << ";\n";
}

void printFuncDef(std::ostream &os,A_funcDef fd)
{
    if(fd == nullptr) return;
    printFuncType(os,fd->type);
    os << " ";
    os << fd->v;
    os << "(";
    printFuncFParams(os,fd->ffp);
    os << ")\n";
    printBlock(os,fd->b);
}

void printFuncType(std::ostream &os,enum A_funcType type)
{
    switch (type)
    {
    case A_funcType::f_int:
    {
        os << "int";
        break;
    }
    case A_funcType::f_float:
    {
        os << "float";
        break;
    }
    case A_funcType::f_void:
    {
        os << "void";
        break;
    }
    default:
        break;
    }
}

void printConstDef(std::ostream &os,A_constDef cd)
{
    if(cd == nullptr) return;
    os << cd->id;
    A_expList el = cd->cel;
    while (el != nullptr)
    {
        A_exp e = el->head;
        os << "[";
        printExp(os,e);
        os << "]";
        el = el->tail;
    }
    os << " = ";
    printInitVal(os,cd->iv);
}

void printVarDef(std::ostream &os,A_varDef vd)
{
    if(vd == nullptr) return;
    os << vd->id;
    A_expList el = vd->cel;
    while (el != nullptr)
    {
        A_exp e = el->head;
        os << "[";
        printExp(os,e);
        os << "]";
        el = el->tail;
    }
    if(vd->iv)
    {
        os << " = ";
        printInitVal(os,vd->iv);
    }
}

void printExp(std::ostream &os,A_exp e)
{
    if(e == nullptr) return;
    switch (e->kind)
    {
    case A_idExp:
    {
        os << e->u.v;
        break;
    }
    case A_intConst:
    {
        os << e->u.inum;
        break;
    }
    case A_floatConst:
    {
        os << e->u.fnum;
        break;
    }
    case A_notExp:
    {
        os << "!";
        printExp(os,e->u.e);
        break;
    }
    case A_opExp:
    {
        printExp(os,e->u.op.left);
        switch (e->u.op.oper)
        {
        case A_plus:
        {
            os << " + ";
            break;
        }
        case A_minus:
        {
            os << " - ";
            break;
        }
        case A_times:
        {
            os << " * ";
            break;
        }
        case A_div:
        {
            os << " / ";
            break;
        }
        case A_mod:
        {
            os << " % ";
            break;
        }
        case A_and:
        {
            os << " && ";
            break;
        }
        case A_or:
        {
            os << " || ";
            break;
        }
        case A_le:
        {
            os << " <= ";
            break;
        }
        case A_less:
        {
            os << " < ";
            break;
        }
        case A_ge:
        {
            os << " >= ";
            break;
        }
        case A_greater:
        {
            os << " > ";
            break;
        }
        case A_eq:
        {
            os << " == ";
            break;
        }
        case A_ne:
        {
            os << " != ";
            break;
        }
        default:
            break;
        }
        printExp(os,e->u.op.right);
        break;
    }
    case A_arrayExp:
    {
        printExp(os,e->u.array_pos.arr);
        A_expList el = e->u.array_pos.arr_pos;
        while (el != nullptr)
        {
            A_exp head = el->head;
            os << '[';
            printExp(os,head);
            os << ']';
            el = el->tail;
        }
        break;
    }
    case A_callExp:
    {
        os << e->u.call.fun;
        os << "(";
        A_expList el = e->u.call.el;
        bool init = true;
        while (el != nullptr)
        {
            if(!init)
            {
                os << ",";
            }
            init = false;
            A_exp head = el->head;
            printExp(os,head);
            el = el->tail;
        }
        os << ")";
        break;
    }
    case A_minusExp:
    {
        os << "-";
        printExp(os,e->u.e);
        break;
    }
    case A_getch:
    {
        os << "getch()";
        break;
    }
    case A_getint:
    {
        os << "getint()";
        break;
    }
    case A_getfloat:
    {
        os << "getfloat()";
        break;
    }
    case A_getarray:
    {
        os << "getarray(";
        printExp(os,e->u.e);
        os << ")";
        break;
    }
    case A_getfarray:
    {
        os << "getfarray(";
        printExp(os,e->u.e);
        os << ")";
        break;
    }
    default:
        break;
    }
}

void printInitVal(std::ostream &os,A_initVal iv)
{
    if(iv == nullptr)
    {
        return;
    }
    switch (iv->kind)
    {
    case A_initVal_::init_exp:
    {
        printExp(os,iv->u.e);
        break;
    }
    case A_initVal_::init_array:
    {
        printArrayInit(os,iv->u.ai);
        break;
    }
    default:
        break;
    }
}

void printArrayInit(std::ostream &os,A_arrayInit ai)
{
    if(ai == nullptr) return;
    os << "{";
    A_initValList ivl = ai->ivl;
    bool init = true;
    while (ivl != nullptr)
    {
        if(!init)
        {
            os << ",";
        }
        init = false;
        A_initVal iv = ivl->head;
        printInitVal(os,iv);
        ivl = ivl->tail;
    }
    os << "}";
}

void printFuncFParams(std::ostream &os,A_funcFParams ffp)
{
    if(ffp == nullptr) return;
    A_funcFParamList ffpl = ffp->ffpl;
    bool init = true;
    while (ffpl != nullptr)
    {
        if(!init)
        {
            os << ",";
        }
        init = false;
        A_funcFParam head = ffpl->head;
        printFuncFParam(os,head);
        ffpl = ffpl->tail;
    }
}

void printFuncFParam(std::ostream &os,A_funcFParam ffp)
{
    if(ffp == nullptr) return;
    printFuncType(os,ffp->type);
    os << " ";
    os << ffp->id;
    A_expList el = ffp->el;
    if(ffp->is_arr)
    {
        os << "[]";
    }
    while (el != nullptr)
    {
        A_exp head = el->head;
        os << "[";
        printExp(os,head);
        os << "]";
        el = el->tail;
    }  
}

void printBlock(std::ostream &os,A_block b)
{
    if(b == nullptr) return;
    os << "{\n";
    A_blockItemList bil = b->bil;
    while (bil != nullptr)
    {
        A_blockItem head = bil->head;
        printBlockItem(os,head);
        bil = bil->tail;
    }
    os << "}\n";
}

void printBlockItem(std::ostream &os,A_blockItem bi)
{
    if(bi == nullptr) return;
    switch (bi->kind)
    {
    case A_blockItem_::b_decl:
    {
        printDecl(os,bi->u.d);
        break;
    }
    case A_blockItem_::b_stmt:
    {
        printStmt(os,bi->u.s);
        break;
    }
    default:
        break;
    }
}

void printStmt(std::ostream &os,A_stmt s)
{
    if(s == nullptr) return;
    switch (s->kind)
    {
    case A_blockStm:
    {
        printBlock(os,s->u.b);
        break;
    }
    case A_ifStm:
    {
        os << "if(";
        printExp(os,s->u.if_stat.e);
        os << ")\n";
        printStmt(os,s->u.if_stat.s1);
        if(s->u.if_stat.s2)
        {
            os << "else\n";
            printStmt(os,s->u.if_stat.s2);
        }
        break;
    }
    case A_whileStm:
    {
        os << "while(";
        printExp(os,s->u.while_stat.e);
        os << ")\n";
        printStmt(os,s->u.while_stat.s);
        break;
    }
    case A_assignStm:
    {
        printExp(os,s->u.assign.arr);
        os << " = ";
        printExp(os,s->u.assign.value);
        os << ";\n";
        break;
    }
    case A_callStm:
    {
        os << s->u.call_stat.fun;
        os << "(";
        A_expList el = s->u.call_stat.el;
        bool init = true;
        while (el != nullptr)
        {
            if(!init)
            {
                os << ",";
            }
            init = false;
            A_exp head = el->head;
            printExp(os,head);
            el = el->tail;
        }
        os << ");\n";
        break;
    }
    case A_continue:
    {
        os << "continue;\n";
        break;
    }
    case A_break:
    {
        os << "break;\n";
        break;
    }
    case A_return:
    {
        os << "return";
        if(s->u.e)
        {
            os << " ";
            printExp(os,s->u.e);
        }
        os << ";\n";
        break;
    }
    case A_expStm:
    {
        if(s->u.e)
        {
            os << " ";
            printExp(os,s->u.e);
        }
        os << ";\n";
        break;
    }
    case A_putch:
    {
        os << "putch(";
        printExp(os,s->u.e);
        os << ");\n";
        break;
    }
    case A_putint:
    {
        os << "putint(";
        printExp(os,s->u.e);
        os << ");\n";
        break;
    }
    case A_putfloat:
    {
        os << "putfloat(";
        printExp(os,s->u.e);
        os << ");\n";
        break;
    }
    case A_putf:
    {
        break;
    }
    case A_putarray:
    {
        os << "putarray(";
        printExp(os,s->u.putarray.e1);
        os << ",";
        printExp(os,s->u.putarray.e2);
        os << ");\n";
        break;
    }
    case A_putfarray:
    {
        os << "putfarray(";
        printExp(os,s->u.putarray.e1);
        os << ",";
        printExp(os,s->u.putarray.e2);
        os << ");\n";
        break;
    }
    case A_starttime:
    {
        os << "starttime();\n";
        break;
    }
    case A_stoptime:
    {
        os << "stoptime();\n";
        break;
    }
    default:
        break;
    }
}

}