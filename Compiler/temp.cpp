/*
 * temp.c - functions to create and manipulate temporary variables which are
 *          used in the IR tree representation before it has been determined
 *          which variables are to go into registers.
 *
 */

#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <list>
#include <unordered_set>
#include <unordered_map>
#include "util.h"
#include "symbol.h"
#include "temp.h"
#include "oldtable.h"
#include <assert.h>

using std::unordered_map;

string Temp_labelstring(Temp_label s)
{return S_name(s);
}

int Temp_labelnum(Temp_label s)
{return atoi(S_name(s)+1);
}

static int labels = 0;

Temp_label Temp_newlabel(void)
{char buf[100];
 sprintf(buf,"L%d",labels++);
 return Temp_namedlabel(String(buf));
}

/* The label will be created only if it is not found. */
Temp_label Temp_namedlabel(string s)
{return S_Symbol(s);
}

static int temps = 200;

// static Temp_map_t my_Temp_map;
static unordered_map<int, Temp_temp> my_Temp_map;

int get_maxtemp(){
  return temps;
}

static void catchTemp(Temp_temp t){
  // if(t->num == 595){
  //   printf("ffuck\n");
  // }
}

Temp_temp Temp_newtemp_unknown(void){
 Temp_temp p = (Temp_temp) checked_malloc(sizeof (*p));
 p->num=temps++;
 p->alias = p->num;
 p->color = -1;
 p->isSpill = FALSE;
 p->offset = 0;
 p->gp_degree = 0;
 p->fp_degree = 0;
 p->isCallee = FALSE;
 p->spilledColor = -1;
 p->type = UNKNOWN;
 char r[80];
 sprintf(r, "u_%d", p->num);
 p->info = String(r);
 Temp_enter(Temp_name(), p, String(r));
 my_Temp_map.emplace(p->num, p);
 catchTemp(p);
 return p;
}

Temp_temp Temp_newtemp(void)
{Temp_temp p = (Temp_temp) checked_malloc(sizeof (*p));
 p->num=temps++;
 p->alias = p->num;
 p->color = -1;
 p->isSpill = FALSE;
 p->offset = 0;
 p->gp_degree = 0;
 p->fp_degree = 0;
 p->isCallee = FALSE;
 p->spilledColor = -1;
 p->type = INT_TEMP;
 char r[80];
 sprintf(r, "i_%d", p->num);
 p->info = String(r);
 Temp_enter(Temp_name(), p, String(r));
 my_Temp_map.emplace(p->num, p);
 catchTemp(p);
 return p;
}

Temp_temp Temp_newtemp_float(void)
{Temp_temp p = (Temp_temp) checked_malloc(sizeof (*p));
 p->num=temps++;
 p->alias = p->num;
 p->color = -1;
 p->isSpill = FALSE;
 p->offset = 0;
 p->gp_degree = 0;
 p->fp_degree = 0;
 p->isCallee = FALSE;
 p->spilledColor = -1;
 p->type = FLOAT_TEMP;
 char r[80];
 sprintf(r, "f_%d", p->num);
 p->info = String(r);
 Temp_enter(Temp_name(), p, String(r));
 my_Temp_map.emplace(p->num, p);
 catchTemp(p);
 return p;
}

Temp_temp Temp_newtemp_int_ptr(void){
 Temp_temp p = (Temp_temp) checked_malloc(sizeof (*p));
 p->num=temps++;
 p->alias = p->num;
 p->color = -1;
 p->isSpill = FALSE;
 p->offset = 0;
 p->gp_degree = 0;
 p->fp_degree = 0;
 p->isCallee = FALSE;
 p->spilledColor = -1;
 p->type = INT_PTR;
 char r[80];
 sprintf(r, "iptr_%d", p->num);
 p->info = String(r);
 Temp_enter(Temp_name(), p, String(r));
 my_Temp_map.emplace(p->num, p);
 catchTemp(p);
 return p;
}

