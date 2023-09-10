%{
#  include <stdio.h>
void yyerror(char *s);
int yylex();
%}

// you should define the return value in lexer here
%union {
	int val;
}

// you should declare tokens and their value type here
%token <val> NUMBER
%token ADD SUB
%token EOL
%type <val> term exp


// you should declare rules for parser between the first and the second %%
%%
calclist: 
	| calclist exp EOL { printf("= %d\n> ", $2);}
	| calclist EOL { printf("> "); } 
	;

exp: term
	| exp ADD exp { $$ = $1 + $3; }
	| exp SUB term { $$ = $1 - $3; }
	;

term: NUMBER
	;


%%

void yyerror(char *s)
{
	fprintf(stderr, "Error: %s\n", s);
}

int main()
{
	printf("> "); 
	yyparse();
}