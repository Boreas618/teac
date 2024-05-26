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
#include <sstream>
#include <iostream>
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
static unordered_map<int, AS_address *> fpOffset;
static unordered_map<int, AS_relopkind> condMap;
static unordered_map<string, StructDef *> structLayout;
int getMemLength(TempDef &members)
{
    switch (members.kind)
    {
    case TempType::INT_PTR:
        return INT_LENGTH * members.len;
        break;
    case TempType::INT_TEMP:
        return INT_LENGTH;
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

            for (auto x : def->u.SRT->members)
            {
                structdef->offset.push_back(structdef->size);
                structdef->size += getMemLength(x);
            }
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
                    stack_frame += max(INT_LENGTH, INT_LENGTH * alloca->len);

                    fpOffset.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame));

                    // printf("alloca->len:%d,INT_PTR,stack_frame:%d\n", alloca->len,stack_frame);

                    break;
                case TempType::INT_TEMP:
                    assert(0);
                    break;
                case TempType::STRUCT_PTR:
                {
                    int temp = structLayout[alloca->structname]->size;
                    stack_frame += max(temp, temp * alloca->len);

                    fpOffset.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame));

                    // printf("temp:%d,STRUCT_PTR.stack_frame:%d\n",temp, stack_frame);

                    break;
                }

                case TempType::STRUCT_TEMP:
                    stack_frame += structLayout[alloca->structname]->size;

                    fpOffset.emplace(alloca->num, new AS_address(new AS_reg(AS_type::Xn, XnFP), -stack_frame));

                    // printf("STRUCT_TEMP.stack_frame:%d\n", stack_frame);

                    break;
                }
            }
        }
    }

    stack_frame = ((stack_frame + 15) >> 4) << 4;
    for (auto &x : fpOffset)
    {
        // printf("%r%d %s\n", x.first, printAS_add(x.second).c_str());
    }
}