Temp_temp Temp_newtemp_float_ptr(void){
 Temp_temp p = (Temp_temp) checked_malloc(sizeof (*p));
 p->num=temps++;
 p->alias = p->num;
 p->color = -1;
 p->isSpill = FALSE;
 p->offset = 0;
 p->gp_degree = 0;
 p->fp_degree = 0;
 p->isCallee = FALSE;
 p->spilledColor = -1;
 p->type = FLOAT_PTR;
 char r[80];
 sprintf(r, "fptr_%d", p->num);
 p->info = String(r);
 Temp_enter(Temp_name(), p, String(r));
 my_Temp_map.emplace(p->num, p);
 catchTemp(p);
 return p;
}

struct Temp_temp_ r[RESEVED_REG];

struct Temp_temp_ callee_saved[RESEVED_REG];

struct Temp_temp_ r_fp[RESEVED_REG];

struct Temp_temp_ callee_saved_fp[RESEVED_REG];


void Temp_inittemp(void)
{
 char t[100];
 for(int i=0; i<RESEVED_REG; ++i){
  r[i].num = i;
  r[i].alias = i;
  r[i].color = i; 
  r[i].isSpill = FALSE;
  r[i].offset = 0;
  r[i].gp_degree = 0;
  r[i].fp_degree = 0;
  r[i].isCallee = FALSE;
  r[i].spilledColor = -1;
  r[i].type = INT_TEMP;
  sprintf(t, "gp_%d", i);
  r[i].info = String(t);
  Temp_enter(Temp_name(), &r[i], String(t));
  my_Temp_map.emplace(r[i].num, &r[i]);
  // map_set(MyTempMap(), String(t), &r[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  r_fp[i].num = i+RESEVED_REG;
  r_fp[i].alias = i+RESEVED_REG;
  r_fp[i].color = i+RESEVED_REG; 
  r_fp[i].isSpill = FALSE;
  r_fp[i].offset = 0;
  r_fp[i].gp_degree = 0;
  r_fp[i].fp_degree = 0;
  r_fp[i].isCallee = FALSE;
  r_fp[i].spilledColor = -1;
  r_fp[i].type = FLOAT_TEMP;
  sprintf(t, "fp_%d", i+RESEVED_REG);
  r_fp[i].info = String(t);
  Temp_enter(Temp_name(), &r_fp[i], String(t));
  my_Temp_map.emplace(r_fp[i].num, &r_fp[i]);
  // map_set(MyTempMap(), String(t), &r[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  callee_saved[i].num = i+100;
  callee_saved[i].alias = i+100;
  callee_saved[i].color = -1; 
  callee_saved[i].isSpill = FALSE;
  callee_saved[i].offset = 0;
  callee_saved[i].gp_degree = 0;
  callee_saved[i].fp_degree = 0;
  callee_saved[i].isCallee = TRUE;
  callee_saved[i].spilledColor = -1;
  callee_saved[i].type = INT_TEMP;
  sprintf(t, "gp_callee_%d", i+100);
  callee_saved[i].info = String(t);
  Temp_enter(Temp_name(), &callee_saved[i], String(t));
  my_Temp_map.emplace(callee_saved[i].num, &callee_saved[i]);
  // map_set(MyTempMap(), String(t), &callee_saved[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  callee_saved_fp[i].num = i+100+RESEVED_REG;
  callee_saved_fp[i].alias = i+100+RESEVED_REG;
  callee_saved_fp[i].color = -1; 
  callee_saved_fp[i].isSpill = FALSE;
  callee_saved_fp[i].offset = 0;
  callee_saved_fp[i].gp_degree = 0;
  callee_saved_fp[i].fp_degree = 0;
  callee_saved_fp[i].isCallee = TRUE;
  callee_saved_fp[i].spilledColor = -1;
  callee_saved_fp[i].type = FLOAT_TEMP;
  sprintf(t, "fp_callee_%d", i+100+RESEVED_REG);
  callee_saved_fp[i].info = String(t);
  Temp_enter(Temp_name(), &callee_saved_fp[i], String(t));
  my_Temp_map.emplace(callee_saved_fp[i].num, &callee_saved_fp[i]);
  // map_set(MyTempMap(), String(t), &callee_saved[i]);
 }
}

