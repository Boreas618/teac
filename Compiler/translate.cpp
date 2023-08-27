#include "translate.hpp"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <sstream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include "ast.h"
#include "loopunroll.hpp"
#include "prtreep.hpp"
#include "treep.hpp"
#include "my_map.hpp"

#define TR_DEBUG
#undef TR_DEBUG // comment it if debug
extern int SEM_ARCH_SIZE;
extern std::string filename;
bool needpcache;
bool lpunrollflag;
bool usefloat;

/* patchList */
struct funcinfo
{
    Temp_label_front name;
    Temp_label_front label;
    std::vector<TY::Type *> param;
    std::vector<Temp_temp> funcvec;
    std::unordered_set<std::string> inarrvar;
};
struct funcinfo nowfunc;

Table::Stable<TY::Entry *> *venv;
Table::Stable<TY::EnFunc *> *fenv;

std::unordered_map<std::string, std::unordered_set<std::string>> funcgraph;
std::unordered_map<std::string, std::vector<std::string>> functable;
std::unordered_set<std::string> impure_func;
std::unordered_set<std::string> impureset;
std::set<Temp_label_front> globalarr;
std::unordered_map<std::string, int> idxvalue;
std::unordered_map<std::string, std::vector<std::string>> funcexplist;
std::unordered_map<std::string, bool> voidarr;
std::unordered_map<std::string, int> curtime;

bool idxflag;
std::string idxname;

std::unordered_map<std::string, constvar> globalconst;

