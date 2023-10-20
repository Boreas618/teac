#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "assem.h"
#include "treep.hpp"
#include "gen_as.h"
#include "util.h"
#include "temp.h"
#include "graph.hpp"
#include "assemblock.h"
#include "bg.h"
#include "llvm_assem.h"
#include "ty.hpp"
#include "table.hpp"
#include "translate.hpp"
#include "llvm_assemblock.h"

static LLVM_IR::T_irList iList = NULL;
static LLVM_IR::T_irList last = NULL;
static char as_buf[200000];
static char arg_list_buf[500000];
static char arg[1000];

extern Table::Stable<TY::EnFunc *> *fenv;


extern std::unordered_map<std::string, constvar> globalconst;

static TY::tyType getReturnTy(std::string id)
{
    if (id == "1_i2f")
    {
        return TY::tyType::Ty_float;
    }
    if (id == "1_f2i")
    {
        return TY::tyType::Ty_int;
    }
    if (id == "1_memset")
    {
        return TY::tyType::Ty_void;
    }
    return fenv->look(id)->ty->tp->kind;
}

static string temp_str(Temp_temp temp)
{
    char ts[80];
    sprintf(ts, "%%t%d", temp->num);
    return String(ts);
}

static void emit(LLVM_IR::T_ir ir)
{
    // AS_print_llvm(stdout, ir->i, Temp_name());
    if (last)
        last = last->tail = LLVM_IR::T_IrList(ir, NULL);
    else
        last = iList = LLVM_IR::T_IrList(ir, NULL);
}

static LLVM_IR::T_irList to_last(LLVM_IR::T_irList List)
{
    assert(List);
    if (!List)
        return NULL;
    while (List->tail)
    {
        List = List->tail;
    }
    return List;
}

static void sprintArg_1(my_string arg, AS_operand op, int num)
{
    assert(num == 0);
    switch (op->kind)
    {
    case AS_operand_::T_TEMP:
    {
        if (op->u.TEMP->type == INT_TEMP)
        {
            sprintf(arg, "i32 `s%d", num);
        }
        else if (op->u.TEMP->type == FLOAT_TEMP)
        {
            sprintf(arg, "float `s%d", num);
        }
        else
        { // ptr
            sprintf(arg, "ptr `s%d", num);
        }
        return;
    }
    case AS_operand_::T_NAME:
    {
        if (op->u.NAME.type == INT_TEMP)
        {
            assert(0); // T_NAME is ptr type
            sprintf(arg, "i32 `s%d", num);
        }
        else if (op->u.NAME.type == FLOAT_TEMP)
        {
            assert(0); // T_NAME is ptr type
            sprintf(arg, "float `s%d", num);
        }
        else
        { // ptr
            sprintf(arg, "ptr `s%d", num);
        }
        return;
    }
    case AS_operand_::T_ICONST:
    {
        sprintf(arg, "i32 `s%d", num);
        return;
    }
    case AS_operand_::T_FCONST:
    {
        sprintf(arg, "float `s%d", num);
        return;
    }
    }
}

static void sprintArg(my_string arg, AS_operand op, int num)
{
    switch (op->kind)
    {
    case AS_operand_::T_TEMP:
    {
        if (op->u.TEMP->type == INT_TEMP)
        {
            sprintf(arg, ", i32 `s%d", num);
        }
        else if (op->u.TEMP->type == FLOAT_TEMP)
        {
            sprintf(arg, ", float `s%d", num);
        }
        else
        { // ptr
            sprintf(arg, ", ptr `s%d", num);
        }
        return;
    }
    case AS_operand_::T_NAME:
    {
        if (op->u.NAME.type == INT_TEMP)
        {
            assert(0); // T_NAME is ptr type
            sprintf(arg, ", i32 `s%d", num);
        }
        else if (op->u.NAME.type == FLOAT_TEMP)
        {
            assert(0); // T_NAME is ptr type
            sprintf(arg, ", float `s%d", num);
        }
        else
        { // ptr
            sprintf(arg, ", ptr `s%d", num);
        }
        return;
    }
    case AS_operand_::T_ICONST:
    {
        sprintf(arg, ", i32 `s%d", num);
        return;
    }
    case AS_operand_::T_FCONST:
    {
        sprintf(arg, ", float `s%d", num);
        return;
    }
    }
}

static string gen_call_assem(AS_operand dst, string method_name, AS_operandList arg_list)
{
    if (!strcmp(method_name, "1_i2f"))
    {
        return String((my_string) "`d0 = sitofp i32 `s0 to float");
    }
    if (!strcmp(method_name, "1_f2i"))
    {
        return String((my_string) "`d0 = fptosi float `s0 to i32");
    }
    if (!strcmp(method_name, "1_memset"))
    {
        AS_operand p_len = nthOperand(arg_list, 2);
        assert(p_len);
        assert(p_len->kind == AS_operand_::T_ICONST);
        sprintf(as_buf, "call void @llvm.memset.p0i8.i64(ptr `s0, i8 0, i32 %d, i1 false)", p_len->u.ICONST);
        return String(as_buf);
    }

    memset(arg_list_buf, 0, sizeof(arg_list_buf));
    arg_list_buf[0] = '(';
    int i = 1;
    for (AS_operandList al = arg_list; al; al = al->tail, ++i)
    {
        // printf("al type %d\n", al->head->kind);
        memset(arg, 0, sizeof(arg));
        if (i == 1)
            sprintArg_1(arg, al->head, i - 1);
        else
            sprintArg(arg, al->head, i - 1);
        strcat(arg_list_buf, arg);
    }

    strcat(arg_list_buf, ")");

    memset(as_buf, 0, sizeof(as_buf));

    if (!dst)
    { // void
        sprintf(as_buf, "call void @%s %s", method_name, arg_list_buf);
    }
    else
    {
        assert(dst->kind == AS_operand_::T_TEMP);
        if (dst->u.TEMP->type == INT_TEMP)
        {
            sprintf(as_buf, "`d0 = call i32 @%s %s", method_name, arg_list_buf);
        }
        else if (dst->u.TEMP->type == FLOAT_TEMP)
        {
            sprintf(as_buf, "`d0 = call float @%s %s", method_name, arg_list_buf);
        }
        else
        { // ptr
            sprintf(as_buf, "`d0 = call ptr @%s %s", method_name, arg_list_buf);
        }
    }

    return String(as_buf);
}

