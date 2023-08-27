#include <stdio.h>
#include <sys/time.h>
#include <fstream>
#include <iostream>
#include <list>
#include <unordered_map>
#include "ast.h"
#include "bg.h"
#include "bg2.h"
#include "bg_llvm.h"
#include "block_optimize.h"
#include "canon.h"
#include "deadce.h"
#include "domtree.h"
#include "elimilation_dc.h"
#include "flowgraph_llvm.h"
#include "fun_inline.h"
#include "gcm.h"
#include "gen_as.h"
#include "gen_as_arm.h"
#include "gvn.h"
#include "liveness_color.h"
#include "liveness_llvm.h"
#include "llvm_assemblock.h"
#include "looptree.h"
#include "mem2reg.h"
#include "naive_merge_ins.h"
#include "printast.h"
#include "prtreep.hpp"
#include "regalloc.h"
#include "ssa.h"
#include "temp.h"
#include "templabel.hpp"
#include "translate.hpp"
#include "treep.hpp"
#include "util.h"
#include "y.tab.hpp"
#include "mem2reg.h"
#include "elimilation_dc.h"
#include "remove_load.h"
#include "ins_schedule.h"
#include "liveness.h"
#include "flowgraph.h"
#include "condition_exec.h"
#include "purecache.hpp"

extern int yyparse();
A_prog root;
extern int yydebug;
static struct timeval start_time, end_time;
static double run_time;
std::string filename;

void print_time(const char *str = "", FILE *stream = stdout)
{
    gettimeofday(&end_time, NULL);
    run_time = (double)(int)(end_time.tv_sec - start_time.tv_sec) * 1000 +
               (double)(end_time.tv_usec - start_time.tv_usec) / 1000;
    fprintf(stream, "%s : %.3f ms\n", str, run_time);
}

void show(AS_instr ins, FILE *stream)
{
    FG_LLVM::FG_Showinfo(stream, ins, Temp_name());
}

