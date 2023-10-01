#include "TeaplAst.h"
#include "TeaplaAst.h"
#include "PrintTeaplaAst.h"
#include "y.tab.h"

extern int yyparse();
extern YYSTYPE yylval;

int line, col;

A_prog root;

int main(int argc, const char * argv[]) {
    line = 1;
    col = 1;
    yyparse();
//  print_slpis testing purpose:
    printA_Prog(stdout, root);
    
    return 0;
}