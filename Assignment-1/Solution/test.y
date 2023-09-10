%{
#include <stdio.h>
#include <math.h>
void yyerror(char *s);
int yylex();
%}

%left ADD SUB MUL DIV

%union {
	double floatval;
}

%token <floatval> NUMBER
%token ADD SUB MUL DIV
%token LPar RPar
%token EOL
%type <floatval> term exp factor

%%

calclist:
	| calclist exp EOL { printf("= %lf\n> ", $2);}
	| calclist EOL { printf("> "); } 
	;

exp:exp ADD term { $$ = $1 + $3; }
	| exp SUB term { $$ = $1 - $3; }
	| term
	;

term:term MUL MUL factor {$$ = pow($1, $4);}
	| term MUL factor {$$ = $1 * $3;}
	| term DIV factor {$$ = $1 / $3;}
	| factor
	;

factor:NUMBER
	| LPar exp RPar {$$ = $2;}
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



