#include "condition_exec.h"
#include <assert.h>
#include <string.h>
#include <iostream>
#include <map>
#include <regex>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "assemblock.h"
#include "translate.hpp"

using namespace std;
using namespace LLVM_IR;

#define C_SIZE 4

struct my_arm_graph_ {
    vector<Temp_label> pred;
    vector<Temp_label> succ;
    AS_instr cmp;
};
unordered_map<Temp_label, struct my_arm_graph_> Graph;
unordered_map<Temp_label, AS_armblock2> label_block;
unordered_set<std::string> instr_set;
// 主要可能有多条指令 :movw,movt
static const char instrCon[][15] = {"add", "sub", "mul", "sdiv", "vadd.f32", "vsub.f32", "vmul.f32", "vdiv.f32",
                                    "mov", "movw", "movt", "mvn", "ldr", "str", "vmov", "vstr.32", "vldr.32",
                                    "and", "orr", "eor", "smull", "rsb", "lsl", "asr", "lsr", "vcvt.f32.s32", "vcvt.s32.f32"};

// 将arm单向链表转成双向  block和instr
static AS_armblock2List arm_single_2_double(AS_blockList bl) {
    AS_armblock2List blockList = new struct AS_armblock2List_();
    for (AS_blockList tl = bl; tl; tl = tl->tail) {
        AS_block head = tl->head;
        AS_armblock2 head_2 = new struct AS_armblock2_();
        head_2->label = head->label;
        head_2->succs = head->succs;
        AS_arminstr2List instr2List = new AS_arminstr2List_();
        for (AS_instrList instrsList = head->instrs; instrsList; instrsList = instrsList->tail) {
            AS_instr instr = instrsList->head;
            instr2List->ilist.push_back(instr);
        }
        head_2->instrs = instr2List;
        blockList->blist.push_back(head_2);
    }
    return blockList;
}

// 将arm双向链表转成单向
static AS_blockList arm_double_2_single(AS_armblock2List bl) {
    AS_blockList blockList = NULL;
    while (!bl->blist.empty()) {
        AS_armblock2 head2 = bl->blist.back();
        bl->blist.pop_back();
        AS_instrList instrList = NULL;
        AS_arminstr2List instr2List = head2->instrs;
        while (!instr2List->ilist.empty()) {
            AS_instr instr = instr2List->ilist.back();
            instr2List->ilist.pop_back();
            instrList = AS_InstrList(instr, instrList);
        }
        AS_block block = (AS_block)checked_malloc(sizeof(*block));
        block->instrs = instrList;
        block->label = head2->label;
        block->succs = head2->succs;
        blockList = AS_BlockList(block, blockList);
    }
    return blockList;
}

static void init(AS_armblock2List bl) {
    Graph.clear();
    label_block.clear();
    instr_set.clear();
    for (auto it : bl->blist) {
        Temp_label label = it->label;
        label_block[label] = it;
        Temp_labelList succ = it->succs;
        for (; succ; succ = succ->tail) {
            Graph[label].succ.push_back(succ->head);
            Graph[succ->head].pred.push_back(label);
        }
        for (auto instr = it->instrs->ilist.rbegin(); instr != it->instrs->ilist.rend(); ++instr) {
            std::string s = (*instr)->u.OPER.assem;
            if (regex_search(s, regex("b.+ "))) {
                Graph[label].cmp = *instr;
                break;
            }
        }
    }
    int length = sizeof(instrCon) / sizeof(instrCon[0]);
    for (int i = 0; i < length; i++) {
        instr_set.insert(instrCon[i]);
    }
}

static int get_num(AS_instr instr) {
    std::string s = instr->u.OPER.assem;
    int ans = 1;
    for (auto c : s) {
        if (c == '\n') {
            ans++;
        }
    }
    // 访存:额外的权重
    if(s.find("str")>=0||s.find("ldr")>=0)
        ans++;
    return ans;
}
static vector<std::string> get_all_instr(AS_instr instr) {
    std::string s = instr->u.OPER.assem;
    vector<std::string> ans;
    int prev = 0;
    for (int i = 0; i < s.size(); i++) {
        if (s[i] == '\n') {
            ans.push_back(s.substr(prev, i - prev));
            prev = i + 1;
        }
    }
    if (prev != s.size()) {
        ans.push_back(s.substr(prev, s.size() - prev));
    }
    return ans;
}

static std::string get_op(AS_instr instr) {
    std::string s = instr->u.OPER.assem;
    return s.substr(1, s.find(' ')-1);
}
static std::string get_instr(std::string instr) {
    return instr.substr(0, instr.find(' '));
}
static std::string get_instr(AS_instr instr) {
    std::string s = instr->u.OPER.assem;
    return s.substr(0, s.find(' '));
}

static bool isTranCon(AS_instr instr) {
    return instr_set.find(get_instr(instr)) != instr_set.end();
}

