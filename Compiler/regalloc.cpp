#include "assem.h"
#include "flowgraph.h"
#include "graph.hpp"
#include "regalloc.h"
#include "temp.h"
#include "util.h"
#include <algorithm>
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "ig.h"
#include "treep.hpp"
#include "liveness.h"
#include "ssa.h"
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <map>
#include <stack>
#include <utility>
#include <queue>
#include <vector>
#include <climits>

using std::unordered_map;
using std::stack;
using std::pair;
using std::map;
using std::make_pair;
using std::vector;
using std::priority_queue;

static int K_gp = 0;
static int K_fp_main = 0;
static int K_fp_other = 0;
static int Fp_for_spill = 0;

map<int, Temp_temp> colors_gp;
map<int, Temp_temp> colors_fp_main;
map<int, Temp_temp> colors_fp_other;

extern struct Temp_temp_ r[RESEVED_REG];
extern struct Temp_temp_ r_fp[RESEVED_REG];

// map_int_t is used as set

static int iterations;
static int spilledCounter = 0;
extern int localOffset;

extern bool usefloat;

unordered_map<int, AS_instrList> moveList;
unordered_map<int, TempSet> adjList;

// temp num to ud times
// unordered_map<int, int> udTimes;
// temp num to loop Depth of every ud instr
unordered_map<int, vector<int>&> udLoopDepth;


map<pair<int, int>, int> edgeSet;


// node set (disjoint)
unordered_map<int, int> initial;
unordered_map<int, int> simplifyWorklist;
unordered_map<int, int> freezeWorklist;
unordered_map<int, int> spillWorklist;
unordered_map<int, int> spilledNodes;
unordered_map<int, int> coalescedNodes;
unordered_map<int, int> coloredNodes;
unordered_map<int, int> selectWorklist;
stack<Temp_temp> selectStack;

// move set (disjoint)
// FIXME: pointer as key, may conflict?
unordered_map<AS_instr, AS_instr> coalescedMoves;
unordered_map<AS_instr, AS_instr> constrainedMoves;

unordered_map<AS_instr, AS_instr> frozenMoves;
unordered_map<AS_instr, AS_instr> worklistMoves;
unordered_map<AS_instr, AS_instr> activeMoves;

map<pair<int, int>, int> simplifiedEdge;

// pair->first is spill cost (div degree)
// pair->seccond is temp num 
// top is the most cheap temp
priority_queue <pair<double, int>, vector<pair<double, int>>, std::greater<pair<double, int>>> spillCostQue;

// pair->first is spill cost (do not care degree)
// pair->seccond is temp num 
// top is the most expensive temp
priority_queue <pair<int, int>, vector<pair<int, int>>, std::less<pair<int, int>>> spilledNodes_Que;

static inline int get_K_fp(my_string func_name){
    if(!strcmp("main", func_name)){
        return K_fp_main;
    }else{
        return K_fp_other;
    }
}

int getFuncLength(AS_instrList ail){
    int len = 0;
    for(AS_instrList til=ail; til; til=til->tail){
        if(til->head->kind == AS_instr_::I_OPER 
        && til->head->u.OPER.src && til->head->u.OPER.dst){
            ++len;
        }
    }
    return len;
}

