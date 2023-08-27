/*
 * mipscodegen.c - Functions to translate to Assem-instructions for
 *             the Jouette assembly language using Maximal Munch.
 */

#include <stdio.h>
#include <stdlib.h> /* for atoi */
#include <string.h> /* for strcpy */
#include <assert.h>
#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "assem.h"

static long long floatHex_llvm(double *f)
{
    return *(long long *)f;
}

static int floatHex_arm(float *f)
{
    return *(int *)f;
}

AS_targets AS_Targets(Temp_labelList labels)
{
    AS_targets p = (AS_targets)checked_malloc(sizeof *p);
    p->labels = labels;
    return p;
}

AS_operand AS_Operand_Temp_NewTemp()
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_TEMP;
    p->u.TEMP = Temp_newtemp();
    return p;
}

AS_operand AS_Operand_Temp_NewFloatTemp()
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_TEMP;
    p->u.TEMP = Temp_newtemp_float();
    return p;
}

AS_operand AS_Operand_Temp_NewIntPtrTemp()
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_TEMP;
    p->u.TEMP = Temp_newtemp_int_ptr();
    return p;
}

AS_operand AS_Operand_Temp_NewFloatPtrTemp()
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_TEMP;
    p->u.TEMP = Temp_newtemp_float_ptr();
    return p;
}

AS_operand AS_Operand_Temp(Temp_temp temp)
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_TEMP;
    p->u.TEMP = temp;
    return p;
}

AS_operand AS_Operand_Name(Temp_label name, TempType type)
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_NAME;
    p->u.NAME.name = name;
    p->u.NAME.type = type;
    return p;
}

AS_operand AS_Operand_Const(int con)
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_ICONST;
    p->u.ICONST = con;
    return p;
}

AS_operand AS_Operand_FConst(float fcon)
{
    AS_operand p = (AS_operand)checked_malloc(sizeof *p);
    p->kind = AS_operand_::T_FCONST;
    p->u.FCONST = fcon;
    return p;
}

bool isIntPtr(AS_operand op)
{
    if ((op->kind == AS_operand_::T_TEMP && (op->u.TEMP->type == INT_PTR)) || (op->kind == AS_operand_::T_NAME && (op->u.NAME.type == INT_PTR)))
        return true;
    else
        return false;
}
bool isFloatPtr(AS_operand op)
{
    if ((op->kind == AS_operand_::T_TEMP && (op->u.TEMP->type == FLOAT_PTR)) || (op->kind == AS_operand_::T_NAME && (op->u.NAME.type == FLOAT_PTR)))
        return true;
    else
        return false;
}
bool isInt(AS_operand op)
{
    if ((op->kind == AS_operand_::T_TEMP && (op->u.TEMP->type == INT_TEMP)) || (op->kind == AS_operand_::T_NAME && (op->u.NAME.type == INT_TEMP)) || op->kind == AS_operand_::T_ICONST)
        return true;
    else
        return false;
}
bool isFloat(AS_operand op)
{
    if ((op->kind == AS_operand_::T_TEMP && (op->u.TEMP->type == FLOAT_TEMP)) || (op->kind == AS_operand_::T_NAME && (op->u.NAME.type == FLOAT_TEMP)) || op->kind == AS_operand_::T_FCONST)
        return true;
    else
        return false;
}
bool isUnknown(AS_operand op)
{
    if (op->kind == AS_operand_::T_TEMP && op->u.TEMP->type == UNKNOWN)
        return true;
    else
        return false;
}

