#include "llvm_ir.h"
#include "asm_arm.h"
#include "temp.h"
#include "llvm2asm.h"
#include "allocReg.h"
#include <queue>
#include <cassert>
#include <iostream>
#include "printASM.h"
#include "printLLVM.h"
#include "register_rules.h"
using namespace std;
using namespace LLVMIR;
using namespace ASM;

#define INSERT1() printf("%s:%d\n", __FILE__, __LINE__);
static int stack_frame;
static bool alloc_frame = false;
struct StructDef
{
    std::vector<int> offset;
    int size;
    StructDef(std::vector<int> _offset, int _size) : offset(_offset), size(_size) {}
    // 打印函数
    void print() const
    {
        std::cerr << "Offsets: ";
        for (const auto &val : offset)
        {
            std::cerr << val << " ";
        }
        std::cerr << "\nSize: " << size << std::endl;
    }
};

static AS_reg *sp = new AS_reg(AS_type::SP, -1);
static unordered_map<int, AS_address *> ptrMap;
static unordered_map<int, AS_relopkind> condMap;
static unordered_map<string, StructDef *> structLayout;
int getMemLength(TempDef &members)
{
    switch (members.kind)
    {
    case TempType::INT_PTR:
        return 8 * members.len;
        break;
    case TempType::INT_TEMP:
        return 8;
        break;
    case TempType::STRUCT_PTR:
        // printf("%d\n", structLayout[members.structname]->size);
        return structLayout[members.structname]->size * members.len;
        break;
    case TempType::STRUCT_TEMP:
        // printf("%d\n", structLayout[members.structname]->size);

        return structLayout[members.structname]->size;
        break;
    default:
        assert(0);
    }
}
void structLayoutInit(vector<L_def *> &defs)
{
    for (const auto &def : defs)
    {
        switch (def->kind)
        {
        case L_DefKind::SRT:
        {
            StructDef *structdef = new StructDef(std::vector<int>(), 0);

            // Fixme: add here
            // 所有结构的体的定义，每个域只有整形值，不考虑结构题中有数组或嵌套其他结构体。但我们允许声明一个变量为结构体数组（但不能在域内）。
            for (auto x : def->u.SRT->members)
            {
                structdef->offset.push_back(structdef->size);
                structdef->size += getMemLength(x);
            }
            structdef->print();
            structLayout[def->u.SRT->name] = structdef;
        }
        case L_DefKind::GLOBAL:
        {
            break;
        }
        case L_DefKind::FUNC:
        {
            break;
        }
        }
    }
}

void set_stack(L_func &func)
{
    // Fixme: add here
    stack_frame = 0;
    for (auto &x : func.blocks)
    {
        for (auto &y : x->instrs)
        {
            if (y->type == L_StmKind::T_ALLOCA)
            {
                auto alloca = y->u.ALLOCA->dst->u.TEMP;
                switch (alloca->type)
                {
                case TempType::INT_PTR:

                    ptrMap.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame - INT_LENGTH));
                    stack_frame += max(8, 8 * alloca->len);

                    // printf("alloca->len:%d,INT_PTR,stack_frame:%d\n", alloca->len,stack_frame);

                    break;
                case TempType::INT_TEMP:
                    assert(0);
                    break;
                case TempType::STRUCT_PTR:
                {
                    int temp = structLayout[alloca->structname]->size;
                    ptrMap.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame - INT_LENGTH));
                    stack_frame += max(temp, temp * alloca->len);

                    // printf("temp:%d,STRUCT_PTR.stack_frame:%d\n",temp, stack_frame);

                    break;
                }

                case TempType::STRUCT_TEMP:
                    ptrMap.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame - INT_LENGTH));
                    stack_frame += structLayout[alloca->structname]->size;

                    // printf("STRUCT_TEMP.stack_frame:%d\n", stack_frame);

                    break;
                }
            }
        }
    }

    stack_frame = ((stack_frame + 15) >> 4) << 4;
    for (auto &x : ptrMap)
    {
        // printf("%r%d %s\n", x.first, printAS_add(x.second).c_str());
    }
}

void new_frame(list<AS_stm *> &as_list, L_func &func)
{
    // Fixme: add here
    as_list.emplace_back(AS_Binop(AS_binopkind::SUB_, sp, new AS_reg(AS_type::IMM, stack_frame), sp));
    int i = 0;

    for (auto x : func.args)
    {
        as_list.emplace_back(AS_Mov(new AS_reg(AS_type::Xn, i), new AS_reg(AS_type::Xn, x->num)));
        i += 1;
    }
}