void new_frame(list<AS_stm *> &as_list, L_func &func)
{
    // Fixme: add here
    as_list.emplace_back(AS_Binop(AS_binopkind::SUB_, sp, new AS_reg(AS_type::IMM, stack_frame), sp));
    int i = 0;

    for (int i = 0; i < 8 && i < func.args.size(); i++)
    {
        as_list.emplace_back(AS_Mov(new AS_reg(AS_type::Xn, i), new AS_reg(AS_type::Xn, func.args[i]->num)));
    }
    int offset = 0;
    for (int i = 8; i < func.args.size(); i++)
    {
        auto tep = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        as_list.emplace_back(AS_Ldr(tep, new AS_reg(AS_type::ADR, new AS_address(new AS_reg(AS_type::Xn, XnFP), offset))));
        offset += INT_LENGTH;
        as_list.emplace_back(AS_Mov(tep, new AS_reg(AS_type::Xn, func.args[i]->num)));
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
        if (fpOffset.find(as_operand->u.TEMP->num) != fpOffset.end())
        {
            auto ptr_fp = fpOffset[as_operand->u.TEMP->num];
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
    AS_reg *src;
    allignLeftvRight(src, mov_stm->u.MOVE->src, as_list);
    assert(mov_stm->u.MOVE->dst->kind == OperandKind::TEMP);
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
        string struct_name = "";
        if (gep->base_ptr->kind == OperandKind::TEMP)
        {
            struct_name = gep->base_ptr->u.TEMP->structname;
        }
        else
        {
            struct_name = gep->base_ptr->u.NAME->structname;
        }
        if (gep->base_ptr->u.TEMP->len == 0)
        {
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
        allignLeftvRight(index_, gep->index, as_list);
        auto temp = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        auto res = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);

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
int save_register(list<AS_stm *> &as_list)
{
    int sub = 0;
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
            sub += 2 * INT_LENGTH;
        }
        else
        {
            // 如果`set`中的元素个数是奇数，最后一个元素将单独处理
            as_list.push_back(AS_Str(new AS_reg(AS_type::Xn, first), sp, -INT_LENGTH));
            sub += INT_LENGTH;
            break;
        }
    }
    as_list.push_back(AS_Stp(new AS_reg(AS_type::Xn, XnFP), new AS_reg(AS_type::Xn, XXnl), sp, -2 * INT_LENGTH));
    sub += 2 * INT_LENGTH;
    return sub;
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
            break;
        }
    }
    rbegin = as_list.insert(rbegin, AS_Ldp(new AS_reg(AS_type::Xn, XnFP), new AS_reg(AS_type::Xn, XXnl), sp, 2 * INT_LENGTH));
}
void getCalls(AS_reg *&op_reg, AS_operand *as_operand, list<AS_stm *> &as_list)
{
    switch (as_operand->kind)
    {
    case OperandKind::ICONST:
    {

        // store from the const: str #1, ...
        // move the instant into x2: mov x2, #1
        int instant = as_operand->u.ICONST;
        AS_reg *src_mov = new AS_reg(AS_type::IMM, instant);
        AS_reg *dst_mov = new AS_reg(AS_type::Xn, Temp_newtemp_int()->num);
        as_list.push_back(AS_Mov(src_mov, dst_mov));
        op_reg = dst_mov;

        break;
    }
    case OperandKind::TEMP:
    {
        switch (as_operand->u.TEMP->type)
        {
        case TempType::INT_PTR:
        case TempType::INT_TEMP:
        {
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

        case TempType::STRUCT_PTR:
        case TempType::STRUCT_TEMP:
        {
            allignPtr(op_reg, as_operand, as_list);
            op_reg = op_reg->u.add->base;
            break;
        }
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
void llvm2asmVoidCall(list<AS_stm *> &as_list, L_stm *call)
{

    for (int i = 0; i < 8 && i < call->u.VOID_CALL->args.size(); i++)
    {
        AS_reg *param;
        getCalls(param, call->u.VOID_CALL->args[i], as_list);
        as_list.emplace_back(AS_Mov(param, new AS_reg(AS_type::Xn, paramRegs[i])));
    }
    vector<AS_reg *> abcd;
    for (int i = 8; i < call->u.VOID_CALL->args.size(); i++)
    {
        AS_reg *param;
        getCalls(param, call->u.VOID_CALL->args[i], as_list);
        abcd.push_back(param);
    }
    if (abcd.size())
    {
        as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XXna)));
        int sub = save_register(as_list);
        as_list.push_back(AS_Mov(new AS_reg(AS_type::Xn, XXna), sp));

        int param_sub = 0;
        for (auto &x : abcd)
        {
            param_sub += INT_LENGTH;
            if (-sub - param_sub < -256)
            {
                auto temp = new AS_reg(AS_type::Xn, XXnb);
                as_list.emplace_back(AS_Mov(new AS_reg(AS_type::IMM, -sub - param_sub), temp));

                as_list.emplace_back(AS_Str(x, new AS_reg(AS_type::ADR, new AS_address(sp, temp))));
            }
            else
            {
                as_list.emplace_back(AS_Str(x, new AS_reg(AS_type::ADR, new AS_address(sp, -sub - param_sub))));
            }
        }
        as_list.emplace_back(AS_Binop(AS_binopkind::SUB_, sp, new AS_reg(AS_type::IMM, sub + param_sub), sp));
    }
    else
    {
        save_register(as_list);
    }

    as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XnFP)));
    as_list.emplace_back(AS_Bl(new AS_label(call->u.VOID_CALL->fun)));
    if (abcd.size())
    {
        as_list.emplace_back(AS_Binop(AS_binopkind::ADD_, sp, new AS_reg(AS_type::IMM, -abcd.size() * INT_LENGTH), sp));
    }
    load_register(as_list);
}
void llvm2asmCall(list<AS_stm *> &as_list, L_stm *call)
{

    for (int i = 0; i < 8 && i < call->u.CALL->args.size(); i++)
    {
        AS_reg *param;
        getCalls(param, call->u.CALL->args[i], as_list);

        as_list.emplace_back(AS_Mov(param, new AS_reg(AS_type::Xn, paramRegs[i])));
    }
    if (call->u.CALL->args.size() > 8)
    {
        as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XXna)));
        int sub = save_register(as_list);
        as_list.push_back(AS_Mov(new AS_reg(AS_type::Xn, XXna), sp));

        int param_sub = 0;
        for (int i = call->u.CALL->args.size() - 1; i >= 8; i--)
        {
            AS_reg *param;
            getCalls(param, call->u.CALL->args[i], as_list);
            param_sub += INT_LENGTH;
            if (-sub - param_sub < -256)
            {
                auto temp = new AS_reg(AS_type::Xn, XXnb);
                as_list.emplace_back(AS_Mov(new AS_reg(AS_type::IMM, -sub - param_sub), temp));

                as_list.emplace_back(AS_Str(param, new AS_reg(AS_type::ADR, new AS_address(sp, temp))));
            }
            else
            {
                as_list.emplace_back(AS_Str(param, new AS_reg(AS_type::ADR, new AS_address(sp, -sub - param_sub))));
            }
        }
        as_list.emplace_back(AS_Binop(AS_binopkind::SUB_, sp, new AS_reg(AS_type::IMM, sub + param_sub), sp));
    }
    else
    {
        save_register(as_list);
    }
    as_list.push_back(AS_Mov(sp, new AS_reg(AS_type::Xn, XnFP)));

    as_list.emplace_back(AS_Bl(new AS_label(call->u.CALL->fun)));
    if (call->u.CALL->args.size() > 8)
    {
        as_list.emplace_back(AS_Binop(AS_binopkind::ADD_, sp, new AS_reg(AS_type::IMM, (call->u.CALL->args.size() - 8) * INT_LENGTH), sp));
    }
    load_register(as_list);
    as_list.emplace_back(AS_Mov(new AS_reg(AS_type::Xn, XXnret), new AS_reg(AS_type::Xn, call->u.CALL->res->u.TEMP->num)));
}