//TODO: add float reg
void Temp_resettemp(void)
{
 char t[100];
 for(int i=0; i<RESEVED_REG; ++i){
  r[i].num = i;
  r[i].alias = i;
  r[i].color = i; 
  r[i].isSpill = FALSE;
  r[i].offset = 0;
  r[i].gp_degree = 0;
  r[i].fp_degree = 0;
  r[i].isCallee = FALSE;
  r[i].spilledColor = -1;
  r[i].type = INT_TEMP;
  sprintf(t, "gp_%d", i);
  r[i].info = String(t);
  Temp_enter(Temp_name(), &r[i], String(t));
  my_Temp_map.emplace(r[i].num, &r[i]);
  // map_set(MyTempMap(), String(t), &r[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  r_fp[i].num = i+RESEVED_REG;
  r_fp[i].alias = i+RESEVED_REG;
  r_fp[i].color = i+RESEVED_REG; 
  r_fp[i].isSpill = FALSE;
  r_fp[i].offset = 0;
  r_fp[i].gp_degree = 0;
  r_fp[i].fp_degree = 0;
  r_fp[i].isCallee = FALSE;
  r_fp[i].spilledColor = -1;
  r_fp[i].type = FLOAT_TEMP;
  sprintf(t, "fp_%d", i+RESEVED_REG);
  r_fp[i].info = String(t);
  Temp_enter(Temp_name(), &r_fp[i], String(t));
  my_Temp_map.emplace(r_fp[i].num, &r_fp[i]);
  // map_set(MyTempMap(), String(t), &r[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  callee_saved[i].num = i+100;
  callee_saved[i].alias = i+100;
  callee_saved[i].color = -1; 
  callee_saved[i].isSpill = FALSE;
  callee_saved[i].offset = 0;
  callee_saved[i].gp_degree = 0;
  callee_saved[i].fp_degree = 0;
  callee_saved[i].isCallee = TRUE;
  callee_saved[i].spilledColor = -1;
  callee_saved[i].type = INT_TEMP;
  sprintf(t, "gp_callee_%d", i+100);
  callee_saved[i].info = String(t);
  Temp_enter(Temp_name(), &callee_saved[i], String(t));
  my_Temp_map.emplace(callee_saved[i].num, &callee_saved[i]);
  // map_set(MyTempMap(), String(t), &callee_saved[i]);
 }

 for(int i=0; i<RESEVED_REG; ++i){
  callee_saved_fp[i].num = i+100+RESEVED_REG;
  callee_saved_fp[i].alias = i+100+RESEVED_REG;
  callee_saved_fp[i].color = -1; 
  callee_saved_fp[i].isSpill = FALSE;
  callee_saved_fp[i].offset = 0;
  callee_saved_fp[i].gp_degree = 0;
  callee_saved_fp[i].fp_degree = 0;
  callee_saved_fp[i].isCallee = TRUE;
  callee_saved_fp[i].spilledColor = -1;
  callee_saved_fp[i].type = FLOAT_TEMP;
  sprintf(t, "fp_callee_%d", i+100+RESEVED_REG);
  callee_saved_fp[i].info = String(t);
  Temp_enter(Temp_name(), &callee_saved_fp[i], String(t));
  my_Temp_map.emplace(callee_saved_fp[i].num, &callee_saved_fp[i]);
  // map_set(MyTempMap(), String(t), &callee_saved[i]);
 }
}

Temp_temp GetTemp(int num){
  // Temp_temp* p_temp = map_get(MyTempMap(), r);
  // if(p_temp) return *p_temp;
  // else return NULL;
  if(my_Temp_map.find(num) != my_Temp_map.end()){
    return my_Temp_map.find(num)->second;
  }else{
    return NULL;
  }
}

Temp_map Temp_name(void) {
 static Temp_map m = NULL;
 if (!m) m=Temp_empty();
 return m;
}

Temp_map newMap(TAB_table tab, Temp_map under) {
  Temp_map m = (Temp_map)checked_malloc(sizeof(*m));
  m->tab=tab;
  m->under=under;
  return m;
}

Temp_map Temp_empty(void) {
  return newMap(TAB_empty(), NULL);
}

Temp_map Temp_layerMap(Temp_map over, Temp_map under) {
  if (over==NULL)
      return under;
  else return newMap(over->tab, Temp_layerMap(over->under, under));
}