void free_frame(list<AS_stm *> &as_list)
{
    as_list.emplace_back(AS_Mov(new AS_reg(AS_type::Xn, XnFP), sp));
}
void allignPtr(AS_reg *&op_reg, AS_operand *as_operand, list<AS_stm *> &as_list)
{
    switch (as_operand->kind)
    {
    case OperandKind::TEMP:
    {
        if (ptrMap.find(as_operand->u.TEMP->num) != ptrMap.end())
        {
            auto ptr_fp = ptrMap[as_operand->u.TEMP->num];
            auto teg = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
            auto base = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);

            as_list.push_back(AS_Mov(new AS_reg(AS_type::IMM, ptr_fp->imm), teg));
            as_list.push_back(AS_Binop(AS_binopkind::ADD_, new AS_reg(AS_type::Xn, XnFP), teg, base));
            op_reg = new AS_reg(AS_type::ADR, new AS_address(base, 0));
        }
        else
        {
            op_reg = new AS_reg(AS_type::ADR, new AS_address(new AS_reg(AS_type::Xn, as_operand->u.TEMP->num), 0));
            // 计算出来的和函数参数中的
        }
        break;
    }
    case OperandKind::NAME:
    {
        auto Xn = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        op_reg = new AS_reg(AS_type::ADR, new AS_address(Xn, 0));
        as_list.push_back(AS_Adr(new AS_label(as_operand->u.NAME->name->name), Xn));
        break;
    }
    case OperandKind::ICONST:
    {
        assert(0);
        break;
    }

        /* code */

    default:
        assert(0);

        break;
    }
    // printf("%s\n", printAS_reg(op_reg).c_str());
}
void allignLeftvRight2(AS_reg *&op_reg, AS_operand *as_operand)
{
    switch (as_operand->kind)
    {
    case OperandKind::ICONST:
    {
        // store from the const: str #1, ...
        // do not need to move the instant into reg, use #1 directly
        int instant = as_operand->u.ICONST;
        op_reg = new AS_reg(AS_type::IMM, instant);
        break;
    }
    case OperandKind::TEMP:
    {
        // store from the reg: str x, ...
        int src_num = as_operand->u.TEMP->num;
        op_reg = new AS_reg(AS_type::Xn, src_num);
        break;
    }
    case OperandKind::NAME:
    {
        assert(0);
    }
    }
}
void allignLeftvRight(AS_reg *&op_reg, AS_operand *as_operand, list<AS_stm *> &as_list)
{
    switch (as_operand->kind)
    {
    case OperandKind::ICONST:
    {

        // store from the const: str #1, ...
        // move the instant into x2: mov x2, #1
        int instant = as_operand->u.ICONST;
        AS_reg *src_mov = new AS_reg(AS_type::IMM, instant);
        INSERT1();
        AS_reg *dst_mov = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        as_list.push_back(AS_Mov(src_mov, dst_mov));
        op_reg = dst_mov;

        break;
    }
    case OperandKind::TEMP:
    {

        // store from the reg directly: str x, ...
        int src_num = as_operand->u.TEMP->num;
        if (as_operand->u.TEMP->len != 0)
        {
            allignPtr(op_reg, as_operand, as_list);
            op_reg = op_reg->u.add->base;
        }
        else
        {
            op_reg = new AS_reg(AS_type::Xn, src_num);
        }
        break;
    }
    case OperandKind::NAME:
    {
        auto Xn = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        auto Xn2 = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        as_list.push_back(AS_Adr(new AS_label(as_operand->u.NAME->name->name), Xn));
        as_list.push_back(AS_Ldr(Xn2, new AS_reg(AS_type::ADR, new AS_address(Xn, 0))));
        op_reg = Xn;
    }
    }
}
void llvm2asmBinop(list<AS_stm *> &as_list, L_stm *binop_stm)
{
    AS_reg *left;
    AS_reg *right;
    AS_reg *dst;
    AS_binopkind op;
    AS_binopkind temp[] = {AS_binopkind::ADD_, AS_binopkind::SUB_, AS_binopkind::MUL_, AS_binopkind::SDIV_};
    op = temp[static_cast<int>(binop_stm->u.BINOP->op)];
    switch (binop_stm->u.BINOP->op)
    {
    case L_binopKind::T_plus:
    case L_binopKind::T_minus:
    {
        INSERT1();
        allignLeftvRight(left, binop_stm->u.BINOP->left, as_list);
        allignLeftvRight2(right, binop_stm->u.BINOP->right);

        break;
    }

    case L_binopKind::T_mul:
    case L_binopKind::T_div:
    {
        allignLeftvRight(left, binop_stm->u.BINOP->left, as_list);
        allignLeftvRight(right, binop_stm->u.BINOP->right, as_list);
        break;
    }
    }

    // Fixme: add here
    dst = new AS_reg(AS_type::Xn, binop_stm->u.BINOP->dst->u.TEMP->num);
    as_list.push_back(AS_Binop(op, left, right, dst));
}