void allocReg(list<AS_stm *> &as_list, L_func &func)
{
    list<InstructionNode *> liveness;

    forwardLivenessAnalysis(liveness, as_list);

    livenessAnalysis(liveness, as_list);
}
struct BLOCKPHI
{
    string label;
    L_stm *phi;
    BLOCKPHI(string _label, L_stm *_phi) : label(_label), phi(_phi) {}
};

AS_func *llvm2asmFunc(L_func &func)
{
    list<AS_stm *> stms;
    list<BLOCKPHI *> phi;
    unordered_map<string, list<AS_stm *>::iterator> block_map;
    auto p = new AS_func(stms);
    auto func_label = new AS_label(func.name);
    p->stms.push_back(AS_Label(func_label));
    for (auto &x : fpOffset)
    {
        std::ostringstream oss;
        oss << x.first << ":" << printAS_add(x.second).c_str() << endl;
        p->stms.push_back(AS_Llvmir(oss.str()));
    }
    string temp_label = "";
    for (const auto &block : func.blocks)
    {
        for (const auto &instr : block->instrs)
        {
            std::ostringstream oss;
            printL_stm(oss, instr);
            p->stms.push_back(AS_Llvmir(oss.str()));
            llvm2asmStm(p->stms, *instr, func);
            if (instr->type == L_StmKind::T_PHI)
            {
                phi.push_back(new BLOCKPHI(temp_label, instr));
            }
            if (instr->type == L_StmKind::T_LABEL)
            {
                temp_label = instr->u.LABEL->label->name;
            }
            if (temp_label.length() > 0)
            {
                block_map[temp_label] = --p->stms.end();
            }
        }
    }

    for (auto &t_phi : phi)
    {
        string temp_block = t_phi->label;
        assert(t_phi->phi->u.PHI->dst->kind == OperandKind::TEMP);
        auto dst = new AS_reg(AS_type::Xn, t_phi->phi->u.PHI->dst->u.TEMP->num);
        for (auto &bh : t_phi->phi->u.PHI->phis)
        {
            auto src = new AS_reg(AS_type::Xn, bh.first->u.TEMP->num);
            assert(bh.first->kind == OperandKind::TEMP);
            string next_block = bh.second->name.c_str();
            auto xx = block_map[next_block];
            while (true)
            {
                if ((*xx)->type == AS_stmkind::B)
                {
                    if ((*xx)->u.B->jump->name == temp_block)
                    {
                        std::ostringstream oss;
                        printL_stm(oss, t_phi->phi);
                        p->stms.insert(xx, AS_Llvmir(temp_block + ":" + oss.str()));
                        p->stms.insert(xx, AS_Mov(src, dst));
                        break;
                    }
                }
                if ((*xx)->type == AS_stmkind::BCOND)
                {
                    if ((*xx)->u.BCOND->jump->name == temp_block)
                    {
                        std::ostringstream oss;
                        printL_stm(oss, t_phi->phi);
                        p->stms.insert(xx, AS_Llvmir(temp_block + ":" + oss.str()));
                        p->stms.insert(xx, AS_Mov(src, dst));
                        break;
                    }
                }
                xx--;
            }
        }
    }

    allocReg(p->stms, func);
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
        switch (def.u.GLOBAL->def.kind)
        {
        case TempType::INT_TEMP:
        {
            AS_label *label = new AS_label(def.u.GLOBAL->name);
            int init;
            if (def.u.GLOBAL->init.size() == 1)
            {
                init = def.u.GLOBAL->init[0];
            }
            else
            {
                init = 0;
            }
            auto global = new AS_global(label, init, 1);
            globals.push_back(global);
            break;
        }
        case TempType::INT_PTR:
        {
            AS_label *label = new AS_label(def.u.GLOBAL->name);
            auto global = new AS_global(label, 0, def.u.GLOBAL->def.len * INT_LENGTH);
            globals.push_back(global);
            break;
        }
        case TempType::STRUCT_TEMP:
        {
            AS_label *label = new AS_label(def.u.GLOBAL->name);
            int struct_len = structLayout[def.u.GLOBAL->def.structname]->size;
            auto global = new AS_global(label, 0, struct_len);
            globals.push_back(global);
            break;
        }
        case TempType::STRUCT_PTR:
        {
            AS_label *label = new AS_label(def.u.GLOBAL->name);
            int struct_len = structLayout[def.u.GLOBAL->def.structname]->size;
            int sum_len = def.u.GLOBAL->def.len * struct_len;
            auto global = new AS_global(label, 0, sum_len);
            globals.push_back(global);
            break;
        }
        }
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

        fpOffset.clear();
        //
    }

    return as_prog;
}