void init_colors(my_string func_name, int len){
    // reset fp reg for gp spill 
    if(!strcmp("main", func_name)){
        // Fp_for_spill = 16;

        if(usefloat){
            Fp_for_spill = 16;
        }else{
            Fp_for_spill = 32;
        }
    }else{
        // Fp_for_spill = 6;

        if(len > 45){
            Fp_for_spill = 16;
        }else{
            Fp_for_spill = 0;
        }
    }

    colors_gp.clear();
    colors_gp.emplace(0, &r[0]);
    colors_gp.emplace(1, &r[1]);
    colors_gp.emplace(2, &r[2]);
    colors_gp.emplace(3, &r[3]);
    colors_gp.emplace(14, &r[14]);
    colors_gp.emplace(12, &r[12]);
    colors_gp.emplace(4, &r[4]);
    colors_gp.emplace(5, &r[5]);
    colors_gp.emplace(6, &r[6]);
    colors_gp.emplace(7, &r[7]);
    colors_gp.emplace(8, &r[8]);
    colors_gp.emplace(9, &r[9]);
    colors_gp.emplace(10, &r[10]);
    K_gp = 13;

    colors_fp_main.clear();
    if(usefloat){
        colors_fp_main.emplace(40, &r_fp[0]);
        colors_fp_main.emplace(41, &r_fp[1]);
        colors_fp_main.emplace(42, &r_fp[2]);
        colors_fp_main.emplace(43, &r_fp[3]);
        colors_fp_main.emplace(44, &r_fp[4]);
        colors_fp_main.emplace(45, &r_fp[5]);
        colors_fp_main.emplace(46, &r_fp[6]);
        colors_fp_main.emplace(47, &r_fp[7]);
        colors_fp_main.emplace(48, &r_fp[8]);
        colors_fp_main.emplace(49, &r_fp[9]);
        colors_fp_main.emplace(50, &r_fp[10]);
        colors_fp_main.emplace(51, &r_fp[11]);
        colors_fp_main.emplace(52, &r_fp[12]);
        colors_fp_main.emplace(53, &r_fp[13]);
        colors_fp_main.emplace(54, &r_fp[14]);
        colors_fp_main.emplace(55, &r_fp[15]);
        // 16 fp regisiter
        K_fp_main = 16;
    }else{
        // no fp regisiter
        K_fp_main = 0;
    }

    // colors_fp_main.emplace(40, &r_fp[0]);
    // colors_fp_main.emplace(41, &r_fp[1]);
    // colors_fp_main.emplace(42, &r_fp[2]);
    // colors_fp_main.emplace(43, &r_fp[3]);
    // colors_fp_main.emplace(44, &r_fp[4]);
    // colors_fp_main.emplace(45, &r_fp[5]);
    // colors_fp_main.emplace(46, &r_fp[6]);
    // colors_fp_main.emplace(47, &r_fp[7]);
    // colors_fp_main.emplace(48, &r_fp[8]);
    // colors_fp_main.emplace(49, &r_fp[9]);
    // colors_fp_main.emplace(50, &r_fp[10]);
    // colors_fp_main.emplace(51, &r_fp[11]);
    // colors_fp_main.emplace(52, &r_fp[12]);
    // colors_fp_main.emplace(53, &r_fp[13]);
    // colors_fp_main.emplace(54, &r_fp[14]);
    // colors_fp_main.emplace(55, &r_fp[15]);
    // // colors_fp_main.emplace(56, &r_fp[16]);
    // // colors_fp_main.emplace(57, &r_fp[17]);
    // // colors_fp_main.emplace(58, &r_fp[18]);
    // // colors_fp_main.emplace(59, &r_fp[19]);
    // // colors_fp_main.emplace(60, &r_fp[20]);
    // // colors_fp_main.emplace(61, &r_fp[21]);
    // // colors_fp_main.emplace(62, &r_fp[22]);
    // // colors_fp_main.emplace(63, &r_fp[23]);
    // // colors_fp_main.emplace(64, &r_fp[24]);
    // // colors_fp_main.emplace(65, &r_fp[25]);
    // // colors_fp_main.emplace(66, &r_fp[26]);
    // // colors_fp_main.emplace(67, &r_fp[27]);
    // // colors_fp_main.emplace(68, &r_fp[28]);
    // // colors_fp_main.emplace(69, &r_fp[29]);
    // // colors_fp_main.emplace(70, &r_fp[30]);
    // // colors_fp_main.emplace(71, &r_fp[31]);
    // K_fp_main = 16;


    colors_fp_other.clear();
    if(len > 45){
        colors_fp_other.emplace(40, &r_fp[0]);
        colors_fp_other.emplace(41, &r_fp[1]);
        colors_fp_other.emplace(42, &r_fp[2]);
        colors_fp_other.emplace(43, &r_fp[3]);
        colors_fp_other.emplace(44, &r_fp[4]);
        colors_fp_other.emplace(45, &r_fp[5]);
        colors_fp_other.emplace(46, &r_fp[6]);
        colors_fp_other.emplace(47, &r_fp[7]);
        colors_fp_other.emplace(48, &r_fp[8]);
        colors_fp_other.emplace(49, &r_fp[9]);
        colors_fp_other.emplace(50, &r_fp[10]);
        colors_fp_other.emplace(51, &r_fp[11]);
        colors_fp_other.emplace(52, &r_fp[12]);
        colors_fp_other.emplace(53, &r_fp[13]);
        colors_fp_other.emplace(54, &r_fp[14]);
        colors_fp_other.emplace(55, &r_fp[15]);
        // 16 fp regisiter
        K_fp_other = 16;
    }else{
        colors_fp_other.emplace(40, &r_fp[0]);
        colors_fp_other.emplace(41, &r_fp[1]);
        colors_fp_other.emplace(42, &r_fp[2]);
        colors_fp_other.emplace(43, &r_fp[3]);
        colors_fp_other.emplace(44, &r_fp[4]);
        colors_fp_other.emplace(45, &r_fp[5]);
        colors_fp_other.emplace(46, &r_fp[6]);
        colors_fp_other.emplace(47, &r_fp[7]);
        colors_fp_other.emplace(48, &r_fp[8]);
        colors_fp_other.emplace(49, &r_fp[9]);
        colors_fp_other.emplace(50, &r_fp[10]);
        colors_fp_other.emplace(51, &r_fp[11]);
        colors_fp_other.emplace(52, &r_fp[12]);
        colors_fp_other.emplace(53, &r_fp[13]);
        colors_fp_other.emplace(54, &r_fp[14]);
        colors_fp_other.emplace(55, &r_fp[15]);
        colors_fp_other.emplace(56, &r_fp[16]);
        colors_fp_other.emplace(57, &r_fp[17]);
        colors_fp_other.emplace(58, &r_fp[18]);
        colors_fp_other.emplace(59, &r_fp[19]);
        colors_fp_other.emplace(60, &r_fp[20]);
        colors_fp_other.emplace(61, &r_fp[21]);
        colors_fp_other.emplace(62, &r_fp[22]);
        colors_fp_other.emplace(63, &r_fp[23]);
        colors_fp_other.emplace(64, &r_fp[24]);
        colors_fp_other.emplace(65, &r_fp[25]);
        colors_fp_other.emplace(66, &r_fp[26]);
        colors_fp_other.emplace(67, &r_fp[27]);
        colors_fp_other.emplace(68, &r_fp[28]);
        colors_fp_other.emplace(69, &r_fp[29]);
        colors_fp_other.emplace(70, &r_fp[30]);
        colors_fp_other.emplace(71, &r_fp[31]);
        // 32 fp regisiter
        K_fp_other = 32;
    }

    // colors_fp_other.emplace(40, &r_fp[0]);
    // colors_fp_other.emplace(41, &r_fp[1]);
    // colors_fp_other.emplace(42, &r_fp[2]);
    // colors_fp_other.emplace(43, &r_fp[3]);
    // colors_fp_other.emplace(44, &r_fp[4]);
    // colors_fp_other.emplace(45, &r_fp[5]);
    // colors_fp_other.emplace(46, &r_fp[6]);
    // colors_fp_other.emplace(47, &r_fp[7]);
    // colors_fp_other.emplace(48, &r_fp[8]);
    // colors_fp_other.emplace(49, &r_fp[9]);
    // colors_fp_other.emplace(50, &r_fp[10]);
    // colors_fp_other.emplace(51, &r_fp[11]);
    // colors_fp_other.emplace(52, &r_fp[12]);
    // colors_fp_other.emplace(53, &r_fp[13]);
    // colors_fp_other.emplace(54, &r_fp[14]);
    // colors_fp_other.emplace(55, &r_fp[15]);
    // colors_fp_other.emplace(56, &r_fp[16]);
    // colors_fp_other.emplace(57, &r_fp[17]);
    // colors_fp_other.emplace(58, &r_fp[18]);
    // colors_fp_other.emplace(59, &r_fp[19]);
    // colors_fp_other.emplace(60, &r_fp[20]);
    // colors_fp_other.emplace(61, &r_fp[21]);
    // colors_fp_other.emplace(62, &r_fp[22]);
    // colors_fp_other.emplace(63, &r_fp[23]);
    // colors_fp_other.emplace(64, &r_fp[24]);
    // colors_fp_other.emplace(65, &r_fp[25]);
    // // colors_fp_other.emplace(66, &r_fp[26]);
    // // colors_fp_other.emplace(67, &r_fp[27]);
    // // colors_fp_other.emplace(68, &r_fp[28]);
    // // colors_fp_other.emplace(69, &r_fp[29]);
    // // colors_fp_other.emplace(70, &r_fp[30]);
    // // colors_fp_other.emplace(71, &r_fp[31]);
    // K_fp_other = 26;
}


// do this before ig
// cause ig is used here
void init_regalloc(my_string func_name){
    moveList.clear();
    adjList.clear();
    edgeSet.clear();
    simplifiedEdge.clear();

    // node set (disjoint)
    initial.clear();
    simplifyWorklist.clear();
    freezeWorklist.clear();
    spillWorklist.clear();
    while(!spillCostQue.empty()) spillCostQue.pop();
    spilledNodes.clear();
    while(!spilledNodes_Que.empty()) spilledNodes_Que.pop();
    coalescedNodes.clear();
    coloredNodes.clear();
    selectWorklist.clear();
    while(!selectStack.empty()) selectStack.pop();

    // move set (disjoint)
    coalescedMoves.clear();
    constrainedMoves.clear();
    frozenMoves.clear();
    worklistMoves.clear();
    activeMoves.clear();

    // udTimes.clear();
    udLoopDepth.clear();
}

Bool IsPrecolor(int num){
    return num < 100;
}

void Get_initial(G_nodeList flg){
    TempSet use;
    TempSet def;
    TempSet tempSet;
    while(flg != NULL){
        use=FG_use(flg->head);
        def=FG_def(flg->head);
        for(auto &it : *use){
            if(!IsPrecolor(it->num)){
                initial.emplace(it->num, it->num);
            } 
        }
        for(auto &it : *def){
            if(!IsPrecolor(it->num)){
                initial.emplace(it->num, it->num);
            } 
        }
        
        flg = flg->tail;
    }
}

Bool IsMoveRelated(int num) {
    G_node node = NULL;
    AS_instrList moveList_n = moveList.find(num)->second;

    for(; moveList_n; moveList_n=moveList_n->tail){
        if((activeMoves.find(moveList_n->head) != activeMoves.end())
        || (worklistMoves.find(moveList_n->head) != worklistMoves.end()))
            return TRUE;
    }

    return FALSE;
}