bool opTypeEqInfer(AS_operand op1, AS_operand op2)
{
    if (isUnknown(op1) && isUnknown(op2))
    {
        return false;
    }
    else if (isUnknown(op1))
    {
        if (isInt(op2))
        {
            op1->u.TEMP->type = INT_TEMP;
        }
        else if (isIntPtr(op2))
        {
            op1->u.TEMP->type = INT_PTR;
        }
        else if (isFloat(op2))
        {
            op1->u.TEMP->type = FLOAT_TEMP;
        }
        else if (isFloatPtr(op2))
        {
            op1->u.TEMP->type = FLOAT_PTR;
        }
        else
        {
            assert(0);
        }
        return true;
    }
    else if (isUnknown(op2))
    {
        if (isInt(op1))
        {
            op2->u.TEMP->type = INT_TEMP;
        }
        else if (isIntPtr(op1))
        {
            op2->u.TEMP->type = INT_PTR;
        }
        else if (isFloat(op1))
        {
            op2->u.TEMP->type = FLOAT_TEMP;
        }
        else if (isFloatPtr(op1))
        {
            op2->u.TEMP->type = FLOAT_PTR;
        }
        else
        {
            assert(0);
        }
        return true;
    }
    else
    {
        if (isIntPtr(op1))
        {
            return isIntPtr(op2);
        }
        else if (isInt(op1))
        {
            return isInt(op2);
        }
        else if (isFloat(op1))
        {
            return isFloat(op2);
        }
        else if (isFloatPtr(op1))
        {
            return isFloatPtr(op2);
        }
        else
        {
            return false;
        }
    }
}

bool opTypeMemInfer(AS_operand ptr, AS_operand op)
{
    if (isIntPtr(ptr))
    {
        if (isUnknown(op))
        {
            op->u.TEMP->type = INT_TEMP;
        }
        return isInt(op);
    }
    else if (isFloatPtr(ptr))
    {
        if (isUnknown(op))
        {
            op->u.TEMP->type = FLOAT_TEMP;
        }
        return isFloat(op);
    }
    else
    {
        return false; // ptr no type
    }
}

