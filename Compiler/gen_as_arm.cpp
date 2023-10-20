#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cmath>
#include "assem.h"
#include "treep.hpp"
#include "gen_as_arm.h"
#include "util.h"
#include "temp.h"
#include "graph.hpp"
#include "assemblock.h"
#include "bg.h"
#include "llvm_assem.h"
#include "llvm_assemblock.h"

using namespace LLVM_IR;

#define GP_ARG_NUM 4

#define FP_ARG_NUM 16

int max_call_arg_num = 3;

extern struct Temp_temp_ r[RESEVED_REG];
extern struct Temp_temp_ callee_saved[RESEVED_REG];

extern struct Temp_temp_ r_fp[RESEVED_REG];
extern struct Temp_temp_ callee_saved_fp[RESEVED_REG];

extern std::string filename;

static AS_operandList caller_saved = AS_OperandList(AS_Operand_Temp(&r[0]),
                                    AS_OperandList(AS_Operand_Temp(&r[1]),
                                    AS_OperandList(AS_Operand_Temp(&r[2]),
                                    AS_OperandList(AS_Operand_Temp(&r[3]),
                                    AS_OperandList(AS_Operand_Temp(&r[14]),
                                    AS_OperandList(AS_Operand_Temp(&r[12]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[0]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[1]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[2]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[3]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[4]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[5]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[6]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[7]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[8]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[9]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[10]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[11]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[12]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[13]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[14]),
                                    AS_OperandList(AS_Operand_Temp(&r_fp[15]), NULL))))))))))))))))))))));

static AS_instrList iList = NULL;
static AS_instrList last = NULL;
static char as_buf[200000];
static char arg_list_buf[500000];
static char arg[1000];

static const int higher_mask = 0xffff0000;
static const int lower_mask = 0x0000ffff;

int localOffset = REG_SIZE;

void reset_localOffset_before_gen_arm()
{
    localOffset = REG_SIZE;
}

int get_localOffset()
{
    return localOffset;
}

static inline int fcon2i(float *f)
{
    return *(int *)f;
}

static inline int get_lower(int num)
{
    return num & lower_mask;
}

static inline int get_higher(int num)
{
    return ((unsigned int)num & higher_mask) >> 16;
}

static bool imm8m(int n)
{
    unsigned int mask[8] = {0xffffff00, 0x3fffffc0, 0x0ffffff0, 0x03fffffc, 0x00ffffff, 0xffc03fff, 0xfffff00f, 0xfffffc03};
    for (int i = 0; i < 8; ++i)
    {
        if ((mask[i] & n) == 0)
            return true;
    }
    return false;
}

static int armSpOffset(int offset)
{
    return ((offset / 8) + 1) * 8;
}

static void emit(AS_instr inst)
{
    if (last)
        last = last->tail = AS_InstrList(inst, NULL);
    else
        last = iList = AS_InstrList(inst, NULL);
}

// if not memset
// you should add func_name to the head of call_used
static void emit_call_bl(string func_name, AS_operandList call_used, int loopDepth){
    if(!strcmp(func_name, "1_memset")){
        emit(AS_Oper((string) "bl memset", caller_saved, call_used, NULL, loopDepth));
    }else{
        emit(AS_Oper((string) "bl `s0", caller_saved, AS_OperandList(AS_Operand_Name(Temp_namedlabel(func_name), UNKNOWN), call_used), NULL, loopDepth));
    }
}