void llvm2asmLoad(list<AS_stm *> &as_list, L_stm *load_stm)
{
    AS_reg *dst;
    AS_reg *ptr;
    dst = new AS_reg(AS_type::Xn, load_stm->u.LOAD->dst->u.TEMP->num);
    // Fixme: add here
    allignPtr(ptr, load_stm->u.LOAD->ptr, as_list);
    as_list.push_back(AS_Ldr(dst, ptr));
}

void llvm2asmStore(list<AS_stm *> &as_list, L_stm *store_stm)
{
    AS_reg *src;
    AS_reg *ptr;

    allignLeftvRight(src, store_stm->u.STORE->src, as_list);
    // Fixme: add here

    allignPtr(ptr, store_stm->u.STORE->ptr, as_list);
    as_list.push_back(AS_Str(src, ptr));
}

void llvm2asmCmp(list<AS_stm *> &as_list, L_stm *cmp_stm)
{
    // Fixme: add here
    AS_reg *left;
    AS_reg *right;
    AS_relopkind temp[] = {AS_relopkind::EQ_,
                           AS_relopkind::NE_,
                           AS_relopkind::LT_,
                           AS_relopkind::GT_,
                           AS_relopkind::LE_,
                           AS_relopkind::GE_};
    allignLeftvRight(left, cmp_stm->u.CMP->left, as_list);

    allignLeftvRight(right, cmp_stm->u.CMP->right, as_list);
    condMap[cmp_stm->u.CMP->dst->u.TEMP->num] = temp[static_cast<int>(cmp_stm->u.CMP->op)];
    as_list.push_back(AS_Cmp(left, right));
}
void llvm2asmMov(list<AS_stm *> &as_list, L_stm *mov_stm)
{
    AS_reg* src;
    allignLeftvRight(src,mov_stm->u.MOVE->src,as_list);
    assert(mov_stm->u.MOVE->dst->kind==OperandKind::TEMP);
    as_list.push_back(AS_Mov(src, new AS_reg(AS_type::Xn, mov_stm->u.MOVE->dst->u.TEMP->num)));
}
void llvm2asmCJmp(list<AS_stm *> &as_list, L_stm *cjmp_stm)
{
    // Fixme: add here
    as_list.push_back(AS_BCond(condMap[cjmp_stm->u.CJUMP->dst->u.TEMP->num], new AS_label(cjmp_stm->u.CJUMP->true_label->name)));
    as_list.push_back(AS_B(new AS_label(cjmp_stm->u.CJUMP->false_label->name)));
}

void llvm2asmRet(list<AS_stm *> &as_list, L_stm *ret_stm)
{
    // Fixme: add here
    if (ret_stm->type == L_StmKind::T_RETURN && ret_stm->u.RET->ret != nullptr)
    {
        auto call = ret_stm->u.RET;
        AS_reg *res;
        if (call->ret)
            allignLeftvRight(res, call->ret, as_list);
        as_list.emplace_back(AS_Mov(res, new AS_reg(AS_type::Xn, XXnret)));
    }
    free_frame(as_list);

    as_list.push_back(AS_Ret());
}