void makeUdTimes_loopDepth(AS_instrList ail){
    for(AS_instrList t_ail=ail; t_ail; t_ail=t_ail->tail){
        AS_instr thisIns = t_ail->head;

        // udTimes and loopDepth are insert and update concurrently
        Temp_tempList instr_use = getTempList(GetSrc(thisIns));
        for(Temp_tempList tl=instr_use; tl; tl=tl->tail){
            int thisTempnum = tl->head->num;
            if(udLoopDepth.find(thisTempnum) == udLoopDepth.end()){
                vector<int> &vec = *(new vector<int>);
                vec.emplace_back(thisIns->nest_depth);
                udLoopDepth.emplace(thisTempnum, vec);
                // udTimes.emplace(thisTempnum, 1);
                // loopDepth.emplace(thisTempnum, thisIns->nest_depth);
            }else{
                udLoopDepth.find(thisTempnum)->second.emplace_back(thisIns->nest_depth);
                // int newUdTimes = ++udTimes.find(thisTempnum)->second;
                // int newLoopDepth = std::max(loopDepth.find(thisTempnum)->second, thisIns->nest_depth);
                // udTimes.erase(thisTempnum);
                // loopDepth.erase(thisTempnum);
                // udTimes.emplace(thisTempnum, newUdTimes);
                // loopDepth.emplace(thisTempnum, newLoopDepth);
            }
        }

        Temp_tempList instr_def = getTempList(GetDst(thisIns));
        for(Temp_tempList tl=instr_def; tl; tl=tl->tail){
            int thisTempnum = tl->head->num;
            if(udLoopDepth.find(thisTempnum) == udLoopDepth.end()){
                vector<int> &vec = *(new vector<int>);
                vec.emplace_back(thisIns->nest_depth);
                udLoopDepth.emplace(thisTempnum, vec);
                // udTimes.emplace(thisTempnum, 1);
                // loopDepth.emplace(thisTempnum, thisIns->nest_depth);
            }else{
                udLoopDepth.find(thisTempnum)->second.emplace_back(thisIns->nest_depth);
                // int newUdTimes = ++udTimes.find(thisTempnum)->second;
                // int newLoopDepth = std::max(loopDepth.find(thisTempnum)->second, thisIns->nest_depth);
                // udTimes.erase(thisTempnum);
                // loopDepth.erase(thisTempnum);
                // udTimes.emplace(thisTempnum, newUdTimes);
                // loopDepth.emplace(thisTempnum, newLoopDepth);
            }
        }
    }
}

static inline int loopPow(int depth){
    if(depth > 7){
        return INT_MAX;
    }else{
        return 1 << (depth*4);
    }
}

static int calLoopDepthCost(int TempNum){
    assert(udLoopDepth.find(TempNum) != udLoopDepth.end());
    vector<int>& vec = udLoopDepth.find(TempNum)->second;
    int cost = 0;
    for(auto &it : vec){
        long long temp = (long long)cost+(long long)loopPow(it);
        if(temp >= INT_MAX){
            return INT_MAX;
        }else{
            cost += loopPow(it);
        }
    }
    return cost;
}

static double calSpillCost(int TempNum){
    // assert(udTimes.find(TempNum) != udTimes.end());
    // assert(udLoopDepth.find(TempNum) != udLoopDepth.end());
    
    int degree = 0;
    Temp_temp temp = GetTemp(TempNum);
    if(temp->type == FLOAT_TEMP){
        degree = temp->fp_degree;
    }else{
        degree = temp->gp_degree;
    }
    // avoid div 0
    degree = (degree / (iterations + 1)) + 1;

    if(ALLOCATION_INFO){
        printf("temp %d degree %d\n", TempNum, degree);
        printf("Temp %d LoopDepthCost %d\n", TempNum, calLoopDepthCost(TempNum));
        printf("temp %d spillCost %f\n", TempNum, (double) calLoopDepthCost(TempNum) /  degree);
    }
    

    return (double)calLoopDepthCost(TempNum) / degree;
}

void MakeWorklist(my_string func_name){
    int n_num = 0;
    G_node node = NULL;

    for(auto &it : initial){
        n_num = it.second;
        Temp_temp n_temp = GetTemp(n_num);
        int gp_degree_n = n_temp->gp_degree;
        int fp_degree_n = n_temp->fp_degree;
        if(n_temp->type == FLOAT_TEMP){
            if(fp_degree_n >= get_K_fp(func_name)){
                spillWorklist.emplace(n_num, n_num);
                spillCostQue.emplace(calSpillCost(n_num), n_num);
            } else if(IsMoveRelated(n_num)){
                freezeWorklist.emplace(n_num, n_num);
            } else {
                simplifyWorklist.emplace(n_num, n_num);
            }
        }else{
            if(gp_degree_n >= K_gp){
                spillWorklist.emplace(n_num, n_num);
                spillCostQue.emplace(calSpillCost(n_num), n_num);
            } else if(IsMoveRelated(n_num)){
                freezeWorklist.emplace(n_num, n_num);
            } else {
                simplifyWorklist.emplace(n_num, n_num);
            }
        }
    }
}

void EnableMoves(int num) {
    if(moveList.find(num) != moveList.end()){
        AS_instrList moveList_n = moveList.find(num)->second;
        for(; moveList_n; moveList_n=moveList_n->tail){
            if(activeMoves.find(moveList_n->head) != activeMoves.end()){
                activeMoves.erase(moveList_n->head);
                worklistMoves.emplace(moveList_n->head, moveList_n->head);
            }
        }
    }
}

void DecreaseDegree_gp(int num) {
    Temp_temp temp = GetTemp(num);
    int d = temp->gp_degree--;
    if(d == K_gp){
        EnableMoves(num);
        auto it = adjList.find(num);
        if(it != adjList.end()){
            TempSet adjSet = it->second;
            for(auto &it : *adjSet){
                EnableMoves(it->num);
            }
        }
        if(spillWorklist.find(num) != spillWorklist.end()){
            if (IsMoveRelated(num)){
                spillWorklist.erase(num);
                freezeWorklist.emplace(num, num);
            } else {
                spillWorklist.erase(num);
                simplifyWorklist.emplace(num, num);
            }
        }
    }
    
}

void DecreaseDegree_fp(int num, my_string func_name){
    Temp_temp temp = GetTemp(num);
    int d = temp->fp_degree--;
    if(d == get_K_fp(func_name)){
        EnableMoves(num);
        auto it = adjList.find(num);
        if(it != adjList.end()){
            TempSet adjSet = it->second;
            for(auto &it : *adjSet){
                EnableMoves(it->num);
            }
        }
        if(spillWorklist.find(num) != spillWorklist.end()){
            if (IsMoveRelated(num)) {
                spillWorklist.erase(num);
                freezeWorklist.emplace(num, num);
            } else {
                spillWorklist.erase(num);
                simplifyWorklist.emplace(num, num);
            }
        }
    }
}

void DeleteEdge(int u_num, int v_num, my_string func_name) {
    pair<int, int> edge_key = make_pair(u_num, v_num);
    pair<int, int> edge_key2 = make_pair(v_num, u_num);
    if(edgeSet.find(edge_key) == edgeSet.end() 
    || edgeSet.find(edge_key2) == edgeSet.end()){
        // deleteEdge err
        assert(0);
    }

    edgeSet.erase(edge_key);
    edgeSet.erase(edge_key2);

    Temp_temp v_temp = GetTemp(v_num);
    Temp_temp u_temp = GetTemp(u_num);
    
    if(adjList.find(u_num) != adjList.end()){
        TempSet_remove(adjList.find(u_num)->second, v_temp);
    }
    
    if(adjList.find(v_num) != adjList.end()){
        TempSet_remove(adjList.find(v_num)->second, u_temp);
    }

    if(u_temp->type == FLOAT_TEMP && v_temp->type == FLOAT_TEMP){
        DecreaseDegree_fp(u_num, func_name);
        DecreaseDegree_fp(v_num, func_name);
    }else if(u_temp->type != FLOAT_TEMP && v_temp->type != FLOAT_TEMP){
        DecreaseDegree_gp(u_num);
        DecreaseDegree_gp(v_num);
    }
}

