%{
# include "test.tab.h"
void yyerror(char*);
%}

/* you should implement the following between the first and the second %% */
/* 1. more operators and actions */
/* 2. how to match float numbers? */
%%
"+"	{ return ADD; }
"-"	{ return SUB; }
[0-9]+	{ yylval.val = atoi(yytext); return NUMBER; }

[ \t]   { /* ignore white space */ }
.	{ yyerror("Unknown character!\n"); }
\n      { return EOL; }
%%