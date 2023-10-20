#include "assem.h"
#include "temp.h"
#include "symbol.h"
#include "graph.hpp"
#include "assemblock.h"
#include "util.h"
#include "bg.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "ssa.h"
#include "liveness_llvm.h"
#include "llvm_assemblock.h"
#include "llvm_assem.h"
#include <vector>
#include <unordered_map>
#include <stack>
#include <unordered_set>
#include "bg_llvm.h"

using std::stack;
using std::unordered_map;
using std::unordered_set;
using std::unordered_multimap;
using std::vector;

static int *dfnum;
static int **vertex;
static int **parent;
static int **ancestor;
static int **semi;
int **idom;
static int **samedom;
static int **best;
static int **self; // int to &mykey (ie int to G_node)

static int N;

vector<vector<int *>> children; // reverse of idom
static vector<vector<int *>> DF;
static vector<unordered_map<int, Temp_temp>> Aorig;
static unordered_map<int, unordered_map<int, int *>> defsites;
static vector<unordered_map<int, int>> Aphi;
static vector<stack<Temp_temp>> St;
static unordered_map<int, int> rename_map;

static unordered_map<Temp_label, TempSet> In_map;  // label to in_tempList
static unordered_map<Temp_label, TempSet> Out_map; // label to out_tempList

// static unordered_set<int> multiDefTemp;


std::vector<std::vector<int *>>&get_DF_array(){
    return DF;
}

void DFS(G_node p, G_node n)
{
    int *p_n_num = GetMykey(n);
    int n_num = *p_n_num;
    if (dfnum[n_num] == -1)
    {
        // printf("DFS Node %d N %d\n", n_num, N);
        dfnum[n_num] = N;
        vertex[N] = p_n_num;
        int *p_p_num;
        if (p)
            p_p_num = GetMykey(p);
        else
            p_p_num = NULL;
        parent[n_num] = p_p_num;
        self[n_num] = p_n_num;
        ++N;
        for (G_nodeList w = G_succ(n); w != NULL; w = w->tail)
            DFS(n, w->head);
    }
    return;
}

int *AncestorWithLowestSemi(G_node v)
{
    int *p_v_num = GetMykey(v);
    int v_num = *p_v_num;
    int *p_a_num = ancestor[v_num];
    int a_num = *p_a_num;
    if (ancestor[a_num])
    {
        int *p_b_num = AncestorWithLowestSemi(GetNode(p_a_num));
        int b_num = *p_b_num;
        ancestor[v_num] = ancestor[a_num];
        if (dfnum[*semi[b_num]] < dfnum[*semi[*best[v_num]]])
            best[v_num] = p_b_num;
    }
    return best[v_num];
}

void Link(G_node p, G_node n)
{
    int *p_n_num = GetMykey(n);
    int *p_p_num = GetMykey(p);
    int n_num = *p_n_num;
    int p_num = *p_p_num;
    ancestor[n_num] = p_p_num;
    best[n_num] = p_n_num;
    return;
}