// remove while iteration may have bug
void Simplify(my_string func_name) {
    int n_key = simplifyWorklist.begin()->first;
    int n_num = simplifyWorklist.begin()->second;
    simplifyWorklist.erase(simplifyWorklist.begin());

    selectWorklist.emplace(n_key, n_num);
    selectStack.push(GetTemp(n_num));

    if(adjList.find(n_key) != adjList.end()){
        TempSet tSet=adjList.find(n_key)->second;
        // FIXME: erase in for
        vector<int> deleteTempNum;
        for(auto &it : *tSet){
            simplifiedEdge.emplace(make_pair(n_num, it->num), 1);
            simplifiedEdge.emplace(make_pair(it->num, n_num), 1);
            deleteTempNum.emplace_back(it->num);
        }
        for(auto &it : deleteTempNum){
            DeleteEdge(it, n_num, func_name);
        }
    }
}

void addWorkList(int num, my_string func_name) {
    Temp_temp temp = GetTemp(num);
    int d_gp = temp->gp_degree;
    int d_fp = temp->fp_degree;
    if(!IsPrecolor(num) && !IsMoveRelated(num) 
    && ((temp->type != FLOAT_TEMP && d_gp < K_gp) || (temp->type == FLOAT_TEMP && d_fp < get_K_fp(func_name)))){
        freezeWorklist.erase(num);
        simplifyWorklist.emplace(num, num);
    }
}

bool OK(int u_num, int v_num, my_string func_name) {
    return false; // do not coalesce temp with precolored reg
    Temp_temp u_temp = GetTemp(u_num);
    Temp_temp v_temp = GetTemp(v_num);
    if((u_temp->type == FLOAT_TEMP && v_temp->type != FLOAT_TEMP)
    || (u_temp->type != FLOAT_TEMP && v_temp->type == FLOAT_TEMP)){
        return FALSE;
    }

    // else u and v are all gp or all fp 
    Temp_temp t_temp = NULL;
    TempSet adjSet = adjList.find(v_num)->second;
    for(auto &it : *adjSet){
        // t is adjl->head
        t_temp = GetTemp(it->num);
        int t_d_gp = t_temp->gp_degree;
        int t_d_fp = t_temp->fp_degree;
        
        if(!((t_temp->type != FLOAT_TEMP && t_d_gp < K_gp) || (t_temp->type == FLOAT_TEMP && t_d_fp < get_K_fp(func_name))
        || IsPrecolor(it->num) 
        || (edgeSet.find(make_pair(it->num, u_num)) != edgeSet.end())))
            return false;
    }
    printf("OK %d and %d\n", u_num, v_num);
    return true;
}

Bool Conservative(int u_num, int v_num, my_string func_name) {
    Temp_temp u_temp = GetTemp(u_num);
    Temp_temp v_temp = GetTemp(v_num);
    if((u_temp->type == FLOAT_TEMP && v_temp->type != FLOAT_TEMP)
    || (u_temp->type != FLOAT_TEMP && v_temp->type == FLOAT_TEMP)){
        return FALSE;
    }

    // else u and v are all gp or all fp 
    int k_gp = 0;
    int k_fp = 0;
    Temp_temp temp = NULL;
    TempSet u_adj = adjList.find(u_num)->second;
    TempSet v_adj = adjList.find(v_num)->second;
    if(u_temp->type == FLOAT_TEMP && v_temp->type == FLOAT_TEMP){
        for(auto &it : *u_adj){
            temp = GetTemp(it->num);
            if(temp->type == FLOAT_TEMP){
                if(temp->fp_degree >= get_K_fp(func_name)) ++k_fp;
            }            
        }
        for(auto &it : *v_adj){
            temp = GetTemp(it->num);
            if(temp->type == FLOAT_TEMP){
                if(temp->fp_degree >= get_K_fp(func_name)) ++k_fp;
            }            
        }
        return k_fp < get_K_fp(func_name);
    }else if(u_temp->type != FLOAT_TEMP && v_temp->type != FLOAT_TEMP){
        for(auto &it : *u_adj){
            temp = GetTemp(it->num);
            if(temp->type != FLOAT_TEMP){
                if(temp->gp_degree >= K_gp) ++k_gp;
            }            
        }
        for(auto &it : *v_adj){
            temp = GetTemp(it->num);
            if(temp->type != FLOAT_TEMP){
                if(temp->gp_degree >= K_gp) ++k_gp;
            }            
        }
        return k_gp < K_gp;
    }else{
        assert(0);
        return FALSE;
    }
}

int GetAlias(int num) {
    if(coalescedNodes.find(num) != coalescedNodes.end()){
        int my_alias = GetTemp(num)->alias;
        int pred_alias = GetAlias(my_alias);
        GetTemp(num)->alias = pred_alias;
        return pred_alias;
    } else {
        return num;
    }
}

void Combine(int u_num, int v_num, my_string func_name) {
    assert(!IsPrecolor(u_num));
    assert(!IsPrecolor(v_num));

    if(freezeWorklist.find(v_num) != freezeWorklist.end()){
        freezeWorklist.erase(v_num);
        coalescedNodes.emplace(v_num, v_num);
    } else {
        spillWorklist.erase(v_num);
        coalescedNodes.emplace(v_num, v_num);
    }
    GetTemp(v_num)->alias = u_num;

    AS_instrList u_moveList = moveList.find(u_num)->second;
    AS_instrList v_moveList = moveList.find(v_num)->second;
    AS_instrList uv_moveList = AS_instrList_union(u_moveList, v_moveList);
    moveList.erase(u_num);
    moveList.emplace(u_num, uv_moveList);

    EnableMoves(v_num);

    TempSet v_adj = adjList.find(v_num)->second;
    Temp_temp u_temp = GetTemp(u_num);
    Temp_temp t_temp = NULL;
    int t_gp_d = 0;
    int t_fp_d = 0;
    int t_num = -1;
    //FIXME: erase in for (DeleteEdge)
    vector<Temp_temp> deleteTemp;
    for(auto &it : *v_adj){
        deleteTemp.emplace_back(it);
        AddEdge(u_temp, it);
    }
    for(auto &it : deleteTemp){
        t_num = it->num;
        t_temp = it;
        t_gp_d = t_temp->gp_degree;
        t_fp_d = t_temp->fp_degree;
        DeleteEdge(t_num, v_num, func_name);

        if(((t_temp->type == FLOAT_TEMP && t_fp_d >= get_K_fp(func_name)) || (t_temp->type != FLOAT_TEMP && t_gp_d >= K_gp)) 
        && (freezeWorklist.find(t_num) != freezeWorklist.end())){
            freezeWorklist.erase(t_num);
            spillWorklist.emplace(t_num, t_num);
            spillCostQue.emplace(calSpillCost(t_num), t_num);
        }
    }
    

    int u_gp_d = u_temp->gp_degree;
    int u_fp_d = u_temp->fp_degree;
    if(((u_temp->type == FLOAT_TEMP && u_fp_d >= get_K_fp(func_name)) || (u_temp->type != FLOAT_TEMP && u_gp_d >= K_gp))
    && (freezeWorklist.find(u_num) != freezeWorklist.end())) {
        freezeWorklist.erase(u_num);
        spillWorklist.emplace(u_num, u_num);
        spillCostQue.emplace(calSpillCost(u_num), u_num);
    }
    
}