int main(int argc, char *argv[])
{
    yydebug = 0;
    filename = argv[4];
    gettimeofday(&start_time, NULL);
    freopen(argv[4], "r", stdin);
    yyparse();
    // std::ofstream os(argv[2]);

    Temp_inittemp();

    FILE *LLVMstream;
    FILE *ARMstream;

    my_string LLVMname = makeLLVMfilename(argv[3]);
    my_string ARMname = argv[3];

    LLVMstream = fopen(LLVMname, "w");
    ARMstream = fopen(ARMname, "w");
    // std::ostream& os = std::cout;
    // printast::printProg(os, root);

    ast2irCompUnitList(root->cul, LLVMstream, ARMstream);
    pureCompUnitList(root->cul);
    T_funcDeclList fdl = ast2irCompUnitList2(root->cul, LLVMstream, ARMstream);
    // printFuncDeclList(os, fdl);
    // fprintf(LLVMstream, "---------------------\n\n");
    T_stm s;
    std::unordered_map<std::string, P_funList> fun_list;
    while (fdl)
    {
        s = fdl->head->stm;
        auto sl = canon::linearize(s);
        auto block = canon::basicBlocks(sl, fdl->head->name);
        auto sl_ = canon::traceSchedule(block);
        // printStmList(std::cout,sl_,0);
        auto block_ = canon::basicBlocks(sl_, fdl->head->name);

        // canon::printCBlock(os, block_);

        canon::C_stmListList block_llist = block_.llist;

        LLVM_IR::llvm_AS_blockList_ *bgabl = NULL;
        LLVM_IR::llvm_AS_blockList_ *bglast = NULL;
        LLVM_IR::llvm_AS_blockList_ *liveabl = NULL;
        LLVM_IR::llvm_AS_blockList_ *livelast = NULL;

        while (block_llist)
        {
            assert(block_llist->head);

            if (bglast)
                bglast = bglast->tail = AS_BlockList(AS_Block(gen_asList(block_llist->head)), NULL);
            else
                bglast = bgabl = AS_BlockList(AS_Block(gen_asList(block_llist->head)), NULL);
            if (livelast)
                livelast = livelast->tail = AS_BlockList(AS_Block(gen_asList(block_llist->head)), NULL);
            else
                livelast = liveabl = AS_BlockList(AS_Block(gen_asList(block_llist->head)), NULL);

            block_llist = block_llist->tail;
        }

        Temp_label this_label = Temp_namedlabel((my_string)block_.label.c_str());

        bglast = bglast->tail = AS_BlockList(AS_Block(gen_retInsList_llvm_ir(fdl->head->name, this_label)), NULL);
        livelast = livelast->tail = AS_BlockList(AS_Block(gen_retInsList_llvm_ir(fdl->head->name, this_label)), NULL);

        bgabl = AS_BlockList(gen_dummy_head(bgabl, fdl->head->args), bgabl);
        liveabl = AS_BlockList(gen_dummy_head(liveabl, fdl->head->args), liveabl);

        G_nodeList bg = BG_LLVM::Create_bg(bgabl);

        // Show_bg(LLVMstream, bg);

        SingleSourceGraph(bg->head, BG_LLVM::Bg_graph());
        LLVM_IR::T_irList_ *ail = AS_traceSchedule(liveabl, gen_prolog_llvm_ir(fdl->head->name, fdl->head->args), gen_epilog_llvm_ir(), FALSE);

        G_graph G = FG_LLVM::FG_AssemFlowGraph(ail);
        G_nodeList lg = LI_LLVM::Liveness(G_nodes(G));

        // LI_LLVM::Show_Liveness(LLVMstream, lg);

        Dominators(BG_LLVM::Bg_graph());
        computeDF(bg->head);
        getInOut(lg);
        PlacePhiFunc(BG_LLVM::Bg_graph());
        resetRename(fdl->head->args);
        Rename(bg->head);

        //**********************************
        // print before opt llvm ir

        bgabl = bglast = NULL;
        while (bg)
        { // regenerate bgabl cause i delete node in Bg_graph, and this should be my output
            assert(bg->head);
            if (bglast)
                bglast = bglast->tail = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            else
                bglast = bgabl = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            bg = bg->tail;
        }

        /******************************************************************************/
        // 优化
        AS_block2List tmp_bl = single_2_double(bgabl);

        tmp_bl = simple_DeadCD(tmp_bl, fdl->head->args);

        bg = G_nodes(BG_LLVM::Bg_graph());
        domtree::gen_dom_tree(bg->head);
        domtree::gen_label_block_map(tmp_bl);
        auto bg_ = BG_LLVM_2::Create_bg(tmp_bl);
        auto rootloop = looptree::gen_looptree(bg_, tmp_bl, BG_LLVM_2::Bg_graph());
        bg_ = BG_LLVM_2::Create_bg(tmp_bl);
        looptree::update_blockmap(bg_->head);
        domtree::gen_label_block_map(tmp_bl);
        for (int i = 0; i < 20; i++)
        {
            auto flag = gvn::gvn(tmp_bl, bg_->head);
            if (!flag)
            {
                break;
            }
        }
        gcm::gcm(tmp_bl, bg_->head);

        tmp_bl = cc_propagation(tmp_bl, fdl->head->args);
        remove_load::remove_load(tmp_bl);
        remove_load::naive_remove_load(tmp_bl);

        tmp_bl = cc_propagation(tmp_bl, fdl->head->args);
        tmp_bl = elimilation_DeadCD(tmp_bl);
        // tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        // tmp_bl = simple_DeadCD(tmp_bl, fdl->head->args);
        tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        tmp_bl = simple_DeadCD(tmp_bl, fdl->head->args);
        tmp_bl = block_Optimize(tmp_bl);

        // tmp_bl = cc_propagation(tmp_bl, fdl->head->args);
        remove_load::remove_load(tmp_bl);
        remove_load::naive_remove_load(tmp_bl);
        // tmp_bl = cc_propagation(tmp_bl, fdl->head->args);

        /******************************************************************************************/
        P_funList fun_tmp = new struct P_funList_(fdl->head->name, fdl->head->args, tmp_bl);
        fun_list.insert({fun_tmp->name, fun_tmp});
        fdl = fdl->tail;
    }

    fun_inline(fun_list);
    auto ret_map = mem2reg::mem2reg(fun_list);

    for (auto &fun : fun_list)
    {
        auto tmp_bl = fun.second->blockList;
        auto live_bl = mem2reg::deepcopy(tmp_bl);
        auto bgabl = double_2_single(tmp_bl);
        LLVM_IR::llvm_AS_blockList_ *bglast = NULL;
        auto bg = BG_LLVM::Create_bg(bgabl);
        auto liveabl = double_2_single(live_bl);
        SingleSourceGraph(bg->head, BG_LLVM::Bg_graph());
        LLVM_IR::T_irList_ *ail = AS_traceSchedule(liveabl, nullptr, gen_epilog_llvm_ir(), FALSE);

        G_graph G = FG_LLVM::FG_AssemFlowGraph(ail);
        // G_nodeList lg = LI_LLVM::Liveness(G_nodes(G));

        // LI_LLVM::Show_Liveness(LLVMstream, lg);

        Dominators(BG_LLVM::Bg_graph());
        computeDF(bg->head);
        auto phiTempMap = ret_map.find(fun.first)->second;
        PlacePhiFunc(BG_LLVM::Bg_graph(), phiTempMap);
        resetRename(fun.second->args);
        Rename(bg->head);
        bgabl = bglast = NULL;
        while (bg)
        {
            assert(bg->head);
            if (bglast)
                bglast = bglast->tail = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            else
                bglast = bgabl = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            bg = bg->tail;
        }

        fun.second->blockList = single_2_double(bgabl);
    }
    mem2reg::remove_mem(fun_list);
    remove_load::remove_global_arr(fun_list);
    for (auto& fun : fun_list) {
        auto tmp_bl = fun.second->blockList;
        tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = cc_propagation(tmp_bl, fun.second->args);
        tmp_bl = block_Optimize(tmp_bl);
        // tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        // tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        auto bgabl_ = double_2_single(fun.second->blockList);
        G_nodeList bg_tmp = BG_LLVM::Create_bg(bgabl_);
        SingleSourceGraph(bg_tmp->head, BG_LLVM::Bg_graph());
        Dominators(BG_LLVM::Bg_graph());
        tmp_bl = single_2_double(bgabl_);

        bg_tmp = G_nodes(BG_LLVM::Bg_graph());
        domtree::gen_dom_tree(bg_tmp->head);
        domtree::gen_label_block_map(tmp_bl);
        auto bg_ = BG_LLVM_2::Create_bg(tmp_bl);
        auto rootloop = looptree::gen_looptree(bg_, tmp_bl, BG_LLVM_2::Bg_graph());
        bg_ = BG_LLVM_2::Create_bg(tmp_bl);
        looptree::update_blockmap(bg_->head);
        domtree::gen_label_block_map(tmp_bl);
        for (int i = 0; i < 20; i++)
        {
            auto flag = gvn::gvn(tmp_bl, bg_->head);
            if (!flag)
            {
                break;
            }
        }
        gcm::gcm(tmp_bl, bg_->head);

        tmp_bl = cc_propagation(tmp_bl, fun.second->args);
        remove_load::remove_load(tmp_bl);
        remove_load::naive_remove_load(tmp_bl);

        tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = cc_propagation(tmp_bl, fun.second->args);
        tmp_bl = elimilation_DeadCD(tmp_bl);
        // tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        // tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = naive_merge_ins::merge_ins(tmp_bl);
        tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = block_Optimize(tmp_bl);

        fun.second->blockList = tmp_bl;
    }
    remove_load::remove_global_arr(fun_list);
    for (auto& fun : fun_list) {
        auto tmp_bl = fun.second->blockList;
        tmp_bl = simple_DeadCD(tmp_bl, fun.second->args);
        tmp_bl = block_Optimize(tmp_bl);
        fun.second->blockList = tmp_bl;
    }

    mem2reg::addr2reg(fun_list);

    for (auto &fun : fun_list)
    {
        G_nodeList bg;
        LLVM_IR::llvm_AS_blockList_ *bgabl = NULL;
        LLVM_IR::llvm_AS_blockList_ *bglast = NULL;
        LLVM_IR::T_irList_ *ail;
        looptree::gen_ins_nest_map(fun.second->blockList);
        bgabl = double_2_single(fun.second->blockList);

        /********************LLVM  ********************/
        // bg = BG_LLVM::Create_bg(bgabl);
        // bgabl = bglast = NULL;
        // while (bg) {  // regenerate bgabl cause i delete node in Bg_graph, and this should be my output
        //     assert(bg->head);
        //     if (bglast)
        //         bglast = bglast->tail = AS_BlockList((LLVM_IR::llvm_AS_block_*)bg->head->info, NULL);
        //     else
        //         bglast = bgabl = AS_BlockList((LLVM_IR::llvm_AS_block_*)bg->head->info, NULL);
        //     bg = bg->tail;
        // }
        // ail = AS_traceSchedule(bgabl, gen_prolog_llvm_ir(fun.second->name, fun.second->args), gen_epilog_llvm_ir(), FALSE);
        // AS_printInstrList_llvm(LLVMstream, LLVM_IR::irList_to_insList(ail), Temp_name());
        // fflush(LLVMstream);

        /********************LLVM  ********************/
        bg = BG_LLVM::Create_bg(bgabl);
        eliminatePhiFunc(BG_LLVM::Bg_graph());
        bgabl = bglast = NULL;
        while (bg)
        { // regenerate bgabl cause i delete node in Bg_graph, and this should be my output
            assert(bg->head);
            if (bglast)
                bglast = bglast->tail = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            else
                bglast = bgabl = AS_BlockList((LLVM_IR::llvm_AS_block_ *)bg->head->info, NULL);
            bg = bg->tail;
        }

        reset_localOffset_before_gen_arm();

        AS_blockList arm_bgabl = gen_arm_bgl(bgabl);
        AS_blockList arm_liveabl = gen_arm_bgl(bgabl);
        AS_instrList arm_liveail = AS_traceSchedule(arm_liveabl, gen_prolog_arm((my_string)fun.second->name.c_str(), fun.second->args), gen_epilog_arm(), FALSE);
        G_graph arm_G = FG_AssemFlowGraph(arm_liveail);
        G_nodeList lg = Liveness(G_nodes(arm_G));
        makeBBInOut(lg);

        // fprintf(stdout, "+++++ begin before schedule +++++\n");
        // AS_printInstrList(stdout, arm_liveail, Temp_name());
        // fprintf(stdout, "+++++ end before schedule +++++\n");

        for (AS_blockList tbl = arm_bgabl; tbl; tbl = tbl->tail)
        {
            buildDDG(tbl->head->instrs);
            // printf("%s:\n", Temp_labelstring(tbl->head->label));
            // dumpDDG(tbl->head->instrs);
            // you can not call insCombine here
            // cause insCombine will modify ins, make liveness expire
            // insCombine(tbl->head->instrs);
            tbl->head->instrs = scheduleIns(tbl->head->instrs);
            insCombine(tbl->head->instrs);
        }

        AS_instrList arm_ail = AS_traceSchedule(arm_bgabl, gen_prolog_arm((my_string)fun.second->name.c_str(), fun.second->args), gen_epilog_arm(), FALSE);

        // fprintf(ARMstream, "+++++ begin after schedule +++++\n");
        // AS_printInstrList(ARMstream, arm_ail, Temp_name());
        // fprintf(ARMstream, "+++++ end after schedule +++++\n");

        Temp_resettemp();
        init_colors((my_string)fun.second->name.c_str(), getFuncLength(arm_ail));
        init_regalloc((my_string)fun.second->name.c_str());
        RegAlloc(arm_ail, (my_string)fun.second->name.c_str(), fun.second->args);
        reset_sp(get_localOffset());

        arm_G = FG_AssemFlowGraph(arm_ail);
        lg = Liveness_color(G_nodes(arm_G));
        // Show_Liveness_color(stdout, lg);
        insCombine_color(arm_ail);
        arm_G = FG_AssemFlowGraph(arm_ail);
        lg = Liveness_color(G_nodes(arm_G));
        // Show_Liveness_color(stdout, lg);
        insCombine_color(arm_ail);
        arm_G = FG_AssemFlowGraph(arm_ail);
        lg = Liveness_color(G_nodes(arm_G));
        // Show_Liveness_color(stdout, lg);
        insCombine_color(arm_ail);
        arm_G = FG_AssemFlowGraph(arm_ail);
        lg = Liveness_color(G_nodes(arm_G));
        // Show_Liveness_color(stdout, lg);
        insCombine_color(arm_ail);

        // arm_ail = condition_exec(arm_ail);

        eliminateBnext(arm_ail);

        // arm_ail=condition_exec(arm_ail);     
        AS_printInstrList_colored(ARMstream, arm_ail, Temp_name());
    }

    fclose(LLVMstream);
    fclose(ARMstream);
    print_time("exit");
    return 0;
}