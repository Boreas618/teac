#include "printASM.h"
#include "asm_arm.h"
#include <iostream>

using namespace std;
using namespace ASM;

void ASM::printAS_global(std::ostream &os, ASM::AS_global *global) {
    os << global->label->name << ":\n";
    if (global->len == 1) {
        os << "        .word   " << global->init << "\n";
    } else {
        os << "        .zero   " << 4 * global->len << "\n";
    }
}

void ASM::printAS_decl(std::ostream &os, ASM::AS_decl *decl) {
    os << ".global " << decl->name << "\n";
}


void ASM::printAS_stm(std::ostream &os, AS_stm *stm) {
    switch (stm->type) {
        case AS_stmkind::BINOP: {
            os << "        ";
            switch (stm->u.BINOP->op) {
                case AS_binopkind::ADD_: {
                    os << "add     ";
                    break;
                }
                case AS_binopkind::SUB_: {
                    os << "sub     ";
                    break;
                }
                case AS_binopkind::MUL_: {
                    os << "mul     ";
                    break;
                }
                case AS_binopkind::SDIV_: {
                    os << "sdiv     ";
                    break;
                }
            }
            printAS_reg(os,stm->u.BINOP->dst);
            os << ", ";
            printAS_reg(os,stm->u.BINOP->left);
            os << ", ";
            printAS_reg(os,stm->u.BINOP->right);
            break;
        }
        case AS_stmkind::MOV: {
            os << "        " << "mov     ";
            printAS_reg(os, stm->u.MOV->dst);
            os << ", ";
            printAS_reg(os, stm->u.MOV->src);
            break;
        }
        case AS_stmkind::LDR: {
            os << "        " << "ldr     ";
            printAS_reg(os,stm->u.LDR->dst);
            os << ", ";
            printAS_reg(os,stm->u.LDR->ptr);
            break;
        }
        case AS_stmkind::STR: {
            os << "        " << "str     ";
            printAS_reg(os,stm->u.STR->ptr);
            os << ", ";
            printAS_reg(os,stm->u.STR->src);
            break;
        }
        case AS_stmkind::ADR: {
            os << "        " << "adr     ";
            printAS_reg(os, stm->u.ADR->reg);
            os << ", " << stm->u.ADR->label->name;
            break;
        }
        case AS_stmkind::LABEL: {
            os << stm->u.LABEL->name << ":";
            break;
        }
        case AS_stmkind::B: {
            os << "        " << "b       ";
            os << stm->u.B->jump->name;
            break;
        }
        case AS_stmkind::CMP: {
            os << "        " << "cmp     ";
            printAS_reg(os,stm->u.CMP->left);
            os << ", ";
            printAS_reg(os,stm->u.CMP->right);
            break;
        }
        case AS_stmkind::BCOND: {
            os << "        " << "b.";
            switch (stm->u.BCOND->op) {
                case AS_relopkind::EQ_: {
                    os << "eq    ";
                    break;
                }
                case AS_relopkind::NE_: {
                    os << "ne    ";
                    break;
                }
                case AS_relopkind::LT_: {
                    os << "lt    ";
                    break;
                }
                case AS_relopkind::GT_: {
                    os << "gt    ";
                    break;
                }
                case AS_relopkind::LE_: {
                    os << "le    ";
                    break;
                }
                case AS_relopkind::GE_: {
                    os << "ge    ";
                    break;
                }
            }
            os << stm->u.BCOND->jump->name;
            break;
        }
        case AS_stmkind::BL: {
            os << "        " << "bl      ";
            os << stm->u.BL->jump->name;
            break;
        }
        case AS_stmkind::RET: {
            os << "        " << "ret";
            break;
        }
    }
    os << "\n";
}

void ASM::printAS_reg(std::ostream &os, AS_reg *reg) {
    if (reg->reg == -1) {
        if (reg->offset == -1) {
            os << "sp";
        } else {
            os << "[sp";
            if (reg->offset != 0) {
                os << ", #" << reg->offset << "]";
            } else {
                os << "]";
            }
        }
    } else if (reg->reg == -3) {
        os << "#" << reg->offset;
    } else {
        if (reg->offset != -1 ) {
            os << "x" << reg->reg;
        } else {
            os << "[x" << reg->reg <<"]";
        }
    }
}

void ASM::printAS_func(std::ostream &os, AS_func *func) {
    for(const auto &stm : func->stms) {
        printAS_stm(os, stm);
    }
}

void ASM::printAS_prog(std::ostream &os, AS_prog *prog) {

    os << ".section .data\n";
    for(const auto &global : prog->globals) {
        printAS_global(os, global);
    }

    os << ".section .text\n";

    for(const auto &decl : prog->decls) {
        printAS_decl(os, decl);
    }

    for(const auto &func : prog->funcs) {
        printAS_func(os, func);
    }

}