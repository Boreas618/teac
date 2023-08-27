/*
 * util.c - commonly used utility functions.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "util.h"
void *checked_malloc(int len)
{
    assert(len >= 0);
    void *p = malloc(len);
    if (!p)
    {
        fprintf(stderr, "\nRan out of memory!\n");
        exit(1);
    }
    return p;
}
string String(const char *s){
    string p = (string)checked_malloc((int)strlen(s) + 1);
    strcpy(p, s);
    return p;
}
string String(char *s)
{
    string p = (string)checked_malloc((int)strlen(s) + 1);
    strcpy(p, s);
    return p;
}

string Stringcat(char *a, char *b)
{
    string p = (string)checked_malloc((int)strlen(a) + strlen(b) + 5);
    strcpy(p, a);
#ifdef ARM_INSTR
    strcat(p, "__");
#else
    strcat(p, "__");
#endif
    strcat(p, b);
    return p;
}

string makeASTfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strcpy(p, a);
    strcat(p, ".ast");
    return p;
}

string makeIRPfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strcpy(p, a);
    strcat(p, ".irp");
    return p;
}

string makeSTMfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strcpy(p, a);
    strcat(p, ".stm");
    return p;
}

string makeLIVfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strcpy(p, a);
    strcat(p, ".liv");
    return p;
}

string makeLLVMfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strcpy(p, a);
    strcat(p, ".ll");
    return p;
}

string makeARMfilename(const char *a)
{
    string p = (string)checked_malloc((int)strlen(a) + 10);
    strncpy(p, a, strlen(a));
    strcat(p, ".s");
    return p;
}

void Stringbrk(const char *raw, char **pa, char **pb)
{
    int len = (int)strlen(raw);
    *pa = (char *)checked_malloc(len);
    *pb = (char *)checked_malloc(len);
    memset(*pa, 0, len);
    memset(*pb, 0, len);
    int i = 0;
    for (; i < len; ++i)
    {
        if (*(raw + i) != '$')
            *((*pa) + i) = *(raw + i);
        else
            break;
    }
    ++i;
    int j = i;
    for (; i < len; ++i)
    {
        *((*pb) + i - j) = *(raw + i);
    }
    return;
}

string StringLabel(char *s)
{
    string p = (string)checked_malloc((int)strlen(s) + 3);
    strcpy(p, s);
    strcat(p, ":");
    return p;
}

string StringLabel_arm(char *s)
{
    string p = (string)checked_malloc((int)strlen(s) + 5);
    strcpy(p, ".");
    strcat(p, s);
    strcat(p, ":");
    return p;
}

U_boolList U_BoolList(Bool head, U_boolList tail)
{
    U_boolList list = (U_boolList)checked_malloc((int)sizeof(*list));
    list->head = head;
    list->tail = tail;
    return list;
}

void *Stpop(Stack *st)
{
    assert(!Stempty(st));
    return st->s[st->top--];
}

void *Sttop(Stack *st)
{
    assert(!Stempty(st));
    return st->s[st->top];
}

void Stpush(Stack *st, void *it)
{
    assert(!Stfull(st));
    st->s[++st->top] = it;
}

Bool Stempty(Stack *st)
{
    return st->top == 0;
}

Bool Stfull(Stack *st)
{
    return st->top == Stmax + 1;
}

void Stinit(Stack *st)
{
    st->top = 0;
    return;
}

void *LStpop(LStack *st)
{
    assert(!LStempty(st));
    return st->s[st->top--];
}

void *LSttop(LStack *st)
{
    assert(!LStempty(st));
    return st->s[st->top];
}

void LStpush(LStack *st, void *it)
{
    assert(!LStfull(st));
    st->s[++st->top] = it;
}

Bool LStempty(LStack *st)
{
    return st->top == 0;
}

Bool LStfull(LStack *st)
{
    return st->top == LStmax + 1;
}

void LStinit(LStack *st)
{
    st->top = 0;
    return;
}

char edge_key[150];
char ptr_key[100];

string gen_edge_key(int u_num, int v_num)
{
    sprintf(edge_key, "(%d,%d)", u_num, v_num);
    return String(edge_key);
}

void get_edge_by_key(const char *key, int *u_num, int *v_num)
{
    *u_num = atoi(key + 1);
    const char *p = NULL;
    for (p = key;; ++p)
    {
        if (*p == ',')
            break;
    }
    *v_num = atoi(p + 1);
}

string gen_ptr_key(void *p)
{
    sprintf(ptr_key, "%p", p);
    return String(ptr_key);
}

void *str_to_ptr(char *key)
{
    void *p;
    sscanf(key, "%p", &p);
    return p;
}

// 查看当前进程的内存使用情况
void cat_used_memory()
{
    FILE *fp;
    fp = fopen("/proc/self/status", "r");
    char line[128];
    while (fgets(line, 128, fp) != NULL)
    {
        if (strncmp(line, "VmRSS:", 6) == 0)
        {
            printf("当前进程占用内存大小为：%.4f MB\n", (double)atoi(line + 6) / 1024);
            break;
        }
    }
    fclose(fp);
}