void Temp_enter(Temp_map m, Temp_temp t, string s) {
  assert(m && m->tab);
  TAB_enter(m->tab,t,s);
}

string Temp_look(Temp_map m, Temp_temp t) {
  string s;
  assert(m && m->tab);
  s = (string)TAB_look(m->tab, t);
  if (s) return s;
  else if (m->under) return Temp_look(m->under, t);
  else return NULL;
}

Temp_tempList Temp_TempList(Temp_temp h, Temp_tempList t) 
{Temp_tempList p = (Temp_tempList) checked_malloc(sizeof (*p));
 p->head=h; p->tail=t;
 return p;
}

Temp_temp* GetjthTemp(Temp_tempList tl, int j){
    int i=1;
    for(; tl && i<j; tl=tl->tail, ++i);
    if(i==j) return &tl->head;
    else return NULL;
}

Temp_temp nthTemp(Temp_tempList list, int i) {
  assert(list);
  if (i==0) return list->head;
  else return nthTemp(list->tail,i-1);
}

Temp_labelList Temp_LabelList(Temp_label h, Temp_labelList t)
{Temp_labelList p = (Temp_labelList) checked_malloc(sizeof (*p));
 p->head=h; p->tail=t;
 return p;
}

Temp_label nthLabel(Temp_labelList list, int i) {
  assert(list);
  if (i==0) return list->head;
  else return nthLabel(list->tail,i-1);
}

static FILE *outfile;
void showit(Temp_temp t, string r) {
  fprintf(outfile, "t%d -> %s\n", t->num, r);
}

void Temp_dumpMap(FILE *out, Temp_map m) {
  outfile=out;
  TAB_dump(m->tab,(void (*)(void *, void*))showit);
  if (m->under) {
     fprintf(out,"---------\n");
     Temp_dumpMap(out,m->under);
  }
}

//add one to another list (if not already there)
Temp_tempList TempList_add(Temp_tempList tl, Temp_temp t) {
    for (Temp_tempList l1=tl; l1!=NULL; l1=l1->tail) {
        if (l1->head->num == t->num) return tl; //nothing to add
    }
    return(Temp_TempList(t, tl)); //else add to the head
}

Bool TempList_contains(Temp_tempList tl, Temp_temp t) {
    for (Temp_tempList l1=tl; l1!=NULL; l1=l1->tail) {
        if (l1->head->num == t->num) return TRUE; //nothing to add
    }
    return FALSE; //else add to the head
}

bool TempList_contains_color(Temp_tempList tl, Temp_temp t) {
    assert(t->color != -1);
    for (Temp_tempList l1=tl; l1!=NULL; l1=l1->tail) {
        assert(l1->head->color != -1);
        if (l1->head->color == t->color) return true; //nothing to add
    }
    return false; //else add to the head
}

//do a simple union (add each one at a time)
Temp_tempList TempList_union(Temp_tempList tl1, Temp_tempList tl2) {
    std::unordered_set<int> set1, set2;
    for (Temp_tempList tl = tl1; tl; tl = tl->tail) {
        set1.insert(tl->head->num);
    }
    for (Temp_tempList tl = tl2; tl; tl = tl->tail) {
        if (set1.find(tl->head->num) == set1.end())
            set2.insert(tl->head->num);
    }
    for (auto& it : set2) {
        tl1 = Temp_TempList(GetTemp(it), tl1);
    }
    return tl1;
    // for (; tl2!=NULL; tl2=tl2->tail)
    //     tl1=TempList_add(tl1, tl2->head);
    // return(tl1);
}

//Implement a list difference tl1-tl2 (for each on in tl1, scan tl2)
Temp_tempList TempList_diff(Temp_tempList tl1, Temp_tempList tl2)  {
    std::unordered_set<int> set1, set2;
    for (Temp_tempList tl = tl1; tl; tl = tl->tail) {
      set1.insert(tl->head->num);
    }
    for (Temp_tempList tl = tl2; tl; tl = tl->tail) {
      set2.insert(tl->head->num);
    }
    tl1 = NULL;
    for (auto& it : set1) {
      if (set2.find(it) == set2.end())
          tl1 = Temp_TempList(GetTemp(it), tl1);
    }
    return tl1;
    // Bool found;
    
    // Temp_tempList scan = tl1;
    // Temp_tempList result=NULL;
    // while (scan!=NULL ) {
    //     found=FALSE;
    //     for (Temp_tempList l2=tl2; l2!=NULL; l2=l2->tail)
    //         if (scan->head==l2->head) found=TRUE;
    //     if (!found) { //if not found in tl2, then add to the result list
    //         result = Temp_TempList(scan->head, result);
    //     }
    //     scan=scan->tail;
    // }
    // return(result);
}