void Dominators(G_graph g)
{

    // init
    int TotalNodeNum = G_nodeNum(g);
    N = 0;
    int MaxTemp = get_maxtemp();

    // printf("MaxTemp %d\n", MaxTemp);

    vector<unordered_map<int, int *>> bucket;
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        bucket.emplace_back();

    dfnum = (int *)checked_malloc((TotalNodeNum + 5) * sizeof(int));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        dfnum[i] = -1;

    vertex = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        vertex[i] = NULL;

    parent = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        parent[i] = NULL;

    semi = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        semi[i] = NULL;

    ancestor = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        ancestor[i] = NULL;

    idom = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        idom[i] = NULL;

    samedom = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        samedom[i] = NULL;

    best = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        best[i] = NULL;

    self = (int **)checked_malloc((TotalNodeNum + 5) * sizeof(int *));
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        self[i] = NULL;

    children.clear();
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        children.emplace_back();

    DF.clear();
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        DF.emplace_back();

    Aorig.clear();
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        Aorig.emplace_back();

    defsites.clear();

    Aphi.clear();
    for (int i = 0; i < TotalNodeNum + 5; ++i)
        Aphi.emplace_back();

    St.clear();
    for (int i = 0; i < MaxTemp + 5; ++i)
    {
        St.emplace_back();
    }
    for (int i = 0; i < MaxTemp + 5; ++i)
    {
        St[i].push(GetTemp(i));
    }
    rename_map.clear();
    for (int i = 100; i < MaxTemp; ++i)
    {
        rename_map.emplace(i, i);
    }

    G_node r = G_nodes(g)->head;
    DFS(NULL, r);

    G_node n = NULL;
    int *p_n_num = NULL;
    int n_num = -1;
    G_node p = NULL;
    G_node s = NULL;
    G_node sp = NULL;
    G_nodeList vlist = NULL;
    unordered_map<int, int *> bucket_p;
    G_node v = NULL;
    int *p_v_num = NULL;
    int v_num = -1;
    int *p_y_num = NULL;
    int y_num = -1;
    G_node y = NULL;

    for (int i = N - 1; i > 0; --i)
    {
        p_n_num = vertex[i];
        n_num = *p_n_num;
        n = GetNode(p_n_num);
        p = GetNode(parent[n_num]);
        s = p;
        for (vlist = G_pred(n); vlist != NULL; vlist = vlist->tail)
        {
            if (dfnum[*GetMykey(vlist->head)] <= dfnum[n_num])
                sp = vlist->head;
            else
                sp = GetNode(semi[*AncestorWithLowestSemi(vlist->head)]);
            // printf("sp: dfnum[%d] %d,s: dfnum[%d] %d\n", *GetMykey(sp), dfnum[*GetMykey(sp)], *GetMykey(s), dfnum[*GetMykey(s)]);
            if (dfnum[*GetMykey(sp)] < dfnum[*GetMykey(s)])
                s = sp;
        }

        semi[n_num] = GetMykey(s);
        bucket[*GetMykey(s)].emplace(n_num, p_n_num);
        Link(p, n);

        // printf("check bucket %d\n", *GetMykey(p));
        bucket_p = bucket[*GetMykey(p)];

        for (auto &it : bucket_p)
        {
            p_v_num = it.second;
            v_num = it.first;
            assert(v_num == *p_v_num);
            v = GetNode(p_v_num);
            p_y_num = AncestorWithLowestSemi(v);
            y_num = *p_y_num;
            // printf("check node v %d\n", v_num);
            // printf("semi[y %d] %d, semi[v %d] %d\n", y_num, *semi[y_num], v_num, *semi[v_num]);
            if (semi[y_num] == semi[v_num])
                idom[v_num] = GetMykey(p);
            else
                samedom[v_num] = p_y_num;
        }

        bucket_p.clear();
    }

    for (int i = 1; i < N; ++i)
    {
        p_n_num = vertex[i];
        n_num = *p_n_num;
        if (samedom[n_num])
            idom[n_num] = idom[*samedom[n_num]];
    }

    for (int i = 0; i < TotalNodeNum; ++i)
    {
        if (idom[i])
        {
            children[*idom[i]].emplace_back(self[i]);
        }
    }

    // printf("idom:\n");
    // for(int i=0; i<TotalNodeNum; ++i){
    //     if(idom[i])
    //         printf("%d : %d\n", i, *idom[i]);
    //     else
    //         printf("%d : nil\n", i);
    // }

    // printf("children:\n");
    // for(int i=0; i<TotalNodeNum; ++i){
    //     printf("%d : ", i);
    //     for(auto &it : children[i]){
    //         printf("%d ", *it);
    //     }
    //     printf("\n");
    // }
}

int **GetIdom()
{
    return idom;
}

// check if n dom w
Bool IsDom(int *p_n_num, int *p_w_num)
{
    while (p_w_num)
    {
        if (p_w_num == p_n_num)
            return TRUE;
        p_w_num = idom[*p_w_num];
    }
    return FALSE;
}

void getDF()
{
    int *p_n_num = NULL;
    for (int i = 0; i < N; ++i)
    {
        p_n_num = vertex[i];
        if (!idom[*p_n_num])
            computeDF(GetNode(p_n_num));
    }
    return;
}