static LLVM_IR::T_binOp binops_enum[] =
    {LLVM_IR::T_plus,
     LLVM_IR::T_minus,
     LLVM_IR::T_mul,
     LLVM_IR::T_div,
     LLVM_IR::T_mod,
     LLVM_IR::F_plus,
     LLVM_IR::F_minus,
     LLVM_IR::F_mul,
     LLVM_IR::F_div};

static const char binops_str[][15] = {"add", "sub", "mul", "sdiv", "srem", "fadd", "fsub", "fmul", "fdiv"};

// static void ffuck(){
//     printf("ffuck\n");
// }

static AS_operand munch_Exp(T_exp e)
{
    AS_operand ret;
    switch (e->kind)
    {
    case T_BINOP:
    {
        AS_operand left = munch_Exp(e->BINOP.left);
        AS_operand right = munch_Exp(e->BINOP.right);

        // gep
        if (isIntPtr(left))
        { // gep
            assert(e->BINOP.op == T_plus);
            assert(isInt(right));
            ret = AS_Operand_Temp_NewIntPtrTemp();
            sprintf(as_buf, "`d0 = getelementptr i32, ptr `s0, i32 `s1");

            AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(ret, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(ret, left, right);
            emit(LLVM_IR::T_Ir(stm, instr));
        }
        else if (isFloatPtr(left))
        {
            assert(e->BINOP.op == T_plus);
            assert(isInt(right));
            ret = AS_Operand_Temp_NewFloatPtrTemp();
            sprintf(as_buf, "`d0 = getelementptr float, ptr `s0, i32 `s1");

            AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(ret, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(ret, left, right);
            emit(LLVM_IR::T_Ir(stm, instr));
        }
        else if (isIntPtr(right))
        { // gep
            assert(e->BINOP.op == T_plus);
            assert(isInt(left));
            ret = AS_Operand_Temp_NewIntPtrTemp();
            sprintf(as_buf, "`d0 = getelementptr i32, ptr `s1, i32 `s0");

            AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(ret, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(ret, left, right);
            emit(LLVM_IR::T_Ir(stm, instr));
        }
        else if (isFloatPtr(right))
        {
            assert(e->BINOP.op == T_plus);
            assert(isInt(left));
            ret = AS_Operand_Temp_NewFloatPtrTemp();
            sprintf(as_buf, "`d0 = getelementptr float, ptr `s1, i32 `s0");

            AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(ret, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(ret, left, right);
            emit(LLVM_IR::T_Ir(stm, instr));
        }
        else
        {
            if (isFloat(left) || isFloat(right))
            {
                ret = AS_Operand_Temp_NewFloatTemp();
                sprintf(as_buf, "`d0 = %s float `s0, `s1", binops_str[e->BINOP.op]);
            }
            else
            {
                ret = AS_Operand_Temp_NewTemp();
                sprintf(as_buf, "`d0 = %s i32 `s0, `s1", binops_str[e->BINOP.op]);
            }
            AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(ret, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[e->BINOP.op], ret, left, right);
            emit(LLVM_IR::T_Ir(stm, instr));
        }

        return ret;
    }
    case T_MEM:
    {
        AS_operand ptr = munch_Exp(e->MEM);

        if (isIntPtr(ptr))
        {
            ret = AS_Operand_Temp_NewTemp();

            if(e->MEM->kind == T_NAME 
            && globalconst.find(e->MEM->NAME.label) != globalconst.end()){
                AS_operand newConst = AS_Operand_Const(globalconst.find(e->MEM->NAME.label)->second.intvalue);
                AS_instr instr = AS_Oper((string) "`d0 = bitcast i32 `s0 to i32", AS_OperandList(ret, NULL), AS_OperandList(newConst, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(ret, newConst);
                emit(LLVM_IR::T_Ir(stm, instr));
            }else{
                AS_instr instr = AS_Oper((string) "`d0 = load i32, ptr `s0", AS_OperandList(ret, NULL), AS_OperandList(ptr, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(ret, ptr);
                emit(LLVM_IR::T_Ir(stm, instr));
            }

            return ret;
        }
        else if (isFloatPtr(ptr))
        {
            ret = AS_Operand_Temp_NewFloatTemp();

            if(e->MEM->kind == T_NAME 
            && globalconst.find(e->MEM->NAME.label) != globalconst.end()){
                AS_operand newConst = AS_Operand_FConst(globalconst.find(e->MEM->NAME.label)->second.floatvalue);
                AS_instr instr = AS_Oper((string) "`d0 = bitcast float `s0 to float", AS_OperandList(ret, NULL), AS_OperandList(newConst, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(ret, newConst);
                emit(LLVM_IR::T_Ir(stm, instr));
            }else{
                AS_instr instr = AS_Oper((string) "`d0 = load float, ptr `s0", AS_OperandList(ret, NULL), AS_OperandList(ptr, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(ret, ptr);
                emit(LLVM_IR::T_Ir(stm, instr));
            }

            return ret;
        }
        else
        {
            assert(0);
            return ret;
        }
    }
    case T_TEMP:
    {
        return AS_Operand_Temp(e->TEMP);
    }
    case T_ESEQ:
    {
        assert(0);
        return NULL;
    }
    case T_NAME:
    {
        
        return AS_Operand_Name(S_Symbol((my_string)e->NAME.label.c_str()), e->NAME.type);
    }
    case T_CONST:
    {
        return AS_Operand_Const(e->ICONST);
    }
    case T_FCONST:
    {
        return AS_Operand_FConst(e->FCONST);
    }
    case T_CALL:
    {
        T_expList el = e->CALL.args;
        AS_operandList operandList;
        AS_operandList operandLast;
        operandList = operandLast = NULL;
        int arg_num = 0;
        for (; el; el = el->tail, ++arg_num)
        {
            assert(el->head);
            if (operandLast)
                operandLast = operandLast->tail = AS_OperandList(munch_Exp(el->head), NULL);
            else
                operandLast = operandList = AS_OperandList(munch_Exp(el->head), NULL);
        }

        my_string fun = (my_string)e->CALL.id.c_str();
        // printf("%s\n", e->CALL.id.c_str());
        // printf("type %d\n", operandList->head->kind);
        TY::tyType ty = getReturnTy(e->CALL.id);

        if (ty == TY::tyType::Ty_void)
        {
            AS_instr instr = AS_Oper(gen_call_assem(NULL, fun, operandList), NULL, operandList, NULL);
            LLVM_IR::llvm_T_stm_ *stm = NULL;
            // deal with memset
            if(!strcmp(fun, "1_memset"))
                stm = LLVM_IR::T_VoidCall((my_string)"1_memset", operandList);
            else
                stm = LLVM_IR::T_VoidCall(fun, operandList);
            emit(LLVM_IR::T_Ir(stm, instr));

            return NULL;
        }
        else if (ty == TY::tyType::Ty_int)
        {
            ret = AS_Operand_Temp_NewTemp();

            AS_instr instr = AS_Oper(gen_call_assem(ret, fun, operandList), AS_OperandList(ret, NULL), operandList, NULL);
            LLVM_IR::llvm_T_stm_ *stm = NULL;
            // deal with f2i
            if(!strcmp(fun, "1_f2i"))
                stm = LLVM_IR::T_F2i(ret, operandList->head);
            else
                stm = LLVM_IR::T_Call(fun, ret, operandList);
            emit(LLVM_IR::T_Ir(stm, instr));

            return ret;
        }
        else if (ty == TY::tyType::Ty_float)
        {
            ret = AS_Operand_Temp_NewFloatTemp();

            AS_instr instr = AS_Oper(gen_call_assem(ret, fun, operandList), AS_OperandList(ret, NULL), operandList, NULL);
            LLVM_IR::llvm_T_stm_ *stm = NULL;
            // deal with i2f
            if(!strcmp(fun, "1_i2f"))
                stm = LLVM_IR::T_I2f(ret, operandList->head);
            else
                stm = LLVM_IR::T_Call(fun, ret, operandList);
            emit(LLVM_IR::T_Ir(stm, instr));

            return ret;
        }
        else
        {
            assert(0);

            return ret;
        }
    }
    default:
    {
        assert(0);
    }
    } /* end of switch */
}

static LLVM_IR::T_relOp relops_enum[] = {LLVM_IR::T_eq, LLVM_IR::T_ne, LLVM_IR::T_lt, LLVM_IR::T_gt, LLVM_IR::T_le, LLVM_IR::T_ge, LLVM_IR::F_eq, LLVM_IR::F_ne, LLVM_IR::F_lt, LLVM_IR::F_gt, LLVM_IR::F_le, LLVM_IR::F_ge};

static const char relops_str[][15] = {"eq", "ne", "slt", "sgt", "sle", "sge", "oeq", "one", "olt", "ogt", "ole", "oge"};

static void munch_Stm(T_stm s)
{
    switch (s->kind)
    {
    case T_SEQ:
    {
        munch_Stm(s->SEQ.left);
        munch_Stm(s->SEQ.right);
        return;
    }
    case T_LABEL:
    {
        my_string label_str = (my_string)s->LABEL.c_str();
        Temp_label label = S_Symbol(label_str);
        AS_instr instr = AS_Label(StringLabel(label_str), label);
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Label(label);
        emit(LLVM_IR::T_Ir(stm, instr));
        return;
    }
    case T_JUMP:
    {
        my_string label_str = (my_string)s->JUMP.jump.c_str();
        Temp_label label = S_Symbol(label_str);
        AS_instr instr = AS_Oper((string) "br label `j0", NULL, NULL, AS_Targets(Temp_LabelList(label, NULL)));
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Jump(label);
        emit(LLVM_IR::T_Ir(stm, instr));
        return;
    }
    case T_CJUMP:
    {
        AS_operand left = munch_Exp(s->CJUMP.left);
        AS_operand right = munch_Exp(s->CJUMP.right);
        AS_operand cond = AS_Operand_Temp_NewTemp();

        if (s->CJUMP.op < F_eq)
        {
            sprintf(as_buf, "`d0 = icmp %s i32 `s0, `s1", relops_str[s->CJUMP.op]);
        }
        else
        {
            sprintf(as_buf, "`d0 = fcmp %s float `s0, `s1", relops_str[s->CJUMP.op]);
        }

        AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(cond, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Cmp(relops_enum[s->CJUMP.op], left, right);
        emit(LLVM_IR::T_Ir(stm, instr));

        my_string true_label_str = (my_string)s->CJUMP.t.c_str();
        Temp_label true_label = S_Symbol(true_label_str);
        my_string false_label_str = (my_string)s->CJUMP.f.c_str();
        Temp_label false_label = S_Symbol(false_label_str);

        instr = AS_Oper((string) "br i1 `s0, label `j0, label `j1", NULL, AS_OperandList(cond, NULL), AS_Targets(Temp_LabelList(true_label, Temp_LabelList(false_label, NULL))));
        stm = LLVM_IR::T_Cjump(relops_enum[s->CJUMP.op], true_label, false_label);
        emit(LLVM_IR::T_Ir(stm, instr));

        return;
    }
    case T_MOVE:
    {
        switch (s->MOVE.dst->kind)
        {
        case T_TEMP:
        {
            switch (s->MOVE.src->kind)
            {
            case T_BINOP:
            {
                AS_operand left = munch_Exp(s->MOVE.src->BINOP.left);
                AS_operand right = munch_Exp(s->MOVE.src->BINOP.right);
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);

                // gep
                if (isIntPtr(left))
                {
                    assert(s->MOVE.src->BINOP.op == T_plus);
                    assert(opTypeEqInfer(left, dst));
                    assert(isInt(right) || isUnknown(right));
                    sprintf(as_buf, "`d0 = getelementptr i32, ptr `s0, i32 `s1");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(dst, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));
                }
                else if (isFloatPtr(left))
                {
                    assert(s->MOVE.src->BINOP.op == T_plus);
                    assert(opTypeEqInfer(left, dst));
                    assert(isInt(right) || isUnknown(right));
                    sprintf(as_buf, "`d0 = getelementptr float, ptr `s0, i32 `s1");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(dst, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));
                }
                else if (isIntPtr(right))
                { // gep
                    assert(s->MOVE.src->BINOP.op == T_plus);
                    assert(opTypeEqInfer(right, dst));
                    assert(isInt(left) || isUnknown(left));
                    sprintf(as_buf, "`d0 = getelementptr i32, ptr `s1, i32 `s0");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(dst, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));
                }
                else if (isFloatPtr(right))
                {
                    assert(s->MOVE.src->BINOP.op == T_plus);
                    assert(opTypeEqInfer(right, dst));
                    assert(isInt(left) || isUnknown(left));
                    sprintf(as_buf, "`d0 = getelementptr float, ptr `s1, i32 `s0");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Gep(dst, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));
                }
                else
                {
                    if (isFloat(left))
                    {
                        assert(opTypeEqInfer(left, dst));
                        sprintf(as_buf, "`d0 = %s float `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);
                    }
                    else if (isFloat(right))
                    {
                        assert(opTypeEqInfer(right, dst));
                        sprintf(as_buf, "`d0 = %s float `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);
                    }
                    else if (isInt(left))
                    {
                        assert(opTypeEqInfer(left, dst));
                        sprintf(as_buf, "`d0 = %s i32 `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);
                    }
                    else if (isInt(right))
                    {
                        assert(opTypeEqInfer(right, dst));
                        sprintf(as_buf, "`d0 = %s i32 `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);
                    }
                    else
                    {
                        assert(0);
                    }
                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], dst, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));
                }

                return;
            }
            case T_MEM:
            {
                AS_operand ptr = munch_Exp(s->MOVE.src->MEM);
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                if (isIntPtr(ptr)){
                    opTypeMemInfer(ptr, dst);

                    if(s->MOVE.src->MEM->kind == T_NAME 
                    && globalconst.find(s->MOVE.src->MEM->NAME.label) != globalconst.end()){
                        AS_operand newConst = AS_Operand_Const(globalconst.find(s->MOVE.src->MEM->NAME.label)->second.intvalue);
                        AS_instr instr = AS_Oper((string) "`d0 = bitcast i32 `s0 to i32", AS_OperandList(dst, NULL), AS_OperandList(newConst, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, newConst);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }else{
                        AS_instr instr = AS_Oper((string) "`d0 = load i32, ptr `s0", AS_OperandList(dst, NULL), AS_OperandList(ptr, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(dst, ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }
                    
                    return;
                }else if (isFloatPtr(ptr)){
                    opTypeMemInfer(ptr, dst);

                    if(s->MOVE.src->MEM->kind == T_NAME 
                    && globalconst.find(s->MOVE.src->MEM->NAME.label) != globalconst.end()){
                        AS_operand newConst = AS_Operand_FConst(globalconst.find(s->MOVE.src->MEM->NAME.label)->second.floatvalue);
                        AS_instr instr = AS_Oper((string) "`d0 = bitcast float `s0 to float", AS_OperandList(dst, NULL), AS_OperandList(newConst, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, newConst);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }else{
                        AS_instr instr = AS_Oper((string) "`d0 = load float, ptr `s0", AS_OperandList(dst, NULL), AS_OperandList(ptr, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(dst, ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }
                    
                    return;
                }else{
                    assert(0);
                    return;
                }
            }
            case T_TEMP:
            {
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                AS_operand src = AS_Operand_Temp(s->MOVE.src->TEMP);

                if (isFloatPtr(dst))
                {
                    // printf("dst %d %d src %d %d\n", dst->u.TEMP->num, dst->u.TEMP->type, src->u.TEMP->num, src->u.TEMP->type);
                    assert(opTypeEqInfer(src, dst));

                    AS_instr instr = AS_Move((string) "`d0 = bitcast ptr `s0 to ptr", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isIntPtr(dst))
                {
                    assert(opTypeEqInfer(src, dst));

                    AS_instr instr = AS_Move((string) "`d0 = bitcast ptr `s0 to ptr", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isFloat(dst))
                {
                    assert(opTypeEqInfer(src, dst));

                    AS_instr instr = AS_Move((string) "`d0 = bitcast float `s0 to float", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isInt(dst))
                {
                    // printf("dst %d src %d\n", dst->u.TEMP->num, src->u.TEMP->num);
                    assert(opTypeEqInfer(src, dst));

                    AS_instr instr = AS_Move((string) "`d0 = bitcast i32 `s0 to i32", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else
                { // unknown
                    if (isFloatPtr(src) || isIntPtr(src))
                    {
                        assert(opTypeEqInfer(src, dst));
                        AS_instr instr = AS_Move((string) "`d0 = bitcast ptr `s0 to ptr", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        return;
                    }
                    else if (isFloat(src))
                    {
                        assert(opTypeEqInfer(src, dst));
                        AS_instr instr = AS_Move((string) "`d0 = bitcast float `s0 to float", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        return;
                    }
                    else if (isInt(src))
                    {
                        assert(opTypeEqInfer(src, dst));
                        AS_instr instr = AS_Move((string) "`d0 = bitcast i32 `s0 to i32", AS_OperandList(dst, NULL), AS_OperandList(src, NULL));
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        return;
                    }
                    else
                    {
                        assert(0);
                    }
                }
            }
            case T_ESEQ:
            {
                assert(0);
                return;
            }
            case T_NAME:
            {
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                my_string label_str = (my_string)s->MOVE.src->NAME.label.c_str();
                Temp_label label = S_Symbol(label_str);
                AS_operand src = AS_Operand_Name(label, s->MOVE.src->NAME.type);

                if (isFloatPtr(src))
                    assert(opTypeEqInfer(src, dst));
                else if (isIntPtr(src))
                    assert(opTypeEqInfer(src, dst));
                else
                    assert(0); // T_NAME is ptr type

                sprintf(as_buf, "`d0 = bitcast ptr @%s to ptr", label_str);

                AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            case T_CONST:
            {
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                AS_operand src1 = AS_Operand_Const(s->MOVE.src->ICONST);

                assert(opTypeEqInfer(src1, dst));

                sprintf(as_buf, "`d0 = bitcast i32 `s0 to i32");

                AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(src1, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src1);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            case T_FCONST:
            {
                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                AS_operand src1 = AS_Operand_FConst(s->MOVE.src->FCONST);

                assert(opTypeEqInfer(src1, dst));

                sprintf(as_buf, "`d0 = bitcast float `s0 to float");

                AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(src1, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(dst, src1);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            case T_CALL:
            {
                // gen operandList
                T_expList el = s->MOVE.src->CALL.args;
                AS_operandList operandList;
                AS_operandList operandLast;
                operandList = operandLast = NULL;
                int arg_num = 0;
                for (; el; el = el->tail, ++arg_num)
                {
                    assert(el->head);
                    if (operandLast)
                        operandLast = operandLast->tail = AS_OperandList(munch_Exp(el->head), NULL);
                    else
                        operandLast = operandList = AS_OperandList(munch_Exp(el->head), NULL);
                }

                AS_operand dst = AS_Operand_Temp(s->MOVE.dst->TEMP);
                my_string fun = (my_string)s->MOVE.src->CALL.id.c_str();

                if (s->MOVE.src->CALL.id == "1_arr")
                {
                    assert(isFloatPtr(dst) || isIntPtr(dst));
                    if (isIntPtr(dst))
                    {
                        assert(operandList->head->kind == AS_operand_::T_ICONST);
                        AS_instr instr = AS_Oper((my_string) "`d0 = alloca [`s0 x i32]", AS_OperandList(dst, NULL), operandList, NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Alloca(dst, operandList->head->u.ICONST * 4, true);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        return;
                    }
                    else
                    {
                        assert(operandList->head->kind == AS_operand_::T_ICONST);
                        AS_instr instr = AS_Oper((my_string) "`d0 = alloca [`s0 x float]", AS_OperandList(dst, NULL), operandList, NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Alloca(dst, operandList->head->u.ICONST * 4, false);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        return;
                    }
                }

                AS_instr instr = AS_Oper(gen_call_assem(dst, fun, operandList), AS_OperandList(dst, NULL), operandList, NULL);

                LLVM_IR::llvm_T_stm_ *stm = NULL;
                // deal with i2f
                if(!strcmp(fun, "1_i2f"))
                    stm = LLVM_IR::T_I2f(dst, operandList->head);
                else if(!strcmp(fun, "1_f2i"))
                    stm = LLVM_IR::T_F2i(dst, operandList->head);
                else
                    stm = LLVM_IR::T_Call(fun, dst, operandList);

                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            default:
            {
                assert(0);
                return;
            }
            }
        }
        case T_MEM:
        {
            AS_operand store_ptr = munch_Exp(s->MOVE.dst->MEM);

            switch (s->MOVE.src->kind)
            {
            case T_BINOP:
            {
                AS_operand left = munch_Exp(s->MOVE.src->BINOP.left);
                AS_operand right = munch_Exp(s->MOVE.src->BINOP.right);
                AS_operand res;

                // TODO: gep
                if (isIntPtr(left))
                { // gep
                    assert(0); // do not store ptr
                    assert(isInt(right));
                    res = AS_Operand_Temp_NewIntPtrTemp();
                    sprintf(as_buf, "`d0 = getelementptr i32, ptr `s0, i32 `s1");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isFloatPtr(left))
                {
                    assert(0); // do not store ptr
                    assert(isInt(right));
                    res = AS_Operand_Temp_NewFloatPtrTemp();
                    sprintf(as_buf, "`d0 = getelementptr float, ptr `s0, i32 `s1");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isIntPtr(right))
                { // gep
                    assert(0); // do not store ptr
                    assert(isInt(left));
                    res = AS_Operand_Temp_NewIntPtrTemp();
                    sprintf(as_buf, "`d0 = getelementptr i32, ptr `s1, i32 `s0");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isFloatPtr(right))
                {
                    assert(0); // do not store ptr
                    assert(isInt(left));
                    res = AS_Operand_Temp_NewFloatPtrTemp();
                    sprintf(as_buf, "`d0 = getelementptr float, ptr `s1, i32 `s0");

                    AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else
                {
                    if (isFloat(left) || isFloat(right))
                    {
                        res = AS_Operand_Temp_NewFloatTemp();
                        sprintf(as_buf, "`d0 = %s float `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);

                        AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                        stm = LLVM_IR::T_Store(res, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        return;
                    }
                    else
                    {
                        res = AS_Operand_Temp_NewTemp();
                        sprintf(as_buf, "`d0 = %s i32 `s0, `s1", binops_str[s->MOVE.src->BINOP.op]);

                        AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(res, NULL), AS_OperandList(left, AS_OperandList(right, NULL)), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Binop(binops_enum[s->MOVE.src->BINOP.op], res, left, right);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                        stm = LLVM_IR::T_Store(res, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        return;
                    }
                }
            }
            case T_MEM:
            {
                AS_operand load_ptr = munch_Exp(s->MOVE.src->MEM);

                if (isFloatPtr(load_ptr))
                {
                    if(s->MOVE.src->MEM->kind == T_NAME 
                    && globalconst.find(s->MOVE.src->MEM->NAME.label) != globalconst.end()){
                        AS_operand newConst = AS_Operand_FConst(globalconst.find(s->MOVE.src->MEM->NAME.label)->second.floatvalue);
                        AS_instr instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(newConst, AS_OperandList(store_ptr, NULL)), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(newConst, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                        
                    }else{
                        AS_operand res = AS_Operand_Temp_NewFloatTemp();

                        AS_instr instr = AS_Oper((string) "`d0 = load float, ptr `s0", AS_OperandList(res, NULL), AS_OperandList(load_ptr, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(res, load_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                        stm = LLVM_IR::T_Store(res, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }

                    return;
                }
                else if (isIntPtr(load_ptr))
                {
                    if(s->MOVE.src->MEM->kind == T_NAME 
                    && globalconst.find(s->MOVE.src->MEM->NAME.label) != globalconst.end()){
                        AS_operand newConst = AS_Operand_Const(globalconst.find(s->MOVE.src->MEM->NAME.label)->second.intvalue);
                        AS_instr instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(newConst, AS_OperandList(store_ptr, NULL)), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(newConst, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }else{
                        AS_operand res = AS_Operand_Temp_NewTemp();

                        AS_instr instr = AS_Oper((string) "`d0 = load i32, ptr `s0", AS_OperandList(res, NULL), AS_OperandList(load_ptr, NULL), NULL);
                        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Load(res, load_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));

                        instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                        stm = LLVM_IR::T_Store(res, store_ptr);
                        emit(LLVM_IR::T_Ir(stm, instr));
                    }
                    return;
                }
                else
                {
                    assert(0);
                    return;
                }
            }
            case T_TEMP:
            {
                AS_operand res = AS_Operand_Temp(s->MOVE.src->TEMP);

                if (isFloat(res))
                {
                    AS_instr instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isInt(res))
                {
                    AS_instr instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else
                {
                    assert(0);
                    return;
                }
            }
            case T_ESEQ:
            {
                assert(0);
                return;
            }
            case T_NAME:
            {
                // you should not store a ptr
                assert(0);
                return;
            }
            case T_CONST:
            {
                AS_operand con = AS_Operand_Const(s->MOVE.src->ICONST);

                sprintf(as_buf, "store i32 `s0, ptr `s1");

                AS_instr instr = AS_Oper(String(as_buf), NULL, AS_OperandList(con, AS_OperandList(store_ptr,  NULL)), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(con, store_ptr);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            case T_FCONST:
            {
                AS_operand con = AS_Operand_FConst(s->MOVE.src->FCONST);

                sprintf(as_buf, "store float `s0, ptr `s1");

                AS_instr instr = AS_Oper(String(as_buf), NULL, AS_OperandList(con, AS_OperandList(store_ptr, NULL)), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Store(con, store_ptr);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            case T_CALL:
            {
                // gen operandList
                T_expList el = s->MOVE.src->CALL.args;
                AS_operandList operandList;
                AS_operandList operandLast;
                operandList = operandLast = NULL;
                int arg_num = 0;
                for (; el; el = el->tail, ++arg_num)
                {
                    assert(el->head);
                    if (operandLast)
                        operandLast = operandLast->tail = AS_OperandList(munch_Exp(el->head), NULL);
                    else
                        operandLast = operandList = AS_OperandList(munch_Exp(el->head), NULL);
                }

                if (isFloatPtr(store_ptr))
                {
                    AS_operand res = AS_Operand_Temp_NewFloatTemp();
                    my_string fun = (my_string)s->MOVE.src->CALL.id.c_str();

                    AS_instr instr = AS_Oper(gen_call_assem(res, fun, operandList), AS_OperandList(res, NULL), operandList, NULL);
                    LLVM_IR::llvm_T_stm_ *stm = NULL;
                    // deal with i2f
                    if(!strcmp(fun, "1_i2f"))
                        stm = LLVM_IR::T_I2f(res, operandList->head);
                    else
                        stm = LLVM_IR::T_Call(fun, res, operandList);

                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store float `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else if (isIntPtr(store_ptr))
                {
                    AS_operand res = AS_Operand_Temp_NewTemp();
                    my_string fun = (my_string)s->MOVE.src->CALL.id.c_str();

                    AS_instr instr = AS_Oper(gen_call_assem(res, fun, operandList), AS_OperandList(res, NULL), operandList, NULL);
                    LLVM_IR::llvm_T_stm_ *stm = NULL;
                    // deal with f2i
                    if(!strcmp(fun, "1_f2i"))
                        stm = LLVM_IR::T_F2i(res, operandList->head);
                    else
                        stm = LLVM_IR::T_Call(fun, res, operandList);

                    emit(LLVM_IR::T_Ir(stm, instr));

                    instr = AS_Oper((string) "store i32 `s0, ptr `s1", NULL, AS_OperandList(res, AS_OperandList(store_ptr, NULL)), NULL);
                    stm = LLVM_IR::T_Store(res, store_ptr);
                    emit(LLVM_IR::T_Ir(stm, instr));

                    return;
                }
                else
                {
                    assert(0);
                    return;
                }
            }
            default:
            {
                assert(0);
                return;
            }
            }
        }
        default:
        {
            assert(0);
            return;
        }
        }
    }
    case T_EXP:
    {
        munch_Exp(s->EXP);
        return;
    }
    case T_RETURN:
    {
        if (s->EXP)
        {
            AS_operand ret = munch_Exp(s->EXP);

            if (isFloat(ret))
            {
                AS_instr instr = AS_Oper((string) "ret float `s0", NULL, AS_OperandList(ret, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Return(ret);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            else if (isInt(ret))
            {
                AS_instr instr = AS_Oper((string) "ret i32 `s0", NULL, AS_OperandList(ret, NULL), NULL);
                LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Return(ret);
                emit(LLVM_IR::T_Ir(stm, instr));

                return;
            }
            else
            {
                assert(0);
                return;
            }
        }
        else
        { // return null
            AS_instr instr = AS_Oper((string) "ret void", NULL, NULL, NULL);
            LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Return(NULL);
            emit(LLVM_IR::T_Ir(stm, instr));

            return;
        }
    }
    default:
    {
        assert(0);
        return;
    }
    }
    return;
}

// gen asList for a C_Block
LLVM_IR::T_irList gen_asList(T_stmList sl)
{
    iList = last = NULL;
    for (; sl; sl = sl->tail)
    {
        assert(sl->head);
        munch_Stm(sl->head);
    }
    return iList;
}

// gen prolog for a method
AS_instrList gen_prolog_llvm(std::string &method_name, Temp_tempList args)
{
    memset(arg_list_buf, 0, sizeof(arg_list_buf));
    arg_list_buf[0] = '(';
    for (int i = 0; args; args = args->tail, ++i)
    {
        memset(arg, 0, sizeof(arg));
        if (i == 0)
        {
            switch (args->head->type)
            {
            case INT_TEMP:
            {
                sprintf(arg, "i32 %%t%d", args->head->num);
                break;
            }
            case FLOAT_TEMP:
            {
                sprintf(arg, "float %%t%d", args->head->num);
                break;
            }
            case INT_PTR:
            case FLOAT_PTR:
            {
                sprintf(arg, "ptr %%t%d", args->head->num);
                break;
            }
            default:
            {
                assert(0);
                break;
            }
            }
        }
        else
        {
            switch (args->head->type)
            {
            case INT_TEMP:
            {
                sprintf(arg, ", i32 %%t%d", args->head->num);
                break;
            }
            case FLOAT_TEMP:
            {
                sprintf(arg, ", float %%t%d", args->head->num);
                break;
            }
            case INT_PTR:
            case FLOAT_PTR:
            {
                sprintf(arg, ", ptr %%t%d", args->head->num);
                break;
            }
            default:
            {
                assert(0);
                break;
            }
            }
        }
        strcat(arg_list_buf, arg);
    }
    strcat(arg_list_buf, ")");

    memset(as_buf, 0, sizeof(as_buf));
    TY::tyType returnTy = getReturnTy(method_name);
    switch (returnTy)
    {
    case TY::tyType::Ty_float:
    {
        sprintf(as_buf, "define float @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    case TY::tyType::Ty_int:
    {
        sprintf(as_buf, "define i32 @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    case TY::tyType::Ty_void:
    {
        sprintf(as_buf, "define void @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    default:
    {
        assert(0);
        break;
    }
    }

    string define_assem = (string)malloc((int)strlen(as_buf)+10);
    strcpy(define_assem, as_buf);

    return AS_InstrList(AS_Oper(define_assem, NULL, NULL, NULL), NULL);
}

// gen epilog for a method
AS_instrList gen_epilog_llvm(std::string &method_name, Temp_label lexit)
{
    TY::EnFunc *func = fenv->look(method_name);
    if (func->ty->tp->kind == TY::tyType::Ty_void)
    {
        return AS_InstrList(AS_Label(StringLabel(Temp_labelstring(lexit)), lexit),
                            AS_InstrList(AS_Oper((string) "ret void", NULL, NULL, NULL),
                                         AS_InstrList(AS_Oper((string) "}", NULL, NULL, NULL),
                                                      NULL)));
    }
    else if (func->ty->tp->kind == TY::tyType::Ty_int)
    {
        return AS_InstrList(AS_Label(StringLabel(Temp_labelstring(lexit)), lexit),
                            AS_InstrList(AS_Oper((string) "ret i32 0", NULL, NULL, NULL),
                                         AS_InstrList(AS_Oper((string) "}", NULL, NULL, NULL),
                                                      NULL)));
    }
    else if (func->ty->tp->kind == TY::tyType::Ty_float)
    {
        return AS_InstrList(AS_Label(StringLabel(Temp_labelstring(lexit)), lexit),
                            AS_InstrList(AS_Oper((string) "ret float -0.0", NULL, NULL, NULL),
                                         AS_InstrList(AS_Oper((string) "}", NULL, NULL, NULL),
                                                      NULL)));
    }
    else
    {
        assert(0);
        return NULL;
    }
}

// gen prolog for a method
LLVM_IR::T_irList_ *gen_prolog_llvm_ir(std::string &method_name, Temp_tempList args)
{
    memset(arg_list_buf, 0, sizeof(arg_list_buf));
    arg_list_buf[0] = '(';
    for (int i = 0; args; args = args->tail, ++i)
    {
        memset(arg, 0, sizeof(arg));
        if (i == 0)
        {
            switch (args->head->type)
            {
            case INT_TEMP:
            {
                sprintf(arg, "i32 %%t%d", args->head->num);
                break;
            }
            case FLOAT_TEMP:
            {
                sprintf(arg, "float %%t%d", args->head->num);
                break;
            }
            case INT_PTR:
            case FLOAT_PTR:
            {
                sprintf(arg, "ptr %%t%d", args->head->num);
                break;
            }
            default:
            {
                assert(0);
                break;
            }
            }
        }
        else
        {
            switch (args->head->type)
            {
            case INT_TEMP:
            {
                sprintf(arg, ", i32 %%t%d", args->head->num);
                break;
            }
            case FLOAT_TEMP:
            {
                sprintf(arg, ", float %%t%d", args->head->num);
                break;
            }
            case INT_PTR:
            case FLOAT_PTR:
            {
                sprintf(arg, ", ptr %%t%d", args->head->num);
                break;
            }
            default:
            {
                assert(0);
                break;
            }
            }
        }
        strcat(arg_list_buf, arg);
    }
    strcat(arg_list_buf, ")");

    memset(as_buf, 0, sizeof(as_buf));
    TY::tyType returnTy = getReturnTy(method_name);
    switch (returnTy)
    {
    case TY::tyType::Ty_float:
    {
        sprintf(as_buf, "define float @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    case TY::tyType::Ty_int:
    {
        sprintf(as_buf, "define i32 @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    case TY::tyType::Ty_void:
    {
        sprintf(as_buf, "define void @%s %s {", method_name.c_str(), arg_list_buf);
        break;
    }
    default:
    {
        assert(0);
        break;
    }
    }

    return LLVM_IR::T_IrList(LLVM_IR::T_Ir(NULL, AS_Oper(String(as_buf), NULL, NULL, NULL)), NULL);
}

// gen epilog for a method
LLVM_IR::T_irList_ *gen_retInsList_llvm_ir(std::string &method_name, Temp_label lexit)
{
    TY::EnFunc *func = fenv->look(method_name);
    if (func->ty->tp->kind == TY::tyType::Ty_void)
    {
        return LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Label(lexit), AS_Label(StringLabel(Temp_labelstring(lexit)), lexit)),
                                 LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Return(NULL), AS_Oper((string) "ret void", NULL, NULL, NULL)),
                                                   
                                                                     NULL));
    }
    else if (func->ty->tp->kind == TY::tyType::Ty_int)
    {
        return LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Label(lexit), AS_Label(StringLabel(Temp_labelstring(lexit)), lexit)),
                                 LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Return(AS_Operand_Const(0)), AS_Oper((string) "ret i32 0", NULL, NULL, NULL)),
                                                   
                                                                     NULL));
    }
    else if (func->ty->tp->kind == TY::tyType::Ty_float)
    {
        return LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Label(lexit), AS_Label(StringLabel(Temp_labelstring(lexit)), lexit)),
                                 LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Return(AS_Operand_FConst(-0.0)), AS_Oper((string) "ret float -0.0", NULL, NULL, NULL)),
                                                   
                                                                     NULL));
    }
    else
    {
        assert(0);
        return NULL;
    }
}

LLVM_IR::T_irList_ *gen_epilog_llvm_ir(void)
{
    return LLVM_IR::T_IrList(LLVM_IR::T_Ir(NULL, AS_Oper((string) "}", NULL, NULL, NULL)),
                                                                     NULL);
}

