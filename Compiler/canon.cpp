#include <assert.h>
#include <list>
#include <typeinfo>
#include <vector>
#include <unordered_map>
#include <queue>
#include <string>
#include "temp.h"
#include "util.h"
#include "canon.h"
#include "prtreep.hpp"
#include "ty.hpp"
#include "table.hpp"

using namespace canon;

C_stmListList canon::C_StmListList(T_stmList head, C_stmListList tail)
{
    C_stmListList p = (C_stmListList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

C_block canon::C_Block(C_stmListList llist, Temp_label_front label)
{
    C_block p;
    p.llist = llist;
    p.label = label;
    return p;
}

static C_stmExp do_exp(T_exp e);
static T_stm do_stm(T_stm s);

typedef struct C_expRefList_ *C_expRefList;
struct C_expRefList_
{
    T_exp* head;
    C_expRefList tail;
};

C_expRefList C_ExpRefList(T_exp* head, C_expRefList tail)
{
    C_expRefList p = (C_expRefList)checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

static bool isNop(T_stm x) 
{  
    return x->kind == T_EXP && (x->EXP->kind == T_CONST || x->EXP->kind == T_FCONST);
}

static T_stm seq(T_stm x, T_stm y)
{
    if (isNop(x))
        return y;
    if (isNop(y))
        return x;
    return T_Seq(x, y);
}

static bool commute(T_stm x, T_exp y)
{
    if (isNop(x))
        return true;
    if (y->kind == T_NAME || y->kind == T_CONST || y->kind == T_FCONST)
        return true;
    return false;
}

extern Table::Stable<TY::EnFunc *> *fenv;

static TY::tyType getReturnTy(std::string id){
    if(id == "1_i2f"){
        return TY::tyType::Ty_float;
    }
    if(id == "1_f2i"){
        return TY::tyType::Ty_int;
    }
    if(id == "1_memset"){
        return TY::tyType::Ty_void;
    }
    return fenv->look(id)->ty->tp->kind;
}

static T_stm reorder(C_expRefList rlist)
{
    if (rlist == nullptr)
    {
        return T_Exp(T_Const(0));
    }
    else if ((*rlist->head)->kind == T_CALL)
    {
        assert((*rlist->head)->CALL.id != "1_arr");
        Temp_temp t;
        
        TY::tyType ty = getReturnTy((*rlist->head)->CALL.id);
        
        if(ty == TY::tyType::Ty_void){
            assert(0);
        }else if(ty == TY::tyType::Ty_int){
            t = Temp_newtemp();
        }else if(ty == TY::tyType::Ty_float){
            t = Temp_newtemp_float();
        }else{
            assert(0);
        }

        *rlist->head = T_Eseq(T_Move(T_Temp(t), (*rlist->head)), T_Temp(t));
        return reorder(rlist);
    }
    else
    {
        C_stmExp hd = do_exp((*rlist->head));
        T_stm s = reorder(rlist->tail);
        if (commute(s, hd.e))
        {
            *rlist->head = hd.e;
            return seq(hd.s, s);
        }
        else
        {
            Temp_temp t = Temp_newtemp_unknown();
            *rlist->head = T_Temp(t);
            return seq(hd.s, seq(T_Move(T_Temp(t), hd.e), s));
        }
    }
}

static C_expRefList get_call_rlist(T_exp exp)
{
    C_expRefList rlist, curr;
    T_expList args = exp->CALL.args;
    if (args) 
    {
        curr = rlist = C_ExpRefList(&args->head, NULL);
        args = args->tail;
        for (; args; args = args->tail)
            curr = curr->tail = C_ExpRefList(&args->head, NULL);
        return rlist;
    }
    else
        return NULL;
}

static C_stmExp C_StmExp(T_stm stm, T_exp exp)
{
    C_stmExp x;
    x.s = stm;
    x.e = exp;
    return x;
}

static C_stmExp do_exp(T_exp e)
{
    switch (e->kind)
    {
    case T_BINOP:
    {
        return C_StmExp(reorder(C_ExpRefList(&e->BINOP.left,C_ExpRefList(&e->BINOP.right,nullptr))),e);
        break;
    }
    case T_CALL:
    {
        return C_StmExp(reorder(get_call_rlist(e)), e);
        break;
    }
    case T_MEM:
    {
        return C_StmExp(reorder(C_ExpRefList(&e->MEM, nullptr)), e);
        break;
    }
    case T_ESEQ:
    {
        C_stmExp x = do_exp(e->ESEQ.exp);
        return C_StmExp(seq(do_stm(e->ESEQ.stm),x.s),x.e);
        break;
    }
    default:
    {
        return C_StmExp(reorder(nullptr), e);
        break;
    }
    }
}

static T_stm do_stm(T_stm s)
{
    //printf("s kind:%d\n",s->kind);
    //pr_stm(std::cout,s,20);
    switch (s->kind)
    {
    case T_SEQ:
    {
        return seq(do_stm(s->SEQ.left),do_stm(s->SEQ.right));
        break;
    }
    case T_JUMP:
    {
        return s;
        break;
    }
    case T_CJUMP:
    {
        return seq(reorder(C_ExpRefList(&s->CJUMP.left,C_ExpRefList(&s->CJUMP.right,nullptr))),s);
        break;
    }
    case T_MOVE:
    {
        if((s->MOVE.dst->kind == T_NAME || s->MOVE.dst->kind == T_TEMP)
            && s->MOVE.src->kind == T_CALL)
        {
            return seq(reorder(get_call_rlist(s->MOVE.src)),s);
        }
        else if(s->MOVE.dst->kind == T_NAME || s->MOVE.dst->kind == T_TEMP)
        {
            return seq(reorder(C_ExpRefList(&s->MOVE.src,nullptr)),s);
        }
        else if(s->MOVE.dst->kind == T_MEM)
        {
            return seq(reorder(C_ExpRefList(&s->MOVE.dst->MEM,C_ExpRefList(&s->MOVE.src,nullptr))),s);
        }
        else if(s->MOVE.dst->kind == T_ESEQ)
        {
            T_stm ss = s->MOVE.dst->ESEQ.stm;
            s->MOVE.dst = s->MOVE.dst->ESEQ.exp;
            return do_stm(T_Seq(ss, s));
        }
        else
        {
            assert(0);
        }
        break;
    }
    case T_EXP:
    {
        if(s->EXP->kind == T_CALL)
        {
            return seq(reorder(get_call_rlist(s->EXP)),s);
        }
        else
        {
            return seq(reorder(C_ExpRefList(&s->EXP,nullptr)),s);
        }
        break;
    }
    case T_RETURN:
    {
        if(s->EXP != nullptr)
            return seq(reorder(C_ExpRefList(&s->EXP,nullptr)), s);
        else
            return s;
    }
    default:
    {
        return s;
        break;
    }
    }
}

T_stmList canon::linearize(T_stm stm)
{
    std::vector<T_stm> res, st;
    st.push_back(do_stm(stm));
    while (!st.empty())
    {
        auto tp = st.back();
        st.pop_back();
        if (tp->kind == T_SEQ)
        {
            st.push_back(tp->SEQ.right);
            st.push_back(tp->SEQ.left);
        } 
        else 
        {
            res.push_back(tp);
        }
    }
    int len = res.size();
    if (len == 0)
        return 0;
    auto it = T_StmList(res.back(), nullptr);
    for (int i = len - 2; i >= 0; i--)
    {
        it = T_StmList(res[i], it);
    }
    return it;
}

static C_stmListList mkBlocks(T_stmList stms, Temp_label_front done)
{
    assert(stms && stms->head->kind == T_LABEL);
    T_stmList head = T_StmList(nullptr, nullptr), tail;
    tail = head;
    C_stmListList lhead = C_StmListList(nullptr, nullptr), ltail;
    ltail = lhead;
    constexpr int IN = 1;
    constexpr int OUT = 2;
    int state = OUT;
    while (stms)
    {
        T_stm stm = stms->head;
        switch (state)
        {
        case IN:
        {
            if (stm->kind == T_LABEL)
            {
                state = OUT;
                std::string lab = stm->LABEL;
                tail = tail->tail = T_StmList(T_Jump(lab), nullptr);
                ltail = ltail->tail = C_StmListList(head->tail, nullptr);
            }
            else
            {
                tail = tail->tail = T_StmList(stm, nullptr);
                stms = stms->tail;
                if (stm->kind == T_JUMP || stm->kind == T_CJUMP || stm->kind == T_RETURN)
                {
                    state = OUT;
                    ltail = ltail->tail = C_StmListList(head->tail, nullptr);
                }
            }
            break;
        }
        case OUT:
        {
            if (stm->kind == T_LABEL)
            {
                state = IN;
                head->tail = nullptr;
                tail = head;
                tail = tail->tail = T_StmList(stm, nullptr);
                stms = stms->tail;
            }
            else
            {
                state = IN;
                head->tail = nullptr;
                tail = head;
                tail = tail->tail = T_StmList(T_Label(Temp_newlabel_front()), nullptr);
            }
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    if (state == IN)
    {
        state = OUT;
        tail = tail->tail = T_StmList(T_Jump(done), nullptr);
        ltail = ltail->tail = C_StmListList(head->tail, nullptr);
    }
    return lhead->tail;
}

C_block canon::basicBlocks(T_stmList sl, std::string funcname)
{
    C_block b;
    b.label = funcname + "_RETURN3124";
    b.llist = mkBlocks(sl, b.label);
    return b;
}

static T_stmList getLast(T_stmList list)
{
    T_stmList last = list;
    assert(last->tail);
    while (last->tail->tail)
        last = last->tail;
    return last;
}

static void printStmList_(std::ostream &os,T_stmList sl)
{
    while (sl != nullptr)
    {
        pr_stm(os,sl->head,0);
        os << "\n";
        sl = sl->tail;
    }
}

void canon::printCBlock(std::ostream &os,C_block b)
{
    C_stmListList sList;
    for (sList = b.llist; sList; sList = sList->tail)
    {
        printStmList_(os,sList->head);
        os << "\n";
    }
}

T_stmList canon::traceSchedule(C_block b)
{
    C_stmListList sList;
    std::unordered_map<std::string, T_stmList> block_env;
    for (sList = b.llist; sList; sList = sList->tail)
    {
        Temp_label_front label = sList->head->head->LABEL;
        block_env.insert(std::make_pair(label, sList->head));
    }
    T_stmList head = T_StmList(nullptr, T_StmList(nullptr, nullptr)), tail, last;
    last = head;
    tail = last->tail;
    for (sList = b.llist; sList; sList = sList->tail)
    {
        T_stmList block = sList->head;
        T_stm labelstm = block->head;
        assert(labelstm->kind == T_LABEL);
        std::string name = labelstm->LABEL;
        if(block_env.count(name) == 0) 
            continue;
        block_env.erase(name);
        tail->tail = block;
        last = getLast(tail);
        tail = last->tail;
        T_stm jump = tail->head;
        while (true)
        {
            if (jump->kind == T_JUMP)
            {
                std::string nextlabel = jump->JUMP.jump;
                if(block_env.count(nextlabel) == 0)
                {
                    break;
                }
                block = block_env.at(nextlabel);
                block_env.erase(nextlabel);
                last->tail = block;
                last = getLast(last);
                tail = last->tail;
                jump = tail->head;
            }
            else if (jump->kind == T_CJUMP)
            {
                std::string truelabel = jump->CJUMP.t;
                std::string falselabel = jump->CJUMP.f;
                if (block_env.count(falselabel))
                {
                    block = block_env.at(falselabel);
                    block_env.erase(falselabel);
                    tail->tail = block;
                    last = getLast(last);
                    tail = last->tail;
                    jump = tail->head;
                }
                else if (block_env.count(truelabel))
                {
                    jump->CJUMP.t = falselabel;
                    jump->CJUMP.f = truelabel;
                    T_relOp op = jump->CJUMP.op;
                    jump->CJUMP.op = T_notRel(op);
                    block = block_env.at(truelabel);
                    block_env.erase(truelabel);
                    tail->tail = block;
                    last = getLast(last);
                    tail = last->tail;
                    jump = tail->head;
                }
                else
                {
                    Temp_label_front falselabel_ = Temp_newlabel_front();
                    jump->CJUMP.f = falselabel_;
                    tail->tail = T_StmList(T_Label(falselabel_), nullptr);
                    last = tail;
                    tail = last->tail;
                    tail->tail = T_StmList(T_Jump(falselabel), nullptr);
                    last = tail;
                    tail = last->tail;
                    break;
                }
            }
            else if(jump->kind == T_RETURN)
            {
                break;
            }
            else
            {
                assert(0);
            }
        }
    }
    // tail->tail = T_StmList(T_Label(b.label), T_StmList(T_Return(T_Const(-1)),nullptr));
    return head->tail->tail;
}