typedef struct patchList_ *patchList;
struct patchList_
{
    Temp_label_front *head;
    patchList tail;
};
static patchList PatchList(Temp_label_front *head, patchList tail)
{
    patchList p = (patchList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

void doPatch(patchList pl, Temp_label_front tl)
{
    for (; pl; pl = pl->tail)
        *(pl->head) = tl;
}

patchList joinPatch(patchList first, patchList second)
{
    if (!first)
        return second;
    if (!second)
        return first;
    patchList tmp = first;
    while (tmp->tail)
        tmp = tmp->tail;
    tmp->tail = second;
    return first;
}

/* Tr_exp */

typedef struct Cx_ *Cx;

struct Cx_
{
    patchList trues;
    patchList falses;
    T_stm stm;
};

enum class Tr_ty
{
    Tr_ex,
    Tr_nx,
    Tr_cx
};
struct Tr_exp_
{
    Tr_ty kind;
    union
    {
        T_exp ex;
        T_stm nx;
        Cx cx;
    } u;
};

void changeFunc(std::string oldfunc, std::string newfunc)
{
    TY::EnFunc *func = fenv->look(oldfunc);
    func->label = newfunc;
    fenv->enter(newfunc, func);
}
void newpure(std::string oldfunc, std::string newfunc)
{
    if (impure_func.find(oldfunc) != impure_func.end())
        impure_func.insert(newfunc);
}

static Tr_exp Tr_Ex(T_exp ex)
{
    Tr_exp exp = (Tr_exp)checked_malloc(sizeof(*exp));
    exp->kind = Tr_ty::Tr_ex;
    exp->u.ex = ex;
    return exp;
}

static Tr_exp Tr_Nx(T_stm nx)
{
    Tr_exp exp = (Tr_exp)checked_malloc(sizeof(*exp));
    exp->kind = Tr_ty::Tr_nx;
    exp->u.nx = nx;
    return exp;
}

static Tr_exp Tr_Cx(patchList trues, patchList falses, T_stm stm)
{
    Tr_exp exp = (Tr_exp)checked_malloc(sizeof(*exp));
    exp->kind = Tr_ty::Tr_cx;
    exp->u.cx = (Cx)checked_malloc(sizeof(*(exp->u.cx)));
    exp->u.cx->trues = trues;
    exp->u.cx->falses = falses;
    exp->u.cx->stm = stm;
    return exp;
}

static T_exp unEx(Tr_exp exp)
{
    if (!exp)
        return NULL;
    assert(exp);
    switch (exp->kind)
    {
    case Tr_ty::Tr_ex:
        return exp->u.ex;
    case Tr_ty::Tr_cx:
    {
        Temp_temp r = Temp_newtemp();
        Temp_label_front t = Temp_newlabel_front();
        Temp_label_front f = Temp_newlabel_front();
        Temp_label_front e = Temp_newlabel_front();
        doPatch(exp->u.cx->trues, t);
        doPatch(exp->u.cx->falses, f);
        return T_Eseq(
            T_Seq(exp->u.cx->stm,
                  T_Seq(T_Label(t),
                        T_Seq(T_Move(T_Temp(r), T_Const(1)),
                              T_Seq(T_Jump(e),
                                    T_Seq(T_Label(f),
                                          T_Seq(T_Move(T_Temp(r), T_Const(0)),
                                                T_Label(e))))))),
            T_Temp(r));
    }
    case Tr_ty::Tr_nx:
        return T_Eseq(exp->u.nx, T_Const(0));
    default:
        assert(0);
    }
}

static T_stm unNx(Tr_exp exp)
{
    if (!exp)
        return NULL;
    switch (exp->kind)
    {
    case Tr_ty::Tr_ex:
        return T_Exp(exp->u.ex);
    case Tr_ty::Tr_cx:
    {
        Temp_temp r = Temp_newtemp();
        Temp_label_front t = Temp_newlabel_front();
        Temp_label_front f = Temp_newlabel_front();
        Temp_label_front e = Temp_newlabel_front();
        doPatch(exp->u.cx->trues, t);
        doPatch(exp->u.cx->falses, f);
        return T_Seq(
            exp->u.cx->stm,
            T_Seq(T_Label(t),
                  T_Seq(T_Move(T_Temp(r), T_Const(1)),
                        T_Seq(T_Jump(e),
                              T_Seq(T_Label(f),
                                    T_Seq(T_Move(T_Temp(r), T_Const(0)),
                                          T_Seq(T_Label(e), T_Exp(T_Temp(r)))))))));
    }
    case Tr_ty::Tr_nx:
        return exp->u.nx;
    default:
        assert(0);
    }
}

static Cx unCx(Tr_exp exp, TY::tyType type)
{
    if (!exp)
        return NULL;
    switch (exp->kind)
    {
    case Tr_ty::Tr_ex:
    {
        T_stm stm = NULL;
        if (type == TY::tyType::Ty_float)
            stm = T_Cjump(F_ne, unEx(exp), T_FConst(0), "", "");
        else
            stm = T_Cjump(T_ne, unEx(exp), T_Const(0), "", "");
        patchList trues = PatchList(&stm->CJUMP.t, NULL);
        patchList falses = PatchList(&stm->CJUMP.f, NULL);
        Tr_exp cx = Tr_Cx(trues, falses, stm);
        return cx->u.cx;
    }
    case Tr_ty::Tr_cx:
        return exp->u.cx;
    default:
        assert(0);
    }
    return NULL;
}
std::pair<bool, int> getidxinit(std::string v)
{
    if (idxvalue.find(v) != idxvalue.end())
        return {true, idxvalue[v]};
    return {false, 0};
}
void syfuncInsert()
{
    const char types[] = "if";
    const int types_count = 2;
    auto inttype = TY::intType(new int(0), false);
    auto floattype = TY::floatType(new float(0), false);
    auto voidtype = TY::voidType();

    fenv->enter("__built__in__sy_f_get",
                new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>()), "__built__in__sy_f_get"));
    fenv->enter("__built__in__sy_i_get",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "__built__in__sy_i_get"));
    fenv->enter("__built__in__sy_f_init",
                new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>()), "__built__in__sy_f_init"));
    fenv->enter("__built__in__sy_i_init",
                new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>()), "__built__in__sy_i_init"));

    impure_func.insert("__built__in__sy_f_get");
    impure_func.insert("__built__in__sy_i_get");
    impure_func.insert("__built__in__sy_i_init");
    impure_func.insert("__built__in__sy_f_init");

    TY::Type *vartype[] = {inttype, floattype};
    for (int length = 2; length <= 4; length++)
    {
        for (int bitmask = 0; bitmask < (1 << length); bitmask++)
        {
            int temp = bitmask;
            std::vector<TY::Type *> paramvec = {inttype};
            int index = temp & 1;
            auto returntype = vartype[index];
            std::string findname = "__built__in__sy_";
            std::string setname = "__built__in__sy_";
            findname += types[index];
            setname += types[index];
            findname += "_";
            setname += "_";
            temp >>= 1;

            for (int i = 1; i < length; i++)
            {
                index = temp & 1;
                findname += types[index];
                setname += types[index];
                paramvec.push_back(vartype[index]);
                temp >>= 1;
            }
            findname += "_find";
            setname += "_set";

            fenv->enter(findname, new TY::EnFunc(TY::funcType(inttype, paramvec), findname));
            paramvec.push_back(returntype);
            fenv->enter(setname, new TY::EnFunc(TY::funcType(voidtype, paramvec), setname));
            impure_func.insert(findname);
            impure_func.insert(setname);
            // std::cout << findname << std::endl
            //           << setname << std::endl;
        }
    }
}
static void dfs(std::string node)
{
    if (impure_func.find(node) == impure_func.end())
    {
        impure_func.insert(node);
        auto edge = funcgraph[node];
        for (auto &i : edge)
        {
            dfs(i);
        }
    }
}
bool isglobalarr(std::string name)
{
    return globalarr.find(name) != globalarr.end();
}
bool ispure(std::string name)
{
    return impure_func.find(name) == impure_func.end();
}
bool ispurecache(std::string name)
{
    if (!ispure(name))
        return false;
    std::vector<std::string> vec = functable[name];
    if (vec.size() == 1 && vec[0] == name)
        return true;
    return false;
    for (auto &i : vec)
    {
        if (i != name)
            return false;
    }
    return true;
}
std::vector<A_exp> leafvar;
int lvalcount;
bool handleleaf(A_exp &exp, string name, A_binop op)
{
    if (exp->kind == A_callExp)
        return false;
    if (exp->kind == A_opExp)
    {
        if (exp->u.op.oper != op)
            return false;
        return handleleaf(exp->u.op.left, name, op) && handleleaf(exp->u.op.right, name, op);
    }
    // if (exp->kind == A_idExp)
    // {
    if (exp->kind == A_idExp && !strcmp(exp->u.v, name))
        lvalcount++;
    else
        leafvar.push_back(exp);
    return true;
    // }
}
static A_exp handlervalue(A_exp exp, string name)
{
    leafvar = std::vector<A_exp>();
    lvalcount = 0;
    if (exp->kind != A_opExp)
        return exp;
    A_binop op = exp->u.op.oper;
    if (op != A_plus && op != A_times)
        return exp;
    if (!handleleaf(exp, name, op))
        return exp;
    // printf("total lval:%d\n", lvalcount);
    A_exp ret = NULL;
    if (leafvar.size() == 0)
        return exp;
    if (leafvar.size() == 1 && lvalcount == 0)
        return exp;
    if (leafvar.size() == 1 && lvalcount >= 0)
    {
        lvalcount--;
        ret = A_OpExp(exp->pos, leafvar[0], op, A_IdExp(exp->pos, name));
        while (lvalcount)
        {
            lvalcount--;
            ret = A_OpExp(exp->pos, ret, op, A_IdExp(exp->pos, name));
        }
        return ret;
    }
    ret = A_OpExp(exp->pos, leafvar[0], op, leafvar[1]);
    for (int i = 2; i < leafvar.size(); i++)
    {
        ret = A_OpExp(exp->pos, ret, op, leafvar[i]);
    }
    while (lvalcount)
    {
        lvalcount--;
        ret = A_OpExp(exp->pos, ret, op, A_IdExp(exp->pos, name));
    }
    return ret;
}
static void handlePurefunc()
{
    for (auto &i : funcgraph)
    {
        for (auto &j : i.second)
        {
            if (functable.find(j) == functable.end())
            {
                functable[j] = std::vector<std::string>();
            }
            functable[j].emplace_back(i.first);
        }
    }
    for (auto &i : impureset)
        dfs(i);
    impure_func.insert("1_arr");
    impure_func.insert("1_memset");
    impure_func.insert("1_i2f");
    impure_func.insert("1_f2i");
    impure_func.insert("getint");
    impure_func.insert("getch");
    impure_func.insert("getfloat");
    impure_func.insert("getarray");
    impure_func.insert("getfarray");
    impure_func.insert("putint");
    impure_func.insert("putch");
    impure_func.insert("putarray");
    impure_func.insert("putfarray");
    impure_func.insert("putfloat");
    impure_func.insert("putf");
    impure_func.insert("_sysy_starttime");
    impure_func.insert("_sysy_stoptime");

    // impure_func.insert("__built__in__sy_f_f_set");
    // impure_func.insert("__built__in__sy_f_f_find");
    // impure_func.insert("__built__in__sy_f_fff_set");
    // impure_func.insert("__built__in__sy_f_fff_find");
}
static void purejudge(A_exp lval)
{
    assert(lval);

    // if (lval->kind == A_arrayExp)
    // {
    //     assert(lval->u.array_pos.arr && lval->u.array_pos.arr->u.v);
    //     TY::Entry *item = venv->look(lval->u.array_pos.arr->u.v);
    //     if (item->kind == TY::tyEntry::Ty_global)
    //         impureset.insert(nowfunc.name);
    //     if (nowfunc.inarrvar.find(lval->u.array_pos.arr->u.v) != nowfunc.inarrvar.end())
    //         impureset.insert(nowfunc.name);
    // }
    // else
    if (lval->kind == A_idExp)
    {
        assert(lval->u.v);
        TY::Entry *item = venv->look(lval->u.v);
        if (item->kind == TY::tyEntry::Ty_global)
        {
            Temp_label_front label = static_cast<TY::GloVar *>(item)->label;
            if (globalconst.find(label) != globalconst.end())
            {
                globalconst.erase(label);
            }
            impureset.insert(nowfunc.name);
        }
    }
    return;
}
int string_f2i(char *str)
{
    float result = std::stof(str);
    return (int)result;
}
float string2f(char *str) { return std::stof(str); }
int f2i(float f) { return (int)f; }
float i2f(int i) { return (float)i; }
T_exp T_i2f(T_exp exp)
{
    usefloat = true;
    if (exp->kind == T_FCONST)
        return T_FConst((float)exp->ICONST);
    else
        return T_Call("1_i2f", T_ExpList(exp, NULL));
}
T_exp T_f2i(T_exp exp)
{
    usefloat = true;
    if (exp->kind == T_FCONST)
        return T_Const((int)exp->FCONST);
    else
        return T_Call("1_f2i", T_ExpList(exp, NULL));
}
static T_exp TyAssign(T_exp rexp, TY::tyType lty, TY::tyType rty)
{
    // printf("here\n");
    if (lty == TY::tyType::Ty_float && rty == TY::tyType::Ty_int)
    {
        // printf("here1\n");
        return T_i2f(rexp);
    }
    else if (lty == TY::tyType::Ty_int && rty == TY::tyType::Ty_float)
    {
        // printf("here2\n");
        return T_f2i(rexp);
    }
    else
        return rexp;
}
int fencode(float *f)
{
    return *(int *)f;
}
A_expList convertExpl(A_expList orig)
{
    if (!orig)
        return NULL;
    int k = 0;
    A_expList ret = NULL;
    for (auto i = orig; i != NULL; i = i->tail)
    {
        // printf("iter: %d\n", k++);
        if (!ret)
            ret = A_ExpList(i->head, NULL);
        else
            ret = A_ExpList(i->head, ret);
    }
    return ret;
}
void handleLibFunc_llvm(std::ostringstream *libFunc)
{
    *libFunc << "declare i32 @getint()\n";
    *libFunc << "declare i32 @getch()\n";
    *libFunc << "declare float @getfloat()\n";
    *libFunc << "declare i32 @getarray(i32*)\n";
    *libFunc << "declare i32 @getfarray(float*)\n";
    *libFunc << "declare void @putint(i32)\n";
    *libFunc << "declare void @putch(i32)\n";
    *libFunc << "declare void @putarray(i32, i32*)\n";
    *libFunc << "declare void @putfloat(float)\n";
    *libFunc << "declare void @putfarray(i32, float*)\n";
    *libFunc << "declare void @putf(i8*, ...)\n";
    *libFunc << "declare void @llvm.va_start(i8*)\n";
    *libFunc << "declare void @llvm.va_end(i8*)\n";
    *libFunc << "declare void @before_main()\n";
    *libFunc << "declare void @after_main()\n";
    *libFunc << "declare void @_sysy_starttime(i32)\n";
    *libFunc << "declare void @_sysy_stoptime(i32)\n";
    *libFunc << "declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i32, i1 immarg)\n";
    return;
}
void handleGlobalVar_llvm(std::ostringstream *globalVar, std::ostringstream *globalArray)
{
    for (auto it = venv->begin(); it != venv->end(); ++it)
    {
        TY::Entry *entry = venv->look(it->first);
        // std::cout << it->first << std::endl;
        assert(entry);
        assert(entry->kind == TY::tyEntry::Ty_global);
        if (entry->ty->isconst)
        {
            assert(entry->ty->kind != TY::tyType::Ty_array);
            continue; // const
        }
        Temp_label_front name = static_cast<TY::GloVar *>(entry)->label;
        switch (entry->ty->kind)
        {
        case TY::tyType::Ty_int:
        {
            assert(entry->ty->ivalue);
            *globalVar << "@" + name + " = " + "dso_local global i32 " + std::to_string(*entry->ty->ivalue) + ", align 4" << std::endl;
        }
        break;
        case TY::tyType::Ty_float:
        {
            assert(entry->ty->fvalue);
            *globalVar << "@" + name + " = " + "dso_local global float " + std::to_string(*entry->ty->fvalue) + ", align 4" << std::endl;
        }
        break;
        case TY::tyType::Ty_array:
        { // int
            *globalArray << "@" + name + " = " + "dso_local global ";
            std::string funcsig = "{";
            std::string initval = "{";
            if (entry->ty->fvalue)
            {
                int zerocount = 0;
                for (int i = 0; i < entry->ty->arraysize; i++)
                {
                    if (entry->ty->fvalue[i] == 0)
                    {
                        zerocount++;
                        continue;
                    }
                    else
                    {
                        if (zerocount >= 2)
                        {
                            funcsig = funcsig + "[" + std::to_string(zerocount) + " x " + "float" + "] , ";
                            initval = initval + "[" + std::to_string(zerocount) + " x " + "float" + "]" + " zeroinitializer , ";
                        }
                        else if (zerocount == 1)
                        {
                            funcsig = funcsig + "float , ";
                            initval = initval + "float " + "0.000000e+00" + " , ";
                        }
                        funcsig = funcsig + "float , ";
                        initval = initval + "float " + std::to_string(entry->ty->fvalue[i]);
                        if (i + 1 != entry->ty->arraysize)
                        {
                            funcsig = funcsig + " , ";
                            initval = initval + " , ";
                        }
                        zerocount = 0;
                    }
                }
                if (zerocount >= 2)
                {
                    funcsig = funcsig + "[" + std::to_string(zerocount) + " x " + "float" + "] ";
                    initval = initval + "[" + std::to_string(zerocount) + " x " + "float" + "]" + " zeroinitializer";
                }
                else if (zerocount == 1)
                {
                    funcsig = funcsig + "float ";
                    initval = initval + "float " + "0.000000e+00";
                }
                funcsig = funcsig + "} ";
                initval = initval + "} , align 4";
            }
            else
            {
                int zerocount = 0;
                for (int i = 0; i < entry->ty->arraysize; i++)
                {
                    if (entry->ty->ivalue[i] == 0)
                    {
                        zerocount++;
                        continue;
                    }
                    else
                    {
                        if (zerocount >= 2)
                        {
                            funcsig = funcsig + "[" + std::to_string(zerocount) + " x " + "i32" + "] , ";
                            initval = initval + "[" + std::to_string(zerocount) + " x " + "i32" + "]" + " zeroinitializer , ";
                        }
                        else if (zerocount == 1)
                        {
                            funcsig = funcsig + "i32 , ";
                            initval = initval + "i32 " + "0" + " , ";
                        }
                        funcsig = funcsig + "i32";
                        initval = initval + "i32 " + std::to_string(entry->ty->ivalue[i]);
                        if (i + 1 != entry->ty->arraysize)
                        {
                            funcsig = funcsig + " , ";
                            initval = initval + " , ";
                        }
                        zerocount = 0;
                    }
                }
                if (zerocount >= 2)
                {
                    funcsig = funcsig + "[" + std::to_string(zerocount) + " x " + "i32" + "] ";
                    initval = initval + "[" + std::to_string(zerocount) + " x " + "i32" + "]" + " zeroinitializer ";
                }
                else if (zerocount == 1)
                {
                    funcsig = funcsig + "i32 ";
                    initval = initval + "i32 " + "0";
                }
                funcsig = funcsig + "} ";
                initval = initval + "} , align 4\n";
            }
            *globalArray << funcsig << initval;
        }
        break;
        default:
            assert(0);
        }
    }
    return;
}
void handleLibFunc_arm(std::ostringstream *libFunc)
{
    *libFunc << ".extern getint\n";
    *libFunc << ".extern getch\n";
    *libFunc << ".extern getfloat\n";
    *libFunc << ".extern getarray\n";
    *libFunc << ".extern getfarray\n";
    *libFunc << ".extern putint\n";
    *libFunc << ".extern putch\n";
    *libFunc << ".extern putarray\n";
    *libFunc << ".extern putfloat\n";
    *libFunc << ".extern putfarray\n";
    *libFunc << ".extern putf\n";
    *libFunc << ".extern _sysy_starttime\n";
    *libFunc << ".extern _sysy_stoptime\n";
    *libFunc << ".extern memset\n";
    if (needpcache)
        haddleMap(libFunc);
    return;
}
void handleGlobalVar_arm(std::ostringstream *globalVar, std::ostringstream *globalArray)
{
    for (auto it = venv->begin(); it != venv->end(); ++it)
    {
        TY::Entry *entry = venv->look(it->first);
        assert(entry);
        assert(entry->kind == TY::tyEntry::Ty_global);
        if (entry->ty->isconst)
        {
            assert(entry->ty->kind != TY::tyType::Ty_array);
            continue; // const
        }
        Temp_label_front name = static_cast<TY::GloVar *>(entry)->label;
        switch (entry->ty->kind)
        {
        case TY::tyType::Ty_int:
        {
            assert(entry->ty->ivalue);
            *globalVar << "\t.global " + name + "\n";
            *globalVar << "\t.data\n";
            *globalVar << "\t.align 2\n";
            *globalVar << "\t.type " + name + ", %object\n";
            *globalVar << "\t.size " + name + ", 4\n";
            *globalVar << name + ":\n";
            *globalVar << "\t.word\t" + std::to_string(*entry->ty->ivalue) + "\n";
        }
        break;
        case TY::tyType::Ty_float:
        {
            assert(entry->ty->fvalue);
            *globalVar << "\t.global " + name + "\n";
            *globalVar << "\t.data\n";
            *globalVar << "\t.align 2\n";
            *globalVar << "\t.type " + name + ", %object\n";
            *globalVar << "\t.size " + name + ", 4\n";
            *globalVar << name + ":\n";
            *globalVar << "\t.word\t" + std::to_string(fencode(entry->ty->fvalue)) + "\n";
        }
        break;
        case TY::tyType::Ty_array:
        { // int
            if (voidarr.find(it->first) != voidarr.end())
            {
                *globalArray << "\t.global " + name + "\n";
                *globalArray << "\t.bss\n";
                *globalArray << "\t.align 2\n";
                *globalArray << "\t.type " + name + ", %object\n";
                *globalArray << "\t.size " + name + ", " + std::to_string(entry->ty->arraysize * 4) + "\n";
                *globalArray << name + ":\n";
                *globalArray << "\t.space " + std::to_string(entry->ty->arraysize * 4) + "\n";
            }
            else
            {
                *globalArray << "\t.global " + name + "\n";
                *globalArray << "\t.data\n";
                *globalArray << "\t.align 2\n";
                *globalArray << "\t.type " + name + ", %object\n";
                *globalArray << "\t.size " + name + ", " + std::to_string(entry->ty->arraysize * 4) + "\n";
                *globalArray << name + ":\n";
                std::string initval;
                if (entry->ty->fvalue)
                {
                    int zerocount = 0;
                    for (int i = 0; i < entry->ty->arraysize; i++)
                    {
                        if (entry->ty->fvalue[i] == 0)
                        {
                            zerocount++;
                            continue;
                        }
                        else
                        {
                            if (zerocount >= 2)
                            {
                                initval = initval + "\t.space\t" + std::to_string(zerocount * 4) + "\n";
                            }
                            else if (zerocount == 1)
                            {
                                initval = initval + "\t.word\t0\n";
                            }
                            initval = initval + "\t.word\t" + std::to_string(fencode(&entry->ty->fvalue[i])) + "\n";
                            zerocount = 0;
                        }
                    }
                    if (zerocount >= 2)
                    {
                        initval = initval + "\t.space\t" + std::to_string(zerocount * 4) + "\n";
                    }
                    else if (zerocount == 1)
                    {
                        initval = initval + "\t.word\t0\n";
                    }
                    *globalArray << initval;
                }
                else
                {
                    int zerocount = 0;
                    for (int i = 0; i < entry->ty->arraysize; i++)
                    {
                        if (entry->ty->ivalue[i] == 0)
                        {
                            zerocount++;
                            continue;
                        }
                        else
                        {
                            if (zerocount >= 2)
                            {
                                initval = initval + "\t.space\t" + std::to_string(zerocount * 4) + "\n";
                            }
                            else if (zerocount == 1)
                            {
                                initval = initval + "\t.word\t0\n";
                            }
                            initval = initval + "\t.word\t" + std::to_string(entry->ty->ivalue[i]) + "\n";
                            zerocount = 0;
                        }
                    }
                    if (zerocount >= 2)
                    {
                        initval = initval + "\t.space\t" + std::to_string(zerocount * 4) + "\n";
                    }
                    else if (zerocount == 1)
                    {
                        initval = initval + "\t.word\t0\n";
                    }
                    *globalArray << initval;
                }
            }
        }
        break;
        default:
            assert(0);
        }
    }
    return;
}
T_funcDeclList ast2irCompUnitList2(A_compUnitList list, FILE *llvmout, FILE *armout)
{
    venv = new Table::Stable<TY::Entry *>();
    fenv = new Table::Stable<TY::EnFunc *>();
    funcgraph = std::unordered_map<std::string, std::unordered_set<std::string>>();
    functable = std::unordered_map<std::string, std::vector<std::string>>();
    impure_func = std::unordered_set<std::string>();
    impureset = std::unordered_set<std::string>();
    globalarr = std::set<Temp_label_front>();
    idxvalue = std::unordered_map<std::string, int>();
    voidarr = std::unordered_map<std::string, bool>();
    idxflag = 0;
    idxname = "";
    usefloat = false;
    globalconst = std::unordered_map<std::string, constvar>();

    auto inttype = TY::intType(new int(0), false);
    auto floattype = TY::floatType(new float(0), false);
    auto voidtype = TY::voidType();
    if (needpcache)
        syfuncInsert();
    // fenv->enter("__built__in__sy_f_f_set",
    //             new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>{inttype, floattype}), "__built__in__sy_f_f_set"));
    // fenv->enter("__built__in__sy_f_f_find",
    //             new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>{inttype, floattype}), "__built__in__sy_f_f_find"));
    // fenv->enter("__built__in__sy_f_fff_set",
    //             new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>{inttype, floattype, floattype, floattype}), "__built__in__sy_f_fff_set"));
    // fenv->enter("__built__in__sy_f_fff_find",
    //             new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>{inttype, floattype, floattype, floattype}), "__built__in__sy_f_fff_find"));

    fenv->enter("getint",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "getint"));
    fenv->enter("getch", new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "getch"));
    fenv->enter("getfloat",
                new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>()), "getfloat"));
    fenv->enter("getarray",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>(
                                                         1, TY::arrayType(inttype, 1, false))),
                               "getarray"));
    fenv->enter("getfarray",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>(
                                                         1, TY::arrayType(floattype, 1, false))),
                               "getfarray"));
    fenv->enter(
        "putint",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, inttype)), "putint"));
    fenv->enter("putch", new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, inttype)),
                                        "putch"));
    fenv->enter(
        "putfloat",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, floattype)), "putfloat"));
    fenv->enter(
        "putarray",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(
                                                  {inttype, TY::arrayType(inttype, 1, false)})),
                       "putarray"));
    fenv->enter(
        "putfarray",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(
                                                  {inttype, TY::arrayType(floattype, 1, false)})),
                       "putfarray"));
    fenv->enter("_sysy_starttime",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "_sysy_starttime"));
    fenv->enter("_sysy_stoptime", new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "_sysy_stoptime"));

    T_funcDeclList ret, tail;
    ret = tail = NULL;
    for (auto it = list; it != NULL; it = it->tail)
    {
        if (it->head->u.fd && "main" == std::string(it->head->u.fd->v))
        {
            std::ostringstream *llvm_globalVar = new std::ostringstream();
            std::ostringstream *llvm_globalArray = new std::ostringstream();
            std::ostringstream *llvm_libFunc = new std::ostringstream();
            handleGlobalVar_llvm(llvm_globalVar, llvm_globalArray);
            handleLibFunc_llvm(llvm_libFunc);
            std::string llvmprolog = llvm_libFunc->str() + "\n" + llvm_globalVar->str() + "\n" + llvm_globalArray->str();
            fprintf(llvmout, "%s\n", llvmprolog.c_str());

            std::ostringstream *arm_globalVar = new std::ostringstream();
            std::ostringstream *arm_globalArray = new std::ostringstream();
            std::ostringstream *arm_libFunc = new std::ostringstream();
            handleGlobalVar_arm(arm_globalVar, arm_globalArray);
            handleLibFunc_arm(arm_libFunc);
            std::string armprolog = arm_libFunc->str() + arm_globalVar->str() + arm_globalArray->str();
            fprintf(armout, "%s\n", armprolog.c_str());
            handlePurefunc();
        }
        T_funcDeclList list = T_FuncDeclList(ast2irCompUnit(it->head), NULL);
        if (!list)
            continue;
        if (ret == NULL)
            ret = tail = list;
        else
            tail = tail->tail = list;
    }
    return ret;
}
T_funcDeclList ast2irCompUnitList(A_compUnitList list, FILE *llvmout, FILE *armout)
{
    venv = new Table::Stable<TY::Entry *>();
    fenv = new Table::Stable<TY::EnFunc *>();
    idxflag = 0;
    auto inttype = TY::intType(new int(0), false);
    auto floattype = TY::floatType(new float(0), false);
    auto voidtype = TY::voidType();
    fenv->enter("getint",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "getint"));
    fenv->enter("getch", new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "getch"));
    fenv->enter("getfloat",
                new TY::EnFunc(TY::funcType(floattype, std::vector<TY::Type *>()), "getfloat"));
    fenv->enter("getarray",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>(
                                                         1, TY::arrayType(inttype, 1, false))),
                               "getarray"));
    fenv->enter("getfarray",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>(
                                                         1, TY::arrayType(floattype, 1, false))),
                               "getfarray"));
    fenv->enter(
        "putint",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, inttype)), "putint"));
    fenv->enter("putch", new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, inttype)),
                                        "putch"));
    fenv->enter(
        "putfloat",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(1, floattype)), "putfloat"));
    fenv->enter(
        "putarray",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(
                                                  {inttype, TY::arrayType(inttype, 1, false)})),
                       "putarray"));
    fenv->enter(
        "putfarray",
        new TY::EnFunc(TY::funcType(voidtype, std::vector<TY::Type *>(
                                                  {inttype, TY::arrayType(floattype, 1, false)})),
                       "putfarray"));
    fenv->enter("_sysy_starttime",
                new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "_sysy_starttime"));
    fenv->enter("_sysy_stoptime", new TY::EnFunc(TY::funcType(inttype, std::vector<TY::Type *>()), "_sysy_stoptime"));
    T_funcDeclList ret, tail;
    ret = tail = NULL;
    for (auto it = list; it != NULL; it = it->tail)
    {
        if (it->head->u.fd && "main" == std::string(it->head->u.fd->v))
        {
            // std::ostringstream *llvm_globalVar = new std::ostringstream();
            // std::ostringstream *llvm_globalArray = new std::ostringstream();
            // std::ostringstream *llvm_libFunc = new std::ostringstream();
            // handleGlobalVar_llvm(llvm_globalVar, llvm_globalArray);
            // handleLibFunc_llvm(llvm_libFunc);
            // std::string llvmprolog = llvm_libFunc->str() + "\n" + llvm_globalVar->str() + "\n" + llvm_globalArray->str();
            // fprintf(llvmout, "%s\n", llvmprolog.c_str());

            // std::ostringstream *arm_globalVar = new std::ostringstream();
            // std::ostringstream *arm_globalArray = new std::ostringstream();
            // std::ostringstream *arm_libFunc = new std::ostringstream();
            // handleGlobalVar_arm(arm_globalVar, arm_globalArray);
            // handleLibFunc_arm(arm_libFunc);
            // std::string armprolog = arm_libFunc->str() + arm_globalVar->str() + arm_globalArray->str();
            // fprintf(armout, "%s\n", armprolog.c_str());
            handlePurefunc();
        }
        T_funcDeclList list = T_FuncDeclList(ast2irCompUnit(it->head), NULL);
        if (!list)
            continue;
        if (ret == NULL)
            ret = tail = list;
        else
            tail = tail->tail = list;
    }
    // handlePurefunc();
    // for (auto &i : functable)
    // {
    //     if (ispurecache(i.first))
    //         std::cout << "this is global arr: " << i.first << std::endl;
    // }
    return ret;
}
T_funcDecl ast2irCompUnit(A_compUnit unit)
{
    T_funcDecl ret = NULL;
    switch (unit->kind)
    {
    case A_compUnit_::comp_decl:
        switch (unit->u.d->kind)
        {
        case A_decl_::constDecl:
            ast2irConstDecl(unit->u.d->u.cd, "");
            break;
        case A_decl_::varDecl:
            ast2irVarDecl(unit->u.d->u.vd, "");
            break;
        default:
            break;
        }
        break;
    case A_compUnit_::comp_func:
        ret = ast2irFuncDef(unit->u.fd, "", "", "");
        break;
    default:
        break;
    }
    return ret;
}
T_stm ast2irConstDecl(A_constDecl cdl, Temp_label_front name)
{
    T_stm stm = NULL;
    for (auto it = cdl->cdl; it != NULL; it = it->tail)
    {
        stm = make_seq(stm, ast2irConstDef(cdl->type, it->head, name));
    }
    return stm;
}
T_stm ast2irConstDef(A_funcType type, A_constDef cdf, Temp_label_front name)
{
    switch (type)
    {
    case f_int:
    {
        if (cdf->cel)
        {
            // int []
            int offset = 0;
            TY::Type *head = TY::intType(new int(0), false);
            int k = 0;
            for (auto i = convertExpl(cdf->cel); i != NULL; i = i->tail)
            {
                ExpTy expty = ast2irExp(i->head, name);
                // int index = i->head->u.inum;
                // printf("num is : %d\n", i->head->u.inum);

                // assert(expty.ty->ivalue);
                head = TY::arrayType(head, *expty.ty->ivalue, false);
                // printf("--------------\n");
            }
            if (name == "")
            {
                Temp_label_front label = Temp_newlabel_front();
                T_exp exp = T_Name(label, TempType::INT_PTR);
                ExpTy expty = InitcalArray(cdf->iv->u.ai->ivl, exp, 0, head, name);
                venv->enter(cdf->id, new TY::GloVar(expty.ty, label));
                return NULL;
            }
            else
            {
                // local const
                // store in stack
                Temp_temp tmp = Temp_newtemp_int_ptr();
                T_stm cat_stm =
                    T_Move(T_Temp(tmp), T_Call("1_arr", T_ExpList(T_Const(head->arraysize), NULL)));
                T_expList param = (T_expList)checked_malloc(sizeof(*param));
                param->head = T_Temp(tmp);
                param->tail = T_ExpList(T_Const(0),
                                        T_ExpList(T_Const(head->arraysize * 4), NULL));
                cat_stm = make_seq(cat_stm, T_Exp(T_Call("1_memset", param)));
                ExpTy expty = InitcalArray(cdf->iv->u.ai->ivl, T_Temp(tmp), 0, head, name);
                venv->enter(cdf->id, new TY::LocVar(head, tmp));
                return make_seq(cat_stm, T_Exp(unEx(expty.exp)));
            }
        }
        else
        {
            // int
            ExpTy expty = ast2irExp(cdf->iv->u.e, name);
            int *ret = new int(0);
            if (expty.ty->kind == TY::tyType::Ty_float)
            {
                *ret = f2i(*expty.ty->fvalue);
            }
            else
                *ret = *expty.ty->ivalue;
            venv->enter(cdf->id,
                        new TY::GloVar(TY::intType(ret, true), Temp_newlabel_front()));
            return NULL;
        }
    }
    break;
    case f_float:
    {
        usefloat = true;
        if (cdf->cel)
        {
            // float []
            int offset = 0;
            TY::Type *head = TY::floatType(new float(0), false);
            for (auto i = convertExpl(cdf->cel); i != NULL; i = i->tail)
            {
                ExpTy expty = ast2irExp(i->head, name);
                // int index = i->head->u.inum;
                head = TY::arrayType(head, *expty.ty->ivalue, false);
                // head = TY::arrayType(head, index, false);
            }
            if (name == "")
            {
                Temp_label_front label = Temp_newlabel_front();
                T_exp exp = T_Name(label, TempType::FLOAT_PTR);
                ExpTy expty = InitfcalArray(cdf->iv->u.ai->ivl, exp, 0, head, name);
                venv->enter(cdf->id, new TY::GloVar(expty.ty, label));
                return NULL;
            }
            else
            {
                // local const
                Temp_temp tmp = Temp_newtemp_float_ptr();
                T_stm cat_stm =
                    T_Move(T_Temp(tmp), T_Call("1_arr", T_ExpList(T_Const(head->arraysize), NULL)));
                T_expList param = (T_expList)checked_malloc(sizeof(*param));
                param->head = T_Temp(tmp);
                param->tail = T_ExpList(T_Const(0),
                                        T_ExpList(T_Const(head->arraysize * 4), NULL));
                cat_stm = make_seq(cat_stm, T_Exp(T_Call("1_memset", param)));
                ExpTy expty = InitfcalArray(cdf->iv->u.ai->ivl, T_Temp(tmp), 0, head, name);
                venv->enter(cdf->id, new TY::LocVar(head, tmp));
                return make_seq(cat_stm, T_Exp(unEx(expty.exp)));
            }
        }
        else
        {
            // float
            ExpTy expty = ast2irExp(cdf->iv->u.e, name);
            float *ret = new float(0);
            if (expty.ty->kind == TY::tyType::Ty_int)
            {
                *ret = i2f(*expty.ty->ivalue);
            }
            else
                *ret = *expty.ty->fvalue;
            venv->enter(cdf->id,
                        new TY::GloVar(TY::floatType(ret, true), Temp_newlabel_front()));
            return NULL;
        }
    }
    break;
    default:
        break;
    }
    return NULL;
}
T_stm ast2irVarDecl(A_varDecl vdl, Temp_label_front name)
{
    T_stm stm = NULL;
    for (auto it = vdl->vdl; it != NULL; it = it->tail)
    {
        stm = make_seq(stm, ast2irVarDef(vdl->type, it->head, name));
    }
    return stm;
}
T_stm ast2irVarDef(A_funcType type, A_varDef vdf, Temp_label_front name)
{
    // std::cout << name << std::endl;
    // printf("vardef: %s\n", vdf->id);
    switch (type)
    {
    case f_int:
    {
        if (name == "")
        {
            if (vdf->cel)
            {
                // int []
                int offset = 0;
                TY::Type *head = TY::intType(new int(0), false);
                assert(!head->fvalue);
                // printf("vardef: %s\n", vdf->id);
                for (auto i = convertExpl(vdf->cel); i != NULL; i = i->tail)
                {
                    // printf("in-------------------\n");
                    ExpTy expty = ast2irExp(i->head, name);
                    // int index = i->head->u.inum;
                    head = TY::arrayType(head, *expty.ty->ivalue, false);
                }
                Temp_label_front label = Temp_newlabel_front();
                globalarr.insert(std::string(label));
                assert(!head->fvalue);
                if (vdf->iv)
                {
                    // printf("here\n");
                    T_exp exp = T_Name(label, TempType::INT_PTR);
                    ExpTy expty = InitcalArray(vdf->iv->u.ai->ivl, exp, 0, head, name);
                    venv->enter(vdf->id, new TY::GloVar(expty.ty, label));
                    return NULL;
                }
                else
                {
                    // head->show();
                    voidarr[vdf->id] = 0;
                    // head->ivalue = new int(100);
                    head->ivalue = new int[head->arraysize];
                    assert(!head->fvalue);
                    // memset(head->ivalue, 0, head->arraysize * sizeof(int));
                    venv->enter(vdf->id, new TY::GloVar(head, label));
                    return NULL;
                }
            }
            else
            {
                // int
                Temp_label_front label = Temp_newlabel_front();
                constvar *temp = new constvar();
                temp->intvalue = 0;
                globalconst[label] = *temp;
                if (vdf->iv)
                {
                    ExpTy expty = ast2irExp(vdf->iv->u.e, name);
                    int *ret = new int(0);
                    if (expty.ty->kind == TY::tyType::Ty_float)
                    {
                        *ret = f2i(*expty.ty->fvalue);
                    }
                    else
                        *ret = *expty.ty->ivalue;
                    temp->intvalue = *ret;
                    globalconst[label] = *temp;
                    venv->enter(vdf->id,
                                new TY::GloVar(TY::intType(ret, false), label));
                    return NULL;
                }
                else
                {
                    venv->enter(vdf->id, new TY::GloVar(TY::intType(new int(0), false),
                                                        label));
                    return NULL;
                }
            }
        }
        else
        {
            if (vdf->cel)
            {
                // int []
                int offset = 0;
                TY::Type *head = TY::intType(new int(0), false);
                // printf("vardef: %s\n", vdf->id);
                for (auto i = convertExpl(vdf->cel); i != NULL; i = i->tail)
                {
                    ExpTy expty = ast2irExp(i->head, name);
                    // int index = i->head->u.inum;
                    head = TY::arrayType(head, *expty.ty->ivalue, false);
                }
                Temp_temp temp = Temp_newtemp_int_ptr();
                T_stm cat_stm = T_Move(T_Temp(temp),
                                       T_Call("1_arr", T_ExpList(T_Const(head->arraysize), NULL)));
                // Temp_label_front label = Temp_newlabel_front();
                if (vdf->iv)
                {
                    T_expList param = T_ExpList(T_Temp(temp), T_ExpList(
                                                                  T_Const(0), T_ExpList(T_Const(head->arraysize * 4), NULL)));
                    // param->head = T_Temp(temp);
                    // param->tail = T_ExpList(
                    //     T_Const(0), T_ExpList(T_Const(head->arraysize * 4), NULL));
                    cat_stm = make_seq(cat_stm, T_Exp(T_Call("1_memset", param)));
                    ExpTy expty = InitcalArray(vdf->iv->u.ai->ivl, T_Temp(temp), 0, head, name);
                    // printf("vardef: %s\n", vdf->id);
                    venv->enter(vdf->id, new TY::LocVar(head, temp));
                    return make_seq(cat_stm, T_Exp(unEx(expty.exp)));
                }
                else
                {
                    // head->show();
                    head->ivalue = new int[head->arraysize];
                    memset(head->ivalue, 0, head->arraysize * sizeof(int));
                    venv->enter(vdf->id, new TY::LocVar(head, temp));
                    return cat_stm;
                }
            }
            else
            {
                // int
                if (vdf->iv)
                {
                    // printf("variable: %s\n", vdf->id);
                    ExpTy expty = ast2irExp(vdf->iv->u.e, name);
                    Temp_temp temp = Temp_newtemp();
                    int *ret = new int(0);
                    T_exp retexp = unEx(expty.exp);
                    if (expty.ty->kind == TY::tyType::Ty_float)
                    {
                        *ret = (int)*expty.ty->fvalue;
                        retexp = T_f2i(retexp);
                    }
                    else
                        *ret = (int)*expty.ty->ivalue;
                    if (idxflag && !strcmp(vdf->id, idxname.c_str()))
                    {
                        idxvalue[vdf->id] = *ret;
                    }
                    venv->enter(vdf->id, new TY::LocVar(TY::intType(ret, false), temp));
                    return T_Move(T_Temp(temp), retexp);
                }
                else
                {
                    Temp_temp temp = Temp_newtemp();
                    venv->enter(vdf->id,
                                new TY::LocVar(TY::intType(new int(0), false), temp));
                    return T_Move(T_Temp(temp), T_Const(0));
                }
            }
        }
    }
    break;
    case f_float:
    {
        usefloat = true;
        if (name == "")
        {
            if (vdf->cel)
            {
                // float []
                int offset = 0;
                TY::Type *head = TY::floatType(new float(0), false);
                for (auto i = convertExpl(vdf->cel); i != NULL; i = i->tail)
                {
                    ExpTy expty = ast2irExp(i->head, name);
                    // int index = i->head->u.inum;
                    head = TY::arrayType(head, *expty.ty->ivalue, false);
                }
                Temp_label_front label = Temp_newlabel_front();
                globalarr.insert(std::string(label));
                if (vdf->iv)
                {
                    T_exp exp = T_Name(label, TempType::FLOAT_PTR);
                    ExpTy expty = InitfcalArray(vdf->iv->u.ai->ivl, exp, 0, head, name);
                    venv->enter(vdf->id, new TY::GloVar(expty.ty, label));
                }
                else
                {
                    voidarr[vdf->id] = 1;
                    // head->fvalue = new float(100);
                    head->fvalue = new float[head->arraysize];
                    // memset(head->fvalue, 0, head->arraysize * sizeof(float));
                    venv->enter(vdf->id, new TY::GloVar(head, label));
                }
                return NULL;
            }
            else
            {
                // float
                Temp_label_front label = Temp_newlabel_front();
                constvar temp;
                temp.intvalue = 0;
                globalconst[label] = temp;
                if (vdf->iv)
                {
                    ExpTy expty = ast2irExp(vdf->iv->u.e, name);
                    float *ret = new float(0);
                    if (expty.ty->kind == TY::tyType::Ty_int)
                    {
                        *ret = i2f(*expty.ty->ivalue);
                    }
                    else
                        *ret = *expty.ty->fvalue;
                    temp.floatvalue = *ret;
                    globalconst[label] = temp;
                    venv->enter(vdf->id, new TY::GloVar(TY::floatType(ret, false),
                                                        label));
                }
                else
                    venv->enter(vdf->id, new TY::GloVar(TY::floatType(new float(0), false),
                                                        label));
                return NULL;
            }
        }
        else
        {
            if (vdf->cel)
            {
                // float []
                int offset = 0;
                TY::Type *head = TY::floatType(new float(0), false);
                for (auto i = convertExpl(vdf->cel); i != NULL; i = i->tail)
                {
                    ExpTy expty = ast2irExp(i->head, name);
                    head = TY::arrayType(head, *expty.ty->ivalue, false);
                }
                Temp_temp temp = Temp_newtemp_float_ptr();
                T_stm cat_stm = T_Move(T_Temp(temp),
                                       T_Call("1_arr", T_ExpList(T_Const(head->arraysize), NULL)));
                // Temp_label_front label = Temp_newlabel_front();
                if (vdf->iv)
                {
                    T_expList param = (T_expList)checked_malloc(sizeof(*param));
                    param->head = T_Temp(temp);
                    param->tail = T_ExpList(
                        T_Const(0), T_ExpList(T_Const(head->arraysize * 4), NULL));
                    cat_stm = make_seq(cat_stm, T_Exp(T_Call("1_memset", param)));
                    ExpTy expty = InitfcalArray(vdf->iv->u.ai->ivl, T_Temp(temp), 0, head, name);
                    venv->enter(vdf->id, new TY::LocVar(head, temp));
                    return make_seq(cat_stm, T_Exp(unEx(expty.exp)));
                }
                else
                {
                    head->fvalue = new float[head->arraysize];
                    memset(head->fvalue, 0, head->arraysize * sizeof(float));
                    venv->enter(vdf->id, new TY::LocVar(head, temp));
                    return cat_stm;
                }
            }
            else
            {
                // float
                // std::cout << "getfloat! : " << vdf->id << std::endl;
                if (vdf->iv)
                {
                    ExpTy expty = ast2irExp(vdf->iv->u.e, name);
                    Temp_temp temp = Temp_newtemp_float();
                    float *ret = new float(0);
                    T_exp retexp = unEx(expty.exp);
                    if (expty.ty->kind == TY::tyType::Ty_int)
                    {
                        *ret = (float)*expty.ty->ivalue;
                        retexp = T_i2f(retexp);
                    }
                    else
                        *ret = *expty.ty->fvalue;
                    venv->enter(vdf->id, new TY::LocVar(TY::floatType(ret, false), temp));
                    return T_Move(T_Temp(temp), retexp);
                }
                else
                {
                    Temp_temp temp = Temp_newtemp_float();
                    venv->enter(vdf->id,
                                new TY::LocVar(TY::floatType(new float(0), false), temp));
                    return NULL;
                }
            }
        }
    }
    break;
    default:
        break;
    }
    return NULL;
}
static TY::Type *type(A_funcType btype)
{
    switch (btype)
    {
    case f_int:
        return TY::intType(new int(0), false);
    case f_float:
        return TY::floatType(new float(0), false);
    case f_void:
        return TY::voidType();
    default:
        assert(0);
    }
    return nullptr;
}