static void emit_move(AS_operand dst, AS_operand src, int loopDepth)
{
    assert(dst->kind == AS_operand_::T_TEMP);
    switch (src->kind)
    {
    case AS_operand_::T_TEMP:
    {
        opTypeEqInfer(src, dst);

        if (isFloat(src))
        {
            emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(src, NULL), loopDepth));
        }
        else
        {
            emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(src, NULL), loopDepth));
        }

        return;
    }
    case AS_operand_::T_NAME:
    {
        sprintf(as_buf, "movw `d0, #:lower16:%s\nmovt `d0, #:upper16:%s", Temp_labelstring(src->u.NAME.name), Temp_labelstring(src->u.NAME.name));
        emit(AS_Oper(String(as_buf), AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL, loopDepth));
        return;
    }
    case AS_operand_::T_ICONST:
    {
        if(imm8m(src->u.ICONST)){
            emit(AS_Oper((string) "mov `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL, loopDepth));
        }else if(imm8m((-src->u.ICONST) - 1)){
            src->u.ICONST = (-src->u.ICONST) - 1;
            emit(AS_Oper((string) "mvn `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL, loopDepth));
        }else if(0 <= src->u.ICONST && src->u.ICONST <= 65535){
            emit(AS_Oper((string) "movw `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(src, NULL), NULL, loopDepth));
        }else{
            AS_operand lo_src = AS_Operand_Const(get_lower(src->u.ICONST));
            AS_operand hi_src = AS_Operand_Const(get_higher(src->u.ICONST));
            emit(AS_Oper((string) "movw `d0, `s0\nmovt `d0, `s1", AS_OperandList(dst, NULL), AS_OperandList(lo_src, AS_OperandList(hi_src, NULL)), NULL, loopDepth));
        }
        return;
    }
    case AS_operand_::T_FCONST:
    {
        int icon = fcon2i(&(src->u.FCONST));
        AS_operand lo_src = AS_Operand_Const(get_lower(icon));
        AS_operand hi_src = AS_Operand_Const(get_higher(icon));
        AS_operand intCon = AS_Operand_Temp_NewTemp();
        emit(AS_Oper((string) "movw `d0, `s0\nmovt `d0, `s1", AS_OperandList(intCon, NULL), AS_OperandList(lo_src, AS_OperandList(hi_src, NULL)), NULL, loopDepth));
        emit(AS_Oper((my_string) "vmov `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(intCon, NULL), NULL, loopDepth));
        return;
    }
    default:
    {
        assert(0);
    }
    }
}

static AS_operand imm8Operand(AS_operand con, int loopDepth)
{
    assert(con->kind == AS_operand_::T_ICONST);
    if (imm8m(con->u.ICONST))
    {
        return con;
    }
    else
    {
        AS_operand ret = AS_Operand_Temp_NewTemp();
        emit_move(ret, con, loopDepth);
        return ret;
    }
}

// static AS_operand zeroFloatOperand(AS_operand con)
// {
//     assert(con->kind == AS_operand_::T_FCONST);
//     if (abs(con->u.FCONST) <= 1e-6)
//     {
//         return AS_Operand_FConst(0.0);
//     }
//     else
//     {
//         AS_operand ret = AS_Operand_Temp_NewFloatTemp();
//         emit_move(ret, con);
//         return ret;
//     }
// }

static AS_operand ldrstrOperand(AS_operand con, int loopDepth)
{
    assert(con->kind == AS_operand_::T_ICONST);
    if (abs(con->u.ICONST) <= 4095)
    {
        return con;
    }
    else
    {
        AS_operand ret = AS_Operand_Temp_NewTemp();
        emit_move(ret, con, loopDepth);
        return ret;
    }
}

// static AS_operand vStrLdrOperand(AS_operand con)
// {
//     assert(con->kind == AS_operand_::T_ICONST);
//     if (abs(con->u.ICONST) <= 1020 && abs(con->u.ICONST) % 4 == 0)
//     {
//         return con;
//     }
//     else
//     {
//         AS_operand ret = AS_Operand_Temp_NewTemp();
//         emit_move(ret, con);
//         return ret;
//     }
// }

static void emitVstr(AS_operand src, AS_operand base, int offset, int loopDepth)
{
    if (abs(offset) <= 1020 && abs(offset) % 4 == 0)
    {
        emit(AS_Oper((my_string) "vstr.32 `s0, [`s1, `s2]", NULL, AS_OperandList(src, AS_OperandList(base, AS_OperandList(AS_Operand_Const(offset), NULL))), NULL, loopDepth));
    }
    else
    {
        AS_instrList addIns = NULL;
        AS_operand offsetTemp = AS_Operand_Temp_NewTemp();
        if (imm8m(offset))
        {
            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(base, AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, loopDepth));
        }
        else
        {
            AS_operand conTemp = AS_Operand_Temp_NewTemp();
            emit_move(conTemp, AS_Operand_Const(offset), loopDepth);
            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(base, AS_OperandList(conTemp, NULL)), NULL, loopDepth));
        }
        emit(AS_Oper((my_string) "vstr.32 `s0, [`s1]", NULL, AS_OperandList(src, AS_OperandList(offsetTemp, NULL)), NULL));
    }
}

static AS_instrList genMoveConst(AS_operand dst, int con, int loopDepth)
{

    if(imm8m(con)){
        return AS_InstrList(AS_Oper((string) "mov `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, loopDepth), NULL);
    }else if(imm8m((-con) - 1)){
        con = (-con) - 1;
        return AS_InstrList(AS_Oper((string) "mvn `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, loopDepth), NULL);
    }else if(0 <= con && con <= 65535){
        return AS_InstrList(AS_Oper((string) "movw `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, loopDepth), NULL);
    }else{
        AS_operand lo_src = AS_Operand_Const(get_lower(con));
        AS_operand hi_src = AS_Operand_Const(get_higher(con));
        return AS_InstrList(AS_Oper((string) "movw `d0, `s0\nmovt `d0, `s1", AS_OperandList(dst, NULL), AS_OperandList(lo_src, AS_OperandList(hi_src, NULL)), NULL, loopDepth), NULL);
    }
}

static AS_instrList genVldr(AS_operand dst, AS_operand base, int offset, int loopDepth=0)
{
    if (abs(offset) <= 1020 && abs(offset) % 4 == 0)
    {
        return AS_InstrList(AS_Oper((my_string) "vldr.32 `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(base, AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, loopDepth), NULL);
    }
    else
    {
        AS_instrList addIns = NULL;
        AS_operand offsetTemp = AS_Operand_Temp_NewTemp();
        if (imm8m(offset))
        {
            addIns = AS_InstrList(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(base, AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, loopDepth), NULL);
        }
        else
        {
            AS_operand conTemp = AS_Operand_Temp_NewTemp();
            AS_instrList moveIns = genMoveConst(conTemp, offset, loopDepth);
            addIns = AS_instrList_add(moveIns, AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(base, AS_OperandList(conTemp, NULL)), NULL, loopDepth));
        }
        return AS_instrList_add(addIns, AS_Oper((my_string) "vldr.32 `d0, [`s0]", AS_OperandList(dst, NULL), AS_OperandList(offsetTemp, NULL), NULL, loopDepth));
    }
}

static AS_instrList genLdr(AS_operand dst, AS_operand base, int offset, int loopDepth=0)
{
    if (abs(offset) <= 4095)
    {
        return AS_InstrList(AS_Oper((my_string) "ldr `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(base, AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, loopDepth), NULL);
    }
    else
    {
        AS_operand conTemp = AS_Operand_Temp_NewTemp();
        AS_instrList moveIns = genMoveConst(conTemp, offset, loopDepth);
        return AS_instrList_add(moveIns, AS_Oper((my_string) "ldr `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(base, AS_OperandList(conTemp, NULL)), NULL, loopDepth));
    }
}

static AS_instrList to_last(AS_instrList List)
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

static const char binops_str[][15] = {"add", "sub", "mul", "sdiv", "srem", "vadd.f32", "vsub.f32", "vmul.f32", "vdiv.f32"};

static LLVM_IR::T_relOp relops_enum[] = {LLVM_IR::T_eq, LLVM_IR::T_ne, LLVM_IR::T_lt, LLVM_IR::T_gt, LLVM_IR::T_le, LLVM_IR::T_ge, LLVM_IR::F_eq, LLVM_IR::F_ne, LLVM_IR::F_lt, LLVM_IR::F_gt, LLVM_IR::F_le, LLVM_IR::F_ge};

static const char relops_str[][15] = {"eq", "ne", "lt", "gt", "le", "ge", "eq", "ne", "lt", "gt", "le", "ge"};
int is2pow(int n)
{
    if (n <= 0)
    {
        return false;
    }
    return (n & (n - 1)) == 0;
}
int countTrailingZeros(int num)
{
    if (num == 0)
    {
        return sizeof(num) * 8; // Assuming 32-bit integers
    }
    int count = 0;
    num = (num & -num); // Extract the rightmost set bit
    while (num > 0)
    {
        num >>= 1;
        count++;
    }
    return count - 1; // Subtract 1 to exclude the rightmost set bit
}

int countLeadingZeros(int num)
{
    if (num == 0)
    {
        return sizeof(num) * 8; // Assuming 32-bit integers
    }
    int count = 0;
    while ((num & (1 << 31)) == 0)
    {
        num <<= 1;
        count++;
    }
    return count;
}
int extractOnes(int num)
{
    int count = 0;
    while (num)
    {
        num &= (num - 1); // Clears the rightmost set bit
        count++;
    }
    return count;
}
static void munch_Ir(LLVM_IR::llvm_T_stm_ *s, int loopDepth)
{
    if (!s)
        return;
    switch (s->kind)
    {
    case LLVM_IR::llvm_T_stm_::T_BINOP:
    {

        AS_operand left_op = s->u.BINOP.left;
        AS_operand right_op = s->u.BINOP.right;

        if (s->u.BINOP.op == LLVM_IR::T_mod)
        {
            assert(isInt(left_op));
            assert(isInt(right_op));
            assert(isInt(s->u.BINOP.dst));

            if (left_op->kind == AS_operand_::T_ICONST)
            {
                left_op = AS_Operand_Temp_NewTemp();
                emit_move(left_op, s->u.BINOP.left, loopDepth);
            }
            if (right_op->kind == AS_operand_::T_ICONST)
            {
                if (is2pow(right_op->u.ICONST))
                {
                    if (imm8m(right_op->u.ICONST - 1))
                    {
                        AS_operand neg_op = AS_Operand_Temp_NewTemp();
                        AS_operand neg_ans = AS_Operand_Temp_NewTemp();
                        emit(AS_Oper((my_string) "rsbs `d0, `s0, #0", AS_OperandList(neg_op, NULL), AS_OperandList(left_op, NULL), NULL, loopDepth));
                        emit(AS_Oper((my_string) "and `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(right_op->u.ICONST - 1), NULL)), NULL, loopDepth));
                        emit(AS_Oper((my_string) "and `d0, `s0, `s1", AS_OperandList(neg_ans, NULL), AS_OperandList(neg_op, AS_OperandList(AS_Operand_Const(right_op->u.ICONST - 1), NULL)), NULL, loopDepth));
                        emit(AS_Oper((my_string) "rsbpl `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(neg_ans, AS_OperandList(s->u.BINOP.dst, NULL)), NULL, loopDepth));
                        return;
                    }
                    else
                    {
                        right_op = AS_Operand_Temp_NewTemp();
                        emit_move(right_op, AS_Operand_Const(s->u.BINOP.right->u.ICONST - 1), loopDepth);
                        AS_operand neg_op = AS_Operand_Temp_NewTemp();
                        AS_operand neg_ans = AS_Operand_Temp_NewTemp();
                        emit(AS_Oper((my_string) "rsbs `d0, `s0, #0", AS_OperandList(neg_op, NULL), AS_OperandList(left_op, NULL), NULL, loopDepth));
                        emit(AS_Oper((my_string) "and `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
                        emit(AS_Oper((my_string) "and `d0, `s0, `s1", AS_OperandList(neg_ans, NULL), AS_OperandList(neg_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
                        emit(AS_Oper((my_string) "rsbpl `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(neg_ans, AS_OperandList(s->u.BINOP.dst, NULL)), NULL, loopDepth));
                        return;
                    }
                }

                right_op = AS_Operand_Temp_NewTemp();
                emit_move(right_op, s->u.BINOP.right, loopDepth);
            }

            emit(AS_Oper((my_string) "sdiv `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
            emit(AS_Oper((my_string) "mul `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, AS_OperandList(right_op, NULL)), NULL, loopDepth));
            emit(AS_Oper((my_string) "sub `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(s->u.BINOP.dst, NULL)), NULL, loopDepth));

            return;
        }

        if(s->u.BINOP.op == LLVM_IR::T_plus){
            if(s->u.BINOP.left->kind == AS_operand_::T_ICONST){
                // swap
                right_op = s->u.BINOP.left;
                left_op = s->u.BINOP.right;
            }
        }

        if (s->u.BINOP.op == LLVM_IR::T_plus || s->u.BINOP.op == LLVM_IR::T_minus){
            assert(right_op->kind != AS_operand_::T_NAME);

            if ((left_op->kind == AS_operand_::T_ICONST) || (left_op->kind == AS_operand_::T_NAME))
            {
                AS_operand new_left_op = AS_Operand_Temp_NewTemp();
                emit_move(new_left_op, left_op, loopDepth);
                left_op = new_left_op;
            }

            if (right_op->kind == AS_operand_::T_ICONST)
            {
                right_op = imm8Operand(right_op, loopDepth);
            }
        }else{
            // after modify mem
            // this should work for all binop
            assert(opTypeEqInfer(left_op, s->u.BINOP.dst));
            assert(opTypeEqInfer(right_op, s->u.BINOP.dst));

            if (isFloat(left_op) && isFloat(right_op))
            {
                if (left_op->kind == AS_operand_::T_FCONST)
                {
                    left_op = AS_Operand_Temp_NewFloatTemp();
                    emit_move(left_op, s->u.BINOP.left, loopDepth);
                }
                if (right_op->kind == AS_operand_::T_FCONST)
                {
                    right_op = AS_Operand_Temp_NewFloatTemp();
                    emit_move(right_op, s->u.BINOP.right, loopDepth);
                }
            }
            else if (isInt(left_op) && isInt(right_op))
            {
                bool ismul = s->u.BINOP.op == LLVM_IR::T_mul;
                if (left_op->kind == AS_operand_::T_ICONST)
                {
                    if (ismul && right_op->kind != AS_operand_::T_ICONST)
                    {
                        int imm = left_op->u.ICONST;
                        int abs = imm > 0 ? imm : -imm;
                        if (is2pow(abs))
                        {
                            int sh = 32 - 1 - countLeadingZeros(abs);
                            emit(AS_Oper((my_string) "lsl `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(right_op, AS_OperandList(AS_Operand_Const(sh), NULL)), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                        if (extractOnes(abs) == 2)
                        {
                            int hi = 32 - 1 - countLeadingZeros(abs);
                            int lo = countTrailingZeros(abs);
                            AS_operand hival = AS_Operand_Temp_NewTemp();
                            emit(AS_Oper((my_string) "lsl `d0, `s0, `s1", AS_OperandList(hival, NULL), AS_OperandList(right_op, AS_OperandList(AS_Operand_Const(hi), NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "add `d0, `s0, `s1, lsl `s2", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(hival, AS_OperandList(right_op, AS_OperandList(AS_Operand_Const(lo), NULL))), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                        if (((abs + 1) & (abs)) == 0)
                        {
                            int sh = 32 - 1 - countLeadingZeros(abs + 1);
                            emit(AS_Oper((my_string) "rsb `d0, `s0, `s1, lsl `s2", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(right_op, AS_OperandList(right_op, AS_OperandList(AS_Operand_Const(sh), NULL))), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                    }
                    left_op = AS_Operand_Temp_NewTemp();
                    emit_move(left_op, s->u.BINOP.left, loopDepth);
                }
                if (right_op->kind == AS_operand_::T_ICONST)
                {
                    if (ismul)
                    {
                        int imm = right_op->u.ICONST;
                        int abs = imm > 0 ? imm : -imm;
                        if (is2pow(abs))
                        {
                            int sh = 32 - 1 - countLeadingZeros(abs);
                            emit(AS_Oper((my_string) "lsl `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(sh), NULL)), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                        if (extractOnes(abs) == 2)
                        {
                            int hi = 32 - 1 - countLeadingZeros(abs);
                            int lo = countTrailingZeros(abs);
                            AS_operand hival = AS_Operand_Temp_NewTemp();
                            emit(AS_Oper((my_string) "lsl `d0, `s0, `s1", AS_OperandList(hival, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(hi), NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "add `d0, `s0, `s1, lsl `s2", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(hival, AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(lo), NULL))), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                        if (((abs + 1) & (abs)) == 0)
                        {
                            int sh = 32 - 1 - countLeadingZeros(abs + 1);
                            emit(AS_Oper((my_string) "rsb `d0, `s0, `s1, lsl `s2", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(sh), NULL))), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                    }
                    else
                    {
                        // divide
                        int imm = right_op->u.ICONST;
                        int abs = imm > 0 ? imm : -imm;
                        int sh = 32 - 1 - countLeadingZeros(abs);
                        if(imm == 2){
                            AS_operand temp = AS_Operand_Temp_NewTemp();
                            emit(AS_Oper((my_string) "add `d0, `s0, `s1, lsr #31", AS_OperandList(temp, NULL), AS_OperandList(left_op, AS_OperandList(left_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "asr `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(temp, AS_OperandList(AS_Operand_Const(1), NULL)), NULL, loopDepth));
                            return;
                        }
                        if (is2pow(abs) && imm8m(abs - 1))
                        {
                            AS_operand neg_temp = AS_Operand_Temp_NewTemp();
                            AS_operand temp = AS_Operand_Temp_NewTemp();
                            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(neg_temp, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(abs - 1), NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "bics `d0, `s0, `s1, asr #32", AS_OperandList(left_op, NULL), AS_OperandList(left_op, AS_OperandList(left_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "movcs `d0, `s0", AS_OperandList(left_op, NULL), AS_OperandList(neg_temp, AS_OperandList(left_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "asr `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(sh), NULL)), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                        else if (is2pow(abs))
                        {
                            right_op = AS_Operand_Temp_NewTemp();
                            emit_move(right_op, AS_Operand_Const(s->u.BINOP.right->u.ICONST - 1), loopDepth);
                            AS_operand neg_temp = AS_Operand_Temp_NewTemp();
                            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(neg_temp, NULL), AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "bics `d0, `s0, `s1, asr #32", AS_OperandList(left_op, NULL), AS_OperandList(left_op, AS_OperandList(left_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "movcs `d0, `s0", AS_OperandList(left_op, NULL), AS_OperandList(neg_temp, AS_OperandList(left_op, NULL)), NULL, loopDepth));
                            emit(AS_Oper((my_string) "asr `d0, `s0, `s1", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(AS_Operand_Const(sh), NULL)), NULL, loopDepth));
                            if (imm < 0)
                                emit(AS_Oper((my_string) "rsb `d0, `s0, #0", AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(s->u.BINOP.dst, NULL), NULL, loopDepth));
                            return;
                        }
                    }
                    right_op = AS_Operand_Temp_NewTemp();
                    emit_move(right_op, s->u.BINOP.right, loopDepth);
                }
            }
            else
            {
                assert(0);
            }
        }

        sprintf(as_buf, "%s `d0, `s0, `s1", binops_str[s->u.BINOP.op]);
        emit(AS_Oper(String(as_buf), AS_OperandList(s->u.BINOP.dst, NULL), AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_INTTOPTR:
    {
        assert(0);
        emit(AS_Oper((string) "mov `d0, `s0", AS_OperandList(s->u.INTTOPTR.dst, NULL), AS_OperandList(s->u.INTTOPTR.src, NULL), NULL, loopDepth));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_PTRTOINT:
    {
        assert(0);
        emit(AS_Oper((string) "mov `d0, `s0", AS_OperandList(s->u.PTRTOINT.dst, NULL), AS_OperandList(s->u.PTRTOINT.src, NULL), NULL, loopDepth));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_LOAD:
    {
        if (isIntPtr(s->u.LOAD.ptr))
        {
            assert(isInt(s->u.LOAD.dst));
            if (s->u.LOAD.ptr->kind == AS_operand_::T_NAME)
            {
                AS_operand iptr = AS_Operand_Temp_NewIntPtrTemp();
                emit_move(iptr, s->u.LOAD.ptr, loopDepth);
                emit(AS_Oper((string) "ldr `d0, [`s0]", AS_OperandList(s->u.LOAD.dst, NULL), AS_OperandList(iptr, NULL), NULL, loopDepth));
            }
            else
            {
                emit(AS_Oper((string) "ldr `d0, [`s0]", AS_OperandList(s->u.LOAD.dst, NULL), AS_OperandList(s->u.LOAD.ptr, NULL), NULL, loopDepth));
            }
        }
        else if (isFloatPtr(s->u.LOAD.ptr))
        {
            assert(isFloat(s->u.LOAD.dst));
            if (s->u.LOAD.ptr->kind == AS_operand_::T_NAME)
            {
                AS_operand fptr = AS_Operand_Temp_NewFloatPtrTemp();
                emit_move(fptr, s->u.LOAD.ptr, loopDepth);
                emit(AS_Oper((string) "vldr.32 `d0, [`s0]", AS_OperandList(s->u.LOAD.dst, NULL), AS_OperandList(fptr, NULL), NULL, loopDepth));
            }
            else
            {
                emit(AS_Oper((string) "vldr.32 `d0, [`s0]", AS_OperandList(s->u.LOAD.dst, NULL), AS_OperandList(s->u.LOAD.ptr, NULL), NULL, loopDepth));
            }
        }
        else
        {
            assert(0);
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_STORE:
    {
        AS_operand str_src = s->u.STORE.src;
        AS_operand new_src = NULL;
        if (isInt(str_src))
        {
            if (str_src->kind == AS_operand_::T_ICONST)
            {
                new_src = AS_Operand_Temp_NewTemp();
                emit_move(new_src, str_src, loopDepth);
                str_src = new_src;
            }
            if (s->u.STORE.ptr->kind == AS_operand_::T_NAME)
            {
                AS_operand iptr = AS_Operand_Temp_NewIntPtrTemp();
                emit_move(iptr, s->u.STORE.ptr, loopDepth);
                emit(AS_Oper((string) "str `s0, [`s1]", NULL, AS_OperandList(str_src, AS_OperandList(iptr, NULL)), NULL, loopDepth));
            }
            else
            {
                emit(AS_Oper((string) "str `s0, [`s1]", NULL, AS_OperandList(str_src, AS_OperandList(s->u.STORE.ptr, NULL)), NULL, loopDepth));
            }
        }
        else if (isFloat(s->u.STORE.src))
        {
            if (str_src->kind == AS_operand_::T_FCONST)
            {
                new_src = AS_Operand_Temp_NewFloatTemp();
                emit_move(new_src, str_src, loopDepth);
                str_src = new_src;
            }
            if (s->u.STORE.ptr->kind == AS_operand_::T_NAME)
            {
                AS_operand fptr = AS_Operand_Temp_NewFloatPtrTemp();
                emit_move(fptr, s->u.STORE.ptr, loopDepth);
                emit(AS_Oper((string) "vstr.32 `s0, [`s1]", NULL, AS_OperandList(str_src, AS_OperandList(fptr, NULL)), NULL, loopDepth));
            }
            else
            {
                emit(AS_Oper((string) "vstr.32 `s0, [`s1]", NULL, AS_OperandList(str_src, AS_OperandList(s->u.STORE.ptr, NULL)), NULL, loopDepth));
            }
        }
        else
        {
            assert(0);
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_LABEL:
    {
        emit(AS_Label(StringLabel_arm(Temp_labelstring(s->u.LABEL.label)), s->u.LABEL.label));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_JUMP:
    {
        emit(AS_Oper((string) "b .`j0", NULL, NULL, AS_Targets(Temp_LabelList(s->u.JUMP.jump, NULL)), loopDepth));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_CMP:
    {
        AS_operand left_op = s->u.CMP.left;
        AS_operand right_op = s->u.CMP.right;
        if (s->u.CMP.left->kind == AS_operand_::T_ICONST)
        {
            left_op = AS_Operand_Temp_NewTemp();
            emit_move(left_op, s->u.CMP.left, loopDepth);
        }
        if (s->u.CMP.right->kind == AS_operand_::T_ICONST)
        {
            right_op = imm8Operand(s->u.CMP.right, loopDepth);
        }
        if (s->u.CMP.left->kind == AS_operand_::T_FCONST)
        {
            left_op = AS_Operand_Temp_NewFloatTemp();
            emit_move(left_op, s->u.CMP.left, loopDepth);
        }
        if (s->u.CMP.right->kind == AS_operand_::T_FCONST)
        {
            if (s->u.CMP.right->u.FCONST == 0.0)
            {
                // emit cmp to 0.0
                assert(s->u.CMP.op >= LLVM_IR::F_eq);
                emit(AS_Oper((string) "vcmp.f32 `s0, #0.0\nvmrs APSR_nzcv, FPSCR", NULL, AS_OperandList(left_op, NULL), NULL, loopDepth));
                // emit(AS_Oper((string) "vmrs APSR_nzcv, FPSCR", NULL, NULL, NULL));
                return ;
            }
            else
            {
                right_op = AS_Operand_Temp_NewFloatTemp();
                emit_move(right_op, s->u.CMP.right, loopDepth);
            }
        }

        if (s->u.CMP.op < LLVM_IR::F_eq)
        {
            emit(AS_Oper((string) "cmp `s0, `s1", NULL, AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
        }
        else
        {
            emit(AS_Oper((string) "vcmp.f32 `s0, `s1\nvmrs APSR_nzcv, FPSCR", NULL, AS_OperandList(left_op, AS_OperandList(right_op, NULL)), NULL, loopDepth));
            // emit(AS_Oper((string) "vmrs APSR_nzcv, FPSCR", NULL, NULL, NULL));
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_CJUMP:
    {
        sprintf(as_buf, "b%s .`j0", relops_str[s->u.CJUMP.op]);
        emit(AS_Oper(String(as_buf), NULL, NULL, AS_Targets(Temp_LabelList(s->u.CJUMP.true_label, Temp_LabelList(s->u.CJUMP.false_label, NULL))), loopDepth));

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_MOVE:
    {
        emit_move(s->u.MOVE.dst, s->u.MOVE.src, loopDepth);
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_CALL:
    {
        // method_name should before arg list
        // or arg may be overwrite by mehtod_name
        int arg_num = 0;
        int gp_arg_num = GP_ARG_NUM;
        int fp_arg_num = FP_ARG_NUM;

        AS_operandList tl1, tl2;

        // cal spill args num
        for (tl1 = s->u.CALL.args; tl1; tl1 = tl1->tail)
        {
            assert(tl1->head);
            if (isInt(tl1->head) || isFloatPtr(tl1->head) || isIntPtr(tl1->head))
            {
                if (gp_arg_num > 0)
                {
                    --gp_arg_num;
                }
                else
                {
                    ++arg_num;
                }
            }
            else if (isFloat(tl1->head))
            {
                if (fp_arg_num > 0)
                {
                    --fp_arg_num;
                }
                else
                {
                    ++arg_num;
                }
            }
            else
            {
                assert(0);
            }
        }

        // set sp (8 more)
        if (arg_num > 0)
        {
            emit(AS_Oper((my_string) "sub `d0, `s0, `s1", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(imm8Operand(AS_Operand_Const(armSpOffset(arg_num * REG_SIZE + 8)), loopDepth), NULL)), NULL, loopDepth));
        }

        arg_num = 0;
        gp_arg_num = GP_ARG_NUM;
        fp_arg_num = FP_ARG_NUM;

        // pass args
        for (tl1 = s->u.CALL.args; tl1; tl1 = tl1->tail)
        {
            assert(tl1->head);
            if (isInt(tl1->head) || isFloatPtr(tl1->head) || isIntPtr(tl1->head))
            {
                if (gp_arg_num > 0)
                {
                    emit_move(AS_Operand_Temp(&r[GP_ARG_NUM - gp_arg_num]), tl1->head, loopDepth);
                    --gp_arg_num;
                }
                else
                {
                    AS_operand str_src = tl1->head;
                    if (str_src->kind != AS_operand_::T_TEMP)
                    {
                        AS_operand new_src = AS_Operand_Temp_NewTemp();
                        emit_move(new_src, str_src, loopDepth);
                        str_src = new_src;
                    }
                    sprintf(as_buf, "str `s0, [`s1, `s2]");
                    emit(AS_Oper(String(as_buf), NULL, AS_OperandList(str_src, AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(ldrstrOperand(AS_Operand_Const(arg_num * REG_SIZE), loopDepth), NULL))), NULL, loopDepth));
                    ++arg_num;
                }
            }
            else if (isFloat(tl1->head))
            {
                if (fp_arg_num > 0)
                {
                    emit_move(AS_Operand_Temp(&r_fp[FP_ARG_NUM - fp_arg_num]), tl1->head, loopDepth);
                    --fp_arg_num;
                }
                else
                {
                    // sprintf(as_buf, "vstr.32 `s0, [`s1, `s2]");
                    AS_operand str_src = tl1->head;
                    if (str_src->kind != AS_operand_::T_TEMP)
                    {
                        AS_operand new_src = AS_Operand_Temp_NewTemp();
                        emit_move(new_src, str_src, loopDepth);
                        str_src = new_src;
                    }
                    // emit(AS_Oper(String(as_buf), NULL, AS_OperandList(str_src, AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(vStrLdrOperand(AS_Operand_Const(arg_num * REG_SIZE)), NULL))), NULL));
                    emitVstr(str_src, AS_Operand_Temp(&r[13]), arg_num * REG_SIZE, loopDepth);
                    ++arg_num;
                }
            }
            else
            {
                assert(0);
            }
        }

        // get call_used
        AS_operandList call_used = NULL;
        for (int i = GP_ARG_NUM; i > gp_arg_num; --i)
            call_used = AS_OperandList(AS_Operand_Temp(&r[GP_ARG_NUM - i]), call_used);
        for (int i = FP_ARG_NUM; i > fp_arg_num; --i)
            call_used = AS_OperandList(AS_Operand_Temp(&r_fp[FP_ARG_NUM - i]), call_used);
        // function call will use r13(sp)
        call_used = AS_OperandList(AS_Operand_Temp(&r[13]), call_used);


        // add fun name into call_used
        // but I do not know if unknown type will work
        // call_used = AS_OperandList(AS_Operand_Name(Temp_namedlabel(s->u.CALL.fun), UNKNOWN), call_used);

        // add caller saved to dst
        // add r0(ret val) and para reg to src
        // emit(AS_Oper((string) "bl `s0", caller_saved, call_used, NULL));

        emit_call_bl(s->u.CALL.fun, call_used, loopDepth);

        // recover sp(8 more)
        if (arg_num > 0)
        {
            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(imm8Operand(AS_Operand_Const(armSpOffset(arg_num * REG_SIZE + 8)), loopDepth), NULL)), NULL, loopDepth));
        }

        if (isInt(s->u.CALL.res))
        {
            emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(s->u.CALL.res, NULL), AS_OperandList(AS_Operand_Temp(&r[0]), NULL), loopDepth));
        }
        else if (isFloat(s->u.CALL.res))
        {
            emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(s->u.CALL.res, NULL), AS_OperandList(AS_Operand_Temp(&r_fp[0]), NULL), loopDepth));
        }
        else
        {
            assert(0);
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_VOID_CALL:
    {
        // method_name should before arg list
        // or arg may be overwrite by mehtod_name

        // pass args
        int arg_num = 0;
        int gp_arg_num = GP_ARG_NUM;
        int fp_arg_num = FP_ARG_NUM;

        AS_operandList tl1, tl2;

        // cal spill args num
        for (tl1 = s->u.VOID_CALL.args; tl1; tl1 = tl1->tail)
        {
            assert(tl1->head);
            if (isInt(tl1->head) || isFloatPtr(tl1->head) || isIntPtr(tl1->head))
            {
                if (gp_arg_num > 0)
                {
                    --gp_arg_num;
                }
                else
                {
                    ++arg_num;
                }
            }
            else if (isFloat(tl1->head))
            {
                if (fp_arg_num > 0)
                {
                    --fp_arg_num;
                }
                else
                {
                    ++arg_num;
                }
            }
            else
            {
                assert(0);
            }
        }

        // set sp (8 more)
        if (arg_num > 0)
        {
            emit(AS_Oper((my_string) "sub `d0, `s0, `s1", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(imm8Operand(AS_Operand_Const(armSpOffset(arg_num * REG_SIZE + 8)), loopDepth), NULL)), NULL, loopDepth));
        }

        arg_num = 0;
        gp_arg_num = GP_ARG_NUM;
        fp_arg_num = FP_ARG_NUM;

        for (tl1 = s->u.VOID_CALL.args; tl1; tl1 = tl1->tail)
        {
            assert(tl1->head);
            if (isInt(tl1->head) || isFloatPtr(tl1->head) || isIntPtr(tl1->head))
            {
                if (gp_arg_num > 0)
                {
                    emit_move(AS_Operand_Temp(&r[GP_ARG_NUM - gp_arg_num]), tl1->head, loopDepth);
                    --gp_arg_num;
                }
                else
                {
                    AS_operand str_src = tl1->head;
                    if (str_src->kind != AS_operand_::T_TEMP)
                    {
                        AS_operand new_src = AS_Operand_Temp_NewTemp();
                        emit_move(new_src, str_src, loopDepth);
                        str_src = new_src;
                    }
                    sprintf(as_buf, "str `s0, [`s1, `s2]");
                    emit(AS_Oper(String(as_buf), NULL, AS_OperandList(str_src, AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(ldrstrOperand(AS_Operand_Const(arg_num * REG_SIZE), loopDepth), NULL))), NULL, loopDepth));
                    ++arg_num;
                }
            }
            else if (isFloat(tl1->head))
            {
                if (fp_arg_num > 0)
                {
                    emit_move(AS_Operand_Temp(&r_fp[FP_ARG_NUM - fp_arg_num]), tl1->head, loopDepth);
                    --fp_arg_num;
                }
                else
                {
                    // sprintf(as_buf, "vstr.32 `s0, [`s1, `s2]");
                    AS_operand str_src = tl1->head;
                    if (str_src->kind != AS_operand_::T_TEMP)
                    {
                        AS_operand new_src = AS_Operand_Temp_NewTemp();
                        emit_move(new_src, str_src, loopDepth);
                        str_src = new_src;
                    }
                    // emit(AS_Oper(String(as_buf), NULL, AS_OperandList(str_src, AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(vStrLdrOperand(AS_Operand_Const(arg_num * REG_SIZE)), NULL))), NULL));

                    emitVstr(str_src, AS_Operand_Temp(&r[13]), arg_num * REG_SIZE, loopDepth);
                    ++arg_num;
                }
            }
            else
            {
                assert(0);
            }
        }

        // get call_used(should contain return value r0)
        AS_operandList call_used = NULL;
        for (int i = GP_ARG_NUM; i > gp_arg_num; --i)
            call_used = AS_OperandList(AS_Operand_Temp(&r[GP_ARG_NUM - i]), call_used);
        for (int i = FP_ARG_NUM; i > fp_arg_num; --i)
            call_used = AS_OperandList(AS_Operand_Temp(&r_fp[FP_ARG_NUM - i]), call_used);
        // function call will use r13(sp)
        call_used = AS_OperandList(AS_Operand_Temp(&r[13]), call_used);

        // add caller saved to dst
        // add r0(ret val) and para reg to src
        emit_call_bl(s->u.VOID_CALL.fun, call_used, loopDepth);



        // recover sp (8 more)
        if (arg_num > 0)
        {
            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(imm8Operand(AS_Operand_Const(armSpOffset(arg_num * REG_SIZE + 8)), loopDepth), NULL)), NULL, loopDepth));
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_RETURN:
    {
        if (!s->u.RET.ret)
        {
            // return void
        }
        else if (isInt(s->u.RET.ret))
        {
            emit_move(AS_Operand_Temp(&r[0]), s->u.RET.ret, loopDepth);
        }
        else if (isFloat(s->u.RET.ret))
        {
            emit_move(AS_Operand_Temp(&r_fp[0]), s->u.RET.ret, loopDepth);
        }
        else
        {
            assert(0);
        }

        // recover callee saved reg
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[4]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[4]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[5]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[5]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[6]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[6]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[7]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[7]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[8]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[8]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[9]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[9]), NULL), loopDepth));
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[10]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[10]), NULL), loopDepth));

        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[16]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[16]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[17]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[17]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[18]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[18]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[19]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[19]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[20]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[20]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[21]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[21]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[22]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[22]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[23]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[23]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[24]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[24]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[25]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[25]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[26]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[26]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[27]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[27]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[28]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[28]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[29]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[29]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[30]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[30]), NULL), loopDepth));
        emit(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&r_fp[31]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved_fp[31]), NULL), loopDepth));

        // sub sp, fp, #4
        emit(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[11]), NULL), loopDepth));
        emit(AS_Oper((string) "sub `d0, `s0, #4", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), NULL, loopDepth));

        AS_operandList callee_saved = AS_OperandList(AS_Operand_Temp(&r[4]),
                                                     AS_OperandList(AS_Operand_Temp(&r[5]),
                                                                    AS_OperandList(AS_Operand_Temp(&r[6]),
                                                                                   AS_OperandList(AS_Operand_Temp(&r[7]),
                                                                                                  AS_OperandList(AS_Operand_Temp(&r[8]),
                                                                                                                 AS_OperandList(AS_Operand_Temp(&r[9]),
                                                                                                                                AS_OperandList(AS_Operand_Temp(&r[10]),
                                                                                                                                               AS_OperandList(AS_Operand_Temp(&r_fp[16]),
                                                                                                                                                              AS_OperandList(AS_Operand_Temp(&r_fp[17]),
                                                                                                                                                                             AS_OperandList(AS_Operand_Temp(&r_fp[18]),
                                                                                                                                                                                            AS_OperandList(AS_Operand_Temp(&r_fp[19]),
                                                                                                                                                                                                           AS_OperandList(AS_Operand_Temp(&r_fp[20]),
                                                                                                                                                                                                                          AS_OperandList(AS_Operand_Temp(&r_fp[21]),
                                                                                                                                                                                                                                         AS_OperandList(AS_Operand_Temp(&r_fp[22]),
                                                                                                                                                                                                                                                        AS_OperandList(AS_Operand_Temp(&r_fp[23]),
                                                                                                                                                                                                                                                                       AS_OperandList(AS_Operand_Temp(&r_fp[24]),
                                                                                                                                                                                                                                                                                      AS_OperandList(AS_Operand_Temp(&r_fp[25]),
                                                                                                                                                                                                                                                                                                     AS_OperandList(AS_Operand_Temp(&r_fp[26]),
                                                                                                                                                                                                                                                                                                                    AS_OperandList(AS_Operand_Temp(&r_fp[27]),
                                                                                                                                                                                                                                                                                                                                   AS_OperandList(AS_Operand_Temp(&r_fp[28]),
                                                                                                                                                                                                                                                                                                                                                  AS_OperandList(AS_Operand_Temp(&r_fp[29]),
                                                                                                                                                                                                                                                                                                                                                                 AS_OperandList(AS_Operand_Temp(&r_fp[30]),
                                                                                                                                                                                                                                                                                                                                                                                AS_OperandList(AS_Operand_Temp(&r_fp[31]), NULL)))))))))))))))))))))));

        // pop fp pc
        // use r0 as ret val
        // use r4-10(callee saved reg)
        if (!s->u.RET.ret)
        {
            // return void
            emit(AS_Oper((string) "pop {`d0, `d1}", AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Temp(&r[15]), NULL)), AS_OperandList(AS_Operand_Temp(&r[13]), callee_saved), NULL, loopDepth));
        }
        else if (isInt(s->u.RET.ret))
        {
            emit(AS_Oper((string) "pop {`d0, `d1}", AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Temp(&r[15]), NULL)), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(AS_Operand_Temp(&r[0]), callee_saved)), NULL, loopDepth));
        }
        else if (isFloat(s->u.RET.ret))
        {
            emit(AS_Oper((string) "pop {`d0, `d1}", AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Temp(&r[15]), NULL)), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(AS_Operand_Temp(&r_fp[0]), callee_saved)), NULL, loopDepth));
        }
        else
        {
            assert(0);
        }

        return;
    }
    case LLVM_IR::llvm_T_stm_::T_PHI:
    {
        assert(0);
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_NULL:
    {
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_ALLOCA:
    {
        localOffset += s->u.ALLOCA.size;
        emit(AS_Oper((my_string) "sub `d0, `s0, `s1", AS_OperandList(s->u.ALLOCA.dst, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(imm8Operand(AS_Operand_Const(localOffset), loopDepth), NULL)), NULL, loopDepth));
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_I2F:
    {
        AS_operand new_src = s->u.I2F.src;
        if (s->u.I2F.src->kind != AS_operand_::T_TEMP)
        {
            new_src = AS_Operand_Temp_NewTemp();
            emit_move(new_src, s->u.I2F.src, loopDepth);
        }
        AS_operand temp_dst = AS_Operand_Temp_NewFloatTemp();
        emit(AS_Oper((my_string) "vmov `d0, `s0", AS_OperandList(temp_dst, NULL), AS_OperandList(new_src, NULL), NULL, loopDepth));
        emit(AS_Oper((my_string) "vcvt.f32.s32 `d0, `s0", AS_OperandList(s->u.I2F.dst, NULL), AS_OperandList(temp_dst, NULL), NULL, loopDepth));
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_F2I:
    {
        AS_operand new_src = s->u.F2I.src;
        if (s->u.F2I.src->kind != AS_operand_::T_TEMP)
        {
            new_src = AS_Operand_Temp_NewFloatTemp();
            emit_move(new_src, s->u.F2I.src, loopDepth);
        }
        AS_operand temp_dst = AS_Operand_Temp_NewFloatTemp();
        emit(AS_Oper((my_string) "vcvt.s32.f32 `d0, `s0", AS_OperandList(temp_dst, NULL), AS_OperandList(new_src, NULL), NULL, loopDepth));
        emit(AS_Oper((my_string) "vmov `d0, `s0", AS_OperandList(s->u.I2F.dst, NULL), AS_OperandList(temp_dst, NULL), NULL, loopDepth));
        return;
    }
    case LLVM_IR::llvm_T_stm_::T_GEP:
    {
        AS_operand basePtrTemp = s->u.GEP.base_ptr;
        AS_operand index = s->u.GEP.index;
        if (s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
        {
            if (isIntPtr(s->u.GEP.base_ptr))
                basePtrTemp = AS_Operand_Temp_NewIntPtrTemp();
            else if (isFloatPtr(s->u.GEP.base_ptr))
                basePtrTemp = AS_Operand_Temp_NewFloatPtrTemp();
            else
                assert(0);
            emit_move(basePtrTemp, s->u.GEP.base_ptr, loopDepth);
        }
        if (index->kind != AS_operand_::T_TEMP){
            assert(index->kind == AS_operand_::T_ICONST);
            int offset = index->u.ICONST * 4;
            emit(AS_Oper((my_string) "add `d0, `s0, `s1", AS_OperandList(s->u.GEP.new_ptr, NULL), AS_OperandList(basePtrTemp, AS_OperandList(imm8Operand(AS_Operand_Const(offset), loopDepth), NULL)), NULL, loopDepth));
        }else{
            emit(AS_Oper((my_string) "add `d0, `s0, `s1, lsl `s2", AS_OperandList(s->u.GEP.new_ptr, NULL), AS_OperandList(basePtrTemp, AS_OperandList(index, AS_OperandList(AS_Operand_Const(2), NULL))), NULL, loopDepth));
        }        
        return;
    }
    default:
    {
        assert(0);
    }
    }
}

// gen asList for a C_Block
AS_instrList gen_asList_arm(LLVM_IR::T_irList sl)
{
    iList = last = NULL;
    for (; sl; sl = sl->tail)
    {
        assert(sl->head);
        munch_Ir(sl->head->s, sl->head->i->nest_depth);
    }
    return iList;
}

static AS_operand spOffset[4];

// gen prolog for a method
AS_instrList gen_prolog_arm(string method_name, Temp_tempList args)
{

    AS_instrList prolog_List = NULL;
    AS_instrList prolog_last = NULL;

    prolog_last = prolog_List = AS_InstrList(AS_Oper((string) "", NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".text", NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".align 2", NULL, NULL, NULL), NULL);
    sprintf(as_buf, ".global %s", method_name);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".arch armv8-a", NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".syntax unified", NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".arm", NULL, NULL, NULL), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) ".fpu neon", NULL, NULL, NULL), NULL);
    sprintf(as_buf, ".type %s, %%function", method_name);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), NULL, NULL, NULL), NULL);
    // add label
    sprintf(as_buf, "%s:", method_name);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), NULL, NULL, NULL), NULL);

    // push fp lr
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) "push {`s0, `s1}", NULL, AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Temp(&r[14]), AS_OperandList(AS_Operand_Temp(&r[13]), NULL))), NULL), NULL);
    // set fp
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper((string) "add `d0, `s0, #4", AS_OperandList(AS_Operand_Temp(&r[11]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), NULL), NULL);

    // set sp
    spOffset[0] = AS_Operand_Const(8);
    sprintf(as_buf, "sub `d0, `s0, `s1");
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(spOffset[0], NULL)), NULL), NULL);
    spOffset[1] = AS_Operand_Const(0);
    sprintf(as_buf, "sub `d0, `s0, `s1");
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(spOffset[1], NULL)), NULL), NULL);
    spOffset[2] = AS_Operand_Const(0);
    sprintf(as_buf, "sub `d0, `s0, `s1");
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(spOffset[2], NULL)), NULL), NULL);
    spOffset[3] = AS_Operand_Const(0);
    sprintf(as_buf, "sub `d0, `s0, `s1");
    prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), AS_OperandList(spOffset[3], NULL)), NULL), NULL);

    // save callee saved reg r4-r10 and s16-s31
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[16]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[16]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[17]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[17]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[18]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[18]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[19]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[19]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[20]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[20]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[21]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[21]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[22]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[22]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[23]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[23]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[24]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[24]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[25]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[25]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[26]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[26]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[27]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[27]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[28]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[28]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[29]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[29]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[30]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[30]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved_fp[31]), NULL), AS_OperandList(AS_Operand_Temp(&r_fp[31]), NULL)), NULL);

    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[4]), NULL), AS_OperandList(AS_Operand_Temp(&r[4]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[5]), NULL), AS_OperandList(AS_Operand_Temp(&r[5]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[6]), NULL), AS_OperandList(AS_Operand_Temp(&r[6]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[7]), NULL), AS_OperandList(AS_Operand_Temp(&r[7]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[8]), NULL), AS_OperandList(AS_Operand_Temp(&r[8]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[9]), NULL), AS_OperandList(AS_Operand_Temp(&r[9]), NULL)), NULL);
    prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&callee_saved[10]), NULL), AS_OperandList(AS_Operand_Temp(&r[10]), NULL)), NULL);

    AS_operandList arg_List = NULL;
    AS_operandList arg_last = NULL;
    for (Temp_tempList tl = args; tl; tl = tl->tail)
    {
        assert(tl->head);
        if (arg_last)
            arg_last = arg_last->tail = AS_OperandList(AS_Operand_Temp(tl->head), NULL);
        else
            arg_last = arg_List = AS_OperandList(AS_Operand_Temp(tl->head), NULL);
    }

    // get parameter (from reg and stack)
    int arg_num = 0;
    int gp_arg_num = GP_ARG_NUM;
    int fp_arg_num = FP_ARG_NUM;
    for (AS_operandList al = arg_List; al; al = al->tail)
    {
        assert(al->head);
        if (isInt(al->head) || isFloatPtr(al->head) || isIntPtr(al->head))
        {
            if (gp_arg_num > 0)
            {
                prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "mov `d0, `s0", AS_OperandList(al->head, NULL), AS_OperandList(AS_Operand_Temp(&r[GP_ARG_NUM - gp_arg_num]), NULL)), NULL);
                --gp_arg_num;
            }
            else
            {
                // sprintf(as_buf, "ldr `d0, [`s0, `s1]");
                // prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(al->head, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(imm8Operand(AS_Operand_Const((arg_num+1) * REG_SIZE)), NULL)), NULL), NULL);

                prolog_last = prolog_last->tail = genLdr(al->head, AS_Operand_Temp(&r[11]), (arg_num + 1) * REG_SIZE);
                ++arg_num;
            }
        }
        else if (isFloat(al->head))
        {
            if (fp_arg_num > 0)
            {
                prolog_last = prolog_last->tail = AS_InstrList(AS_Move((string) "vmov.f32 `d0, `s0", AS_OperandList(al->head, NULL), AS_OperandList(AS_Operand_Temp(&r_fp[FP_ARG_NUM - fp_arg_num]), NULL)), NULL);
                --fp_arg_num;
            }
            else
            {
                // sprintf(as_buf, "vldr.32 `d0, [`s0, `s1]");
                // prolog_last = prolog_last->tail = AS_InstrList(AS_Oper(String(as_buf), AS_OperandList(al->head, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(vStrLdrOperand(AS_Operand_Const((arg_num+1) * REG_SIZE)), NULL)), NULL), NULL);

                prolog_last = prolog_last->tail = genVldr(al->head, AS_Operand_Temp(&r[11]), (arg_num + 1) * REG_SIZE);
                ++arg_num;
            }
        }
        else
        {
            assert(0);
        }
    }

    return prolog_List;
}

