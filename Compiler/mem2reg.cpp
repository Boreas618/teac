#include <unordered_map>
#include <string>
#include <unordered_set>
#include <assert.h>
#include "mem2reg.h"
#include "translate.hpp"
#include <assert.h>
#include <string.h>

using namespace std;

static unordered_map<std::string,unordered_set<std::string>> func_mem_map;
static unordered_map<std::string,unordered_set<std::string>> func_use_mem_map;
static unordered_map<std::string,unordered_set<std::string>> func_def_mem_map;
static unordered_map<std::string,TempType> mem_type_map;
static unordered_map<std::string,AS_operand> mem_mem_map;

static AS_operand deepcopy(AS_operand op)
{
    auto new_op = new AS_operand_();
    switch (op->kind)
    {
    case AS_operand_::T_TEMP:
    {
        new_op->kind = AS_operand_::T_TEMP;
        auto new_temp = Temp_newtemp();
        new_temp->alias = op->u.TEMP->alias;
        new_temp->num = op->u.TEMP->num;
        new_temp->type = op->u.TEMP->type;
        new_op->u.TEMP = new_temp;
        break;
    }
    case AS_operand_::T_ICONST:
    {
        new_op->kind = AS_operand_::T_ICONST;
        new_op->u.ICONST = op->u.ICONST;
        break;
    }
    case AS_operand_::T_FCONST:
    {
        new_op->kind = AS_operand_::T_FCONST;
        new_op->u.FCONST = op->u.FCONST;
        break;
    }
    case AS_operand_::T_NAME:
    {
        new_op->kind = AS_operand_::T_NAME;
        new_op->u.NAME = op->u.NAME;
        break;
    }
    default:
        break;
    }
    return new_op;
}

static void gen_func_mem_map(std::unordered_map<std::string, P_funList> &fl)
{
    func_mem_map.clear();
    func_def_mem_map.clear();
    func_use_mem_map.clear();
    mem_mem_map.clear();
    mem_type_map.clear();
    for(auto &f : fl)
    {
        for(auto &b : f.second->blockList->blist)
        {
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
                {
                    if(ins->s->u.LOAD.ptr->kind == AS_operand_::T_NAME && (ins->s->u.LOAD.ptr->u.NAME.type == INT_PTR || ins->s->u.LOAD.ptr->u.NAME.type == FLOAT_PTR))
                    {
                        if(isglobalarr(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name)))
                        {
                            continue;
                        }
                        func_mem_map[f.second->name].emplace(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name));
                        func_use_mem_map[f.second->name].emplace(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name));
                        mem_type_map.emplace(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name),ins->s->u.LOAD.ptr->u.NAME.type);
                        mem_mem_map.emplace(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name),ins->s->u.LOAD.ptr);
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
                {
                    if(ins->s->u.STORE.ptr->kind == AS_operand_::T_NAME && (ins->s->u.STORE.ptr->u.NAME.type == INT_PTR || ins->s->u.STORE.ptr->u.NAME.type == FLOAT_PTR))
                    {
                        if(isglobalarr(Temp_labelstring(ins->s->u.STORE.ptr->u.NAME.name)))
                        {
                            continue;
                        }
                        func_mem_map[f.second->name].emplace(Temp_labelstring(ins->s->u.STORE.ptr->u.NAME.name));
                        func_def_mem_map[f.second->name].emplace(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name));
                        mem_type_map.emplace(Temp_labelstring(ins->s->u.STORE.ptr->u.NAME.name),ins->s->u.STORE.ptr->u.NAME.type);
                        mem_mem_map.emplace(Temp_labelstring(ins->s->u.STORE.ptr->u.NAME.name),ins->s->u.STORE.ptr);
                    }
                }
            }
        }
    }
}

