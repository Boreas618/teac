%{
# include "test.tab.h"
void yyerror(char*);
%}

number        ([0-9]+|[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?)
%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"  { return MUL; }
"**"  { return POW; }
"/"  { return DIV; }
"(" { return LPar;}
")" { return RPar;}

{number}	{ yylval.floatval = atof(yytext); return NUMBER; }

[ \t]   { /* ignore white space */ }
.	{ yyerror("Unknown character!");}
\n      { return EOL; }
%%