// may not need
// gen epilog for a method
// AS_instrList gen_epilog_arm(string method_name, Temp_label lexit){

//         return AS_InstrList(AS_Label(StringLabel_arm(Temp_labelstring(lexit)), lexit),
//         // recover callee saved
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[4]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[4]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[5]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[5]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[6]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[6]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[7]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[7]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[8]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[8]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[9]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[9]), NULL)),
//         AS_InstrList(AS_Move((string)"mov `d0, `s0", AS_OperandList(AS_Operand_Temp(&r[10]), NULL), AS_OperandList(AS_Operand_Temp(&callee_saved[10]), NULL)),
//         // mov r0, #0
//         AS_InstrList(AS_Oper((string)"mov `d0, #0", AS_OperandList(AS_Operand_Temp(&r[0]), NULL), NULL, NULL),
//         // sub sp, fp, #4
//         AS_InstrList(AS_Oper((string)"sub `d0, `s0, #4", AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[11]), NULL), NULL),
//         // pop fp pc
//         AS_InstrList(AS_Oper((string)"pop {`d0, `d1}", AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Temp(&r[15]), NULL)), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), NULL),
//         AS_InstrList(AS_Oper((string)"", NULL, NULL, NULL),
//         NULL))))))))))));
// }

AS_instrList gen_epilog_arm()
{
    return AS_InstrList(AS_Oper((string) "", NULL, NULL, NULL), NULL);
}