//a simple eq test using diff twice
Bool TempList_eq(Temp_tempList tl1, Temp_tempList tl2) {
     std::unordered_set<int> set;
    for (Temp_tempList tl = tl1; tl; tl = tl->tail) {
      set.insert(tl->head->num);
    }
    for (Temp_tempList tl = tl2; tl; tl = tl->tail) {
      if(set.find(tl->head->num)==set.end()){
        return FALSE;
      }
    }
    return TRUE;
    // if (TempList_diff(tl1, tl2) != NULL)
    //     return FALSE;
    // else {
    //     if (TempList_diff(tl2, tl1) != NULL)
    //         return FALSE;
    //     else
    //         return TRUE;
    // }
}

Temp_tempList TempList_remove(Temp_temp temp, Temp_tempList tl){
  if(tl){
    if(tl->head->num == temp->num) return tl->tail;
    Temp_tempList btl = tl;
    for (; btl && btl->tail; btl=btl->tail){
      if(btl->tail->head->num == temp->num){
        btl->tail = btl->tail->tail;
        return tl;
      }
    }
  }
  // remove err
  assert(0);
  return NULL;
}

void TempSet_add(TempSet tl, Temp_temp t){
  assert(tl != nullptr);
  (*tl).emplace(t);
}

bool TempSet_contains(TempSet tl, Temp_temp t){
  return (*tl).find(t) != (*tl).end();
}

TempSet TempSet_union(TempSet tl1, TempSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  TempSet unionSet = new TempSet_;
  for(auto &it : *tl1){
    (*unionSet).emplace(it);
  }
  for(auto &it : *tl2){
    (*unionSet).emplace(it);
  }
  return unionSet;
}

TempSet TempSet_diff(TempSet tl1, TempSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  TempSet diffSet = new TempSet_;
  for(auto &it : *tl1){
    (*diffSet).emplace(it);
  }
  for(auto &it : *tl2){
    (*diffSet).erase(it);
  }
  return diffSet;
}

bool TempSet_eq(TempSet tl1, TempSet tl2){
  assert(tl1 != nullptr);
  assert(tl2 != nullptr);

  if((*tl1).size() != (*tl2).size()) return false;
  for(auto &it : *tl1){
    if(!TempSet_contains(tl2, it)) return false;
  }
  return true;
}

void TempSet_remove(TempSet tl, Temp_temp t){
  assert(tl != nullptr);
  (*tl).erase(t);
}

char temp_key[80];

string gen_temp_key(int num){
  sprintf(temp_key, "%d", num);
  return String(temp_key);
}


void printTempList(Temp_tempList tl){
    printf("TempList: ");
    for(; tl; tl=tl->tail){
        printf("%d ", tl->head->num);
    }   
    printf("\n");
}

//for printing purpose
void PrintTemp(FILE *out, Temp_temp t) {
    fprintf(out, " %s ", Temp_look(Temp_name(), t));
}

//Printing
void PrintTemps(FILE *out, Temp_tempList tl) {
    if (tl==NULL) return;
    Temp_temp h=tl->head;
    fprintf(out, "%s, ", Temp_look(Temp_name(), h));
    PrintTemps(out, tl->tail);
}

//Printing
void PrintTemps(FILE *out, TempSet tl) {
    for(auto &it : *tl){
      fprintf(out, "%d, ", it->num);
    }
}

int getTempNumber()
{
  return temps;
}
//Printing
void PrintTemps_color(FILE *out, std::unordered_set<int>* tl) {
    for(auto &it : *tl){
      fprintf(out, "%d, ", it);
    }
}