static void tran_move(AS_armblock2List bl, Temp_label pred_label, Temp_label true_label) {
    std::string op = get_op(Graph[pred_label].cmp);
    auto true_block = label_block[true_label];
    // printf("%s:\n", S_name(true_label));
    for (auto instr : true_block->instrs->ilist) {
        if (instr->kind == AS_instr_::I_LABEL || (instr->kind == AS_instr_::I_OPER && instr->u.OPER.jumps)) {
            //  printf("跳过:  %s  %d\n",instr->u.OPER.assem,instr->kind==AS_instr_::I_LABEL);
            continue;
        }
        // printf("o:  %s\n", instr->u.OPER.assem);
        auto instrList = get_all_instr(instr);
        std::string new_instrList;
        for (int i = 0; i < instrList.size(); i++) {
            std::string new_instr = instrList[i];
            std::string new_op=get_instr(new_instr);
            if (new_op.find(".") != -1) {
                int index=new_op.find(".");
                // cout<<new_op<<"--"<<endl;
                // cout<<op<<"--"<<endl;
                new_op =new_op.substr(0,index)+op+new_op.substr(index);
            } else {
               new_op += op;
            }
             new_instr = new_op + new_instr.substr(new_instr.find(' '));
            // cout<<"p:  "<<new_instr<<endl;
            new_instrList += new_instr;
            if (i + 1 < instrList.size()) {
                new_instrList += '\n';
            }
        }
        instr->u.OPER.assem = String(new_instrList.c_str());
        // printf("n:  %s\n", instr->u.OPER.assem);
    }
    Graph[pred_label].succ[0] = Graph[true_label].succ[0];
    Graph.erase(true_label);

    auto pred_block = label_block[pred_label];
    pred_block->succs->head = Graph[pred_label].succ[0];
    AS_instr instr = pred_block->instrs->ilist.back();
    instr->u.OPER.jumps->labels->head = Graph[pred_label].succ[0];

    pred_block->instrs->ilist.splice(--pred_block->instrs->ilist.end(), true_block->instrs->ilist, ++true_block->instrs->ilist.begin(), --true_block->instrs->ilist.end());
}

static void slove(AS_armblock2List bl) {
    for (auto it : bl->blist) {
        Temp_label pred_label = it->label;
        if (Graph.find(pred_label) == Graph.end()) {
            continue;
        }
        if (Graph[pred_label].succ.size() == 2) {
            Temp_label true_label = it->succs->head;
            if (Graph[true_label].pred.size() == 1 && Graph[true_label].succ.size() == 1) {
                int num = 0;
                bool isC = true;
                auto true_block = label_block[true_label];
                for (auto instr : true_block->instrs->ilist) {
                    if (instr->kind == AS_instr_::I_LABEL || (instr->kind == AS_instr_::I_OPER && instr->u.OPER.jumps)) {
                        continue;
                    }
                    if (isTranCon(instr)) {
                        num += get_num(instr);
                    } else {
                        isC = false;
                        break;
                    }
                    if (num > C_SIZE) {
                        isC = false;
                        break;
                    }
                }
                if (isC) {
                    // printf("%d\n",num);
                    tran_move(bl, pred_label, true_label);
                }
            }
        }
    }
    for (auto it = bl->blist.begin(); it != bl->blist.end();) {
        if (Graph.find((*it)->label) == Graph.end()) {
            it = bl->blist.erase(it);
        } else {
            ++it;
        }
    }
}

static AS_armblock2List condition_exec(AS_armblock2List blist) {
    init(blist);
    slove(blist);
    return blist;
}

AS_blockList condition_exec(AS_blockList bl) {
    AS_armblock2List blist = arm_single_2_double(bl);
    init(blist);
    slove(blist);
    bl = arm_double_2_single(blist);
    return bl;
}

AS_instrList condition_exec(AS_instrList il) {
    AS_instrList head = il, prev = NULL;
    int num = 0;
    for (; head; prev = head, head = head->tail) {
        if (strstr(head->head->u.OPER.assem, ":")) {
            num++;
        }
        if (num == 2) {
            break;
        }
    }
    // prev->tail = NULL;
    AS_armblock2List blockList = new struct AS_armblock2List_();
    AS_armblock2 block = NULL;
    for (; head; head = head->tail) {
        AS_instr instr = head->head;
        if (instr->kind == AS_instr_::I_LABEL) {
            if (block) {
                blockList->blist.push_back(block);
            }
            block = new struct AS_armblock2_();
            block->instrs = new struct AS_arminstr2List_();
            block->label = head->head->u.LABEL.label;
        }
        block->instrs->ilist.push_back(head->head);
        if ((instr->kind == AS_instr_::I_OPER && instr->u.OPER.jumps)) {
            block->succs = instr->u.OPER.jumps->labels;
        }
    }
    if (block) {
        blockList->blist.push_back(block);
    }

    blockList = condition_exec(blockList);

    for (auto it : blockList->blist) {
        for (auto instr : it->instrs->ilist) {
            prev->tail = AS_InstrList(instr, NULL);
            prev = prev->tail;
        }
    }
    return il;
}