char set_sp_assem[] = "sub `d0, `s0, #";

Bool check_set_sp_assem(string assem)
{
    if (!(strncmp(assem, set_sp_assem, strlen(set_sp_assem))))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

Bool check_set_sp(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        if (check_set_sp_assem(instr->u.OPER.assem) && instr->u.OPER.src->head->kind == AS_operand_::T_TEMP && instr->u.OPER.src->head->u.TEMP == &r[13] && instr->u.OPER.dst->head->kind == AS_operand_::T_TEMP && instr->u.OPER.dst->head->u.TEMP == &r[13])
        {
            return TRUE;
        }
    }
    return FALSE;
}

// local_offset is total offset of all the spilled variable
// you should call reset_sp after gen_prolog_arm and before print
void reset_sp(int local_offset)
{
    int totalOffset = spOffset[0]->u.ICONST + local_offset;
    assert(totalOffset > 0);
    unsigned int mask[4] = {0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff};
    spOffset[0]->u.ICONST = totalOffset & mask[0];
    spOffset[1]->u.ICONST = totalOffset & mask[1];
    spOffset[2]->u.ICONST = totalOffset & mask[2];
    spOffset[3]->u.ICONST = armSpOffset(totalOffset & mask[3]);

    return;
}
// void reset_sp (AS_instrList ail, int local_offset){
//     for(; ail; ail=ail->tail){
//         if(check_set_sp(ail->head)){
//             int old_offset = 0;
//             sscanf(ail->head->u.OPER.assem+strlen(set_sp_assem), "%d", &old_offset);
//             sprintf(as_buf, "sub `d0, `s0, #%d", old_offset+local_offset+8);
//             ail->head = AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), AS_OperandList(AS_Operand_Temp(&r[13]), NULL), NULL);
//             return;
//         }
//     }
//     return;
// }