void llvm2asmGep(list<AS_stm *> &as_list, L_stm *gep_stm)
{
    // Fixme: add here
    AS_reg *new_ptr;
    AS_reg *base_ptr;
    AS_reg *index_;
    auto gep = gep_stm->u.GEP;
    new_ptr = new AS_reg(AS_type::Xn, gep->new_ptr->u.TEMP->num);
    // allignPtr(base_ptr, gep->base_ptr, as_list, XXn1);
    //
    int bits = 0;

    TempType ttemp;
    if (gep->base_ptr->kind == OperandKind::TEMP)
    {
        ttemp = gep->base_ptr->u.TEMP->type;
    }
    else
    {
        ttemp = gep->base_ptr->u.NAME->type;
    }
    switch (ttemp)
    {
    case TempType::INT_PTR:
    {
        allignLeftvRight(index_, gep->index, as_list);
        auto temp = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        auto res = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        as_list.push_back(AS_Mov(new AS_reg(AS_type::IMM, INT_LENGTH), temp));
        as_list.push_back(AS_Binop(AS_binopkind::MUL_, index_, temp, res)); // XXn2,XXn1,空闲
        allignPtr(base_ptr, gep->base_ptr, as_list);

        as_list.push_back(AS_Binop(
            AS_binopkind::ADD_,
            base_ptr->u.add->base, // base+index*int_length+imm
            res,
            new_ptr));

        /* code */
        break;
    }
    case TempType::STRUCT_TEMP:
    {
        assert(gep->index->kind == OperandKind::ICONST);
        string struct_name = "";
        if (gep->base_ptr->kind == OperandKind::TEMP)
        {
            struct_name = gep->base_ptr->u.TEMP->structname;
        }
        else
        {
            struct_name = gep->base_ptr->u.NAME->structname;
        }
        auto bits_ = new AS_reg(AS_type::IMM,
                                structLayout[struct_name]->offset[gep->index->u.ICONST]);
        auto temp1 = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);

        as_list.push_back(AS_Mov(bits_, temp1));
        allignPtr(base_ptr, gep->base_ptr, as_list);

        as_list.push_back(AS_Binop(
            AS_binopkind::ADD_,
            base_ptr->u.add->base,
            temp1,
            new_ptr));
        break;
    }
    case TempType::STRUCT_PTR:
    {
        allignLeftvRight(index_, gep->index, as_list);
        auto temp = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        auto res = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        string struct_name = "";
        if (gep->base_ptr->kind == OperandKind::TEMP)
        {
            struct_name = gep->base_ptr->u.TEMP->structname;
        }
        else
        {
            struct_name = gep->base_ptr->u.NAME->structname;
        }
        as_list.push_back(AS_Mov(new AS_reg(AS_type::IMM, structLayout[struct_name]->size), temp));
        as_list.push_back(AS_Binop(AS_binopkind::MUL_, index_, temp, res)); // XXn2,XXn1,空闲
        allignPtr(base_ptr, gep->base_ptr, as_list);

        as_list.push_back(AS_Binop(
            AS_binopkind::ADD_,
            base_ptr->u.add->base, // base+index*int_length
            res,
            new_ptr));
        break;
    }
    case TempType::INT_TEMP:
        allignPtr(base_ptr, gep->base_ptr, as_list);
        as_list.push_back(AS_Mov(base_ptr->u.add->base, new_ptr));
        break;

    default:
        assert(0);
        break;
    }
}