void Coalesce(my_string func_name) {
    AS_instr move_key = worklistMoves.begin()->first;
    AS_instr move_instr = worklistMoves.begin()->second;
    Temp_temp x = GetTemp(GetAlias(move_instr->u.MOVE.src->head->u.TEMP->num));
    Temp_temp y = GetTemp(GetAlias(move_instr->u.MOVE.dst->head->u.TEMP->num));

    Temp_temp u, v;
    if (IsPrecolor(y->num)) {
        u = y; v = x;
    } else {
        u = x; v = y;
    }

    worklistMoves.erase(move_key);

    if (u == v) {
        coalescedMoves.emplace(move_instr, move_instr);
        addWorkList(u->num, func_name);
    } else if (IsPrecolor(v->num) 
    || (edgeSet.find(make_pair(u->num, v->num)) != edgeSet.end())) {
        constrainedMoves.emplace(move_instr, move_instr);
        addWorkList(u->num, func_name);
        addWorkList(v->num, func_name);
    } else if (IsPrecolor(u->num) && OK(u->num, v->num, func_name) ||
            !IsPrecolor(u->num) && Conservative(u->num, v->num, func_name)) {
        coalescedMoves.emplace(move_instr, move_instr);
        Combine(u->num, v->num, func_name);
        addWorkList(u->num, func_name);
    } else {
        activeMoves.emplace(move_instr, move_instr);
        // activeMoves.erase(move_instr);
    }
}

void FreezeMoves(int u_num, my_string func_name){
    AS_instrList u_moveList = moveList.find(u_num)->second;
    int v_num = 0;
    Temp_temp v_temp = NULL;
    for(; u_moveList; u_moveList=u_moveList->tail){
        if((activeMoves.find(u_moveList->head) != activeMoves.end())
        || (worklistMoves.find(u_moveList->head) != worklistMoves.end())){
            if(GetAlias(u_moveList->head->u.MOVE.src->head->u.TEMP->num) == GetAlias(u_num)){
                v_num = GetAlias(u_moveList->head->u.MOVE.dst->head->u.TEMP->num);
            }else{
                v_num = GetAlias(u_moveList->head->u.MOVE.src->head->u.TEMP->num);
            }

            activeMoves.erase(u_moveList->head);
            frozenMoves.emplace(u_moveList->head, u_moveList->head);

            Bool isEmpty = TRUE;
            AS_instrList v_moveList = moveList.find(v_num)->second;
            for(; v_moveList; v_moveList=v_moveList->tail){
                if((activeMoves.find(v_moveList->head) != activeMoves.end())
                || (worklistMoves.find(v_moveList->head) != worklistMoves.end())){
                    isEmpty = FALSE;
                    break;
                }
            }

            v_temp = GetTemp(v_num);
            if(isEmpty && ((v_temp->type == FLOAT_TEMP && v_temp->fp_degree < get_K_fp(func_name)) 
                            || (v_temp->type != FLOAT_TEMP && v_temp->gp_degree < K_gp)) 
                        && (freezeWorklist.find(v_num) != freezeWorklist.end())){
                freezeWorklist.erase(v_num);
                simplifyWorklist.emplace(v_num, v_num);
            }
        }
    }
}

void Freeze(my_string func_name) {
    int u_key = freezeWorklist.begin()->first;
    int u_num = freezeWorklist.begin()->second;
    freezeWorklist.erase(freezeWorklist.begin());
    simplifyWorklist.emplace(u_key, u_num);
    FreezeMoves(u_num, func_name);
}

Bool SpillFlag(string str){
    int len = strlen(str);
    for(int i=0; i<len-4; ++i){
        if(*(str+i) == 's'
        && *(str+i+1) == 'p'
        && *(str+i+2) == 'i'
        && *(str+i+3) == 'l'
        && *(str+i+4) == 'l'){
            return TRUE;
        }
            
    }
    return FALSE;
}

void SelectSpill(my_string func_name) {
    // pop temp not in spillWorklist
    while(spillWorklist.find(spillCostQue.top().second) == spillWorklist.end()){
        spillCostQue.pop();
    }
    // select the temp with min spill cost 
    int toSpill = spillCostQue.top().second;
    spillCostQue.pop();
    spillWorklist.erase(toSpill);                
    simplifyWorklist.emplace(toSpill, toSpill);
    FreezeMoves(toSpill, func_name);
}

void AssignColors(my_string func_name) {
    // restore simplified edges
    int u_num = 0;
    int v_num = 0;

    for(auto &it : simplifiedEdge){
        u_num = it.first.first;
        v_num = it.first.second;
        AddEdge(GetTemp(GetAlias(u_num)), GetTemp(GetAlias(v_num)));
    }
    // begin assign

    map<int, Temp_temp> okColors;
    while(!selectStack.empty()) {
        Temp_temp n = selectStack.top();
        selectStack.pop();
        if(n->type == FLOAT_TEMP){
            if(!strcmp("main", func_name)){
                okColors = colors_fp_main;
            }else{
                okColors = colors_fp_other;
            }
        }else{
            okColors = colors_gp;
        }
        TempSet n_adj = adjList.find(n->num)->second;
        for(auto &it : *n_adj){
            // w is n_adjList->head
            int w_num = GetAlias(it->num);
            if((coloredNodes.find(w_num) != coloredNodes.end())
            || IsPrecolor(w_num)){
                int w_color = GetTemp(w_num)->color;
                if(okColors.find(w_color) != okColors.end()){
                    okColors.erase(w_color);
                }
            }
        }

        if(okColors.empty()){// spilled
            selectWorklist.erase(n->num);
            spilledNodes.emplace(n->num, n->num);
            spilledNodes_Que.emplace(calLoopDepthCost(n->num), n->num);
            // set color null
            n->color = -1;
        }else{// colored
            selectWorklist.erase(n->num);
            coloredNodes.emplace(n->num, n->num);

            if(n->isCallee && okColors.find(n->num-100) != okColors.end()){
                n->color = n->num-100;
            }else{
                if(n->type != FLOAT_TEMP && (*okColors.begin()).second->num > 3){
                    if((okColors.find(12) != okColors.end())){
                        n->color = 12;
                    }else if(okColors.find(14) != okColors.end()){
                        n->color = 14;
                    }else{
                        n->color = (*okColors.begin()).second->num;
                    }
                }else{
                    n->color = (*okColors.begin()).second->num;
                }
                
            }            
        }
    }

    int coal_node_num = 0;
    for(auto &coal_it : coalescedNodes){
        coal_node_num = coal_it.second;
        GetTemp(coal_node_num)->color = GetTemp(GetAlias(coal_node_num))->color;
        if(GetTemp(GetAlias(coal_node_num))->color == -1){
            coloredNodes.erase(coal_it.first);
            spilledNodes.emplace(coal_node_num, coal_node_num);
            spilledNodes_Que.emplace(calLoopDepthCost(coal_node_num), coal_node_num);
        }
    }

    if (ALLOCATION_INFO) {
        printf("=== Color Assign Result === (%s %d)\n", func_name, iterations);
        printf("colored :");
        const char *print_map_key;
        int print_node_num = 0;

        for(auto &it : coloredNodes){
            print_node_num = it.second;
            printf(" %s [%d] (%s)", GetTemp(print_node_num)->info, GetTemp(print_node_num)->num, GetTemp(GetTemp(print_node_num)->color)->info);
        }

        printf("\ncoalesced :");
        for(auto &it : coalescedNodes){
            print_node_num = it.second;
            printf(" %s (%s)", GetTemp(print_node_num)->info, GetTemp(GetAlias(print_node_num))->info);
        }

        printf("\nspilled :");
        for(auto &it : spilledNodes){
            printf(" %s", GetTemp(it.second)->info);
        }
        printf("\n");
    }
}