T_funcDecl ast2irFuncDef(A_funcDef e, Temp_label_front brelabel, Temp_label_front conlabel, Temp_label_front name)
{
    TY::Type *ty = TY::funcType(NULL, std::vector<TY::Type *>());
    ty->tp = type(e->type);
    // //std::cout << e->v << std::endl;
    // assert(e->ffp);
    std::vector<Temp_temp> tempvec;
    std::unordered_set<std::string> inarr;
    std::vector<std::string> funcparam;
    for (auto it = e->ffp->ffpl; it != NULL; it = it->tail)
    {
        // std::cout << it->head->id << std::endl;
        funcparam.push_back(it->head->id);
        if (it->head->is_arr == 0)
        {
            ty->param.push_back(type(it->head->type));
            if (it->head->type == f_int)
                tempvec.push_back(Temp_newtemp());
            else
                tempvec.push_back(Temp_newtemp_float());
        }
        else
        {
            // printf("var is arr\n");
            //  type(it->head->type)->show();
            impureset.insert(e->v);
            inarr.insert(it->head->id);
            TY::Type *head;
            if (it->head->type == f_int)
            {
                head = TY::intType(new int(0), false);
                tempvec.push_back(Temp_newtemp_int_ptr());
            }
            else
            {
                head = TY::floatType(new float(0), false);
                tempvec.push_back(Temp_newtemp_float_ptr());
            }
            for (auto i = convertExpl(it->head->el); i != NULL; i = i->tail)
            {
                // A_exp exp=it->head->el->head;
                ExpTy expty = ast2irExp(i->head, name);

                head = TY::arrayType(head, *expty.ty->ivalue, false);
            }
            head = TY::arrayType(head, 0, false);
            head->ivalue = new int[head->arraysize];
            memset(head->ivalue, 0, head->arraysize * sizeof(int));
            // head->show();
            ty->param.push_back(head);
        }
    }
    name = e->v;
    Temp_label_front fb = name;
    fenv->enter(fb, new TY::EnFunc(ty, fb));
    venv->beginScope(NULL);
    T_stm cat_stm = T_Label(fb);
    int stksize = 0, cnt = 0;
    Temp_tempList templist = NULL;
    Temp_tempList templast = NULL;
    int i = 0;
    for (auto it = e->ffp->ffpl; it != NULL; it = it->tail, i++)
    {
        // std::cout << "now is:" << it->head->id << std::endl;
        //  ast2irVarDef(it->head->type, A_VarDef(it->head->pos, it->head->id, it->head->el, NULL), name);
        assert(ty->param[i]->fvalue || ty->param[i]->ivalue);
        venv->enter(it->head->id, new TY::LocVar(ty->param[i], tempvec[i]));
        TY::LocVar *entry = static_cast<TY::LocVar *>(venv->look(it->head->id));
        Temp_temp temp = entry->temp;
        if (templast)
            templast = templast->tail = Temp_TempList(temp, NULL);
        else
            templast = templist = Temp_TempList(temp, NULL);
    }

    // std::cout << name << std::endl;

    nowfunc.name = name;
    nowfunc.funcvec = tempvec;
    nowfunc.param = ty->param;
    nowfunc.label = "BEGIN_" + name;
    nowfunc.inarrvar = inarr;
    funcexplist[name] = funcparam;
    curtime[name] = 0;

    T_stm stm = ast2irBlock(e->b, brelabel, conlabel, name);
    venv->endScope();

    return T_FuncDecl(name, templist, make_seq(cat_stm, make_seq(T_Label("BEGIN_" + name), stm)));
    // return make_seq(cat_stm, make_seq(T_Label("BEGIN_" + name), stm));
}
T_stm ast2irBlock(A_block block, Temp_label_front brelabel, Temp_label_front conlabel,
                  Temp_label_front name)
{
    venv->beginScope(NULL);
    T_stm cat_stm = NULL;
    for (auto i = block->bil; i != NULL; i = i->tail)
    {
        T_stm stm = NULL;
        switch (i->head->kind)
        {
        case A_blockItem_::b_decl:
            switch (i->head->u.d->kind)
            {
            case A_decl_::constDecl:
                stm = ast2irConstDecl(i->head->u.d->u.cd, name);
                break;
            case A_decl_::varDecl:
                if (i->tail && i->tail->head &&
                    i->tail->head->kind == A_blockItem_::b_stmt &&
                    i->tail->head->u.s->kind == A_whileStm)
                {

                    if (i->tail->head->u.s->u.while_stat.e->kind == A_idExp)
                    {
                        idxname = i->tail->head->u.s->u.while_stat.e->u.v;
                        idxflag = 1;
                    }
                    else if (i->tail->head->u.s->u.while_stat.e->kind == A_opExp &&
                             i->tail->head->u.s->u.while_stat.e->u.op.left->kind == A_idExp)
                    {
                        idxname = i->tail->head->u.s->u.while_stat.e->u.op.left->u.v;
                        idxflag = 1;
                    }
                }
                stm = ast2irVarDecl(i->head->u.d->u.vd, name);
                idxflag = 0;
                idxname = "";
                break;
            }
            break;
        case A_blockItem_::b_stmt:
            if (i->head->u.s->kind == A_assignStm)
            {
                if (i->tail && i->tail->head &&
                    i->tail->head->kind == A_blockItem_::b_stmt &&
                    i->tail->head->u.s->kind == A_whileStm &&
                    ((i->tail->head->u.s->u.while_stat.e->kind == A_idExp &&
                      !strcmp(i->head->u.s->u.assign.arr->u.v, i->tail->head->u.s->u.while_stat.e->u.v)) ||
                     (i->tail->head->u.s->u.while_stat.e->kind == A_opExp &&
                      i->tail->head->u.s->u.while_stat.e->u.op.left->kind == A_idExp &&
                      !strcmp(i->head->u.s->u.assign.arr->u.v, i->tail->head->u.s->u.while_stat.e->u.op.left->u.v))))
                {
                    idxflag = 1;
                }
            }
            stm = ast2irStm(i->head->u.s, brelabel, conlabel, name);
            idxflag = 0;
            idxname = "";
            break;
        default:
            break;
        }
        cat_stm = make_seq(cat_stm, stm);
    }
    venv->endScope();
    return cat_stm;
}
// void loopunroll(A_stmt stm, Temp_label_front brelabel, Temp_label_front conlabel,
//                 Temp_label_front name)
// {
//     assert(stm->kind == A_whileStm);
//     if (stm->u.while_stat.e->u.op.right->kind != A_intConst)
//     {
//         return;
//     }
//     if (stm->u.while_stat.e->u.op.left->kind != A_idExp)
//     {
//         return;
//     }
//     std::string idname = stm->u.while_stat.e->u.op.left->u.v;