void llvm2asmStm(list<AS_stm *> &as_list, L_stm &stm, L_func &func)
{

    if (!alloc_frame && stm.type != L_StmKind::T_LABEL)
    {
        new_frame(as_list, func);
        alloc_frame = true;
    }

    switch (stm.type)
    {
    case L_StmKind::T_BINOP:
    {
        llvm2asmBinop(as_list, &stm);
        break;
    }
    case L_StmKind::T_LOAD:
    {
        llvm2asmLoad(as_list, &stm);
        break;
    }
    case L_StmKind::T_STORE:
    {
        llvm2asmStore(as_list, &stm);
        break;
    }
    case L_StmKind::T_LABEL:
    {
        auto label = new AS_label(stm.u.LABEL->label->name);
        as_list.push_back(AS_Label(label));
        break;
    }
    case L_StmKind::T_JUMP:
    {
        auto label = new AS_label(stm.u.JUMP->jump->name);
        as_list.push_back(AS_B(label));
        break;
    }
    case L_StmKind::T_CMP:
    {
        llvm2asmCmp(as_list, &stm);
        break;
    }
    case L_StmKind::T_CJUMP:
    {
        llvm2asmCJmp(as_list, &stm);
        break;
    }
    case L_StmKind::T_MOVE:
    {
        llvm2asmMov(as_list, &stm);
        break;
    }
    case L_StmKind::T_CALL:
    {
        llvm2asmCall(as_list, &stm);
        break;
    }
    case L_StmKind::T_VOID_CALL:
    {
        llvm2asmVoidCall(as_list, &stm);
        break;
    }
    case L_StmKind::T_RETURN:
    {
        llvm2asmRet(as_list, &stm);
        break;
    }
    case L_StmKind::T_ALLOCA:
    {
        // Do nothing
        break;
    }
    case L_StmKind::T_GEP:
    {

        llvm2asmGep(as_list, &stm);

        break;
    }
    case L_StmKind::T_PHI:
    {
        // Do nothing
        break;
    }
    case L_StmKind::T_NULL:
    {
        // Do nothing
        break;
    }
    }
    //
}
void save_register(list<AS_stm *> &as_list)
{
    for (auto it = allocateRegs.begin(); it != allocateRegs.end(); ++it)
    {
        // 获取当前元素
        int first = *it;
        ++it; // 移动到下一个元素

        // 检查是否有下一个元素
        if (it != allocateRegs.end())
        {
            int second = *it;
            as_list.push_back(AS_Stp(new AS_reg(AS_type::Xn, first), new AS_reg(AS_type::Xn, second), sp, -2 * INT_LENGTH));
        }
        else
        {
            // 如果`set`中的元素个数是奇数，最后一个元素将单独处理
            as_list.push_back(AS_Str(new AS_reg(AS_type::Xn, first), sp, -INT_LENGTH));
        }
    }
    as_list.push_back(AS_Stp(new AS_reg(AS_type::Xn, XnFP), new AS_reg(AS_type::Xn, XXnl), sp, -2 * INT_LENGTH));
}
void load_register(list<AS_stm *> &as_list)
{
    list<AS_stm *>::iterator rbegin = as_list.rbegin().base();
    for (auto it = allocateRegs.begin(); it != allocateRegs.end(); ++it)
    {
        // 获取当前元素
        int first = *it;
        ++it; // 移动到下一个元素

        // 检查是否有下一个元素
        if (it != allocateRegs.end())
        {
            int second = *it;
            rbegin = as_list.insert(rbegin, AS_Ldp(new AS_reg(AS_type::Xn, first), new AS_reg(AS_type::Xn, second), sp, 2 * INT_LENGTH));
        }
        else
        {
            // 如果`set`中的元素个数是奇数，最后一个元素将单独处理
            rbegin = as_list.insert(rbegin, AS_Ldr(new AS_reg(AS_type::Xn, first), sp, INT_LENGTH));
        }
    }
    rbegin = as_list.insert(rbegin, AS_Ldp(new AS_reg(AS_type::Xn, XnFP), new AS_reg(AS_type::Xn, XXnl), sp, 2 * INT_LENGTH));
}
void llvm2asmVoidCall(list<AS_stm *> &as_list, L_stm *call)
{
    int n = 0;
    for (auto x : call->u.VOID_CALL->args)
    {
        AS_reg *param;
        allignLeftvRight(param, x, as_list);
        as_list.emplace_back(AS_Mov(param, new AS_reg(AS_type::Xn, paramRegs[n])));
        n += 1;
    }
    save_register(as_list);
    as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XnFP)));
    as_list.emplace_back(AS_Bl(new AS_label(call->u.VOID_CALL->fun)));
    load_register(as_list);
}
void llvm2asmCall(list<AS_stm *> &as_list, L_stm *call)
{
    int n = 0;
    for (auto x : call->u.CALL->args)
    {
        AS_reg *param;
        allignLeftvRight(param, x, as_list);
        as_list.emplace_back(AS_Mov(param, new AS_reg(AS_type::Xn, paramRegs[n])));
        n += 1;
    }
    // 强制返回值使用X0
    call->u.CALL->res->u.TEMP->num = XXnret;
    save_register(as_list);
    as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XnFP)));

    as_list.emplace_back(AS_Bl(new AS_label(call->u.CALL->fun)));
    load_register(as_list);
}