void computeDF(G_node n)
{
    vector<int *> S;
    int *p_n_num = GetMykey(n);
    int *p_y_num = NULL;
    int *p_c_num = NULL;
    int *p_w_num = NULL;
    int *p_S_num = NULL;
    G_node c = NULL;

    // printf("n %d\n", *p_n_num);
    for (G_nodeList y = G_succ(n); y != NULL; y = y->tail)
    {
        p_y_num = GetMykey(y->head);
        // printf("succ y %d\n", *p_y_num);
        if (idom[*p_y_num] != p_n_num)
        {
            // printf("y %d into S\n", *p_y_num);
            S.emplace_back(p_y_num);
        }
    }

    for (auto &it : children[*p_n_num])
    {
        p_c_num = it;
        c = GetNode(p_c_num);
        computeDF(c);

        for (auto &it : DF[*p_c_num])
        {
            p_w_num = it;
            if (!IsDom(p_n_num, p_w_num) || p_n_num == p_w_num)
            {
                S.emplace_back(p_w_num);
            }
        }
    }

    DF[*p_n_num] = S;
}

void printDF()
{
    int *p_num = NULL;
    printf("DF:\n");
    for (int i = 0; i < N; ++i)
    {
        printf("%d : ", i);
        for (auto &it : DF[i])
        {
            p_num = it;
            printf("%d ", *p_num);
        }
        printf("\n");
    }
}

void NodeTempMap(G_node n)
{
    LLVM_IR::llvm_AS_block_ *nb = (LLVM_IR::llvm_AS_block_ *)n->info;
    int *p_n_num = GetMykey(n);
    for (LLVM_IR::T_irList_ *list = nb->irs; list; list = list->tail)
    {
        if (list->head->i->kind == AS_instr_::I_MOVE && list->head->i->u.MOVE.dst)
        {
            for (Temp_tempList tl = getTempList(list->head->i->u.MOVE.dst); tl; tl = tl->tail)
            {
                Aorig[*p_n_num].emplace(tl->head->num, tl->head);
            }
        }
        else if (list->head->i->kind == AS_instr_::I_OPER && list->head->i->u.OPER.dst)
        {
            for (Temp_tempList tl = getTempList(list->head->i->u.OPER.dst); tl; tl = tl->tail)
            {
                Aorig[*p_n_num].emplace(tl->head->num, tl->head);
            }
        }
        else
            ;
    }
    return;
}

void CreateAorig(G_graph g)
{
    for (G_nodeList nl = G_nodes(g); nl; nl = nl->tail)
        NodeTempMap(nl->head);
    return;
}

void CreateAorig(G_graph g, std::unordered_map<Temp_label, std::unordered_set<int>>& phiTempMap)
{
    for(auto &it : phiTempMap){
        for(auto &temp_it : it.second){
            int nodeKey = BG_LLVM::getNodeByLabel(it.first);
            // printf("label %s temp %d\n", Temp_labelstring(it.first), temp_it);
            Aorig[nodeKey].emplace(temp_it, GetTemp(temp_it));
        }
    }
    return;
}

static bool checkTempInList(int temp_num, TempSet ts)
{
    for(auto &it : *ts){
        if(it->num == temp_num){
            return true;
        }
    }
    return false;
}

// check if temp is live in at n
Bool checkLive(int temp_num, G_node n)
{
    assert(((LLVM_IR::llvm_AS_block_ *)n->info)->irs->head->i->kind == AS_instr_::I_LABEL);
    Temp_label n_label = ((LLVM_IR::llvm_AS_block_ *)n->info)->irs->head->i->u.LABEL.label;

    auto n_In = In_map.find(n_label);

    if (n_In != In_map.end())
        return checkTempInList(temp_num, n_In->second);
    else
        return FALSE;
}

