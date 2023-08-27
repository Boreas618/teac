#include "purecache.hpp"
extern Table::Stable<TY::EnFunc *> *fenv;
extern std::unordered_map<std::string, std::vector<std::string>> funcexplist;
int count;
extern bool needpcache;
extern std::unordered_map<std::string, int> curtime;

std::string typestr(TY::tyType type)
{
    if (type == TY::tyType::Ty_float)
        return "f";
    else
        return "i";
}
std::string funcstr(std::string name)
{
    std::string ret = "";
    TY::Type *type = fenv->look(name)->ty;
    if (type->tp->kind == TY::tyType::Ty_void)
    {
        return "NULL";
    }
    ret += typestr(type->tp->kind);
    ret += "_";
    for (auto &i : type->param)
    {
        ret += typestr(i->kind);
    }
    return ret;
}

A_stmt pureStm(A_stmt stm, Temp_label_front name)
{
    if (!stm)
        return NULL;
    // std::cout << stm->kind << std::endl;
    switch (stm->kind)
    {
    case A_blockStm:
    {
        pureBlock(stm->u.b, name);
        return NULL;
    }
    case A_ifStm:
    {
        auto temp = pureStm(stm->u.if_stat.s1, name);
        if (temp)
            stm->u.if_stat.s1 = temp;
        temp = pureStm(stm->u.if_stat.s2, name);
        if (temp)
            stm->u.if_stat.s2 = temp;
        return NULL;
    }
    case A_whileStm:
    {
        auto temp = pureStm(stm->u.while_stat.s, name);
        if (temp)
            stm->u.while_stat.s = temp;
        return NULL;
    }
    case A_return:
    {
        assert(stm->u.e);
        A_stmt oldstm = stm;
        std::string setname = "__built__in__sy_" + funcstr(name);
        setname += "_set";
        auto vec = funcexplist[name];
        A_expList explist = A_ExpList(A_IntConst(stm->pos, count), NULL);
        A_expList tail = explist;
        for (auto &i : vec)
        {
            tail->tail = A_ExpList(A_IdExp(stm->pos, String((i + "__sy__builtin__param").c_str())), NULL);
            tail = tail->tail;
        }
        tail->tail = A_ExpList(stm->u.e, NULL);
        A_blockItem setin = A_BlockItemStmt(stm->pos,
                                            A_ExpStm(stm->pos, A_CallExp(stm->pos, String(setname.c_str()), explist)));
        A_blockItemList bl = A_BlockItemList(setin, A_BlockItemList(A_BlockItemStmt(stm->pos, oldstm), NULL));
        auto newstm = A_BlockStm(stm->pos, A_Block(stm->pos, bl));
        return newstm;
    }
    default:
        return NULL;
    }
    return NULL;
}
void pureBlock(A_block block, Temp_label_front name)
{
    A_stmt temp = NULL;
    for (auto i = block->bil; i != NULL; i = i->tail)
    {
        switch (i->head->kind)
        {
        case A_blockItem_::b_decl:
            switch (i->head->u.d->kind)
            {
            case A_decl_::constDecl:
                break;
            case A_decl_::varDecl:
                break;
            }
            break;
        case A_blockItem_::b_stmt:
            temp = pureStm(i->head->u.s, name);
            if (temp)
                i->head->u.s = temp;
            break;
        default:
            break;
        }
    }
    return;
}
A_blockItemList paramimage(std::string name)
{
    auto str = funcstr(name);
    auto vec = funcexplist[name];
    A_pos pos = A_Pos(0, 0);
    A_blockItemList ret = nullptr;
    for (int i = 0; i < vec.size(); i++)
    {
        A_funcType type = f_int;
        if (str[2 + i] == 'f')
            type = f_float;
        Temp_label_front name = vec[i];
        auto initval = A_InitValExp(pos, A_IdExp(pos, String(name.c_str())));
        auto vardef = A_VarDef(pos, String(std::string(name + "__sy__builtin__param").c_str()), NULL, initval);
        auto vardecl = A_VarDecl(pos, type, A_VarDefList(vardef, NULL));
        auto blockItem = A_BlockItemDecl(pos, A_DeclVar(pos, vardecl));
        ret = A_BlockItemList(blockItem, ret);
    }
    return ret;
}
void pureFuncDef(A_funcDef e, Temp_label_front name)
{
    name = e->v;
    if (name == "main" && needpcache)
    {
        A_blockItem cachein = NULL;
        cachein = A_BlockItemStmt(e->b->pos,
                                  A_ExpStm(e->b->pos,
                                           A_CallExp(e->b->pos, String("__built__in__sy_f_init"), NULL)));
        e->b = A_Block(e->b->pos, A_BlockItemList(cachein, e->b->bil));
        cachein = A_BlockItemStmt(e->b->pos,
                                  A_ExpStm(e->b->pos,
                                           A_CallExp(e->b->pos, String("__built__in__sy_i_init"), NULL)));
        e->b = A_Block(e->b->pos, A_BlockItemList(cachein, e->b->bil));
    }
    if (!ispurecache(name) || curtime[name] < 2)
        return;
    A_blockItem cachein = NULL;
    std::string str = funcstr(name);
    // return;
    std::string findname = "__built__in__sy_" + str + "_find";
    std::string getname = "__built__in__sy_";
    getname += typestr(fenv->look(name)->ty->tp->kind);
    getname += "_get";

    auto vec = funcexplist[name];
    A_expList explist = A_ExpList(A_IntConst(e->b->pos, count), NULL);
    A_expList tail = explist;
    for (auto &i : vec)
    {
        tail->tail = A_ExpList(A_IdExp(e->b->pos, String(i.c_str())), NULL);
        tail = tail->tail;
    }
    cachein = A_BlockItemStmt(e->b->pos,
                              A_IfStm(e->b->pos,
                                      A_CallExp(e->b->pos, String(findname.c_str()), explist),
                                      A_Return(e->b->pos, A_CallExp(e->b->pos, String(getname.c_str()), NULL)), NULL));

    pureBlock(e->b, name);
    auto paramin = paramimage(name);
    e->b = A_Block(e->b->pos, A_BlockItemList(cachein, e->b->bil));
    for (A_blockItemList blist = paramin; blist; blist = blist->tail)
    {
        e->b = A_Block(e->b->pos, A_BlockItemList(blist->head, e->b->bil));
    }
    count++;
    needpcache = true;
    return;
}
void pureCompUnit(A_compUnit unit)
{
    switch (unit->kind)
    {
    case A_compUnit_::comp_decl:
        switch (unit->u.d->kind)
        {
        case A_decl_::constDecl:
            break;
        case A_decl_::varDecl:
            break;
        default:
            break;
        }
        break;
    case A_compUnit_::comp_func:
        pureFuncDef(unit->u.fd, "");
        break;
    default:
        break;
    }
    return;
}
void pureCompUnitList(A_compUnitList list)
{
    for (auto it = list; it != NULL; it = it->tail)
    {
        pureCompUnit(it->head);
    }
    return;
}