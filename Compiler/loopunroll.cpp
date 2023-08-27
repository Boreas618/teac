#include "translate.hpp"
#include <cstring>
#include <iostream>
#include <sstream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include "ast.h"
#include "translate.hpp"
#include "prtreep.hpp"
#include "treep.hpp"

int loopunroll(A_stmt stm, Temp_label_front brelabel, Temp_label_front conlabel,
               Temp_label_front name)
{
    assert(stm->kind == A_whileStm);
    if (stm->u.while_stat.e->kind != A_opExp)
    {
        return 0;
    }
    if (stm->u.while_stat.e->u.op.right->kind != A_intConst)
    {
        return 0;
    }
    if (stm->u.while_stat.e->u.op.left->kind != A_idExp)
    {
        return 0;
    }
    std::string idname = stm->u.while_stat.e->u.op.left->u.v;

    A_binop whileoper = stm->u.while_stat.e->u.op.oper;

    if (!getidxinit(idname).first)
    {
        return 0;
    };
    int init = getidxinit(idname).second;
    int end = stm->u.while_stat.e->u.op.right->u.inum;
    int step;
    A_binop oper;
    if (stm->u.while_stat.s->kind != A_blockStm)
    {
        return 0;
    }
    auto block = stm->u.while_stat.s->u.b;
    bool flag = false;
    int stmcount = 0;
    for (auto i = block->bil; i != NULL; i = i->tail)
    {
        stmcount++;
        if (i->head->kind == A_blockItem_::b_stmt)
        {
            if (i->head->u.s->kind == A_whileStm)
                return 0;
            if (i->head->u.s->kind == A_assignStm &&
                i->head->u.s->u.assign.arr->kind == A_idExp &&
                !strcmp(i->head->u.s->u.assign.arr->u.v, idname.c_str()) &&
                i->head->u.s->u.assign.value->kind == A_opExp)
            {
                if (flag)
                    return 0;
                A_exp exp = i->head->u.s->u.assign.value;
                oper = exp->u.op.oper;
                if (oper == A_plus || oper == A_times)
                {
                    if (exp->u.op.left->kind == A_idExp &&
                        !strcmp(exp->u.op.left->u.v, idname.c_str()) &&
                        exp->u.op.right->kind == A_intConst)
                    {
                        step = exp->u.op.right->u.inum;
                        flag = true;
                    }
                    else if (exp->u.op.right->kind == A_idExp &&
                             !strcmp(exp->u.op.right->u.v, idname.c_str()) &&
                             exp->u.op.left->kind == A_intConst)
                    {
                        step = exp->u.op.left->u.inum;
                        flag = true;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else if (oper == A_minus || oper == A_div)
                {
                    if (exp->u.op.left->kind == A_idExp &&
                        !strcmp(exp->u.op.left->u.v, idname.c_str()) &&
                        exp->u.op.right->kind == A_intConst)
                    {
                        step = exp->u.op.right->u.inum;
                        flag = true;
                    }
                    else
                        return 0;
                }
            }
        }
        else
            return 0;
    }
    if (!flag)
        return 0;
    int times = 0;
    switch (oper)
    {
    case A_minus:
    {
        switch (whileoper)
        {
        case A_less:
            return 0;
            break;
        case A_le:
            return 0;
            break;
        case A_greater:
            times = ((init - end) % step == 0) ? (init - end) / step : (init - end) / step + 1;
            break;
        case A_ge:
            times = (init - end) / step + 1;
            break;
        case A_eq:
            times = (init == end) ? 1 : 0;
            break;
        case A_ne:
            times = ((end - init) % step == 0) ? (end - init) / step : -1;
            break;
        default:
            assert(0);
        }
    }
    break;
    case A_div:
    {
        return 0;
        switch (whileoper)
        {
        case A_less:
            break;
        case A_le:
            break;
        case A_greater:
            break;
        case A_ge:
            break;
        case A_eq:
            break;
        case A_ne:
            break;
        default:
            assert(0);
        }
    }
    break;
    case A_plus:
    {
        switch (whileoper)
        {
        case A_less:
            times = ((end - init) % step == 0) ? (end - init) / step : (end - init) / step + 1;
            break;
        case A_le:
            times = (end - init) / step + 1;
            break;
        case A_greater:
            return 0;
            break;
        case A_ge:
            return 0;
            break;
        case A_eq:
            times = (init == end) ? 1 : 0;
            break;
        case A_ne:
            times = ((end - init) % step == 0) ? (end - init) / step : -1;
            break;
        default:
            assert(0);
        }
    }
    break;
    case A_times:
    {
        return 0;
        switch (whileoper)
        {
        case A_less:
            break;
        case A_le:
            break;
        case A_greater:
            break;
        case A_ge:
            break;
        case A_eq:
            break;
        case A_ne:
            break;
        default:
            assert(0);
        }
    }
    break;
    default:
        std::cout << idname << std::endl;
        std::cout << oper << std::endl;
        assert(0);
    }
    if (times <= 0)
        return 0;
    A_stmt unrolledstm;
    if (stmcount * times > 300)
        return 0;
    return times;
}