void InsertPhiFunc(int temp_num, G_node n, G_nodeList pred)
{
    LLVM_IR::llvm_AS_block_ *nb = (LLVM_IR::llvm_AS_block_ *)n->info;
    Temp_tempList temp_list = NULL;
    Temp_tempList last = NULL;
    Temp_temp t = GetTemp(temp_num);
    Temp_labelList lList = NULL;
    Temp_labelList lLast = NULL;
    char as_buf[30000];
    char temp_list_buf[20000];
    char temp[500];
    int j = 0;

    if(temp_num == 467 && !strcmp(Temp_labelstring(nb->label), "AaBbcCL49")){
        printf("ffuck");
    }

    // gen phi assem and temp_list
    // insert the phi func into nb
    memset(temp_list_buf, 0, sizeof(temp_list_buf));

    if (checkLive(temp_num, n))
    {
        memset(temp, 0, sizeof(temp));
        sprintf(temp, "[`s0, `j0]");
        strcat(temp_list_buf, temp);
        last = temp_list = Temp_TempList(t, NULL);
        lLast = lList = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);
        ++j;
    }

    pred = pred->tail;

    for (; pred; pred = pred->tail)
    {
        if (checkLive(temp_num, n))
        {
            memset(temp, 0, sizeof(temp));
            if (j == 0)
                sprintf(temp, "[`s0, `j0]");
            else
                sprintf(temp, ", [`s%d, `j%d]", j, j);
            strcat(temp_list_buf, temp);

            if (last)
                last = last->tail = Temp_TempList(t, NULL);
            else
                last = temp_list = Temp_TempList(t, NULL);

            if (lLast)
                lLast = lLast->tail = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);
            else
                lLast = lList = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);

            ++j;
        }
    }

    if (j > 1)
    {
        // printf("insert phi func\n");
        // printf("t->type %d\n", t->type);
        switch (t->type)
        {
        case INT_TEMP:
        {
            sprintf(as_buf, "`d0 = phi i32 %s", temp_list_buf);
            break;
        }
        case FLOAT_TEMP:
        {
            sprintf(as_buf, "`d0 = phi float %s", temp_list_buf);
            break;
        }
        case INT_PTR:
        case FLOAT_PTR:
        {
            sprintf(as_buf, "`d0 = phi ptr %s", temp_list_buf);
            break;
        }
        default:
        {
            assert(0);
            break;
        }
        }
        AS_operandList opl = getOperandList(temp_list);
        AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(t), NULL), opl, AS_Targets(lList));
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Phi(AS_Operand_Temp(t), lList, opl);

        nb->irs->tail = LLVM_IR::T_IrList(LLVM_IR::T_Ir(stm, instr), nb->irs->tail);
    }
}

void InsertPhiFunc2(int temp_num, G_node n, G_nodeList pred)
{
    LLVM_IR::llvm_AS_block_ *nb = (LLVM_IR::llvm_AS_block_ *)n->info;
    Temp_tempList temp_list = NULL;
    Temp_tempList last = NULL;
    Temp_temp t = GetTemp(temp_num);
    Temp_labelList lList = NULL;
    Temp_labelList lLast = NULL;
    char as_buf[30000];
    char temp_list_buf[20000];
    char temp[500];
    int j = 0;

    if(temp_num == 467 && !strcmp(Temp_labelstring(nb->label), "AaBbcCL49")){
        printf("ffuck");
    }

    // gen phi assem and temp_list
    // insert the phi func into nb
    memset(temp_list_buf, 0, sizeof(temp_list_buf));

    memset(temp, 0, sizeof(temp));
    sprintf(temp, "[`s0, `j0]");
    strcat(temp_list_buf, temp);
    last = temp_list = Temp_TempList(t, NULL);
    lLast = lList = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);
    ++j;

    pred = pred->tail;

    for (; pred; pred = pred->tail)
    {
        memset(temp, 0, sizeof(temp));
        if (j == 0)
            sprintf(temp, "[`s0, `j0]");
        else
            sprintf(temp, ", [`s%d, `j%d]", j, j);
        strcat(temp_list_buf, temp);
        if (last)
            last = last->tail = Temp_TempList(t, NULL);
        else
            last = temp_list = Temp_TempList(t, NULL);
        if (lLast)
            lLast = lLast->tail = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);
        else
            lLast = lList = Temp_LabelList(((LLVM_IR::llvm_AS_block_ *)pred->head->info)->label, NULL);
        ++j;
    }

    if (j > 1)
    {
        // printf("insert phi func\n");
        // printf("t->type %d\n", t->type);
        switch (t->type)
        {
        case INT_TEMP:
        {
            sprintf(as_buf, "`d0 = phi i32 %s", temp_list_buf);
            break;
        }
        case FLOAT_TEMP:
        {
            sprintf(as_buf, "`d0 = phi float %s", temp_list_buf);
            break;
        }
        case INT_PTR:
        case FLOAT_PTR:
        {
            sprintf(as_buf, "`d0 = phi ptr %s", temp_list_buf);
            break;
        }
        default:
        {
            assert(0);
            break;
        }
        }
        AS_operandList opl = getOperandList(temp_list);
        AS_instr instr = AS_Oper(String(as_buf), AS_OperandList(AS_Operand_Temp(t), NULL), opl, AS_Targets(lList));
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Phi(AS_Operand_Temp(t), lList, opl);

        nb->irs->tail = LLVM_IR::T_IrList(LLVM_IR::T_Ir(stm, instr), nb->irs->tail);
    }
}