static bool isComute = false;

static bool isCmp(T_ir instr)
{
    return instr->s->kind == LLVM_IR::llvm_T_stm_::T_CMP;
}

static void tryCommuteCmp(T_ir instr)
{
    assert(isCmp(instr));
    if(instr->s->u.CMP.left->kind == AS_operand_::T_ICONST
    || instr->s->u.CMP.left->kind == AS_operand_::T_FCONST){
        AS_operand temp = instr->s->u.CMP.left;
        instr->s->u.CMP.left = instr->s->u.CMP.right;
        instr->s->u.CMP.right = temp;
        isComute = true;
    }
}

static bool isCjump(T_ir instr)
{
    return instr->s->kind == LLVM_IR::llvm_T_stm_::T_CJUMP;
}

static LLVM_IR::T_relOp commute(LLVM_IR::T_relOp op)
{
    switch (op)
    {
    case LLVM_IR::T_eq:
        return LLVM_IR::T_eq;
    case LLVM_IR::T_ne:
        return LLVM_IR::T_ne;
    case LLVM_IR::T_lt:
        return LLVM_IR::T_gt;
    case LLVM_IR::T_ge:
        return LLVM_IR::T_le;
    case LLVM_IR::T_gt:
        return LLVM_IR::T_lt;
    case LLVM_IR::T_le:
        return LLVM_IR::T_ge;
    case LLVM_IR::F_eq:
        return LLVM_IR::F_eq;
    case LLVM_IR::F_ne:
        return LLVM_IR::F_ne;
    case LLVM_IR::F_lt:
        return LLVM_IR::F_gt;
    case LLVM_IR::F_ge:
        return LLVM_IR::F_le;
    case LLVM_IR::F_gt:
        return LLVM_IR::F_lt;
    case LLVM_IR::F_le:
        return LLVM_IR::F_ge;
    }
}