static char temp_info[200];
static char as_buf[200];

static inline bool coal_redundantMove(Temp_temp dst, Temp_temp src){
    if(dst->isSpill && src->isSpill){
        if(dst->spilledColor != -1 && src->spilledColor != -1){
            return dst->spilledColor == src->spilledColor;
        }else if(dst->spilledColor == -1 && src->spilledColor == -1){
            return GetTemp(GetAlias(dst->num))->offset == GetTemp(GetAlias(src->num))->offset;
        }else{
            return false;
        }
    }
    if(!dst->isSpill && !src->isSpill){
        return GetAlias(dst->num) == GetAlias(src->num);
    }
    return false;
}

static inline bool color_redundantMove(Temp_temp dst, Temp_temp src){
    if(dst->color != -1 && src->color != -1){
        return dst->color == src->color;
    }else{
        return false;
    }
}

static bool imm8m(int n){
    unsigned int mask[8] = {0xffffff00, 0x3fffffc0, 0x0ffffff0, 0x03fffffc, 0x00ffffff, 0xffc03fff, 0xfffff00f, 0xfffffc03};
    for(int i=0;i<8;++i){
        if((mask[i]&n)==0)return true;
    }
    return false;
}


static const int higher_mask = 0xffff0000;
static const int lower_mask = 0x0000ffff;

static inline int get_lower(int num){
    return num & lower_mask;
}

static inline int get_higher(int num){
    return ((unsigned int)num & higher_mask) >> 16;
}

static AS_instrList genMoveConst(AS_operand dst, int con, int depth){
    if(con > 65535){
        AS_operand lo_src = AS_Operand_Const(get_lower(con));
        AS_operand hi_src = AS_Operand_Const(get_higher(con));
        return AS_InstrList(AS_Oper((string)"movw `d0, `s0\nmovt `d0, `s1", AS_OperandList(dst, NULL), AS_OperandList(lo_src, AS_OperandList(hi_src, NULL)), NULL, depth), NULL);
    }else if(con >= 257){
        return AS_InstrList(AS_Oper((string)"movw `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, depth), NULL);
    }else if(con >= 0){
        return AS_InstrList(AS_Oper((string)"mov `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, depth), NULL);
    }else if(con >= -257){
        con = (-con)-1;
        return AS_InstrList(AS_Oper((string)"mvn `d0, `s0", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Const(con), NULL), NULL, depth), NULL);
    }else{
        AS_operand lo_src = AS_Operand_Const(get_lower(con));
        AS_operand hi_src = AS_Operand_Const(get_higher(con));
        return AS_InstrList(AS_Oper((string)"movw `d0, `s0\nmovt `d0, `s1", AS_OperandList(dst, NULL), AS_OperandList(lo_src, AS_OperandList(hi_src, NULL)), NULL, depth), NULL);
    }
}

static AS_instrList genStr(AS_operand src, int offset, Temp_tempList* p_new_tl, int depth){
    if(abs(offset) <= 4095){
        return AS_InstrList(AS_Oper((my_string)"str `s0, [`s1, `s2]", NULL, AS_OperandList(src, AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL))), NULL, depth), NULL);
    }else{
        AS_operand conTemp = AS_Operand_Temp_NewTemp();
        *p_new_tl = TempList_add(*p_new_tl, conTemp->u.TEMP);
        AS_instrList moveIns = genMoveConst(conTemp, offset, depth);
        return AS_instrList_add(moveIns, AS_Oper((my_string)"str `s0, [`s1, `s2]", NULL, AS_OperandList(src, AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(conTemp, NULL))), NULL, depth));
    }
}