void PlacePhiFunc(G_graph g)
{
    int *p_n_num = NULL;
    Temp_temp temp_a;
    unordered_map<int, unordered_map<int, int *>>::iterator p_map_a;
    int *p_y_num = NULL;
    G_node y = NULL;

    CreateAorig(g);

    for (G_nodeList nl = G_nodes(g); nl; nl = nl->tail)
    {
        p_n_num = GetMykey(nl->head);
        for (auto &it : Aorig[*p_n_num])
        {
            p_map_a = defsites.find(it.first);
            if (p_map_a != defsites.end())
            {
                (*p_map_a).second.emplace(*p_n_num, p_n_num);
            }
            else
            {
                unordered_map<int, int *> map_a = {{*p_n_num, p_n_num}};
                defsites.emplace(it.first, map_a);
            }
        }
    }

    for (auto &it : defsites)
    {
        p_map_a = defsites.find(it.first);
        unordered_map<int, int *> W;

        W = (*p_map_a).second;

        while (!W.empty())
        {
            p_n_num = (*W.begin()).second;
            W.erase(W.begin());
            for (auto y_it : DF[*p_n_num])
            {
                p_y_num = y_it;
                y = GetNode(p_y_num);
                // a not in Aphi
                if (Aphi[*p_y_num].find(it.first) == Aphi[*p_y_num].end())
                {
                    InsertPhiFunc(it.first, y, G_pred(y));
                    Aphi[*p_y_num].emplace(it.first, 1);
                    if (Aorig[*p_y_num].find(it.first) == Aorig[*p_y_num].end())
                    {
                        W.emplace(*p_y_num, p_y_num);
                    }
                }
            }
        }
    }
}

void PlacePhiFunc(G_graph g, std::unordered_map<Temp_label,std::unordered_set<int>>& phiTempMap)
{
    int *p_n_num = NULL;
    Temp_temp temp_a;
    unordered_map<int, unordered_map<int, int *>>::iterator p_map_a;
    int *p_y_num = NULL;
    G_node y = NULL;

    CreateAorig(g, phiTempMap);

    for (G_nodeList nl = G_nodes(g); nl; nl = nl->tail)
    {
        p_n_num = GetMykey(nl->head);
        for (auto &it : Aorig[*p_n_num])
        {
            p_map_a = defsites.find(it.first);
            if (p_map_a != defsites.end())
            {
                (*p_map_a).second.emplace(*p_n_num, p_n_num);
            }
            else
            {
                unordered_map<int, int *> map_a = {{*p_n_num, p_n_num}};
                defsites.emplace(it.first, map_a);
            }
        }
    }

    for (auto &it : defsites)
    {
        p_map_a = defsites.find(it.first);
        unordered_map<int, int *> W;

        W = (*p_map_a).second;

        while (!W.empty())
        {
            p_n_num = (*W.begin()).second;
            W.erase(W.begin());
            for (auto y_it : DF[*p_n_num])
            {
                p_y_num = y_it;
                y = GetNode(p_y_num);
                // a not in Aphi
                if (Aphi[*p_y_num].find(it.first) == Aphi[*p_y_num].end())
                {
                    // printf("try insert phi at label %s for %d\n", Temp_labelstring(((LLVM_IR::llvm_AS_block_ *)y->info)->label), it.first);
                    InsertPhiFunc2(it.first, y, G_pred(y));
                    Aphi[*p_y_num].emplace(it.first, 1);
                    if (Aorig[*p_y_num].find(it.first) == Aorig[*p_y_num].end())
                    {
                        W.emplace(*p_y_num, p_y_num);
                    }
                }
            }
        }
    }
}