AS_operandList AS_OperandList(AS_operand head, AS_operandList tail)
{
    AS_operandList p = (AS_operandList)checked_malloc(sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

void printOperList(AS_operandList opl){
    printf("OperList: ");
    for(; opl; opl=opl->tail){
        printf("%d ", opl->head->kind);
    }   
    printf("\n");
}

AS_operand *GetjthOper(AS_operandList opl, int j)
{
    int i = 1;
    for (; opl && i < j; opl = opl->tail, ++i)
        ;
    if (i == j)
        return &opl->head;
    else
        return NULL;
}

AS_operand nthOperand(AS_operandList list, int i)
{
    assert(list);
    if (i == 0)
        return list->head;
    else
        return nthOperand(list->tail, i - 1);
}

Phi_pair Phi_Pair(AS_operand op, Temp_label label)
{
    Phi_pair p = (Phi_pair)checked_malloc(sizeof *p);
    p->op = op;
    p->label = label;
    return p;
}

Phi_pair_List Phi_Pair_List(Phi_pair head, Phi_pair_List tail)
{
    Phi_pair_List p = (Phi_pair_List)checked_malloc(sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

AS_instr AS_Oper(string a, AS_operandList d, AS_operandList s, AS_targets j)
{
    AS_instr p = (AS_instr)checked_malloc(sizeof *p);
    p->kind = AS_instr_::I_OPER;
    p->u.OPER.assem = a;
    p->u.OPER.dst = d;
    p->u.OPER.src = s;
    p->u.OPER.jumps = j;
    p->nest_depth = 0;
    return p;
}

AS_instr AS_Label(string a, Temp_label label)
{
    AS_instr p = (AS_instr)checked_malloc(sizeof(*p));
    p->kind = AS_instr_::I_LABEL;
    p->u.LABEL.assem = a;
    p->u.LABEL.label = label;
    p->nest_depth = 0;
    return p;
}

AS_instr AS_Move(string a, AS_operandList d, AS_operandList s)
{
    AS_instr p = (AS_instr)checked_malloc(sizeof *p);
    p->kind = AS_instr_::I_MOVE;
    p->u.MOVE.assem = a;
    p->u.MOVE.dst = d;
    p->u.MOVE.src = s;
    p->nest_depth = 0;
    return p;
}

AS_instr AS_Oper(string a, AS_operandList d, AS_operandList s, AS_targets j, int depth)
{
    AS_instr p = (AS_instr)checked_malloc(sizeof *p);
    p->kind = AS_instr_::I_OPER;
    p->u.OPER.assem = a;
    p->u.OPER.dst = d;
    p->u.OPER.src = s;
    p->u.OPER.jumps = j;
    p->nest_depth = depth;
    return p;
}

AS_instr AS_Move(string a, AS_operandList d, AS_operandList s, int depth)
{
    AS_instr p = (AS_instr)checked_malloc(sizeof *p);
    p->kind = AS_instr_::I_MOVE;
    p->u.MOVE.assem = a;
    p->u.MOVE.dst = d;
    p->u.MOVE.src = s;
    p->nest_depth = depth;
    return p;
}

AS_instrList AS_InstrList(AS_instr head, AS_instrList tail)
{
    AS_instrList p = (AS_instrList)checked_malloc(sizeof *p);
    p->head = head;
    p->tail = tail;
    return p;
}

/* put list b at the end of list a */
AS_instrList AS_splice(AS_instrList a, AS_instrList b)
{
    AS_instrList p;
    if (a == NULL)
        return b;
    for (p = a; p->tail != NULL; p = p->tail)
        ;
    p->tail = b;
    return a;
}

static void gen_res(char *result, AS_operand operand)
{
    if (!operand)
        return;
    char operand_str[80];
    switch (operand->kind)
    {
    case AS_operand_::T_ICONST:
    {
        sprintf(operand_str, "%d", operand->u.ICONST);
        strcpy(result, operand_str);
    }
    case AS_operand_::T_NAME:
    {
        strcpy(result, Temp_labelstring(operand->u.NAME.name));
    }
    case AS_operand_::T_TEMP:
    {
        sprintf(operand_str, "t%d", operand->u.TEMP->num);
        strcpy(result, operand_str);
    }
    default:
    {
        assert(0);
    }
    }
    return;
}

static void make_res(char *result, AS_operand operand, int *p_i)
{
    if (!operand)
        return;
    char operand_str[80];
    if (operand->kind != AS_operand_::T_ICONST && operand->kind != AS_operand_::T_FCONST && operand->kind != AS_operand_::T_NAME && operand->kind != AS_operand_::T_TEMP)
        assert(0);
    switch (operand->kind)
    {
    case AS_operand_::T_ICONST:
    {
        sprintf(operand_str, "#%d", operand->u.ICONST);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_FCONST:
    {
        sprintf(operand_str, "#%f", operand->u.FCONST);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_NAME:
    {
        strcpy(result, Temp_labelstring(operand->u.NAME.name));
        *(p_i) += strlen(Temp_labelstring(operand->u.NAME.name));
        return;
    }
    case AS_operand_::T_TEMP:
    {
        sprintf(operand_str, "t%d", operand->u.TEMP->num);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    default:
    {
        assert(0);
    }
    }
    return;
}

static void make_res_llvm(char *result, AS_operand operand, int *p_i)
{
    if (!operand)
        return;
    char operand_str[800];
    if (operand->kind != AS_operand_::T_ICONST && operand->kind != AS_operand_::T_FCONST && operand->kind != AS_operand_::T_NAME && operand->kind != AS_operand_::T_TEMP)
    {
        printf("%d\n", operand->kind);
        assert(0);
    }

    switch (operand->kind)
    {
    case AS_operand_::T_ICONST:
    {
        sprintf(operand_str, "%d", operand->u.ICONST);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_FCONST:
    {
        double fcon = operand->u.FCONST;
        // printf("%f\n", fcon);
        sprintf(operand_str, "0x%llX", floatHex_llvm(&fcon));
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_NAME:
    {
        strcpy(result, "@");
        strcat(result, Temp_labelstring(operand->u.NAME.name));
        *(p_i) += strlen(Temp_labelstring(operand->u.NAME.name)) + 1;
        return;
    }
    case AS_operand_::T_TEMP:
    {
        sprintf(operand_str, "%%t%d", operand->u.TEMP->num);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    default:
    {
        assert(0);
    }
    }
    return;
}

static void make_res_color(char *result, AS_operand operand, int *p_i)
{
    if (!operand)
        return;
    if (operand->kind != AS_operand_::T_ICONST && operand->kind != AS_operand_::T_FCONST && operand->kind != AS_operand_::T_NAME && operand->kind != AS_operand_::T_TEMP)
    {
        printf("%d\n", operand->kind);
        assert(0);
    }

    char operand_str[800];
    switch (operand->kind)
    {
    case AS_operand_::T_ICONST:
    {
        sprintf(operand_str, "#%d", operand->u.ICONST);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_FCONST:
    {
        float fcon = operand->u.FCONST;
        // printf("%f\n", fcon);
        sprintf(operand_str, "%d", floatHex_arm(&fcon));
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    case AS_operand_::T_NAME:
    {
        strcpy(result, Temp_labelstring(operand->u.NAME.name));
        *(p_i) += strlen(Temp_labelstring(operand->u.NAME.name));
        return;
    }
    case AS_operand_::T_TEMP:
    {
        if(operand->u.TEMP->color < RESEVED_REG)// gp
            sprintf(operand_str, "r%d", operand->u.TEMP->color);
        else // fp
            sprintf(operand_str, "s%d", operand->u.TEMP->color-RESEVED_REG);
        strcpy(result, operand_str);
        *(p_i) += strlen(operand_str);
        return;
    }
    default:
    {
        assert(0);
    }
    }
    return;
}

/* first param is string created by this function by reading 'assem' string
 * and replacing `d `s and `j stuff.
 * Last param is function to use to determine what to do with each temp.
 */
static void format(char *result, string assem,
                   AS_operandList dst, AS_operandList src,
                   AS_targets jumps, Temp_map m)
{
    char *p;
    char n_str[50];
    int i = 0; /* offset to result string */
    for (p = assem; p && *p != '\0'; p++)
        if (*p == '`')
            switch (*(++p))
            {
            case 's':
            {
                int n = atoi(++p);
                make_res(result + i, nthOperand(src, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'd':
            {
                int n = atoi(++p);
                make_res(result + i, nthOperand(dst, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'j':
            {
                assert(jumps);
                int n = atoi(++p);
                string s = Temp_labelstring(nthLabel(jumps->labels, n));
                strcpy(result + i, s);
                i += strlen(s);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case '`':
            {
                result[i] = '`';
                i++;
                break;
            }
            default:
                assert(0);
            }
        else
        {
            result[i] = *p;
            i++;
        }
    result[i] = '\0';
}

static void format_llvm(char *result, string assem,
                        AS_operandList dst, AS_operandList src,
                        AS_targets jumps, Temp_map m)
{
    char *p;
    char n_str[50];
    int i = 0; /* offset to result string */
    for (p = assem; p && *p != '\0'; p++)
        if (*p == '`')
            switch (*(++p))
            {
            case 's':
            {
                int n = atoi(++p);
                make_res_llvm(result + i, nthOperand(src, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'd':
            {
                int n = atoi(++p);
                make_res_llvm(result + i, nthOperand(dst, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'j':
            {
                assert(jumps);
                int n = atoi(++p);
                string s = Temp_labelstring(nthLabel(jumps->labels, n));
                strcpy(result + i, "%");
                strcpy(result + i + 1, s);
                i += strlen(s) + 1;
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case '`':
            {
                result[i] = '`';
                i++;
                break;
            }
            default:
                assert(0);
            }
        else
        {
            result[i] = *p;
            i++;
        }
    result[i] = '\0';
}

static char reg_num[100];

static void format_colored(char *result, string assem,
                           AS_operandList dst, AS_operandList src,
                           AS_targets jumps, Temp_map m)
{
    char *p;
    char n_str[50];
    int i = 0; /* offset to result string */
    for (p = assem; p && *p != '\0'; p++)
        if (*p == '`')
            switch (*(++p))
            {
            case 's':
            {
                int n = atoi(++p);
                make_res_color(result + i, nthOperand(src, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'd':
            {
                int n = atoi(++p);
                make_res_color(result + i, nthOperand(dst, n), &i);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case 'j':
            {
                assert(jumps);
                int n = atoi(++p);
                string s = Temp_labelstring(nthLabel(jumps->labels, n));
                strcpy(result + i, s);
                i += strlen(s);
                sprintf(n_str, "%d", n);
                p += strlen(n_str) - 1;
                break;
            }
            case '`':
            {
                result[i] = '`';
                i++;
                break;
            }
            default:
                assert(0);
            }
        else
        {
            result[i] = *p;
            i++;
        }
    result[i] = '\0';
}

void AS_format(char *result, string assem,
               AS_operandList dst, AS_operandList src,
               AS_targets jumps, Temp_map m)
{
    format(result, assem, dst, src, jumps, m);

    strcpy(result + strlen(result), "; d: ");
    AS_operandList l = dst;
    char operand_str[800];
    while (l)
    {
        gen_res(operand_str, l->head);
        strcpy(result + strlen(result), operand_str);
        l = l->tail;
        if (l)
            strcpy(result + strlen(result), ", ");
        else
            strcpy(result + strlen(result), "; ");
    }

    strcpy(result + strlen(result), "s: ");
    l = src;
    while (l)
    {
        gen_res(operand_str, l->head);
        strcpy(result + strlen(result), operand_str);
        l = l->tail;
        if (l)
            strcpy(result + strlen(result), ", ");
    }
}

void AS_print(FILE *out, AS_instr i, Temp_map m)
{
    char r[200000]; /* result */
    switch (i->kind)
    {
    case AS_instr_::I_OPER:
        format(r, i->u.OPER.assem, i->u.OPER.dst, i->u.OPER.src, i->u.OPER.jumps, m);
        fprintf(out, "%s", r);
        break;
    case AS_instr_::I_LABEL:
        format(r, i->u.LABEL.assem, NULL, NULL, NULL, m);
        fprintf(out, "%s", r);
        /* i->u.LABEL->label); */
        break;
    case AS_instr_::I_MOVE:
        format(r, i->u.MOVE.assem, i->u.MOVE.dst, i->u.MOVE.src, NULL, m);
        fprintf(out, "%s", r);
        break;
    }
    fprintf(out, "\n");
}

void AS_print_colored(FILE *out, AS_instr i, Temp_map m)
{
    char r[200000]; /* result */
    switch (i->kind)
    {
    case AS_instr_::I_OPER:
        format_colored(r, i->u.OPER.assem, i->u.OPER.dst, i->u.OPER.src, i->u.OPER.jumps, m);
        fprintf(out, "%s", r);
        break;
    case AS_instr_::I_LABEL:
        format_colored(r, i->u.LABEL.assem, NULL, NULL, NULL, m);
        fprintf(out, "%s", r);
        /* i->u.LABEL->label); */
        break;
    case AS_instr_::I_MOVE:
        format_colored(r, i->u.MOVE.assem, i->u.MOVE.dst, i->u.MOVE.src, NULL, m);
        fprintf(out, "%s", r);
        break;
    }
    fprintf(out, "\n");
}

void AS_print_llvm(FILE *out, AS_instr i, Temp_map m)
{
    char r[200000]; /* result */
    switch (i->kind)
    {
    case AS_instr_::I_OPER:
        format_llvm(r, i->u.OPER.assem, i->u.OPER.dst, i->u.OPER.src, i->u.OPER.jumps, m);
        fprintf(out, "%s", r);
        break;
    case AS_instr_::I_LABEL:
        format_llvm(r, i->u.LABEL.assem, NULL, NULL, NULL, m);
        fprintf(out, "%s", r);
        /* i->u.LABEL->label); */
        break;
    case AS_instr_::I_MOVE:
        format_llvm(r, i->u.MOVE.assem, i->u.MOVE.dst, i->u.MOVE.src, NULL, m);
        fprintf(out, "%s", r);
        break;
    }
    fprintf(out, "\n");
}

/* c should be COL_color; temporarily it is not */
void AS_printInstrList(FILE *out, AS_instrList iList, Temp_map m)
{
    for (; iList; iList = iList->tail)
    {
        AS_print(out, iList->head, m);
        // printf("type %d\n", iList->head->kind);
    }
    fprintf(out, "\n");
}

void AS_printInstrList_colored(FILE *out, AS_instrList iList, Temp_map m)
{
    for (; iList; iList = iList->tail)
    {
        AS_print_colored(out, iList->head, m);
    }
    fprintf(out, "\n");
}

void AS_printInstrList_llvm(FILE *out, AS_instrList iList, Temp_map m)
{
    for (; iList; iList = iList->tail)
    {
        AS_print_llvm(out, iList->head, m);
    }
    fprintf(out, "\n");
}

AS_proc AS_Proc(string p, AS_instrList b, string e)
{
    AS_proc proc = (AS_proc)checked_malloc(sizeof(*proc));
    proc->prolog = p;
    proc->body = b;
    proc->epilog = e;
    return proc;
}

AS_instrList AS_instrList_add(AS_instrList ail, AS_instr instr)
{
    if (!ail)
        return AS_InstrList(instr, NULL);
    for (AS_instrList l1 = ail; l1; l1 = l1->tail)
    {
        if (l1->head == instr)
            return ail; // nothing to add
        if (l1->tail == NULL)
        {
            l1->tail = AS_InstrList(instr, NULL);
        }
    }
    return ail;
}

AS_instrList AS_instrList_union(AS_instrList ail1, AS_instrList ail2)
{
    for (; ail2 != NULL; ail2 = ail2->tail)
        ail1 = AS_instrList_add(ail1, ail2->head);
    return (ail1);
}

void AS_instr_replace_temp(AS_instr instr, Temp_temp old, Temp_temp now)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        for (AS_operandList use_tl = instr->u.OPER.src; use_tl; use_tl = use_tl->tail)
        {
            if (use_tl->head->kind == AS_operand_::T_TEMP && use_tl->head->u.TEMP == old)
                use_tl->head->u.TEMP = now;
        }
        for (AS_operandList def_tl = instr->u.OPER.dst; def_tl; def_tl = def_tl->tail)
        {
            if (def_tl->head->kind == AS_operand_::T_TEMP && def_tl->head->u.TEMP == old)
                def_tl->head->u.TEMP = now;
        }
    }
    if (instr->kind == AS_instr_::I_MOVE)
    {
        for (AS_operandList use_tl = instr->u.MOVE.src; use_tl; use_tl = use_tl->tail)
        {
            if (use_tl->head->kind == AS_operand_::T_TEMP && use_tl->head->u.TEMP == old)
                use_tl->head->u.TEMP = now;
        }
        for (AS_operandList def_tl = instr->u.MOVE.dst; def_tl; def_tl = def_tl->tail)
        {
            if (def_tl->head->kind == AS_operand_::T_TEMP && def_tl->head->u.TEMP == old)
                def_tl->head->u.TEMP = now;
        }
    }
}

bool AS_Opl_replace_temp(AS_operandList opl, Temp_temp old, Temp_temp now)
{
    bool success = false;
    for (; opl; opl = opl->tail)
    {
        if (opl->head->kind == AS_operand_::T_TEMP && opl->head->u.TEMP == old)
        {
            opl->head = AS_Operand_Temp(now);
            success = true;
        }
    }
    return success;
}

bool AS_Opl_replace_color(AS_operandList opl, Temp_temp old, Temp_temp now)
{
    bool success = false;
    for (; opl; opl = opl->tail)
    {
        if (opl->head->kind == AS_operand_::T_TEMP && opl->head->u.TEMP->color == old->color)
        {
            opl->head = AS_Operand_Temp(now);
            success = true;
        }
    }
    return success;
}

Bool IsStr(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        if (*(instr->u.OPER.assem) == 's' && *(instr->u.OPER.assem + 1) == 't' && *(instr->u.OPER.assem + 2) == 'r')
            return TRUE;
    }
    return FALSE;
}

AS_instrList AS_instrList_replace(AS_instrList ail, AS_instr old_instr, AS_instrList now_il)
{
    if(ail->head == old_instr){
    // do not modify head node (head node is prolog, no need to modify)
    // cause RewriteProgram do not pass the pointer of head node
    // if you modify head node, the modify will not be done
    // and RewriteProgram will crash
        return ail;
    }
    for (AS_instrList il = ail; il && il->tail; il = il->tail)
    {
        if (il->tail->head == old_instr)
        {
            AS_instrList next = il->tail->tail;
            il->tail->tail = NULL;

            if (!now_il)
            {
                il->tail = next;
                return ail;
            }

            il->tail = now_il;

            for (; now_il; now_il = now_il->tail)
            {
                if (now_il->tail == NULL)
                {
                    now_il->tail = next;
                    break;
                }
            }
            break;
        }
    }
    return ail;
}

AS_instrList AS_instrList_replace_opt(AS_instrList ail, AS_instrList *prev, AS_instrList *old_instr_node, AS_instrList now_il){
  // 函数返回时保证 prev 和 old_instr_node 指向相同的节点
  // 这样可以保证 *old_instr_node 走到后继依然满足其前驱是 *prev 的条件
  // 函数的返回值永远是 ail (因为这个函数不修改头节点)
  AS_instr old_instr = (*old_instr_node)->head;
  if(ail->head == old_instr){
    // do not modify head node (head node is prolog, no need to modify)
    // cause RewriteProgram do not pass the pointer of head node
    // if you modify head node, the modify will not be done
    // and RewriteProgram will crash
    return ail;
  }
  assert(*prev);
  assert((*prev)->tail == *old_instr_node);
  assert((*prev)->tail->head == old_instr);

  AS_instrList next = (*old_instr_node)->tail;
  (*old_instr_node)->tail = NULL;

  if(!now_il){
    (*prev)->tail = next;
    *old_instr_node = *prev;
  }else{
    (*prev)->tail = now_il;
    for (; now_il; now_il=now_il->tail){
      if (now_il->tail == NULL){
        now_il->tail = next;
        *prev = now_il;
        *old_instr_node = now_il;
        break;
      }
    }
  }
  return ail;
}

Temp_tempList getTempList(AS_operandList opl)
{
    Temp_tempList tlast = NULL;
    Temp_tempList tlist = NULL;
    AS_operandList l = opl;
    for (; l; l = l->tail)
    {
        if (l->head->kind == AS_operand_::T_TEMP)
        {
            if (tlast)
                tlast = tlast->tail = Temp_TempList(l->head->u.TEMP, NULL);
            else
                tlast = tlist = Temp_TempList(l->head->u.TEMP, NULL);
        }
    }
    return tlist;
}

TempSet makeTempSet(AS_operandList opl)
{
    TempSet tempSet = new TempSet_;
    AS_operandList l = opl;
    for (; l; l = l->tail)
    {
        if (l->head->kind == AS_operand_::T_TEMP)
        {
            (*tempSet).emplace(l->head->u.TEMP);
        }
    }
    return tempSet;
}

AS_operandList getOperandList(Temp_tempList tl)
{
    AS_operandList oplast = NULL;
    AS_operandList oplist = NULL;
    Temp_tempList l = tl;
    for (; l; l = l->tail)
    {
        if (oplast)
            oplast = oplast->tail = AS_OperandList(AS_Operand_Temp(l->head), NULL);
        else
            oplast = oplist = AS_OperandList(AS_Operand_Temp(l->head), NULL);
    }
    return oplist;
}

AS_operandList GetSrc(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
        return instr->u.OPER.src;
    else if (instr->kind == AS_instr_::I_MOVE)
        return instr->u.MOVE.src;
    else
        return NULL;
}

AS_operandList GetDst(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
        return instr->u.OPER.dst;
    else if (instr->kind == AS_instr_::I_MOVE)
        return instr->u.MOVE.dst;
    else
        return NULL;
}