static AS_instrList genVstr(AS_operand src, int offset, Temp_tempList* p_new_tl, int depth){
    if(abs(offset) <= 1020 && abs(offset)%4 == 0){
        return AS_InstrList(AS_Oper((my_string)"vstr.32 `s0, [`s1, `s2]", NULL, AS_OperandList(src, AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL))), NULL, depth), NULL);
    }else{
        AS_instrList addIns = NULL;
        AS_operand offsetTemp = AS_Operand_Temp_NewTemp();
        *p_new_tl = TempList_add(*p_new_tl, offsetTemp->u.TEMP);
        if(imm8m(offset)){
            addIns = AS_InstrList(AS_Oper((my_string)"add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, depth), NULL);
        }else{
            AS_operand conTemp = AS_Operand_Temp_NewTemp();
            *p_new_tl = TempList_add(*p_new_tl, conTemp->u.TEMP);
            AS_instrList moveIns = genMoveConst(conTemp, offset, depth);
            addIns = AS_instrList_add(moveIns, AS_Oper((my_string)"add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(conTemp, NULL)), NULL, depth));
        }
        return AS_instrList_add(addIns, AS_Oper((my_string)"vstr.32 `s0, [`s1]", NULL, AS_OperandList(src, AS_OperandList(offsetTemp, NULL)), NULL, depth));
    }
}

static AS_instrList genLdr(AS_operand dst, int offset, Temp_tempList* p_new_tl, int depth){
    if(abs(offset) <= 4095){
        return AS_InstrList(AS_Oper((my_string)"ldr `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, depth), NULL);
    }else{
        AS_operand conTemp = AS_Operand_Temp_NewTemp();
        *p_new_tl = TempList_add(*p_new_tl, conTemp->u.TEMP);
        AS_instrList moveIns = genMoveConst(conTemp, offset, depth);
        return AS_instrList_add(moveIns, AS_Oper((my_string)"ldr `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(conTemp, NULL)), NULL, depth));
    }
}

static AS_instrList genVldr(AS_operand dst, int offset, Temp_tempList* p_new_tl, int depth){
    if(abs(offset) <= 1020 && abs(offset)%4 == 0){
        return AS_InstrList(AS_Oper((my_string)"vldr.32 `d0, [`s0, `s1]", AS_OperandList(dst, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, depth), NULL);
    }else{
        AS_instrList addIns = NULL;
        AS_operand offsetTemp = AS_Operand_Temp_NewTemp();
        *p_new_tl = TempList_add(*p_new_tl, offsetTemp->u.TEMP);
        if(imm8m(offset)){
            addIns = AS_InstrList(AS_Oper((my_string)"add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(AS_Operand_Const(offset), NULL)), NULL, depth), NULL);
        }else{
            AS_operand conTemp = AS_Operand_Temp_NewTemp();
            *p_new_tl = TempList_add(*p_new_tl, conTemp->u.TEMP);
            AS_instrList moveIns = genMoveConst(conTemp, offset, depth);            
            addIns = AS_instrList_add(moveIns, AS_Oper((my_string)"add `d0, `s0, `s1", AS_OperandList(offsetTemp, NULL), AS_OperandList(AS_Operand_Temp(&r[11]), AS_OperandList(conTemp, NULL)), NULL, depth));
        }
        return AS_instrList_add(addIns, AS_Oper((my_string)"vldr.32 `d0, [`s0]", AS_OperandList(dst, NULL), AS_OperandList(offsetTemp, NULL), NULL, depth));
    }
}


void RewriteProgram(Temp_tempList func_params, AS_instrList ail, bool finish){
    Temp_tempList new_tl = NULL;

    // allocate memory offset for spilled nodes
    if(ALLOCATION_INFO){
        printf("=== actual spill ===\n");
    }

    int spill_temp_num = 0;
    Temp_temp spill_temp = nullptr;

    while(!spilledNodes_Que.empty()){
        auto &it = spilledNodes_Que.top();

        spill_temp_num = it.second;
        spill_temp = GetTemp(spill_temp_num);
        if(ALLOCATION_INFO){
            printf("%d spill\n", spill_temp_num);
            if(Fp_for_spill > 0){
                printf("into fp %d\n", 71 - (Fp_for_spill - 1));
            }else{
                printf("offset %d\n", -(localOffset + REG_SIZE));
            }
        }
        if(spill_temp->type != FLOAT_TEMP && Fp_for_spill > 0){
            // spill into fp reg
            Fp_for_spill--;
            spill_temp->isSpill = TRUE;
            spill_temp->spilledColor = 71 - Fp_for_spill;
        }else{
            // spill into stack
            spill_temp->isSpill = TRUE;
            localOffset += REG_SIZE;
            spill_temp->offset = -localOffset;
        }

        spilledNodes_Que.pop();
    }

    // for(auto &it : spilledNodes){
    //     spill_temp_num = it.second;
    //     spill_temp = GetTemp(spill_temp_num);
    //     if(ALLOCATION_INFO){
    //         printf("%d spill\n", spill_temp_num);
    //         printf("offset %d\n", -(localOffset + REG_SIZE));
    //     }
    //     if(spill_temp->type != FLOAT_TEMP && Fp_for_spill > 0){
    //         // spill into fp reg
    //         // TODO: you should use another priority queue 
    //         // to make the most expensive reg spill in fp reg
    //         Fp_for_spill--;
    //         spill_temp->isSpill = TRUE;
    //         spill_temp->spilledColor = 71 - Fp_for_spill;
    //     }else{
    //         // spill into stack
    //         spill_temp->isSpill = TRUE;
    //         localOffset += REG_SIZE;
    //         spill_temp->offset = -localOffset;
    //     }
    // }
    
    // path compression
    for(auto &it : coalescedNodes){
        GetAlias(it.second);
    }

    // rewrite program
    AS_instrList new_il = NULL;
    AS_instrList stores = NULL;
    AS_instrList t_ail = ail;
    AS_instrList prev = NULL;
    for(; t_ail; prev=t_ail, t_ail=t_ail->tail){
        AS_instr this_instr = t_ail->head;
        int this_instr_depth = this_instr->nest_depth;
        AS_instrList new_instr = AS_InstrList(this_instr, NULL);
        Temp_tempList instr_use = getTempList(GetSrc(this_instr));
        Temp_tempList instr_def = getTempList(GetDst(this_instr));
        new_il = NULL;
        stores = NULL;

        // AS_printInstrList(stdout, AS_InstrList(this_instr, NULL), Temp_name());

        // replace coalesce temp
        for(Temp_tempList this_use = instr_use; this_use; this_use=this_use->tail){
            if(coalescedNodes.find(this_use->head->num) != coalescedNodes.end()){
                AS_instr_replace_temp(this_instr, this_use->head, GetTemp(GetAlias(this_use->head->num)));
            }
        }
        for(Temp_tempList this_def = instr_def; this_def; this_def=this_def->tail){
            if(coalescedNodes.find(this_def->head->num) != coalescedNodes.end()){
                AS_instr_replace_temp(this_instr, this_def->head, GetTemp(GetAlias(this_def->head->num)));
            }
        }

        // reget use and def after replace
        instr_use = getTempList(GetSrc(this_instr));
        instr_def = getTempList(GetDst(this_instr));
        
        if(this_instr->kind == AS_instr_::I_LABEL){// label
            continue;
        }
        else if(this_instr->kind == AS_instr_::I_MOVE
        && (coal_redundantMove(this_instr->u.MOVE.dst->head->u.TEMP, this_instr->u.MOVE.src->head->u.TEMP)
           || (finish && color_redundantMove(this_instr->u.MOVE.dst->head->u.TEMP, this_instr->u.MOVE.src->head->u.TEMP)))){// ignore redundant move
            ail = AS_instrList_replace_opt(ail, &prev, &t_ail, new_il);
        }else{// normal spill rewrite
            // avoid duplicate spill
            Temp_tempList spillTemps = NULL;
            for(Temp_tempList this_use = instr_use; this_use; this_use=this_use->tail){
                // use is this_use->head
                if(this_use->head->isSpill && !TempList_contains(spillTemps, this_use->head)){
                    // avoid duplicate spill
                    spillTemps = TempList_add(spillTemps, this_use->head);

                    if(TempList_contains(instr_def, this_use->head)){
                        Temp_temp temp = NULL;
                        if(this_use->head->type == FLOAT_TEMP){
                            temp = Temp_newtemp_float();
                            sprintf(temp_info, "fp_spill_%d_%d", this_use->head->num, spilledCounter++);
                            temp->info = String(temp_info);
                            new_tl = TempList_add(new_tl, temp);

                            Temp_temp alias = GetTemp(GetAlias(this_use->head->num));

                            AS_instrList new_ldr = genVldr(AS_Operand_Temp(temp), alias->offset, &new_tl, this_instr_depth);
                            new_il = AS_instrList_union(new_il, new_ldr);

                            AS_instrList new_str = genVstr(AS_Operand_Temp(temp), alias->offset, &new_tl, this_instr_depth);
                            stores = AS_instrList_union(stores, new_str);
                        }else{
                            temp = Temp_newtemp();
                            sprintf(temp_info, "gp_spill_%d_%d", this_use->head->num, spilledCounter++);
                            temp->info = String(temp_info);
                            new_tl = TempList_add(new_tl, temp);
                            
                            Temp_temp alias = GetTemp(GetAlias(this_use->head->num));
                            if(alias->spilledColor != -1){
                                AS_instrList new_ldr = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(AS_Operand_Temp(temp), NULL), AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), NULL, this_instr_depth), NULL);
                                new_il = AS_instrList_union(new_il, new_ldr);
                                AS_instrList new_str = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), AS_OperandList(AS_Operand_Temp(temp), NULL), NULL, this_instr_depth), NULL);
                                stores = AS_instrList_union(stores, new_str);
                            }else{
                                AS_instrList new_ldr = genLdr(AS_Operand_Temp(temp), alias->offset, &new_tl, this_instr_depth);
                                new_il = AS_instrList_union(new_il, new_ldr);
                                AS_instrList new_str = genStr(AS_Operand_Temp(temp), alias->offset, &new_tl, this_instr_depth);
                                stores = AS_instrList_union(stores, new_str);
                            }
                        }

                        AS_Opl_replace_temp(GetSrc(this_instr), this_use->head, temp);
                        AS_Opl_replace_temp(GetDst(this_instr), this_use->head, temp);
                    }else{
                        if(this_instr->kind == AS_instr_::I_MOVE && !this_instr->u.MOVE.dst->head->u.TEMP->isSpill && GetAlias(this_instr->u.MOVE.src->head->u.TEMP->num) == GetAlias(this_use->head->num)){
                            AS_instrList new_ldr = NULL;
                            if(this_use->head->type == FLOAT_TEMP){
                                new_ldr = genVldr(this_instr->u.MOVE.dst->head, GetTemp(GetAlias(this_use->head->num))->offset, &new_tl, this_instr_depth);
                            }else{
                                Temp_temp alias = GetTemp(GetAlias(this_use->head->num));
                                if(alias->spilledColor != -1){
                                    new_ldr = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(this_instr->u.MOVE.dst->head, NULL), AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), NULL, this_instr_depth), NULL);
                                }else{
                                    new_ldr = genLdr(this_instr->u.MOVE.dst->head, alias->offset, &new_tl, this_instr_depth);
                                }
                            }
                            new_instr = new_ldr;
                        }else{
                            Temp_temp temp = NULL;

                            if(this_use->head->type == FLOAT_TEMP){
                                temp = Temp_newtemp_float();
                                sprintf(temp_info, "fp_spill_%d_%d", this_use->head->num, spilledCounter++);
                                temp->info = String(temp_info);
                                new_tl = TempList_add(new_tl, temp);

                                AS_instrList new_ldr = genVldr(AS_Operand_Temp(temp), GetTemp(GetAlias(this_use->head->num))->offset, &new_tl, this_instr_depth);
                                new_il = AS_instrList_union(new_il, new_ldr);

                            }else{
                                temp = Temp_newtemp();
                                sprintf(temp_info, "gp_spill_%d_%d", this_use->head->num, spilledCounter++);
                                temp->info = String(temp_info);
                                new_tl = TempList_add(new_tl, temp);

                                Temp_temp alias = GetTemp(GetAlias(this_use->head->num));
                                if(alias->spilledColor != -1){
                                    AS_instrList new_ldr = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(AS_Operand_Temp(temp), NULL), AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), NULL, this_instr_depth), NULL);
                                    new_il = AS_instrList_union(new_il, new_ldr);
                                }else{
                                    AS_instrList new_ldr = genLdr(AS_Operand_Temp(temp), alias->offset, &new_tl, this_instr_depth);
                                    new_il = AS_instrList_union(new_il, new_ldr);
                                }
                            }
                            
                            AS_Opl_replace_temp(GetSrc(this_instr), this_use->head, temp);
                        }
                    }
                }
            }

            for(Temp_tempList this_def = instr_def; this_def; this_def=this_def->tail){
                // def is this_def->head
                if(this_def->head->isSpill && !TempList_contains(spillTemps, this_def->head)){
                    // avoid duplicate spill
                    spillTemps = TempList_add(spillTemps, this_def->head);
                    if(TempList_contains(instr_use, this_def->head)){
                        //already done in previous step
                        ;
                    }else{
                        if(this_instr->kind == AS_instr_::I_MOVE && !this_instr->u.MOVE.src->head->u.TEMP->isSpill && GetAlias(this_instr->u.MOVE.dst->head->u.TEMP->num) == GetAlias(this_def->head->num)){
                            AS_instrList new_str = NULL;
                            if(this_def->head->type == FLOAT_TEMP){
                                new_str = genVstr(this_instr->u.MOVE.src->head, GetTemp(GetAlias(this_def->head->num))->offset, &new_tl, this_instr_depth);
                            }else{
                                Temp_temp alias = GetTemp(GetAlias(this_def->head->num));
                                if(alias->spilledColor != -1){
                                    new_str = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), AS_OperandList(this_instr->u.MOVE.src->head, NULL), NULL, this_instr_depth), NULL);
                                }else{
                                    new_str = genStr(this_instr->u.MOVE.src->head, GetTemp(GetAlias(this_def->head->num))->offset, &new_tl, this_instr_depth);
                                }
                            }
                            new_instr = new_str;
                        }else{
                            Temp_temp temp = NULL;

                            if(this_def->head->type == FLOAT_TEMP){
                                temp = Temp_newtemp_float();
                                sprintf(temp_info, "fp_spill_%d_%d", this_def->head->num, spilledCounter++);
                                temp->info = String(temp_info);
                                new_tl = TempList_add(new_tl, temp);

                                AS_instrList new_str = genVstr(AS_Operand_Temp(temp), GetTemp(GetAlias(this_def->head->num))->offset, &new_tl, this_instr_depth);
                                stores = AS_instrList_union(stores, new_str);
                            }else{
                                temp = Temp_newtemp();
                                sprintf(temp_info, "gp_spill_%d_%d", this_def->head->num, spilledCounter++);
                                temp->info = String(temp_info);
                                new_tl = TempList_add(new_tl, temp);

                                Temp_temp alias = GetTemp(GetAlias(this_def->head->num));
                                if(alias->spilledColor != -1){
                                    AS_instrList new_str = AS_InstrList(AS_Oper((my_string)"vmov `d0, `s0", AS_OperandList(AS_Operand_Temp(GetTemp(alias->spilledColor)), NULL), AS_OperandList(AS_Operand_Temp(temp), NULL), NULL, this_instr_depth), NULL);
                                    stores = AS_instrList_union(stores, new_str);
                                }else{
                                    AS_instrList new_str = genStr(AS_Operand_Temp(temp), GetTemp(GetAlias(this_def->head->num))->offset, &new_tl, this_instr_depth);
                                    stores = AS_instrList_union(stores, new_str);
                                }
                            }

                            AS_Opl_replace_temp(GetDst(this_instr), this_def->head, temp);
                        }
                    }
                }
            }

            
            new_il = AS_instrList_union(new_il, new_instr);
            new_il = AS_instrList_union(new_il, stores);
            ail = AS_instrList_replace_opt(ail, &prev, &t_ail, new_il);
        }
    }

    Temp_tempList para_tl = func_params;
    for(; para_tl; para_tl=para_tl->tail){
        // par is para_tl->head
            para_tl->head = GetTemp(GetAlias(para_tl->head->num));
        // no need to set register cause color is register
    }

    if(ALLOCATION_INFO){
        printf("===== REWRITE =====\n");
        AS_printInstrList(stdout, ail, Temp_name());
    }

    while(!selectStack.empty()) selectStack.pop();
    selectWorklist.clear();
    spilledNodes.clear();
    while(!spilledNodes_Que.empty()) spilledNodes_Que.pop();
    initial.clear();

    for(auto &it : coloredNodes){
        initial.emplace(it.first, it.second);
    }

    for(auto &it : coalescedNodes){
        initial.emplace(it.first, it.second);
    }

    for(Temp_tempList a_tl = new_tl; a_tl; a_tl=a_tl->tail){
        initial.emplace(a_tl->head->num, a_tl->head->num);
    }

    coloredNodes.clear();
    coalescedNodes.clear();

}

