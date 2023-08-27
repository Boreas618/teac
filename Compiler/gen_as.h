#ifndef __GEN_AS
#define __GEN_AS

#include "assem.h"
#include "treep.hpp"
#include "llvm_assem.h"

LLVM_IR::T_irList gen_asList(T_stmList sl);
AS_instrList gen_prolog_llvm(std::string &method_name, Temp_tempList args);
AS_instrList gen_epilog_llvm(Temp_label);
LLVM_IR::T_irList_ *gen_prolog_llvm_ir(std::string &method_name, Temp_tempList args);
AS_instrList gen_epilog_llvm(std::string& method_name, Temp_label lexit);
LLVM_IR::T_irList_ *gen_retInsList_llvm_ir(std::string& method_name, Temp_label lexit);
LLVM_IR::T_irList_ *gen_epilog_llvm_ir(void);

#endif