void allocReg(list<AS_stm *> &as_list, L_func &func)
{
    list<InstructionNode *> liveness;

    forwardLivenessAnalysis(liveness, as_list);

    livenessAnalysis(liveness, as_list);
}
AS_func *llvm2asmFunc(L_func &func)
{
    list<AS_stm *> stms;
    list<L_phi *> phi;
    unordered_map<string, list<AS_stm *>::iterator> block_map;
    auto p = new AS_func(stms);
    auto func_label = new AS_label(func.name);
    p->stms.push_back(AS_Label(func_label));

    string temp_label = "";
    for (const auto &block : func.blocks)
    {
        for (const auto &instr : block->instrs)
        {
            INSERT1();

            printL_stm(std::cerr, instr);
            INSERT1();

            llvm2asmStm(p->stms, *instr, func);
            printAS_stm(std::cerr,p->stms.back());
            // if (instr->type == L_StmKind::T_PHI)
            // {
            //     phi.push_back(instr->u.PHI);
            // }
            // if (instr->type == L_StmKind::T_LABEL)
            // {
            //     temp_label = instr->u.LABEL->label->name;
            // }
            // if (temp_label.length()>0)
            // {
            //     block_map[temp_label] = --p->stms.end();
            // }
        }
    }
                INSERT1();


    for (auto &t_phi : phi)
    {
        assert(t_phi->dst->kind == OperandKind::TEMP);
        auto dst = new AS_reg(AS_type::Xn, t_phi->dst->u.TEMP->num);
        for (auto &bh : t_phi->phis)
        {
            auto src = new AS_reg(AS_type::Xn, bh.first->u.TEMP->num);
            assert(bh.first->kind == OperandKind::TEMP);
            string next_block = bh.second->name.c_str();
            auto xx = block_map[bh.second->name.c_str()];
            while (true)
            {
                if ((*xx)->type == AS_stmkind::B)
                {
                    if ((*xx)->u.B->jump->name == next_block)
                    {
                        p->stms.insert(xx, AS_Mov(src, dst));
                        break;
                    }
                }
                if ((*xx)->type == AS_stmkind::BCOND)
                {
                    if ((*xx)->u.BCOND->jump->name == next_block)
                    {
                        p->stms.insert(xx, AS_Mov(src, dst));
                        break;
                    }
                }
                xx--;
            }
        }
    }
    INSERT1();
    allocReg(p->stms, func);
    INSERT1();
    return p;
}

void llvm2asmDecl(vector<AS_decl *> &decls, L_def &def)
{
    switch (def.kind)
    {
    case L_DefKind::GLOBAL:
    {
        return;
    }
    case L_DefKind::FUNC:
    {
        AS_decl *decl = new AS_decl(def.u.FUNC->name);
        decls.push_back(decl);
        break;
    }
    case L_DefKind::SRT:
    {
        return;
    }
    }
}

void llvm2asmGlobal(vector<AS_global *> &globals, L_def &def)
{
    switch (def.kind)
    {
    case L_DefKind::GLOBAL:
    {
        // Fixme: add here
        /*
        AS_global 是汇编代码内全局变量 DATA 的抽象，在全局有一个 label 作为标签。

        对于 int 类型，init 存储初始化的整型值（缺省为 0 ）。
        对于数组或结构体，全部初始化为 0 , len 记录全局变量需要多少字节，注意不是数组长度。*/
        int _len = 8;
        if (def.u.GLOBAL->def.kind == TempType::INT_PTR)
        {
            _len = max(8 * def.u.GLOBAL->def.len, 8);
        }
        else if (def.u.GLOBAL->def.kind == TempType::STRUCT_PTR || def.u.GLOBAL->def.kind == TempType::STRUCT_TEMP)
        {
            int temp = structLayout[def.u.GLOBAL->def.structname]->size;
            _len = max(temp * def.u.GLOBAL->def.len, temp);
        }
        int _init = 0;
        if (def.u.GLOBAL->init.size() == 0 ||
            def.u.GLOBAL->def.kind == TempType::STRUCT_PTR ||
            def.u.GLOBAL->def.kind == TempType::STRUCT_TEMP)
            ;
        else
        {
            if (def.u.GLOBAL->def.kind == TempType::INT_PTR && def.u.GLOBAL->def.len > 0)
                ;
            _init = def.u.GLOBAL->init[0];
        }

        globals.push_back(new AS_global(new AS_label(def.u.GLOBAL->name), _init, _len));
        break;
    }
    case L_DefKind::FUNC:
    {
        return;
    }
    case L_DefKind::SRT:
    {
        return;
    }
    }
}

AS_prog *llvm2asm(L_prog &prog)
{
    std::vector<AS_global *> globals;
    std::vector<AS_decl *> decls;
    std::vector<AS_func *> func_list;

    auto as_prog = new AS_prog(globals, decls, func_list);

    structLayoutInit(prog.defs);

    // translate function definition
    for (const auto &def : prog.defs)
    {
        llvm2asmDecl(as_prog->decls, *def);
    }

    for (const auto &func : prog.funcs)
    {
        AS_decl *decl = new AS_decl(func->name);
        as_prog->decls.push_back(decl);
    }

    // translate global data
    for (const auto &def : prog.defs)
    {
        llvm2asmGlobal(as_prog->globals, *def);
    }

    // translate each llvm function

    for (const auto &func : prog.funcs)
    {
        alloc_frame = false;

        set_stack(*func);

        as_prog->funcs.push_back(llvm2asmFunc(*func));

        ptrMap.clear();
        //
    }

    return as_prog;
}