static auto mem2reg_h(P_funList f)
{
    unordered_map<Temp_label,unordered_set<int>> value_reg;
    unordered_map<std::string,AS_operand> mem_temp_map;
    for(auto &s : func_mem_map[f->name])
    {
        if(mem_type_map[s] == INT_PTR)
        {
            mem_temp_map[s] = AS_Operand_Temp_NewTemp();
        }
        else if(mem_type_map[s] == FLOAT_PTR)
        {
            mem_temp_map[s] = AS_Operand_Temp_NewFloatTemp();
        }
    }
    for(auto &b : f->blockList->blist)
    {
        for(auto &ins : b->instrs->ilist)
        {
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_LOAD)
            {
                if(ins->s->u.LOAD.ptr->kind == AS_operand_::T_NAME)
                {
                    if(mem_temp_map.find(Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name)) != mem_temp_map.end())
                    {
                        auto dst_temp = ins->s->u.LOAD.dst;
                        auto src_temp = deepcopy(mem_temp_map[Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name)]);
                        value_reg[b->label].emplace(src_temp->u.TEMP->num);
                        ins->s = LLVM_IR::T_Move(dst_temp,src_temp);
                        char as[10000];
                        if(dst_temp->u.TEMP->type == INT_TEMP)
                        {
                            sprintf(as,"`d0 = bitcast i32 `s0 to i32");
                        }
                        else if(dst_temp->u.TEMP->type == FLOAT_TEMP)
                        {
                            sprintf(as,"`d0 = bitcast float `s0 to float");
                        }
                        else
                        {
                            assert(0);
                        }
                        ins->i = AS_Move(String(as),AS_OperandList(dst_temp,nullptr),AS_OperandList(src_temp,nullptr));
                    }
                } 
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
            {
                if(ins->s->u.STORE.ptr->kind == AS_operand_::T_NAME)
                {
                    if(mem_temp_map.find(Temp_labelstring(ins->s->u.STORE.ptr->u.NAME.name)) != mem_temp_map.end())
                    {
                        auto src_temp = ins->s->u.STORE.src;
                        auto dst_temp = deepcopy(mem_temp_map[Temp_labelstring(ins->s->u.LOAD.ptr->u.NAME.name)]);
                        value_reg[b->label].emplace(dst_temp->u.TEMP->num);
                        ins->s = LLVM_IR::T_Move(dst_temp,src_temp);
                        char as[10000];
                        if(src_temp->kind == AS_operand_::T_TEMP)
                        {
                            if(src_temp->u.TEMP->type == INT_TEMP)
                            {
                                sprintf(as,"`d0 = bitcast i32 `s0 to i32");
                            }
                            else if(src_temp->u.TEMP->type == FLOAT_TEMP)
                            {
                                sprintf(as,"`d0 = bitcast float `s0 to float");
                            }
                            else
                            {
                                assert(0);
                            }
                            ins->i = AS_Move(String(as),AS_OperandList(dst_temp,nullptr),AS_OperandList(src_temp,nullptr));
                        }
                        else if(src_temp->kind == AS_operand_::T_ICONST)
                        {
                            sprintf(as,"`d0 = bitcast i32 `s0 to i32");
                            ins->i = AS_Oper(String(as),AS_OperandList(dst_temp,nullptr),AS_OperandList(src_temp,nullptr),nullptr);
                        }
                        else if(src_temp->kind == AS_operand_::T_FCONST)
                        {
                            sprintf(as,"`d0 = bitcast float `s0 to i32");
                            ins->i = AS_Oper(String(as),AS_OperandList(dst_temp,nullptr),AS_OperandList(src_temp,nullptr),nullptr);
                        }
                        else
                        {
                            assert(0);
                        }
                    }
                }   
            }
        }
    }
    auto fb = f->blockList->blist.front();
    auto f_it = fb->instrs->ilist.begin();
    while ((*f_it)->i->kind == AS_instr_::I_LABEL)
    {
        ++f_it;
    }
    
    for(auto &p : mem_temp_map)
    {
        auto mem = mem_mem_map[p.first];
        auto temp_op = deepcopy(p.second);
        value_reg[fb->label].emplace(temp_op->u.TEMP->num);
        auto new_s = LLVM_IR::T_Load(temp_op,mem);
        AS_instr new_i = nullptr;
        if(mem->u.NAME.type == INT_PTR)
        {
            new_i = AS_Oper(String("`d0 = load i32,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
        }
        else if(mem->u.NAME.type == FLOAT_PTR)
        {
            new_i = AS_Oper(String("`d0 = load float,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
        }
        else
        {
            assert(0);
        }
        auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
        fb->instrs->ilist.insert(f_it,new_ir);
    }
    for(auto &b : f->blockList->blist)
    {
        for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
        {
            auto ins = *it;
            if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_RETURN)
            {
                for(auto &p : mem_temp_map)
                {
                    auto mem = mem_mem_map[p.first];
                    auto temp_op = deepcopy(p.second);
                    value_reg[b->label].emplace(temp_op->u.TEMP->num);
                    auto new_s = LLVM_IR::T_Store(temp_op,mem);
                    AS_instr new_i = nullptr;
                    if(mem->u.NAME.type == INT_PTR)
                    {
                        new_i = AS_Oper(String("store i32 `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                    }
                    else if(mem->u.NAME.type == FLOAT_PTR)
                    {
                        new_i = AS_Oper(String("store float `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                    }
                    else
                    {
                        assert(0);
                    }
                    auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                    if(f->name == "main")
                        new_ir->remove = true;
                    b->instrs->ilist.insert(it,new_ir);
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_VOID_CALL)
            {
                for(auto &p : mem_temp_map)
                {
                    if(func_use_mem_map.find(ins->s->u.VOID_CALL.fun) != func_use_mem_map.end())
                    {
                        if(func_use_mem_map[ins->s->u.VOID_CALL.fun].find(p.first) != func_use_mem_map[ins->s->u.VOID_CALL.fun].end())
                        {
                            auto mem = mem_mem_map[p.first];
                            auto temp_op = deepcopy(p.second);
                            value_reg[b->label].emplace(temp_op->u.TEMP->num);
                            auto new_s = LLVM_IR::T_Store(temp_op,mem);
                            AS_instr new_i = nullptr;
                            if(mem->u.NAME.type == INT_PTR)
                            {
                                new_i = AS_Oper(String("store i32 `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                            }
                            else if(mem->u.NAME.type == FLOAT_PTR)
                            {
                                new_i = AS_Oper(String("store float `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                            }
                            else
                            {
                                assert(0);
                            }
                            auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                            b->instrs->ilist.insert(it,new_ir);
                        }
                    }
                    if(func_def_mem_map.find(ins->s->u.VOID_CALL.fun) != func_def_mem_map.end())
                    {
                        if(func_def_mem_map[ins->s->u.VOID_CALL.fun].find(p.first) != func_def_mem_map[ins->s->u.VOID_CALL.fun].end())
                        {
                            auto mem = mem_mem_map[p.first];
                            auto temp_op = deepcopy(p.second);
                            auto next_it = it;++next_it;
                            value_reg[b->label].emplace(temp_op->u.TEMP->num);
                            auto new_next_s = LLVM_IR::T_Load(temp_op,mem);
                            AS_instr new_next_i = nullptr;
                            if(mem->u.NAME.type == INT_PTR)
                            {
                                new_next_i = AS_Oper(String("`d0 = load i32,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
                            }
                            else if(mem->u.NAME.type == FLOAT_PTR)
                            {
                                new_next_i = AS_Oper(String("`d0 = load float,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
                            }
                            else
                            {
                                assert(0);
                            }
                            auto new_next_ir = LLVM_IR::T_Ir(new_next_s,new_next_i);
                            b->instrs->ilist.insert(next_it,new_next_ir);
                        }
                    }
                }
            }
            else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_CALL)
            {
                for(auto &p : mem_temp_map)
                {
                    if(func_use_mem_map.find(ins->s->u.CALL.fun) != func_use_mem_map.end())
                    {
                        if(func_use_mem_map[ins->s->u.CALL.fun].find(p.first) != func_use_mem_map[ins->s->u.CALL.fun].end())
                        {
                            auto mem = mem_mem_map[p.first];
                            auto temp_op = deepcopy(p.second);
                            value_reg[b->label].emplace(temp_op->u.TEMP->num);
                            auto new_s = LLVM_IR::T_Store(temp_op,mem);
                            AS_instr new_i = nullptr;
                            if(mem->u.NAME.type == INT_PTR)
                            {
                                new_i = AS_Oper(String("store i32 `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                            }
                            else if(mem->u.NAME.type == FLOAT_PTR)
                            {
                                new_i = AS_Oper(String("store float `s0,ptr `s1"),nullptr,AS_OperandList(temp_op,AS_OperandList(mem,nullptr)),nullptr);
                            }
                            else
                            {
                                assert(0);
                            }
                            auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
                            b->instrs->ilist.insert(it,new_ir);
                        }
                    }
                    if(func_def_mem_map.find(ins->s->u.CALL.fun) != func_def_mem_map.end())
                    {
                        if(func_def_mem_map[ins->s->u.CALL.fun].find(p.first) != func_def_mem_map[ins->s->u.CALL.fun].end())
                        {
                            auto mem = mem_mem_map[p.first];
                            auto temp_op = deepcopy(p.second);
                            auto next_it = it;++next_it;
                            value_reg[b->label].emplace(temp_op->u.TEMP->num);
                            auto new_next_s = LLVM_IR::T_Load(temp_op,mem);
                            AS_instr new_next_i = nullptr;
                            if(mem->u.NAME.type == INT_PTR)
                            {
                                new_next_i = AS_Oper(String("`d0 = load i32,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
                            }
                            else if(mem->u.NAME.type == FLOAT_PTR)
                            {
                                new_next_i = AS_Oper(String("`d0 = load float,ptr `s0"),AS_OperandList(temp_op,nullptr),AS_OperandList(mem,nullptr),nullptr);
                            }
                            else
                            {
                                assert(0);
                            }
                            auto new_next_ir = LLVM_IR::T_Ir(new_next_s,new_next_i);
                            b->instrs->ilist.insert(next_it,new_next_ir);
                        }
                    }
                }
            }
        }
    }
    return value_reg;
}

unordered_map<std::string,unordered_map<Temp_label,unordered_set<int>>> mem2reg::mem2reg(std::unordered_map<std::string, P_funList> &fl)
{
    gen_func_mem_map(fl);
    unordered_map<std::string,unordered_map<Temp_label,unordered_set<int>>> ret;
    for(auto &f : fl)
    {
        auto r = mem2reg_h(f.second);
        ret.emplace(f.first,r);
    }
    return ret;
}


AS_block2List mem2reg::deepcopy(AS_block2List bl)
{ 
    auto new_bl = new struct AS_block2List_();
    for (auto &b : bl->blist) {
        auto new_b = new AS_block2_();
        new_b->label = b->label;
        new_b->succs = b->succs;
        AS_instr2List instrsList = new struct AS_instr2List_();
        for (auto &ins : b->instrs->ilist) {
            AS_instr new_instr = NULL;
            LLVM_IR::llvm_T_stm_ *new_s = NULL;
            AS_operandList new_dst = NULL, new_src = NULL;
            AS_targets new_jumps = NULL;
            Temp_label new_label = NULL;
            switch (ins->i->kind) {
                case AS_instr_::I_OPER: {
                    AS_operandList dst, src;
                    dst = ins->i->u.OPER.dst;
                    src = ins->i->u.OPER.src;
                    AS_targets jumps = ins->i->u.OPER.jumps;
                    list<AS_operand> dst_list, src_list;
                    for (; dst; dst = dst->tail) {
                        AS_operand operand = deepcopy(dst->head);
                        dst_list.push_back(operand);
                    }
                    while (!dst_list.empty()) {
                        new_dst = AS_OperandList(dst_list.back(), new_dst);
                        dst_list.pop_back();
                    }
                    for (; src; src = src->tail) {
                        AS_operand operand = deepcopy(src->head);
                        src_list.push_back(operand);
                    }
                    while (!src_list.empty()) {
                        new_src = AS_OperandList(src_list.back(), new_src);
                        src_list.pop_back();
                    }

                    new_jumps = jumps;
                    new_instr = AS_Oper(String(ins->i->u.OPER.assem), new_dst, new_src, new_jumps);
                } break;
                case AS_instr_::I_LABEL: {
                    new_label = ins->i->u.LABEL.label;
                    new_instr = AS_Label(String(ins->i->u.LABEL.assem), new_label);
                } break;
                case AS_instr_::I_MOVE: {
                    AS_operandList dst, src;
                    dst = ins->i->u.OPER.dst;
                    src = ins->i->u.OPER.src;
                    list<AS_operand> dst_list, src_list;
                    for (; dst; dst = dst->tail) {
                        AS_operand operand = deepcopy(dst->head);
                        dst_list.push_back(operand);
                    }
                    while (!dst_list.empty()) {
                        new_dst = AS_OperandList(dst_list.back(), new_dst);
                        dst_list.pop_back();
                    }
                    for (; src; src = src->tail) {
                        AS_operand operand = deepcopy(src->head);
                        src_list.push_back(operand);
                    }
                    while (!src_list.empty()) {
                        new_src = AS_OperandList(src_list.back(), new_src);
                        src_list.pop_back();
                    }
                    new_instr = AS_Move(String(ins->i->u.MOVE.assem), new_dst, new_src);
                } break;
            }
            switch (ins->s->kind) {
                case LLVM_IR::llvm_T_stm_::T_BINOP: {
                    new_s = LLVM_IR::T_Binop(ins->s->u.BINOP.op, new_dst->head, new_src->head, new_src->tail->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_INTTOPTR: {
                    new_s = LLVM_IR::T_InttoPtr(new_dst->head, new_src->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_PTRTOINT: {
                    new_s = LLVM_IR::T_PtrtoInt(new_dst->head, new_src->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_LOAD: {
                    new_s = LLVM_IR::T_Load(new_dst->head, new_src->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_STORE: {
                    new_s = LLVM_IR::T_Store(new_src->head, new_src->tail->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_LABEL: {
                    new_s = LLVM_IR::T_Label(new_label);
                } break;
                case LLVM_IR::llvm_T_stm_::T_JUMP: {
                    new_s = LLVM_IR::T_Jump(new_jumps->labels->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_CMP: {
                    new_s = LLVM_IR::T_Cmp(ins->s->u.CMP.op, new_src->head, new_src->tail->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_CJUMP: {
                    new_s = LLVM_IR::T_Cjump(ins->s->u.CJUMP.op, new_jumps->labels->head, new_jumps->labels->tail->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_MOVE: {
                    if (new_src) {
                        new_s = LLVM_IR::T_Move(new_dst->head, new_src->head);
                    } else {
                        printf("%s\n",ins->i->u.OPER.assem);
                        if(!strcmp("`d0 = bitcast ptr @AaBbcCL2 to ptr", ins->i->u.OPER.assem)){
                            assert(ins->i->u.OPER.src);
                        }
                        assert(0);
                        new_s = LLVM_IR::T_Move(new_dst->head, NULL);
                    }
                } break;
                case LLVM_IR::llvm_T_stm_::T_CALL: {
                    new_s = LLVM_IR::T_Call(String(ins->s->u.CALL.fun), new_dst->head, new_src);
                } break;
                case LLVM_IR::llvm_T_stm_::T_VOID_CALL: {
                    new_s = LLVM_IR::T_VoidCall(String(ins->s->u.CALL.fun), new_src);
                } break;
                case LLVM_IR::llvm_T_stm_::T_RETURN: {
                    if (new_src) {
                        new_s = LLVM_IR::T_Return(new_src->head);
                    } else {
                        new_s = LLVM_IR::T_Return(NULL);
                    }
                } break;
                case LLVM_IR::llvm_T_stm_::T_PHI: {
                    new_s = LLVM_IR::T_Phi(new_dst->head, new_jumps->labels, new_src);
                } break;
                case LLVM_IR::llvm_T_stm_::T_NULL: {
                    new_s = LLVM_IR::T_Null();
                } break;
                case LLVM_IR::llvm_T_stm_::T_ALLOCA: {
                    new_s = LLVM_IR::T_Alloca(new_dst->head, ins->s->u.ALLOCA.size, ins->s->u.ALLOCA.isIntArr);
                } break;
                case LLVM_IR::llvm_T_stm_::T_I2F: {
                    new_s = LLVM_IR::T_I2f(new_dst->head, new_src->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_F2I: {
                    new_s = LLVM_IR::T_F2i(new_dst->head, new_src->head);
                } break;
                case LLVM_IR::llvm_T_stm_::T_GEP: {
                    new_s = LLVM_IR::T_Gep(new_dst->head, new_src->head, new_src->tail->head);
                } break;
            }
            instrsList->ilist.push_back(T_Ir(new_s, new_instr));
        }
        new_b->instrs = instrsList;
        new_bl->blist.push_back(new_b);
    }
    return new_bl;
}

void mem2reg::remove_mem(std::unordered_map<std::string, P_funList> &fl)
{
    for(auto &f : fl)
    {
        for(auto &b : f.second->blockList->blist)
        {
            for(auto it = b->instrs->ilist.begin();it != b->instrs->ilist.end();++it)
            {
                auto &ins = *it;
                if(ins->remove && ins->s->kind == LLVM_IR::llvm_T_stm_::T_STORE)
                {
                    it = b->instrs->ilist.erase(it);
                }
            }
        }
    }
}

void mem2reg::addr2reg(std::unordered_map<std::string, P_funList> &fl)
{
    unordered_map<std::string,unordered_set<std::string>> func_addr_map;
    unordered_map<std::string,TempType> addr_type_map;
    unordered_map<std::string,AS_operand> addr_mem_map;
    for(auto &f : fl)
    {
        for(auto &b : f.second->blockList->blist)
        {
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                {
                    if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
                    {
                        if(!isglobalarr(Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name)))
                        {
                            continue;
                        }
                        func_addr_map[f.first].emplace(Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name));
                        addr_type_map.emplace(Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name),ins->s->u.GEP.base_ptr->u.NAME.type);
                        addr_mem_map.emplace(Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name),ins->s->u.GEP.base_ptr);
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                {
                    if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                    {
                        if(!isglobalarr(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name)))
                        {
                            continue;
                        }
                        func_addr_map[f.first].emplace(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name));
                        addr_type_map.emplace(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name),ins->s->u.MOVE.src->u.NAME.type);
                        addr_mem_map.emplace(Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name),ins->s->u.MOVE.src);
                    }
                }
            }
        }
    }
    for(auto &f : fl)
    {
        unordered_map<std::string,AS_operand> addr_temp_map;
        for(auto &s : func_addr_map[f.first])
        {
            if(addr_type_map[s] == INT_PTR)
            {
                addr_temp_map.emplace(s,AS_Operand_Temp_NewIntPtrTemp());
            }
            else if(addr_type_map[s] == FLOAT_PTR)
            {
                addr_temp_map.emplace(s,AS_Operand_Temp_NewFloatPtrTemp());
            }
            else
            {
                assert(0);
            }
        }
        for(auto &b : f.second->blockList->blist)
        {
            for(auto &ins : b->instrs->ilist)
            {
                if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_GEP)
                {
                    if(ins->s->u.GEP.base_ptr->kind == AS_operand_::T_NAME)
                    {
                        std::string name = Temp_labelstring(ins->s->u.GEP.base_ptr->u.NAME.name);
                        if(func_addr_map[f.first].find(name) != func_addr_map[f.first].end())
                        {
                            ins->s->u.GEP.base_ptr = addr_temp_map[name];
                            ins->i->u.OPER.src->head = addr_temp_map[name];
                        }
                    }
                }
                else if(ins->s->kind == LLVM_IR::llvm_T_stm_::T_MOVE)
                {
                    if(ins->s->u.MOVE.src->kind == AS_operand_::T_NAME)
                    {
                        std::string name = Temp_labelstring(ins->s->u.MOVE.src->u.NAME.name);
                        if(func_addr_map[f.first].find(name) != func_addr_map[f.first].end())
                        {
                            ins->s->u.MOVE.src = addr_temp_map[name];
                            ins->i->u.MOVE.src->head = addr_temp_map[name];
                        }
                    }
                }
            }
        }
        auto fb = f.second->blockList->blist.front();
        auto f_it = fb->instrs->ilist.begin();
        while ((*f_it)->i->kind == AS_instr_::I_LABEL)
        {
            ++f_it;
        }
        
        for(auto &p : addr_temp_map)
        {
            auto mem = addr_mem_map[p.first];
            auto new_s = LLVM_IR::T_Move(p.second,mem);
            AS_instr new_i = AS_Move(String("`d0 = bitcast ptr `s0 to ptr"),AS_OperandList(p.second,nullptr),AS_OperandList(mem,nullptr));
            auto new_ir = LLVM_IR::T_Ir(new_s,new_i);
            fb->instrs->ilist.insert(f_it,new_ir);
        }
    }
}