//     int end = stm->u.while_stat.e->u.op.right->u.inum;
//     if (stm->u.while_stat.s->kind == A_blockStm)
//     {
//         auto block = stm->u.while_stat.s->u.b;
//         for (auto i = block->bil; i != NULL; i = i->tail)
//         {
//             if (i->head->kind == A_blockItem_::b_stmt)
//             {
//                 if (i->head->u.s->kind == A_assignStm)
//                 {
//                 }
//             }
//         }
//     }
// }

T_stm ast2irStm(A_stmt stm, Temp_label_front brelabel, Temp_label_front conlabel,
                Temp_label_front name)
{

    if (!stm)
        return NULL;
    // std::cout << stm->kind << std::endl;
    switch (stm->kind)
    {
    case A_blockStm:
    {
        return ast2irBlock(stm->u.b, brelabel, conlabel, name);
    }
    case A_ifStm:
    {
        ExpTy expty = ast2irExp(stm->u.if_stat.e, name);
        T_stm then = ast2irStm(stm->u.if_stat.s1, brelabel, conlabel, name);
        T_stm elsee = ast2irStm(stm->u.if_stat.s2, brelabel, conlabel, name);

        Cx testcx = unCx(expty.exp, expty.ty->kind);

        // return
        if (then)
        {
            // patch test
            Temp_label_front iftrue = Temp_newlabel_front();
            Temp_label_front iffalse = Temp_newlabel_front();
            doPatch(testcx->trues, iftrue);
            doPatch(testcx->falses, iffalse);
            if (elsee)
            { // if ... else ...
                Temp_label_front ifend = Temp_newlabel_front();
                return T_Seq(
                    testcx->stm,
                    T_Seq(T_Label(iftrue),
                          T_Seq(then, T_Seq(T_Jump(ifend),
                                            T_Seq(T_Label(iffalse),
                                                  T_Seq(elsee, T_Label(ifend)))))));
            }
            else
            { // if ...
                return T_Seq(testcx->stm,
                             T_Seq(T_Label(iftrue), T_Seq(then, T_Label(iffalse))));
            }
        }
        else
        {
            if (elsee)
            { // if else ...
                Temp_label_front iftrue = Temp_newlabel_front();
                Temp_label_front iffalse = Temp_newlabel_front();
                doPatch(testcx->trues, iftrue);
                doPatch(testcx->falses, iffalse);
                return T_Seq(testcx->stm,
                             T_Seq(T_Label(iffalse), T_Seq(elsee, T_Label(iftrue))));
            }
            else
            { // if else
                Temp_label_front ifend = Temp_newlabel_front();
                doPatch(testcx->trues, ifend);
                doPatch(testcx->falses, ifend);
                return T_Seq(testcx->stm, T_Label(ifend));
            }
        }
    }
    case A_whileStm:
    {
        int looptimes = loopunroll(stm, brelabel, conlabel, name);
        ExpTy expty = ast2irExp(stm->u.while_stat.e, name);
        ExpTy expty2 = ast2irExp(stm->u.while_stat.e, name);

        Cx ct1 = unCx(expty.exp, expty.ty->kind);
        Cx ct2 = unCx(expty2.exp, expty2.ty->kind);
        Temp_label_front begin = Temp_newlabel_front(), test1 = Temp_newlabel_front(),
                         test2 = Temp_newlabel_front(), done = Temp_newlabel_front();
        doPatch(ct1->trues, begin);
        doPatch(ct1->falses, done);
        doPatch(ct2->trues, begin);
        doPatch(ct2->falses, done);
        T_stm teststm1 = make_seq(T_Label(test1), ct1->stm);
        T_stm teststm2 = make_seq(T_Label(test2), ct2->stm);

        lpunrollflag = true;
        T_stm loopstm = make_seq(T_Label(begin),
                                 ast2irStm(stm->u.while_stat.s, done, test2, name));
        if (lpunrollflag && looptimes > 1 && looptimes < 120)
        {
            // std::cout<<name<<" loop: "<<looptimes<<std::endl;
            loopstm = NULL;
            while (looptimes > 0)
            {
                loopstm = make_seq(loopstm, ast2irStm(stm->u.while_stat.s, "", "", name));
                looptimes--;
            }
            lpunrollflag = false;
            return loopstm;
        }
        lpunrollflag = false;
        T_stm donestm = T_Label(done);
        return make_seq(make_seq(teststm1, make_seq(loopstm, teststm2)), donestm);
    }
    case A_assignStm:
    {
        A_exp right = handlervalue(stm->u.assign.value, stm->u.assign.arr->u.v);

        purejudge(stm->u.assign.arr);
        ExpTy l = ast2irExp(stm->u.assign.arr, name);
        ExpTy r = ast2irExp(right, name);
        if (idxflag && right->kind == A_intConst)
        {
            idxvalue[stm->u.assign.arr->u.v] = right->u.inum;
        }
        T_exp lexp = unEx(l.exp);
        T_exp rexp = unEx(r.exp);
        TY::tyType lty = l.ty->kind;
        TY::tyType rty = r.ty->kind;
        rexp = TyAssign(rexp, lty, rty);
        return T_Move(lexp, rexp);
    }
    case A_callStm:
    {
        lpunrollflag = false;
        if (stm->u.call_stat.fun == name)
            curtime[name]++;
        TY::EnFunc *func = fenv->look(stm->u.call_stat.fun);
        T_expList expl = ast2irExpList(stm->u.call_stat.el, *func, name);
        return T_Exp(T_Call(stm->u.call_stat.fun, expl));
    }
    case A_continue:
    {
        lpunrollflag = false;
        return T_Jump(conlabel);
    }
    case A_break:
    {
        lpunrollflag = false;
        return T_Jump(brelabel);
    }
    case A_return:
    {
        if (!stm->u.e)
            return T_Return(NULL);
        if (stm->u.e->kind == A_callExp && !strcmp(stm->u.e->u.call.fun, nowfunc.name.c_str()))
        {
            lpunrollflag = false;
            if (stm->u.call_stat.fun == name)
                curtime[name]++;
            T_stm ret = NULL;
            std::vector<Temp_temp> tempvec;
            std::vector<ExpTy> exptyvec;
            for (auto i = stm->u.e->u.call.el; i; i = i->tail)
            {
                ExpTy expty = ast2irExp(i->head, name);
                exptyvec.push_back(expty);
                Temp_temp temp = Temp_newtemp_unknown();
                tempvec.push_back(temp);
                T_exp rexp = unEx(expty.exp);
                T_stm nowstm = T_Move(T_Temp(temp), rexp);
                ret = make_seq(ret, nowstm);
            }
            assert(tempvec.size() == nowfunc.funcvec.size());
            for (int i = 0; i < tempvec.size(); i++)
            {
                TY::tyType lty = ((nowfunc.param)[i])->kind;
                TY::tyType rty = exptyvec[i].ty->kind;
                T_exp rexp = TyAssign(T_Temp(tempvec[i]), lty, rty);
                T_stm nowstm = T_Move(T_Temp(nowfunc.funcvec[i]), rexp);
                ret = make_seq(ret, nowstm);
            }
            ret = make_seq(ret, T_Jump(nowfunc.label));
            return ret;
        }
        TY::tyType lty = fenv->look(name)->ty->tp->kind;
        ExpTy expty = ast2irExp(stm->u.e, name);
        TY::tyType rty = expty.ty->kind;
        T_exp rexp = unEx(expty.exp);
        rexp = TyAssign(rexp, lty, rty);
        return T_Return(rexp);
    }
    case A_putint:
    {
        impureset.insert(nowfunc.name);
        ExpTy expty = ast2irExp(stm->u.e, name);
        T_exp exp = unEx(expty.exp);
        exp = TyAssign(exp, TY::tyType::Ty_int, expty.ty->kind);
        return T_Exp(T_Call("putint", T_ExpList(exp, NULL)));
    }
    case A_putfloat:
    {
        impureset.insert(nowfunc.name);
        ExpTy expty = ast2irExp(stm->u.e, name);
        T_exp exp = unEx(expty.exp);
        exp = TyAssign(exp, TY::tyType::Ty_float, expty.ty->kind);
        return T_Exp(T_Call("putfloat", T_ExpList(exp, NULL)));
    }
    case A_putarray:
    {
        impureset.insert(nowfunc.name);
        ExpTy pos = ast2irExp(stm->u.putarray.e1, name);
        T_exp posexp = unEx(pos.exp);
        posexp = TyAssign(posexp, TY::tyType::Ty_int, pos.ty->kind);
        ExpTy arr = ast2irExp(stm->u.putarray.e2, name);

        return T_Exp(
            T_Call("putarray", T_ExpList(posexp, T_ExpList(unEx(arr.exp), NULL))));
    }
    case A_putch:
    {
        impureset.insert(nowfunc.name);
        ExpTy expty = ast2irExp(stm->u.e, name);
        T_exp exp = unEx(expty.exp);
        exp = TyAssign(exp, TY::tyType::Ty_int, expty.ty->kind);
        return T_Exp(T_Call("putch", T_ExpList(exp, NULL)));
    }
    case A_starttime:
    {
        impureset.insert(nowfunc.name);
        return T_Exp(T_Call("_sysy_starttime", T_ExpList(T_Const(stm->pos->line), NULL)));
    }
    case A_stoptime:
    {
        impureset.insert(nowfunc.name);
        return T_Exp(T_Call("_sysy_stoptime", T_ExpList(T_Const(stm->pos->line), NULL)));
    }
    case A_expStm:
    {
        if (!stm->u.e)
            return NULL;
        ExpTy expty = ast2irExp(stm->u.e, name);
        if (expty.exp)
            return T_Exp(unEx(expty.exp));
        return NULL;
    }
    case A_putfarray:
    {
        impureset.insert(nowfunc.name);
        ExpTy pos = ast2irExp(stm->u.putarray.e1, name);
        T_exp posexp = unEx(pos.exp);
        posexp = TyAssign(posexp, TY::tyType::Ty_int, pos.ty->kind);
        ExpTy arr = ast2irExp(stm->u.putarray.e2, name);
        return T_Exp(
            T_Call("putfarray", T_ExpList(posexp, T_ExpList(unEx(arr.exp), NULL))));
    }
    case A_putf:
    {
        impureset.insert(nowfunc.name);
        assert(0);
    }
    default:
        assert(0);
    }
    return NULL;
}
T_expList ast2irExpList(A_expList el, TY::EnFunc func, Temp_label_front name)
{
    T_expList ret = NULL, tail = NULL;
    if (!el)
        return ret;
    int i = 0;
    auto params = func.ty->param;
    // std::cout << "size:" << params.size() << std::endl;
    for (auto it = el; it != NULL; it = it->tail, i++)
    {
        // std::cout << i << std::endl;
        TY::tyType lty = params[i]->kind;
        ExpTy expty = ast2irExp(it->head, name);
        T_exp rexp = unEx(expty.exp);
        TY::tyType rty = expty.ty->kind;
        rexp = TyAssign(rexp, lty, rty);
        if (tail)
            tail = tail->tail = T_ExpList(rexp, NULL);
        else
            tail = ret = T_ExpList(rexp, NULL);
        // ret = T_ExpList(unEx(temp.exp), ast2irExpList(el->tail, name));
    }
    return ret;
}
ExpTy ast2irExp(A_exp exp, Temp_label_front name)
{
    ExpTy ret;
    if (!exp)
        return ret;
    // printf("%d\n", exp->kind);
    switch (exp->kind)
    {
    case A_opExp:
    {
        // printf("here!\n");
        switch (exp->u.op.oper)
        {
        case A_and:
        {
            TY::Type *t = TY::intType(new int(0), false);
            ExpTy lExpTy = ast2irExp(exp->u.op.left, name);
            ExpTy rExpTy = ast2irExp(exp->u.op.right, name);
            Cx lcx = unCx(lExpTy.exp, lExpTy.ty->kind);
            Cx rcx = unCx(rExpTy.exp, rExpTy.ty->kind);
            Temp_label_front lab = Temp_newlabel_front();
            doPatch(lcx->trues, lab);
            return ExpTy(
                Tr_Cx(rcx->trues, joinPatch(lcx->falses, rcx->falses),
                      T_Seq(lcx->stm, T_Seq(T_Label(lab), rcx->stm))),
                t);
        }
        case A_or:
        {
            TY::Type *t = TY::intType(new int(0), false);
            ExpTy lExpTy = ast2irExp(exp->u.op.left, name);
            ExpTy rExpTy = ast2irExp(exp->u.op.right, name);
            Cx lcx = unCx(lExpTy.exp, lExpTy.ty->kind);
            Cx rcx = unCx(rExpTy.exp, rExpTy.ty->kind);
            Temp_label_front lab = Temp_newlabel_front();
            doPatch(lcx->falses, lab);
            return ExpTy(
                Tr_Cx(joinPatch(lcx->trues, rcx->trues), rcx->falses,
                      T_Seq(lcx->stm, T_Seq(T_Label(lab), rcx->stm))),
                t);
        }
        case A_less:
        case A_le:
        case A_greater:
        case A_ge:
        case A_eq:
        case A_ne:
            return ast2irRelop(exp, name);
        case A_plus:
        case A_minus:
        case A_times:
        case A_div:
        case A_mod:
            return ast2irBinop(exp, name);
        default:
            assert(0);
        }
    }
    case A_arrayExp:
    {
        // printf("here2!\n");
        std::string idname = exp->u.array_pos.arr->u.v;
        TY::Entry *item = venv->look(idname);
        // std::cout << idname << std::endl;
        T_exp idexp = NULL;
        TempType type;
        if (item->ty->fvalue)
            type = TempType::FLOAT_PTR;
        else
            type = TempType::INT_PTR;
        if (item->kind == TY::tyEntry::Ty_global)
        {
            impureset.insert(nowfunc.name);
            idexp = T_Name(static_cast<TY::GloVar *>(item)->label, type);
        }
        else if (item->kind == TY::tyEntry::Ty_local)
        {
            idexp = T_Temp(static_cast<TY::LocVar *>(item)->temp);
            assert(idexp->TEMP->type == INT_PTR ||
                   idexp->TEMP->type == FLOAT_PTR);
        }

        TY::Type *ty = item->ty;
        // ty->show();
        assert(ty);
        T_exp e = T_Const(0);
        int offset = 0;
        for (auto it = exp->u.array_pos.arr_pos; it != NULL; it = it->tail)
        {
            ExpTy expty = ast2irExp(it->head, name);
            int dim = ty->dim;
            // printf("dim: %d\n", dim);
            e = T_Binop(T_plus, T_Binop(T_mul, T_Const(dim), e), unEx(expty.exp));
            offset = offset * dim + *expty.ty->ivalue;
            ty = ty->tp;
        }
        // //printf("%d,%d\n", exp->pos->line, exp->pos->pos);
        assert(ty);
        if (ty->kind == TY::tyType::Ty_array)
        {
            TY::Type *LvalType = ty; // ty->value must not use,becuase const array
                                     // init cant be a array addr,and const must init
            return ExpTy(
                Tr_Ex(T_Binop(T_plus, idexp,
                              T_Binop(T_mul, T_Const(ty->arraysize), e))),
                LvalType);
        }
        else
        {
            assert(item);
            assert(item->ty);
            // assert(item->ty->arraysize);
            TY::Type *LvalType;
            if (ty->kind == TY::tyType::Ty_int)
                LvalType = item->ty->arraysize != 0 ? TY::intType(new int(item->ty->ivalue[(offset % item->ty->arraysize +
                                                                                            item->ty->arraysize) %
                                                                                           item->ty->arraysize]),
                                                                  0)
                                                    : TY::intType(new int(0), 0);
            // LvalType =
            //     TY::intType(new int(item->ty->ivalue[(offset % item->ty->arraysize +
            //                                           item->ty->arraysize) %
            //                                          item->ty->arraysize]),
            //                 0);
            else if (ty->kind == TY::tyType::Ty_float)
                LvalType = item->ty->arraysize != 0 ? TY::floatType(
                                                          new float(item->ty->fvalue[(offset % item->ty->arraysize +
                                                                                      item->ty->arraysize) %
                                                                                     item->ty->arraysize]),
                                                          0)
                                                    : TY::floatType(new float(0), 0);
            else
                assert(0);
            return ExpTy(
                Tr_Ex(T_Mem(T_Binop(T_plus, idexp, e))),
                LvalType);
        }
    }
    case A_callExp:
    {
        // printf("here3!\n");
        // std::cout << exp->u.call.fun << std::endl;
        lpunrollflag = false;
        if (exp->u.call.fun == name)
            curtime[name]++;
        funcgraph[exp->u.call.fun].insert(nowfunc.name);
        TY::EnFunc *func = fenv->look(exp->u.call.fun);
        assert(func);
        T_expList expl = ast2irExpList(exp->u.call.el, *func, name);
        return ExpTy(Tr_Ex(T_Call(func->label, expl)), func->ty->tp);
    }
    case A_intConst:
    {
        // printf("here4!\n");
        auto trexp = Tr_Ex(T_Const(exp->u.inum));
        return ExpTy(trexp, TY::intType(new int(exp->u.inum), 0));
    }
    case A_floatConst:
    {
        // printf("here5!\n");
        usefloat = true;
        auto trexp = Tr_Ex(T_FConst(string2f(exp->u.fnum)));
        return ExpTy(trexp, TY::floatType(new float(string2f(exp->u.fnum)), 0));
    }
    case A_idExp:
    {
        // printf("here6!\n");
        std::string idname = exp->u.v;
        // std::cout << idname << std::endl;
        TY::Entry *item = venv->look(idname);
        assert(item);
        T_exp idexp = NULL;
        TempType type;
        if (item->ty->kind == TY::tyType::Ty_float)
        {
            type = TempType::FLOAT_PTR;
        }
        else
            type = TempType::INT_PTR;
        if (item->kind == TY::tyEntry::Ty_global)
        {
            // printf("global\n");
            if (!item->ty->isconst)
                impureset.insert(nowfunc.name);
            idexp = T_Name(static_cast<TY::GloVar *>(item)->label, type);
        }
        else if (item->kind == TY::tyEntry::Ty_local)
        {
            idexp = T_Temp(static_cast<TY::LocVar *>(item)->temp);
        }
        TY::Type *ty = item->ty;
        // if (!(ty->fvalue || ty->ivalue))
        // std::cout << idname << std::endl;
        assert(ty->fvalue || ty->ivalue);
        if (ty->isconst)
        {
            if (ty->kind == TY::tyType::Ty_float)
                return ExpTy(Tr_Ex(T_FConst(*ty->fvalue)), ty);
            else
                return ExpTy(Tr_Ex(T_Const(*ty->ivalue)), ty);
        }
        else
        {
            assert(idexp);
            assert(ty);
            if (item->kind == TY::tyEntry::Ty_global)
            {
                if (ty->kind == TY::tyType::Ty_array)
                {
                    // printf("out\n");
                    return ExpTy(Tr_Ex(idexp), ty);
                }
                else
                {
                    // printf("out\n");
                    return ExpTy(Tr_Ex(T_Mem(idexp)), ty);
                }
            }
            else
            {
                // printf("out\n");
                return ExpTy(Tr_Ex(idexp), ty);
            }
        }
    }
    case A_notExp:
    {
        // printf("here7!\n");
        ExpTy expty = ast2irExp(exp->u.e, name);
        Cx expcx = unCx(expty.exp, expty.ty->kind);
        return ExpTy(Tr_Cx(expcx->falses, expcx->trues, expcx->stm), TY::intType(new int(0), false));
    }
    case A_minusExp:
    {
        // printf("here8!\n");
        ExpTy rexpty = ast2irExp(exp->u.e, name);
        auto t = rexpty.ty;
        T_exp rexp = unEx(rexpty.exp);
        TY::Type *rty = rexpty.ty;
        T_exp lexp = NULL;
        T_binOp op = T_minus;
        TY::Type *newty = new TY::Type(*rty);
        if (rty->kind == TY::tyType::Ty_float)
        {
            newty->fvalue = new float(-*rty->fvalue);
            lexp = T_FConst(0);
            op = F_minus;
        }
        else
        {
            newty->ivalue = new int(-*rty->ivalue);
            lexp = T_Const(0);
        }
        return ExpTy(Tr_Ex(T_Binop(op, lexp, rexp)), newty);
    }
    case A_getint:
    {
        // printf("here9!\n");
        impureset.insert(nowfunc.name);
        return ExpTy(Tr_Ex(T_Call("getint", NULL)), TY::intType(new int(0), false));
    }
    case A_getch:
    {
        // printf("here10!\n");
        impureset.insert(nowfunc.name);
        return ExpTy(Tr_Ex(T_Call("getch", NULL)), TY::intType(new int(0), false));
    }
    case A_getfloat:
    {
        // printf("here11!\n");
        impureset.insert(nowfunc.name);
        return ExpTy(Tr_Ex(T_Call("getfloat", NULL)),
                     TY::floatType(new float(0), false));
    }
    case A_getarray:
    {
        // printf("here12!\n");
        impureset.insert(nowfunc.name);
        ExpTy expty = ast2irExp(exp->u.e, name);
        T_exp arr = unEx(expty.exp);
        return ExpTy(Tr_Ex(T_Call("getarray", T_ExpList(arr, NULL))),
                     TY::intType(new int(0), false));
    }
    case A_getfarray:
    {
        // printf("here13!\n");
        impureset.insert(nowfunc.name);
        ExpTy expty = ast2irExp(exp->u.e, name);
        T_exp arr = unEx(expty.exp);
        return ExpTy(Tr_Ex(T_Call("getfarray", T_ExpList(arr, NULL))),
                     TY::intType(new int(0), false));
    }
    default:
        assert(0);
    }
    return ret;
}
ExpTy ExpcalArray(A_exp e, T_exp addr, int noff, TY::Type *ty, Temp_label_front name)
{
    ExpTy expty = ast2irExp(e, name);
    T_exp exp = unEx(expty.exp);
    TY::Type *retType = expty.ty;
    TY::tyType arrtype;
    while (ty->kind == TY::tyType::Ty_array)
        ty = ty->tp;
    if (expty.ty->kind == TY::tyType::Ty_int &&
        ty->kind == TY::tyType::Ty_float)
    {
        exp = T_i2f(exp);
        retType = TY::floatType(new float(i2f(*expty.ty->ivalue)), 0);
    }
    else if (expty.ty->kind == TY::tyType::Ty_float &&
             ty->kind == TY::tyType::Ty_int)
    {
        exp = T_f2i(exp);
        retType = TY::intType(new int(f2i(*expty.ty->fvalue)), 0);
    }
    T_stm stm = T_Move(
        T_Mem(T_Binop(T_plus, addr, T_Const(noff))), exp);
    return ExpTy(Tr_Ex(T_Eseq(stm, T_Const(0))),
                 retType); // not use exp and type
}
ExpTy InitcalArray(A_initValList initv, T_exp addr, int noff, TY::Type *ty, Temp_label_front name)
{
    // temp all ivalue
    ty->ivalue = new int[ty->arraysize];
    memset(ty->ivalue, 0, ty->arraysize * sizeof(int));
    int doff = 0;
    T_stm cat_stm = NULL;
    for (auto it = initv; it != NULL; it = it->tail)
    {
        ExpTy expty;
        if (it->head->kind == A_initVal_::init_exp)
            expty = ExpcalArray(it->head->u.e, addr, noff + doff, ty->tp, name);
        else
            expty = InitcalArray(it->head->u.ai->ivl, addr, noff + doff, ty->tp, name);
        T_stm stm = T_Exp(unEx(expty.exp));
        cat_stm = make_seq(cat_stm, stm);
        if (expty.ty->tp == NULL)
        {
            ty->ivalue[doff] = *expty.ty->ivalue;
        }
        else
        {
            std::memcpy(&ty->ivalue[doff], expty.ty->ivalue, expty.ty->arraysize * 4);
            // delete expty.ty->ivalue;
        }
        doff += expty.ty->arraysize;
    }
    return ExpTy(Tr_Ex(T_Eseq(cat_stm, addr)), ty);
}
ExpTy InitfcalArray(A_initValList initv, T_exp addr, int noff, TY::Type *ty, Temp_label_front name)
{
    // temp all fvalue
    ty->fvalue = new float[ty->arraysize];
    memset(ty->fvalue, 0, ty->arraysize * sizeof(float));
    int doff = 0;
    T_stm cat_stm = NULL;
    for (auto it = initv; it != NULL; it = it->tail)
    {
        ExpTy expty =
            ExpcalArray(it->head->u.e, addr, noff + doff, ty->tp, name);
        T_stm stm = T_Exp(unEx(expty.exp));
        cat_stm = make_seq(cat_stm, stm);
        if (expty.ty->tp == NULL)
        {
            ty->fvalue[doff] = *expty.ty->fvalue;
        }
        else
        {
            std::memcpy(&ty->fvalue[doff], expty.ty->fvalue, expty.ty->arraysize * 4);
            delete expty.ty->fvalue;
        }
        doff += expty.ty->arraysize;
    }
    return ExpTy(Tr_Ex(T_Eseq(cat_stm, addr)), ty);
}
static T_exp turnFloat(T_binOp bop, T_exp lexp, T_exp rexp)
{
    switch (bop)
    {
    case T_plus:
        return T_Binop(F_plus, lexp, rexp);
    case T_minus:
        return T_Binop(F_minus, lexp, rexp);
    case T_mul:
        return T_Binop(F_mul, lexp, rexp);
    case T_div:
        return T_Binop(F_div, lexp, rexp);
    default:
        assert(0);
    }
    return nullptr;
}
static T_exp TyBinop(T_binOp bop, TY::Type *lty, T_exp lexp, TY::Type *rty,
                     T_exp rexp)
{
    if (lty->kind == TY::tyType::Ty_int && rty->kind == TY::tyType::Ty_int)
    {
        return T_Binop(bop, lexp, rexp);
    }
    else if (lty->kind == TY::tyType::Ty_int && rty->kind == TY::tyType::Ty_float)
    {
        lexp = T_i2f(lexp);
        float *value = new float(0);
        *value = (float)*lty->ivalue;
        lty->fvalue = value;
        return turnFloat(bop, lexp, rexp);
    }
    else if (lty->kind == TY::tyType::Ty_float && rty->kind == TY::tyType::Ty_int)
    {
        rexp = T_i2f(rexp);
        float *value = new float(0);
        *value = (float)*rty->ivalue;
        rty->fvalue = value;
        return turnFloat(bop, lexp, rexp);
    }
    else if (lty->kind == TY::tyType::Ty_float && rty->kind == TY::tyType::Ty_float)
    {
        return turnFloat(bop, lexp, rexp);
    }
    else if (lty->kind == TY::tyType::Ty_int && rty->kind == TY::tyType::Ty_array)
    {
        return T_Binop(
            T_plus, rexp,
            T_Binop(T_mul, lexp, T_Const(rty->tp->arraysize)));
    }
    else if (lty->kind == TY::tyType::Ty_array && rty->kind == TY::tyType::Ty_int)
    {
        assert(bop == T_plus || bop == T_minus);
        return T_Binop(
            bop, lexp,
            T_Binop(T_mul, rexp, T_Const(lty->tp->arraysize)));
    }
    else
        assert(0);
}
template <typename T>
static T count(T_binOp op, T l, T r)
{
    switch (op)
    {
    case T_plus:
        return l + r;
    case T_minus:
        return l - r;
    case T_mul:
        return l * r;
    case T_div:
        return l / (r != (T)0 ? r : (T)1);
    default:
        assert(0);
    }
}
static TY::Type *binopResType(TY::Type *a, TY::Type *b, T_binOp op)
{
    if (a->kind == TY::tyType::Ty_int && b->kind == TY::tyType::Ty_int)
    {
        int l = *a->ivalue;
        int r = *b->ivalue;
        if (op == T_mod)
            return TY::intType(new int(l % (r != 0 ? r : 1)), false);
        else
            return TY::intType(new int(count(op, l, r)), false);
    }
    else if (a->kind == TY::tyType::Ty_int && b->kind == TY::tyType::Ty_float)
    {
        float l = (float)*a->ivalue;
        float r = *b->fvalue;
        return TY::floatType(new float(count(op, l, r)), false);
    }
    else if (a->kind == TY::tyType::Ty_float && b->kind == TY::tyType::Ty_int)
    {
        float l = (*a->fvalue);
        float r = (float)*b->ivalue;
        return TY::floatType(new float(count(op, l, r)), false);
    }
    else if (a->kind == TY::tyType::Ty_float && b->kind == TY::tyType::Ty_float)
    {
        float l = *a->fvalue;
        float r = *b->fvalue;
        return TY::floatType(new float(count(op, l, r)), false);
    }
    else if (a->kind == TY::tyType::Ty_int && b->kind == TY::tyType::Ty_array)
    {
        return b;
    }
    else if (a->kind == TY::tyType::Ty_array && b->kind == TY::tyType::Ty_int)
    {
        return a;
    }
    else
        assert(0);
    return NULL;
}
ExpTy ast2irBinop(A_exp e, Temp_label_front name)
{
    T_exp exp;
    TY::Type *t;
    ExpTy lExpTy = ast2irExp(e->u.op.left, name);
    ExpTy rExpTy = ast2irExp(e->u.op.right, name);
    T_exp lexp = unEx(lExpTy.exp);
    T_exp rexp = unEx(rExpTy.exp);
    TY::Type *lty = lExpTy.ty;
    TY::Type *rty = rExpTy.ty;
    T_binOp bop;
    switch (e->u.op.oper)
    {
    case A_plus:
        bop = T_plus;
        break;
    case A_minus:
        bop = T_minus;
        break;
    case A_times:
        bop = T_mul;
        break;
    case A_div:
        bop = T_div;
        break;
    case A_mod:
        bop = T_mod;
        break;
    default:
        assert(0);
    }
    exp = TyBinop(bop, lty, lexp, rty, rexp);
    t = binopResType(lExpTy.ty, rExpTy.ty, bop);
    return ExpTy(Tr_Ex(exp), t);
}
ExpTy ast2irRelop(A_exp e, Temp_label_front name)
{
    TY::Type *t = TY::intType(new int(0), false);
    ExpTy lExpTy = ast2irExp(e->u.op.left, name);
    ExpTy rExpTy = ast2irExp(e->u.op.right, name);
    TY::tyType lty = lExpTy.ty->kind;
    TY::tyType rty = rExpTy.ty->kind;
    T_exp lexp = unEx(lExpTy.exp);
    T_exp rexp = unEx(rExpTy.exp);
    T_relOp bop;
    if (lty == TY::tyType::Ty_float || rty == TY::tyType::Ty_float)
    {
        if (lty == TY::tyType::Ty_int)
            lexp = T_i2f(lexp);
        if (rty == TY::tyType::Ty_int)
            rexp = T_i2f(rexp);
        switch (e->u.op.oper)
        {
        case A_ge:
            bop = F_ge;
            break;
        case A_greater:
            bop = F_gt;
            break;
        case A_le:
            bop = F_le;
            break;
        case A_less:
            bop = F_lt;
            break;
        case A_eq:
            bop = F_eq;
            break;
        case A_ne:
            bop = F_ne;
            break;
        default:
            assert(0);
        }
    }
    else
    {
        switch (e->u.op.oper)
        {
        case A_ge:
            bop = T_ge;
            break;
        case A_greater:
            bop = T_gt;
            break;
        case A_le:
            bop = T_le;
            break;
        case A_less:
            bop = T_lt;
            break;
        case A_eq:
            bop = T_eq;
            break;
        case A_ne:
            bop = T_ne;
            break;
        default:
            assert(0);
        }
    }

    T_stm stm = T_Cjump(bop, lexp, rexp, "", "");
    if (lexp->kind == T_CONST || lexp->kind == T_FCONST)
    {
        stm = T_Cjump(commute(bop), rexp, lexp, "", "");
    }
    patchList trues = PatchList(&stm->CJUMP.t, NULL);
    patchList falses = PatchList(&stm->CJUMP.f, NULL);
    return ExpTy(Tr_Cx(trues, falses, stm), t);
}