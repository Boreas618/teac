#include "translate.hpp"
#include <cstdio>
#include <cstring>
#include <iostream>
#include <sstream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include "ast.h"

void pureCompUnitList(A_compUnitList list);
void pureBlock(A_block block, Temp_label_front name);