static bool IsPhi(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        int len = strlen(instr->u.OPER.assem);
        for (int i = 0; i < len; ++i)
            if (*(instr->u.OPER.assem + i) == 'p' && *(instr->u.OPER.assem + i + 1) == 'h' && *(instr->u.OPER.assem + i + 2) == 'i')
                return true;
    }
    return false;
}

static int GetNodePredth(G_node n, G_node y)
{
    int j = 1;
    for (G_nodeList pred = G_pred(y); pred; pred = pred->tail, ++j)
    {
        if (pred->head == n)
            return j;
    }
    return 0;
}

static int GetPhiOpth(Temp_label n_label, LLVM_IR::T_ir phiIns)
{
    int j = 1;
    for (Phi_pair_List ppl = phiIns->s->u.PHI.phis; ppl; ppl = ppl->tail, ++j)
    {
        if (ppl->head->label == n_label)
            return j;
    }
    return 0;
}

static LLVM_IR::llvm_AS_block_ *getBlock(Temp_label label, G_nodeList gl)
{
    for (; gl; gl = gl->tail)
    {
        LLVM_IR::llvm_AS_block_ *b = (LLVM_IR::llvm_AS_block_ *)gl->head->info;
        if (b->label == label)
            return b;
    }
    return NULL;
}

void addPhiMove(LLVM_IR::llvm_T_stm_ *s, G_nodeList pred)
{
    assert(s->kind == LLVM_IR::llvm_T_stm_::T_PHI);
    // printf("add phi move:\n");
    for (Phi_pair_List pl = s->u.PHI.phis; pl; pl = pl->tail)
    {
        // printf("label: %s\n", Temp_labelstring(pl->head->label));
        // printf("temp: %d\n", pl->head->op->u.TEMP->num);
        LLVM_IR::llvm_AS_block_ *b = getBlock(pl->head->label, pred);
        assert(s->u.PHI.dst->kind == AS_operand_::T_TEMP);
        // assert(pl->head->op->kind == AS_operand_::T_TEMP);
        assert(b);

        AS_instr instr = NULL;
        if (pl->head->op->kind == AS_operand_::T_TEMP)
        {
            instr = AS_Move((string) "mov `d0, `s0", AS_OperandList(s->u.PHI.dst, NULL), AS_OperandList(pl->head->op, NULL));
        }
        else
        {
            instr = AS_Oper((string) "mov `d0, `s0", AS_OperandList(s->u.PHI.dst, NULL), AS_OperandList(pl->head->op, NULL), NULL);
        }
        LLVM_IR::llvm_T_stm_ *stm = LLVM_IR::T_Move(s->u.PHI.dst, pl->head->op);

        LLVM_IR::T_irList_ *il = b->irs;
        LLVM_IR::T_irList_ *il_prev = NULL;
        LLVM_IR::T_irList_ *il_prev_prev = NULL;
        for (; il; il_prev_prev = il_prev, il_prev = il, il = il->tail)
            ;

        il_prev_prev->tail = LLVM_IR::T_IrList(LLVM_IR::T_Ir(stm, instr), il_prev);
    }
}

void eliminatePhiFunc(G_graph g)
{
    G_nodeList nl = G_nodes(g);
    for (; nl; nl = nl->tail)
    {
        LLVM_IR::llvm_AS_block_ *nb = (LLVM_IR::llvm_AS_block_ *)nl->head->info;
        LLVM_IR::T_irList_ *il = nb->irs;
        // printf("block label: %s\n", Temp_labelstring(nb->label));
        LLVM_IR::T_irList_ *il_prev = NULL;
        for (; il;)
        {
            // AS_printInstrList(stdout, AS_InstrList(il->head->i, NULL), Temp_name());
            if (IsPhi(il->head->i))
            {
                addPhiMove(il->head->s, G_pred(nl->head));
                il_prev->tail = il->tail;
                il->tail = NULL;
                il = il_prev->tail;
            }
            else
            {
                il_prev = il;
                il = il->tail;
            }
        }
    }
}

