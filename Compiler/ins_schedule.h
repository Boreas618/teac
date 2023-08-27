#pragma once
#include "assem.h"

void buildDDG(AS_instrList il);
void dumpDDG(AS_instrList il);
AS_instrList scheduleIns(AS_instrList il);
void insCombine(AS_instrList il);
void insCombine_color(AS_instrList il);
