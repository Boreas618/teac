#include "llvm_assem.h"
#include "assem.h"
#include <cassert>
#include <cstdio>

using namespace LLVM_IR;



T_stmList LLVM_IR::T_StmList(llvm_T_stm_ *head, T_stmList tail){
    T_stmList p = (T_stmList) checked_malloc (sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

T_irList LLVM_IR::T_IrList(T_ir head, T_irList tail){
    T_irList p = (T_irList) checked_malloc (sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Binop(T_binOp op, AS_operand dst, AS_operand left, AS_operand right){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_BINOP;
    p->u.BINOP.op = op;
    p->u.BINOP.dst = dst;
    p->u.BINOP.left = left;
    p->u.BINOP.right = right;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_InttoPtr(AS_operand dst, AS_operand src){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_INTTOPTR;
    p->u.INTTOPTR.dst = dst;
    p->u.INTTOPTR.src = src;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_PtrtoInt(AS_operand dst, AS_operand src){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_PTRTOINT;
    p->u.PTRTOINT.dst = dst;
    p->u.PTRTOINT.src = src;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Load(AS_operand dst, AS_operand ptr){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_LOAD;
    p->u.LOAD.dst = dst;
    p->u.LOAD.ptr = ptr;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Store(AS_operand src, AS_operand ptr){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_STORE;
    p->u.STORE.src = src;
    p->u.STORE.ptr = ptr;
    return p;
}
 
llvm_T_stm_ * LLVM_IR::T_Label(Temp_label label){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_LABEL;
    p->u.LABEL.label = label;
    return p;
}
 
llvm_T_stm_ * LLVM_IR::T_Jump(Temp_label label){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_JUMP;
    p->u.JUMP.jump = label;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Cmp(T_relOp op,AS_operand left, AS_operand right){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_CMP;
    p->u.CMP.op=op;
    p->u.CMP.left = left;
    p->u.CMP.right = right;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Cjump(T_relOp op, Temp_label true_label, Temp_label false_label){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_CJUMP;
    p->u.CJUMP.op = op;
    p->u.CJUMP.true_label = true_label;
    p->u.CJUMP.false_label = false_label;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Move(AS_operand dst, AS_operand src){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_MOVE;
    p->u.MOVE.dst = dst;
    p->u.MOVE.src = src;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Call(string fun, AS_operand res, AS_operandList args){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_CALL;
    p->u.CALL.fun = fun;
    p->u.CALL.res = res;
    p->u.CALL.args = args;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_VoidCall(string fun, AS_operandList args){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_VOID_CALL;
    p->u.VOID_CALL.fun = fun;
    p->u.VOID_CALL.args = args;
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Return(AS_operand ret){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_RETURN;
    p->u.RET.ret = ret;
    return p;
}

llvm_T_stm_* LLVM_IR::T_Phi(AS_operand dst, Temp_labelList ll, AS_operandList opl){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_PHI;
    p->u.PHI.dst = dst;

    Phi_pair_List pList = NULL;
    Phi_pair_List pLast = NULL;
    // printf("gen phi\n");
    for(; ll && opl; ll=ll->tail, opl=opl->tail){
        if(pLast) pLast = pLast->tail = Phi_Pair_List(Phi_Pair(opl->head, ll->head), NULL);
        else pLast = pList = Phi_Pair_List(Phi_Pair(opl->head, ll->head), NULL);
        // printf("label: %s\n", Temp_labelstring(ll->head));
        // printf("temp: %d\n", opl->head->u.TEMP->num);
    }

    p->u.PHI.phis = pList;
    
    return p;
}

llvm_T_stm_ * LLVM_IR::T_Null(){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_NULL;
    return p;
}

llvm_T_stm_* LLVM_IR::T_Alloca(AS_operand dst, int size, bool isIntArr){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_ALLOCA;
    p->u.ALLOCA.dst = dst;
    p->u.ALLOCA.size = size;
    p->u.ALLOCA.isIntArr = isIntArr;
    return p;
}

llvm_T_stm_* LLVM_IR::T_I2f(AS_operand dst, AS_operand src){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_I2F;
    p->u.I2F.dst = dst;
    p->u.I2F.src = src;
    return p;
}

llvm_T_stm_* LLVM_IR::T_F2i(AS_operand dst, AS_operand src){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_F2I;
    p->u.F2I.dst = dst;
    p->u.F2I.src = src;
    return p;
}

llvm_T_stm_* LLVM_IR::T_Gep(AS_operand new_ptr, AS_operand base_ptr, AS_operand index){
    llvm_T_stm_ * p = (llvm_T_stm_ *) checked_malloc(sizeof *p);
    p->kind = llvm_T_stm_::T_GEP;
    p->u.GEP.new_ptr = new_ptr;
    p->u.GEP.base_ptr = base_ptr;
    p->u.GEP.index = index;
    return p;
}

T_ir LLVM_IR::T_Ir(llvm_T_stm_ * s, AS_instr i){
    T_ir p = (T_ir) checked_malloc(sizeof *p);
    p->s = s;
    p->i = i;
    p->remove = false;
    return p;
}

AS_instrList LLVM_IR::getinstrList(LLVM_IR::T_irList_ *irl){
    LLVM_IR::T_irList_ *l = irl;
    AS_instrList ilast = NULL;
    AS_instrList ilist = NULL;
    while(l){
        if(ilast) ilast = ilast->tail = AS_InstrList(l->head->i, NULL);
        else ilast = ilist = AS_InstrList(l->head->i, NULL);
        l = l->tail;
    }
    return ilist;
}

bool LLVM_IR::irReplaceDstTemp(LLVM_IR::llvm_T_stm_ *s, Temp_temp old_temp, Temp_temp new_temp){
    if(!s) return true;
    switch (s->kind) {
    case LLVM_IR::llvm_T_stm_::T_BINOP:{
        assert(s->u.BINOP.dst->kind == AS_operand_::T_TEMP);
        if(s->u.BINOP.dst->u.TEMP == old_temp){
            s->u.BINOP.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_INTTOPTR:{
        assert(s->u.INTTOPTR.dst->kind == AS_operand_::T_TEMP);
        if(s->u.INTTOPTR.dst->u.TEMP == old_temp){
            s->u.INTTOPTR.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_PTRTOINT:{   
        assert(s->u.PTRTOINT.dst->kind == AS_operand_::T_TEMP);
        if(s->u.PTRTOINT.dst->u.TEMP == old_temp){
            s->u.PTRTOINT.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_LOAD:{
        assert(s->u.LOAD.dst->kind == AS_operand_::T_TEMP);
        if(s->u.LOAD.dst->u.TEMP == old_temp){
            s->u.LOAD.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_STORE:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_LABEL:{     
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_JUMP:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_CMP:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_CJUMP:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_MOVE:{
        assert(s->u.MOVE.dst->kind == AS_operand_::T_TEMP);
        if(s->u.MOVE.dst->u.TEMP == old_temp){
            s->u.MOVE.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_CALL:{
        assert(s->u.CALL.res->kind == AS_operand_::T_TEMP);
        if(s->u.CALL.res->u.TEMP == old_temp){
            s->u.CALL.res->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_VOID_CALL:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_RETURN:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_PHI:{
        if(s->u.PHI.dst->kind == AS_operand_::T_TEMP && s->u.PHI.dst->u.TEMP == old_temp){
            s->u.PHI.dst->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_NULL:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_ALLOCA:{
        assert(s->u.ALLOCA.dst->kind == AS_operand_::T_TEMP);
        if(s->u.ALLOCA.dst->u.TEMP == old_temp){
            s->u.ALLOCA.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_I2F:{
        assert(s->u.I2F.dst->kind == AS_operand_::T_TEMP);
        if(s->u.I2F.dst->u.TEMP == old_temp){
            s->u.I2F.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_F2I:{
        assert(s->u.F2I.dst->kind == AS_operand_::T_TEMP);
        if(s->u.F2I.dst->u.TEMP == old_temp){
            s->u.F2I.dst->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    case LLVM_IR::llvm_T_stm_::T_GEP:{
        assert(s->u.GEP.new_ptr->kind == AS_operand_::T_TEMP);
        if(s->u.GEP.new_ptr->u.TEMP == old_temp){
            s->u.GEP.new_ptr->u.TEMP = new_temp;
            return true;
        }else{
            return false;
        }
    }
    default:{
        assert(0);
    }
    }
}

bool LLVM_IR::irReplaceSrcTemp(LLVM_IR::llvm_T_stm_ *s, Temp_temp old_temp, Temp_temp new_temp){
    if(!s) return true;
    switch (s->kind) {
    case LLVM_IR::llvm_T_stm_::T_BINOP:{
        if(s->u.BINOP.left->kind == AS_operand_::T_TEMP && s->u.BINOP.left->u.TEMP == old_temp){
            s->u.BINOP.left->u.TEMP = new_temp;
            return true;
        }
        if(s->u.BINOP.right->kind == AS_operand_::T_TEMP && s->u.BINOP.right->u.TEMP == old_temp){
            s->u.BINOP.right->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_INTTOPTR:{
        if(s->u.INTTOPTR.src->kind == AS_operand_::T_TEMP && s->u.INTTOPTR.src->u.TEMP == old_temp){
            s->u.INTTOPTR.src->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_PTRTOINT:{   
        if(s->u.PTRTOINT.src->kind == AS_operand_::T_TEMP && s->u.PTRTOINT.src->u.TEMP == old_temp){
            s->u.PTRTOINT.src->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_LOAD:{
       if(s->u.LOAD.ptr->kind == AS_operand_::T_TEMP && s->u.LOAD.ptr->u.TEMP == old_temp){
            s->u.LOAD.ptr->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_STORE:{
        if(s->u.STORE.src->kind == AS_operand_::T_TEMP && s->u.STORE.src->u.TEMP == old_temp){
            s->u.STORE.src->u.TEMP = new_temp;
            return true;
        }
        if(s->u.STORE.ptr->kind == AS_operand_::T_TEMP && s->u.STORE.ptr->u.TEMP == old_temp){
            s->u.STORE.ptr->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_LABEL:{     
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_JUMP:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_CMP:{
        if(s->u.CMP.left->kind == AS_operand_::T_TEMP && s->u.CMP.left->u.TEMP == old_temp){
            s->u.CMP.left->u.TEMP = new_temp;
            return true;
        }
        if(s->u.CMP.right->kind == AS_operand_::T_TEMP && s->u.CMP.right->u.TEMP == old_temp){
            s->u.CMP.right->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_CJUMP:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_MOVE:{
        if(s->u.MOVE.src->kind == AS_operand_::T_TEMP && s->u.MOVE.src->u.TEMP == old_temp){
            s->u.MOVE.src->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_CALL:{
        for(AS_operandList al=s->u.CALL.args; al; al=al->tail){
            if(al->head->kind == AS_operand_::T_TEMP && al->head->u.TEMP == old_temp){
                al->head->u.TEMP = new_temp;
                return true;
            }
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_VOID_CALL:{
        for(AS_operandList al=s->u.VOID_CALL.args; al; al=al->tail){
            if(al->head->kind == AS_operand_::T_TEMP && al->head->u.TEMP == old_temp){
                al->head->u.TEMP = new_temp;
                return true;
            }
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_RETURN:{
        if(s->u.RET.ret->kind == AS_operand_::T_TEMP && s->u.RET.ret->u.TEMP == old_temp){
            s->u.RET.ret->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_PHI:{
        for(Phi_pair_List al=s->u.PHI.phis; al; al=al->tail){
            if(al->head->op->kind == AS_operand_::T_TEMP && al->head->op->u.TEMP == old_temp){
                al->head->op->u.TEMP = new_temp;
                return true;
            }
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_NULL:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_ALLOCA:{
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_I2F:{
        if(s->u.I2F.src->kind == AS_operand_::T_TEMP && s->u.I2F.src->u.TEMP == old_temp){
            s->u.I2F.src->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_F2I:{
        if(s->u.F2I.src->kind == AS_operand_::T_TEMP && s->u.F2I.src->u.TEMP == old_temp){
            s->u.F2I.src->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    case LLVM_IR::llvm_T_stm_::T_GEP:{
        if(s->u.GEP.base_ptr->kind == AS_operand_::T_TEMP && s->u.GEP.base_ptr->u.TEMP == old_temp){
            s->u.GEP.base_ptr->u.TEMP = new_temp;
            return true;
        }
        if(s->u.GEP.index->kind == AS_operand_::T_TEMP && s->u.GEP.index->u.TEMP == old_temp){
            s->u.GEP.index->u.TEMP = new_temp;
            return true;
        }
        return false;
    }
    default:{
        assert(0);
    }
    }
}

bool LLVM_IR::phiReplacejthSrcTemp(LLVM_IR::llvm_T_stm_ *s, int j, Temp_temp old_temp, Temp_temp new_temp){
    if(!s) return true;
    assert(s->kind == LLVM_IR::llvm_T_stm_::T_PHI);

    int i=1;
    Phi_pair_List al=s->u.PHI.phis;
    for(; al && i<j; al=al->tail, ++i);
    if(i == j){
        assert(al->head->op->kind == AS_operand_::T_TEMP && al->head->op->u.TEMP == old_temp);
        al->head->op->u.TEMP = new_temp;
        return true;
    }
    return false;
}

AS_instrList LLVM_IR::irList_to_insList(LLVM_IR::T_irList irl){
    AS_instrList iList = NULL;
    AS_instrList ilast = NULL;

    // while(irl){
    //     AS_print_llvm(stdout, irl->head->i, Temp_name());
    //     // printf("%p \n", irl->head->i->u.OPER.assem);
    //     irl = irl->tail;
    // }

    while(irl){
        if(ilast) ilast = ilast->tail = AS_InstrList(irl->head->i, NULL);
        else ilast = iList = AS_InstrList(irl->head->i, NULL);
    
        irl = irl->tail;
    }
  
    return iList;
}


T_relOp  LLVM_IR::T_notRel(T_relOp r)
{
 switch(r)
   {case T_eq: return T_ne;
    case T_ne: return T_eq;
    case T_lt: return T_ge;
    case T_ge: return T_lt;
    case T_gt: return T_le;
    case T_le: return T_gt;
    case F_eq: return F_ne;
    case F_ne: return F_eq;
    case F_lt: return F_ge;
    case F_ge: return F_lt;
    case F_gt: return F_le;
    case F_le: return F_gt;
  }
 assert(0); 
}
