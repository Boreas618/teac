/*
 * assem.h - Function prototypes to translate to Assem-instructions
 *             using Maximal Munch.
 */
#ifndef __ASSEM
#define __ASSEM

#include "temp.h"

typedef struct {Temp_labelList labels;} AS_targets_;
typedef AS_targets_ *AS_targets;
AS_targets AS_Targets(Temp_labelList labels);

typedef struct
{
  Temp_label name;
  TempType type;
} Name_name;

typedef struct AS_operand_ *AS_operand;
struct AS_operand_ {
    enum {T_TEMP, T_NAME, T_ICONST, T_FCONST} kind;
    union {
        Temp_temp TEMP;
        Name_name NAME;
        int ICONST;
        float FCONST;
    } u;
};

AS_operand AS_Operand_Temp_NewTemp();
AS_operand AS_Operand_Temp_NewFloatTemp();
AS_operand AS_Operand_Temp_NewIntPtrTemp();
AS_operand AS_Operand_Temp_NewFloatPtrTemp();
AS_operand AS_Operand_Temp(Temp_temp temp);
AS_operand AS_Operand_Name(Temp_label name, TempType type);
AS_operand AS_Operand_Const(int con);
AS_operand AS_Operand_FConst(float fcon);



bool isIntPtr(AS_operand);
bool isFloatPtr(AS_operand);
bool isInt(AS_operand);
bool isFloat(AS_operand);
bool isUnknown(AS_operand op);

bool opTypeEqInfer(AS_operand op1, AS_operand op2);
bool opTypeMemInfer(AS_operand ptr, AS_operand op);


typedef struct AS_operandList_ *AS_operandList;
struct AS_operandList_ {AS_operand head; AS_operandList tail;};

AS_operandList AS_OperandList (AS_operand head, AS_operandList tail);
void printOperList(AS_operandList opl);

AS_operand* GetjthOper(AS_operandList opl, int j);
AS_operand nthOperand(AS_operandList list, int i);

typedef struct Phi_pair_ *Phi_pair;
struct Phi_pair_ {AS_operand op; Temp_label label;};

typedef struct Phi_pair_List_ *Phi_pair_List;
struct Phi_pair_List_ {Phi_pair head; Phi_pair_List tail;};

Phi_pair Phi_Pair(AS_operand op, Temp_label label);
Phi_pair_List Phi_Pair_List(Phi_pair head, Phi_pair_List tail);

typedef struct AS_instr_ *AS_instr;
struct AS_instr_ { enum {I_OPER, I_LABEL, I_MOVE} kind;
	       union {struct {string assem; AS_operandList dst, src; 
			      AS_targets jumps;} OPER;
		      struct {string assem; Temp_label label;} LABEL;
		      struct {string assem; AS_operandList dst, src;} MOVE;
		    } u;
        int nest_depth;
	      };

AS_instr AS_Oper(string a, AS_operandList d, AS_operandList s, AS_targets j);
AS_instr AS_Label(string a, Temp_label label);
AS_instr AS_Move(string a, AS_operandList d, AS_operandList s);

AS_instr AS_Oper(string a, AS_operandList d, AS_operandList s, AS_targets j, int depth);
AS_instr AS_Move(string a, AS_operandList d, AS_operandList s, int depth);

void AS_format(char *, string, AS_operandList, AS_operandList, AS_targets, Temp_map);
void AS_print(FILE *out, AS_instr i, Temp_map m);
void AS_print_llvm(FILE *out, AS_instr i, Temp_map m);
void AS_print_colored(FILE *out, AS_instr i, Temp_map m);

typedef struct AS_instrList_ *AS_instrList;
struct AS_instrList_ { AS_instr head; AS_instrList tail;};
AS_instrList AS_InstrList(AS_instr head, AS_instrList tail);

AS_instrList AS_splice(AS_instrList a, AS_instrList b);
void AS_printInstrList (FILE *out, AS_instrList iList, Temp_map m);
void AS_printInstrList_colored (FILE *out, AS_instrList iList, Temp_map m);
void AS_printInstrList_llvm (FILE *out, AS_instrList iList, Temp_map m);

typedef struct AS_proc_ *AS_proc;
struct AS_proc_ {
  string prolog;
  AS_instrList body;
  string epilog;
};

AS_proc AS_Proc(string p, AS_instrList b, string e);

AS_instrList AS_instrList_union(AS_instrList ail1, AS_instrList ail2);
AS_instrList AS_instrList_add(AS_instrList ail, AS_instr instr);
AS_instrList AS_instrList_replace(AS_instrList ail, AS_instr old_instr, AS_instrList now_il);
AS_instrList AS_instrList_replace_opt(AS_instrList ail, AS_instrList *prev, AS_instrList *old_instr_node, AS_instrList now_il);
void AS_instr_replace_temp(AS_instr instr, Temp_temp old, Temp_temp now);
bool AS_Opl_replace_temp(AS_operandList opl, Temp_temp old, Temp_temp now);
bool AS_Opl_replace_color(AS_operandList opl, Temp_temp old, Temp_temp now);
Bool IsStr(AS_instr instr);

Temp_tempList getTempList(AS_operandList opl);
AS_operandList getOperandList(Temp_tempList tl);
TempSet makeTempSet(AS_operandList opl);

AS_operandList GetSrc(AS_instr instr);
AS_operandList GetDst(AS_instr instr);

#endif