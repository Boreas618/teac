#include "printASM.h"
#include "asm_arm.h"
#include <iostream>
#include <cassert>
using namespace std;
using namespace ASM;

void ASM::printAS_global(std::ostream &os, ASM::AS_global *global)
{

    // Fixme: add here
    os << global->label->name << ":\n\n";
    if (global->init == 0)
    {
        os << "        .zero   " << global->len << endl
           << std::flush;
    }
    else
    {
        os << "        .word   " << global->init << endl
           << std::flush;
    }
}

void ASM::printAS_decl(std::ostream &os, ASM::AS_decl *decl)
{
    // Fixme: add here
    os << ".global " << decl->name << endl
       << std::flush;
}

void ASM::printAS_stm(std::ostream &os, AS_stm *stm)
{
    // Fixme: add here
    switch (stm->type)
    {
    case AS_stmkind::BINOP:
    {
        string temp[] = {"add", "sub", "mul", "sdiv"};
        os << "        " << temp[static_cast<int>(stm->u.BINOP->op)] << "     "
           << printAS_reg(stm->u.BINOP->dst)
           << ", "
           << printAS_reg(stm->u.BINOP->left)
           << ", "
           << printAS_reg(stm->u.BINOP->right)
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::MOV:
    {
        os << "        mov     "
           << printAS_reg(stm->u.MOV->dst)
           << ", "
           << printAS_reg(stm->u.MOV->src)
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::MOVZ:
    {
        os << "        movz     "
           << printAS_reg(stm->u.MOVZ->dst)
           << ", "
           << printAS_reg(stm->u.MOVZ->src)
           << ", LSL #16"
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::MOVK:
    {
        os << "        movk     "
           << printAS_reg(stm->u.MOVK->dst)
           << ", "
           << printAS_reg(stm->u.MOVK->src)
           << ", LSL #0"
           << endl
           << std::flush;

        break;
    }

    case AS_stmkind::LDR:
    {
        if (stm->u.LDR->post_index)
        {
            assert(stm->u.LDR->ptr->type == AS_type::SP);
            os << "        ldr     "
               << printAS_reg(stm->u.LDR->dst)
               << ", [sp], #"
               << stm->u.LDR->post_index
               << endl
               << std::flush;
        }
        else
        {
            os << "        ldr     "
               << printAS_reg(stm->u.LDR->dst)
               << ", "
               << printAS_reg(stm->u.LDR->ptr, false)
               << endl
               << std::flush;
        }

        break;
    }
    case AS_stmkind::LDP:
    {
        assert(stm->u.LDP->ptr->type == AS_type::SP);
        os << "        ldp     "
           << printAS_reg(stm->u.LDP->dst1)
           << ", "
           << printAS_reg(stm->u.LDP->dst2)
           << ", [sp], #"
           << stm->u.LDP->post_index
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::STR:
    {
        if (stm->u.STR->pre_index)
        {
            assert(stm->u.STR->ptr->type == AS_type::SP);
            os << "        str     "
               << printAS_reg(stm->u.STR->src)
               << ", [sp, #"
               << stm->u.STR->pre_index
               << "]!"
               << endl
               << std::flush;
        }
        os << "        str     "
           << printAS_reg(stm->u.STR->src)
           << ", "
           << printAS_reg(stm->u.STR->ptr, false)
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::STP:
    {

        assert(stm->u.STP->ptr->type == AS_type::SP);
        os << "        stp     "
           << printAS_reg(stm->u.STP->src1)
           << ", "
           << printAS_reg(stm->u.STP->src2)
           << ", [sp, #"
           << stm->u.STP->pre_index
           << "]!"
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::LABEL:
    {
        os << stm->u.LABEL->name << ":\n\n";
        break;
    }
    case AS_stmkind::B:
    {

        os
            << "        "
            << "b"
            << "     " << stm->u.B->jump->name
            << endl
            << std::flush;
        break;
    }
    case AS_stmkind::BCOND:
    {
        string temp[] = {"eq", "ne", "lt", "gt", "le", "ge"};
        os << "        "
           << "b." << temp[static_cast<int>(stm->u.BCOND->op)]
           << "     "
           << stm->u.BCOND->jump->name
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::BL:
    {
        os
            // << "        stp	x29, x30, [sp, #-32]!\n"
            //    "        stp x9, x10, [sp, #-32]!\n"
            //    "        stp x11, x12, [sp, #-32]!\n"
            //    "        stp x13, x14, [sp, #-32]!\n"
            //    "        stp x15, x20, [sp, #-32]!\n"
            //    "        stp x21, x22, [sp, #-32]!\n"
            //    "        stp x23, x24, [sp, #-32]!\n"
            //    "        stp x25, x26, [sp, #-32]!\n"
            //    "        stp x27, x28, [sp, #-32]!\n"
            //    "        mov	x29, sp\n"
            << "        bl"
            << "     " << stm->u.BL->jump->name
            << endl
            // << "        ldp x27, x28, [sp], #32\n"
            //    "        ldp x25, x26, [sp], #32\n"
            //    "        ldp x23, x24, [sp], #32\n"
            //    "        ldp x21, x22, [sp], #32\n"
            //    "        ldp x15, x20, [sp], #32\n"
            //    "        ldp x13, x14, [sp], #32\n"
            //    "        ldp x11, x12, [sp], #32\n"
            //    "        ldp x9, x10, [sp], #32\n"
            //    "        ldp	x29, x30, [sp], #32\n"
            << std::flush;

        break;
    }
    case AS_stmkind::CMP:
    {
        os << "        cmp     "
           << printAS_reg(stm->u.CMP->left)
           << ", "
           << printAS_reg(stm->u.CMP->right)
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::RET:
    {
        os << "        ret"
           << endl
           << std::flush;

        break;
    }
    case AS_stmkind::ADR:
    {
        os << "        adr     "
           << printAS_reg(stm->u.ADR->reg)
           << ", " << stm->u.ADR->label->name
           << endl
           << std::flush;

        break;
    }

    default:
        break;
    }
}
string ASM::printAS_add(AS_address *adr)
{
    // printf("aaa,%d,%x\n", adr->imm, adr->reg);
    string res = "";
    res += printAS_reg(adr->base);
    if (adr->imm != 0)
    {
        res += ",#" + to_string(adr->imm);
    }
    if (adr->reg)
    {
        res += "," + printAS_reg(adr->reg);
    }
    return res;
}
string ASM::printAS_reg(AS_reg *reg, bool integer)
{
    // Fixme: add here
    string res = "";
    if (reg->type == AS_type::Xn)
    {
        res += "x" + to_string(reg->u.offset);
    }
    else if (reg->type == AS_type::IMM)
    {
        res += "#" + to_string(reg->u.offset);
    }
    else if (reg->type == AS_type::SP)
    {

        res += "sp";
    }
    else
    {
        res = "[" + printAS_add(reg->u.add) + "]";
    }
    return res;
}

void ASM::printAS_func(std::ostream &os, AS_func *func)
{
    for (const auto &stm : func->stms)
    {
        printAS_stm(os, stm);
    }
}

void ASM::printAS_prog(std::ostream &os, AS_prog *prog)
{

    os << ".section .data\n\n";
    for (const auto &global : prog->globals)
    {
        printAS_global(os, global);
    }

    os << ".section .text\n\n";
    // os << ".global _start\n\
// \n\
// _start:\n\
//     b main  \n\
//     mov x8, #93  \n\
//     mov x0, #0   \n\
//     svc #0       \n";
    for (const auto &decl : prog->decls)
    {
        printAS_decl(os, decl);
    }

    for (const auto &func : prog->funcs)
    {
        printAS_func(os, func);
    }
}