#pragma once

#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "assem.h"

namespace LLVM_IR {

typedef struct llvm_T_stmList_ *T_stmList;
struct llvm_T_stmList_ {struct llvm_T_stm_* head; T_stmList tail;};

typedef struct T_ir_ *T_ir;
typedef struct T_irList_ *T_irList;
struct T_irList_ {T_ir head; T_irList tail;};

typedef enum
{
    T_plus,
    T_minus,
    T_mul,
    T_div,
    T_mod,
    F_plus,
    F_minus,
    F_mul,
    F_div
} T_binOp;

typedef enum
{
    T_eq,
    T_ne,
    T_lt,
    T_gt,
    T_le,
    T_ge,
    F_eq,
    F_ne,
    F_lt,
    F_gt,
    F_le,
    F_ge
} T_relOp;

struct llvm_T_stm_ {
    enum {T_BINOP, T_INTTOPTR, T_PTRTOINT, T_LOAD, T_STORE, T_LABEL,T_JUMP, T_CMP, T_CJUMP, T_MOVE, T_CALL, T_VOID_CALL, T_RETURN, T_PHI, T_NULL, T_ALLOCA, T_I2F, T_F2I, T_GEP} kind;
    union {
        struct {T_binOp op; AS_operand left, right, dst;} BINOP;
        struct {AS_operand dst, src;} INTTOPTR;
        struct {AS_operand dst, src;} PTRTOINT;
        struct {AS_operand dst, ptr;} LOAD;
        struct {AS_operand src, ptr;} STORE;
        struct {Temp_label label;} LABEL;
        struct {Temp_label jump;} JUMP;
        struct {T_relOp op; AS_operand left, right;} CMP;
        struct {T_relOp op; Temp_label true_label, false_label;} CJUMP;
        struct {AS_operand dst, src;} MOVE;
        struct {string fun; AS_operand res; AS_operandList args;} CALL;
        struct {string fun; AS_operandList args;} VOID_CALL;
        struct {AS_operand ret;} RET;
        struct {AS_operand dst; Phi_pair_List phis;} PHI;
        struct {AS_operand dst; int size; bool isIntArr;} ALLOCA;
        struct {AS_operand dst, src;} I2F;
        struct {AS_operand dst, src;} F2I;
        struct {AS_operand new_ptr, base_ptr, index;} GEP;
    } u;
};

struct T_ir_ {
    llvm_T_stm_* s;
    AS_instr i;
    int num;
    bool remove;
};



T_stmList T_StmList (llvm_T_stm_* head, T_stmList tail);
T_irList T_IrList(T_ir head, T_irList tail);

llvm_T_stm_* T_Binop(T_binOp op, AS_operand dst, AS_operand left, AS_operand right);
llvm_T_stm_* T_InttoPtr(AS_operand dst, AS_operand src);
llvm_T_stm_* T_PtrtoInt(AS_operand dst, AS_operand src);
llvm_T_stm_* T_Load(AS_operand dst, AS_operand ptr);
llvm_T_stm_* T_Store(AS_operand src, AS_operand ptr);
llvm_T_stm_* T_Label(Temp_label label);
llvm_T_stm_* T_Jump(Temp_label label);
llvm_T_stm_* T_Cmp(T_relOp op,AS_operand left, AS_operand right);
llvm_T_stm_* T_Cjump(T_relOp op, Temp_label true_label, Temp_label false_label);
llvm_T_stm_* T_Move(AS_operand dst, AS_operand src);
llvm_T_stm_* T_Call(string fun, AS_operand res, AS_operandList args);
llvm_T_stm_* T_VoidCall(string fun, AS_operandList args);
llvm_T_stm_* T_Return(AS_operand ret);
llvm_T_stm_* T_Phi(AS_operand dst, Temp_labelList ll, AS_operandList opl);
llvm_T_stm_ * T_Null();
llvm_T_stm_* T_Alloca(AS_operand dst, int size, bool isIntArr);
llvm_T_stm_* T_I2f(AS_operand dst, AS_operand src);
llvm_T_stm_* T_F2i(AS_operand dst, AS_operand src);
llvm_T_stm_* T_Gep(AS_operand new_ptr, AS_operand base_ptr, AS_operand index);

T_ir T_Ir(llvm_T_stm_* s, AS_instr i);

AS_instrList getinstrList(LLVM_IR::T_irList_ * irl);

bool irReplaceDstTemp(LLVM_IR::llvm_T_stm_ *s, Temp_temp old_temp, Temp_temp new_temp);
bool irReplaceSrcTemp(LLVM_IR::llvm_T_stm_ *s, Temp_temp old_temp, Temp_temp new_temp);
bool phiReplacejthSrcTemp(LLVM_IR::llvm_T_stm_ *s, int j, Temp_temp old_temp, Temp_temp new_temp);

AS_instrList irList_to_insList(LLVM_IR::T_irList irl);

T_relOp T_notRel(T_relOp); 
} // namespace LLVM_ASM