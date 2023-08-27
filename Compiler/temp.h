#ifndef __TEMP
#define __TEMP

/*
 * temp.h
 *
 */
#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "oldtable.h"
#include <unordered_set>

typedef enum
{
    UNKNOWN,
    INT_TEMP,
    FLOAT_TEMP,
    INT_PTR,
    FLOAT_PTR
} TempType;
// offset is the var offset on stack
struct Temp_temp_
{
    int num;
    int color;
    int alias;
    char *info;
    Bool isSpill;
    int offset;
    int gp_degree;
    int fp_degree;
    Bool isCallee;
    int spilledColor;
    TempType type;
};
typedef struct Temp_temp_ *Temp_temp;
Temp_temp Temp_newtemp_unknown(void);
Temp_temp Temp_newtemp(void);
void Temp_inittemp();
void Temp_resettemp();
Temp_temp Temp_newtemp_float(void);
Temp_temp Temp_newtemp_int_ptr(void);
Temp_temp Temp_newtemp_float_ptr(void);

typedef struct Temp_tempList_ *Temp_tempList;
struct Temp_tempList_
{
    Temp_temp head;
    Temp_tempList tail;
};
Temp_tempList Temp_TempList(Temp_temp h, Temp_tempList t);

Temp_temp* GetjthTemp(Temp_tempList tl, int j);
Temp_temp nthTemp(Temp_tempList list, int i);

typedef S_symbol Temp_label;
Temp_label Temp_newlabel(void);
Temp_label Temp_namedlabel(string name);
string Temp_labelstring(Temp_label s);
int Temp_labelnum(Temp_label s);

typedef struct Temp_labelList_ *Temp_labelList;
struct Temp_labelList_
{
    Temp_label head;
    Temp_labelList tail;
};
Temp_labelList Temp_LabelList(Temp_label h, Temp_labelList t);
Temp_label nthLabel(Temp_labelList list, int i);

typedef struct Temp_map_ *Temp_map;
struct Temp_map_
{
    TAB_table tab;
    Temp_map under;
};
Temp_map Temp_empty(void);
Temp_map Temp_layerMap(Temp_map over, Temp_map under);
void Temp_enter(Temp_map m, Temp_temp t, string s);
string Temp_look(Temp_map m, Temp_temp t);
void Temp_dumpMap(FILE *out, Temp_map m);

Temp_map Temp_name(void);

Temp_temp GetTemp(int num);
int get_maxtemp();

typedef std::unordered_set<Temp_temp> TempSet_;
typedef TempSet_* TempSet;

Temp_tempList TempList_add(Temp_tempList tl, Temp_temp t);
Bool TempList_contains(Temp_tempList tl, Temp_temp t);
bool TempList_contains_color(Temp_tempList tl, Temp_temp t);
Temp_tempList TempList_union(Temp_tempList tl1, Temp_tempList tl2);
Temp_tempList TempList_diff(Temp_tempList tl1, Temp_tempList tl2);
Bool TempList_eq(Temp_tempList tl1, Temp_tempList tl2);
Temp_tempList TempList_remove(Temp_temp temp, Temp_tempList tl);

void TempSet_add(TempSet tl, Temp_temp t);
bool TempSet_contains(TempSet tl, Temp_temp t);
TempSet TempSet_union(TempSet tl1, TempSet tl2);
TempSet TempSet_diff(TempSet tl1, TempSet tl2);
bool TempSet_eq(TempSet tl1, TempSet tl2);
void TempSet_remove(TempSet tl, Temp_temp t);

string gen_temp_key(int num);

void printTempList(Temp_tempList tl);

// for printing purpose
void PrintTemp(FILE *out, Temp_temp t);
// Printing
void PrintTemps(FILE *out, Temp_tempList tl);
void PrintTemps(FILE *out, TempSet tl);

int getTempNumber();
void PrintTemps_color(FILE *out, std::unordered_set<int>* tl);

#endif