static void comuteCjump(T_ir instr){
    assert(isCjump(instr));
    assert(isComute);
    isComute = false;
    instr->s->u.CJUMP.op = commute(instr->s->u.CJUMP.op);
    return;
}

AS_blockList gen_arm_bgl(LLVM_IR::llvm_AS_blockList_ *bgabl)
{
    AS_blockList bList = NULL;
    AS_blockList blast = NULL;
    LLVM_IR::llvm_AS_blockList_ *l = bgabl;
    while (l)
    {
        LLVM_IR::T_irList_ *irl = l->head->irs;
        for(LLVM_IR::T_irList_ *t_irl = irl; t_irl; t_irl=t_irl->tail){
            if(isCmp(t_irl->head)){
                tryCommuteCmp(t_irl->head);
            }else if(isCjump(t_irl->head) && isComute){
                comuteCjump(t_irl->head);
            }else{
                ;
            }
        }
        // printf("arm_block_label: %s\n", Temp_labelstring(l->head->label));
        AS_instrList il = gen_asList_arm(irl);
        if (!il)
        {
            l = l->tail;
            continue;
        }
        if (blast)
            blast = blast->tail = AS_BlockList(AS_Block(il), NULL);
        else
            blast = bList = AS_BlockList(AS_Block(il), NULL);

        l = l->tail;
    }

    return bList;
}