bool isArgsDef(AS_instr instr)
{
    if (instr->kind == AS_instr_::I_OPER)
    {
        int len = strlen(instr->u.OPER.assem);
        return len == 0;
    }
    return false;
}

void resetRename(Temp_tempList args){
    // mark args as multiDefTemp
    // multiDefTemp.clear();
    // for(Temp_tempList tl=args; tl; tl=tl->tail){
    //     multiDefTemp.emplace(tl->head->num);
    // }
}

void Rename(G_node n)
{
    LLVM_IR::llvm_AS_block_ *nb = (LLVM_IR::llvm_AS_block_ *)n->info;
    LLVM_IR::llvm_AS_block_ *yb = NULL;
    int j = 0;
    unordered_multimap<int, int> def;
    int ori = 0;
    // printf("Rename block %s\n", Temp_labelstring(nb->label));
    for (LLVM_IR::T_irList_ *al = nb->irs; al; al = al->tail)
    {
        // al->head is S
        if (!IsPhi(al->head->i))
        {
            for (AS_operandList tl = GetSrc(al->head->i); tl; tl = tl->tail)
            {
                // tl->head is x
                if (tl->head->kind == AS_operand_::T_TEMP)
                {
                    ori = rename_map.find(tl->head->u.TEMP->num)->second;
                    Temp_temp top_temp = St[ori].top();
                    // printf("rename src %d\n", ori);
                    // printf("rename %d with %d\n", tl->head->u.TEMP->num, top_temp->num);
                    // seq here is imporant
                    LLVM_IR::irReplaceSrcTemp(al->head->s, tl->head->u.TEMP, top_temp);
                    tl->head->u.TEMP = top_temp;
                    // printTempList(GetSrc(al->head));
                }
            }
        }

        if (!isArgsDef(al->head->i))
        {
            for (AS_operandList tl = GetDst(al->head->i); tl; tl = tl->tail)
            {
                // tl->head is a
                // get tl->head origin temp
                if (tl->head->kind == AS_operand_::T_TEMP)
                {
                    ori = rename_map.find(tl->head->u.TEMP->num)->second;
                    // rename tl->head
                    // note down rename temp
                    def.emplace(tl->head->u.TEMP->num, ori);
                    Temp_temp new_temp = NULL;
                    switch (GetTemp(ori)->type)
                    {
                    case INT_TEMP:
                    {
                        new_temp = Temp_newtemp();
                        break;
                    }
                    case FLOAT_TEMP:
                    {
                        new_temp = Temp_newtemp_float();
                        break;
                    }
                    case INT_PTR:
                    {
                        new_temp = Temp_newtemp_int_ptr();
                        break;
                    }
                    case FLOAT_PTR:
                    {
                        new_temp = Temp_newtemp_float_ptr();
                        break;
                    }
                    default:
                    {
                        assert(0);
                        break;
                    }
                    }
                    // printf("push %d to stack %d\n", new_temp->num, ori);
                    St[ori].push(new_temp);
                    // sprintf(rename_key, "%d", new_temp->num);
                    // note down rename relation
                    rename_map.emplace(new_temp->num, ori);
                    // printf("rename dst\n");
                    // printf("rename %d with %d\n", tl->head->u.TEMP->num, new_temp->num);
                    // seq here is imporant
                    LLVM_IR::irReplaceDstTemp(al->head->s, tl->head->u.TEMP, new_temp);
                    tl->head->u.TEMP = new_temp;
                }
            }
        }
        // printTempList(GetDst(al->head));
    }

    for (G_nodeList succ = G_succ(n); succ; succ = succ->tail)
    {
        // succ->head is y
        Temp_label nb_label = nb->label;
        yb = (LLVM_IR::llvm_AS_block_ *)succ->head->info;
        // printf("rename succ node label %s\n", Temp_labelstring(yb->label));
        for (LLVM_IR::T_irList_ *al = yb->irs; al; al = al->tail)
        {
            if (IsPhi(al->head->i))
            {
                int j = GetPhiOpth(nb_label, al->head);
                AS_operand *p_a = GetjthOper(GetSrc(al->head->i), j);
                // replace a with a_i
                if (p_a && (*p_a)->kind == AS_operand_::T_TEMP)
                {
                    // assert((*p_a)->kind == AS_operand_::T_TEMP);
                    ori = rename_map.find((*p_a)->u.TEMP->num)->second;
                    // printf("rename phi src\n");
                    // printf("rename %d with %d\n", (*p_a)->u.TEMP->num, (St[ori]).top()->num);
                    // seq here is imporant
                    // AS_print(stdout, al->head->i, Temp_name());
                    LLVM_IR::phiReplacejthSrcTemp(al->head->s, j, (*p_a)->u.TEMP, St[ori].top());
                    (*p_a)->u.TEMP = St[ori].top();
                    // printTempList(GetSrc(al->head));
                }
            }
        }
    }

    int *p_n_num = GetMykey(n);
    int *p_x_num = NULL;

    for (auto &it : children[*p_n_num])
    {
        p_x_num = it;
        Rename(GetNode(p_x_num));
    }

    // printf("pop block %s\n", Temp_labelstring(nb->label));
    int a_num = 0;
    for (auto &it : def)
    {
        a_num = it.second;
        // printf("pop %d\n", St[a_num].top()->num);
        St[a_num].pop();
    }
}