void RegAlloc(AS_instrList ail, my_string func_name, Temp_tempList func_params) {
    bool finish;
    iterations = 0;
    do {
        if(ALLOCATION_INFO){
            printf("==== iterations %d ====\n", iterations);
        }
        G_graph G=FG_AssemFlowGraph(ail);
        G_nodeList lg=Liveness(G_nodes(G));
        // Show_Liveness(stdout, lg);
        if(iterations == 0)
            Get_initial(lg);
        G_nodeList ig=Create_ig(lg);
        // fprintf(stdout, "\n------Interference Graph-------\n\n");
        // Show_ig(stdout, ig);
        // fprintf(stdout, "\n------end Interference Graph-------\n\n");
        makeUdTimes_loopDepth(ail);
        MakeWorklist(func_name);

        do {
            if (!simplifyWorklist.empty())
                Simplify(func_name);
            else if (!worklistMoves.empty())
                Coalesce(func_name);
            else if (!freezeWorklist.empty())
                Freeze(func_name);
            else if (!spillWorklist.empty())
                SelectSpill(func_name);
        } while (!simplifyWorklist.empty() || !worklistMoves.empty() || !freezeWorklist.empty() || !spillWorklist.empty());

        AssignColors(func_name);

        finish = spilledNodes_Que.empty();

        if(ALLOCATION_INFO){
            printf("---------- Before Rewrite ----------\n");
            AS_printInstrList(stdout, ail, Temp_name());
        }

        RewriteProgram(func_params, ail, finish);
        iterations++;
    } while (!finish);
}