LLVM_IR::llvm_AS_block_ *gen_dummy_head(LLVM_IR::llvm_AS_blockList_ *abl, Temp_tempList def)
{
    Temp_label new_label = Temp_newlabel();
    AS_operandList defList = NULL;
    Temp_tempList dl = def;
    while (dl)
    {
        defList = AS_OperandList(AS_Operand_Temp(dl->head), defList);
        dl = dl->tail;
    }

    // 这里的跳转没接上
    // 警惕所有的 NULL

    return LLVM_IR::AS_Block(
        LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Label(new_label), AS_Label(StringLabel(Temp_labelstring(new_label)), new_label)),
                          // 使用T_NULL类型，避免空指针
                          LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Null(), AS_Oper((string) "", defList, NULL, NULL)),
                                            LLVM_IR::T_IrList(LLVM_IR::T_Ir(LLVM_IR::T_Jump(abl->head->label), AS_Oper((string) "br label `j0", NULL, NULL, AS_Targets(Temp_LabelList(abl->head->label, NULL)))), NULL))));
}

void getInOut(G_nodeList lg)
{
    In_map.clear();
    Out_map.clear();
    for (; lg; lg = lg->tail)
    {
        LLVM_IR::T_ir_ *ir = (LLVM_IR::T_ir_ *)(lg->head->info);
        if (ir->i->kind == AS_instr_::I_LABEL)
        {
            In_map.emplace(ir->i->u.LABEL.label, LI_LLVM::FG_In(lg->head));
            Out_map.emplace(ir->i->u.LABEL.label, LI_LLVM::FG_Out(lg->head));
        }
    }
}

void RenameAll()
{
    int *p_n_num = NULL;
    for (int i = 0; i < N; ++i)
    {
        p_n_num = vertex[i];
        if (!idom[*p_n_num])
            Rename(GetNode(p_n_num));
    }
    return;
}

void deleteNode(G_node n, G_graph g)
{
    for (G_nodeList gl = G_pred(n); gl; gl = gl->tail)
        G_rmEdge(gl->head, n);

    for (G_nodeList gl = G_succ(n); gl; gl = gl->tail)
        G_rmEdge(n, gl->head);

    for (G_nodeList gl = G_nodes(g); gl && gl->tail; gl = gl->tail)
        if (gl->tail->head == n)
            gl->tail = gl->tail->tail;
}

void SingleSourceGraph(G_node r, G_graph g)
{
    int NodeNum = G_nodeNum(g);
    Bool flag = TRUE;
    while (flag)
    {
        flag = FALSE;
        for (G_nodeList gl = G_nodes(g); gl; gl = gl->tail)
        {
            if (gl->head != r && !G_pred(gl->head))
            {
                deleteNode(gl->head, g);
                flag = TRUE;
            }
        }
    }
    return;
}
