%{
#include "util.h"
#include <stdio.h>
#include "ast.h"
#include "y.tab.hpp"

int c;
int line=1;
int pos=0;

static int get10(char *, int);
static int get8(char *, int);
static int get16(char *, int);


%}

%start COMMENT1 COMMENT2

%%

<INITIAL>"//" {BEGIN COMMENT1;}
<COMMENT1>"\n" {line++;pos=0;BEGIN INITIAL;}
<COMMENT1>. ;
<INITIAL>"/*" {BEGIN COMMENT2;}
<COMMENT2>"*/" {BEGIN INITIAL;}
<COMMENT2>"\n" {line++;pos=0;};
<COMMENT2>. ;
<INITIAL>"\n" {line++; pos = 0;}
<INITIAL>"\t" {pos+=4;}
<INITIAL>" " {pos++;}
<INITIAL>"\r" ;
<INITIAL>"+" { pos++; yylval.token = A_Pos(line,pos); return OP_PLUS; }
<INITIAL>"*" { pos++; yylval.token = A_Pos(line,pos); return OP_MULTIPLY; }
<INITIAL>"-" { pos++; yylval.token = A_Pos(line,pos); return OP_MINUS; }
<INITIAL>"/" { pos++; yylval.token = A_Pos(line,pos); return OP_DIV; }
<INITIAL>"%" { pos++; yylval.token = A_Pos(line,pos); return OP_MOD; }
<INITIAL>"=" { pos++; yylval.token = A_Pos(line,pos); return ASSIGN; }
<INITIAL>"||" { pos+=2; yylval.token = A_Pos(line,pos); return OR; }
<INITIAL>"&&" { pos+=2; yylval.token = A_Pos(line,pos); return AND; }
<INITIAL>"<" { pos++; yylval.token = A_Pos(line,pos); return LT; }
<INITIAL>">" { pos++; yylval.token = A_Pos(line,pos); return GT; }
<INITIAL>"<=" { pos+=2; yylval.token = A_Pos(line,pos); return LE; }
<INITIAL>">=" { pos+=2; yylval.token = A_Pos(line,pos); return GE; }
<INITIAL>"==" { pos+=2; yylval.token = A_Pos(line,pos); return EQ; }
<INITIAL>"!=" { pos+=2; yylval.token = A_Pos(line,pos); return NEQ; }
<INITIAL>"const" { pos += 5; yylval.token = A_Pos(line,pos); return CONST; }
<INITIAL>"putint" { pos += 6; yylval.token = A_Pos(line,pos); return PUTINT; }
<INITIAL>"putch" { pos += 5; yylval.token = A_Pos(line,pos); return PUTCH; }
<INITIAL>"putf" {pos += 4; yylval.token = A_Pos(line,pos); return PUTF; }
<INITIAL>"putfloat" {pos += 8; yylval.token = A_Pos(line,pos); return PUTFLOAT; }
<INITIAL>"int" { pos += 3; yylval.token = A_Pos(line,pos); return INT; }
<INITIAL>"float" { pos += 5; yylval.token = A_Pos(line,pos); return FLOAT; }
<INITIAL>"void" { pos += 4; yylval.token = A_Pos(line,pos); return VOID; }
<INITIAL>"while" {pos += 5; yylval.token = A_Pos(line,pos); return WHILE; }
<INITIAL>"if" {pos += 2; yylval.token = A_Pos(line,pos); return IF; }
<INITIAL>"else" {pos += 4; yylval.token = A_Pos(line,pos); return ELSE; }
<INITIAL>"continue" {pos += 8; yylval.token = A_Pos(line,pos); return CONTINUE; }
<INITIAL>"break" {pos += 5; yylval.token = A_Pos(line,pos); return BREAK; }
<INITIAL>"return" {pos += 6; yylval.token = A_Pos(line,pos); return RETURN; }
<INITIAL>"putarray" {pos += 8; yylval.token = A_Pos(line,pos); return PUTARRAY; }
<INITIAL>"putfarray" { pos += 9; yylval.token = A_Pos(line,pos); return PUTFARRAY; }
<INITIAL>"starttime" {pos += 9; yylval.token = A_Pos(line,pos); return STARTTIME; }
<INITIAL>"stoptime" {pos += 8; yylval.token = A_Pos(line,pos); return STOPTIME; }
<INITIAL>"getfarray" {pos += 9; yylval.token = A_Pos(line,pos); return GETFARRAY; }
<INITIAL>"getint" {pos += 6; yylval.token = A_Pos(line,pos); return GETINT; }
<INITIAL>"getch" {pos += 5; yylval.token = A_Pos(line,pos); return GETCH; }
<INITIAL>"getfloat" {pos += 8; yylval.token = A_Pos(line,pos); return GETFLOAT; }
<INITIAL>"getarray" {pos += 8; yylval.token = A_Pos(line,pos); return GETARRAY; }

<INITIAL>"("|")"|","|";"|"{"|"}"|"!"|"."|"["|"]" {
    pos++;
    c = yytext[0];
    return(c);
}
<INITIAL>[a-z_A-Z][a-z_A-Z0-9]* { 
    pos += yyleng;
    yylval.id = String(yytext);
    return IDENTIFIER;
}
<INITIAL>0[0-7]+ {
	yylval.inum = get8(yytext, yyleng);
	return INTNUMBER;
}

<INITIAL>0[xX][0-9a-fA-F]+ {
	yylval.inum = get16(yytext, yyleng);
	return INTNUMBER;
}

<INITIAL>[1-9][0-9]* {
	yylval.inum = get10(yytext, yyleng);
	return INTNUMBER;
}
<INITIAL>0 {
    pos++;
    yylval.inum = 0;
    return INTNUMBER;
}

<INITIAL>([0-9]*)\.[0-9]* {
	// fprintf(stderr,"%s\n", yytext);
	yylval.fnum = String(yytext);
	// fprintf(stderr, "%f\n", std::stof(*yylval.floatnumber));
	return FLOATNUMBER;
}

<INITIAL>[0-9]+[eE][\+\-]?[0-9]+ {
	/* decimal fps without . */
	// fprintf(stderr,"%s\n", yytext);
	yylval.fnum = String(yytext);
	// fprintf(stderr, "%f\n", std::stof(*yylval.floatnumber));
	return FLOATNUMBER;
}

<INITIAL>[0-9]*\.[0-9]*[eE][\+\-]?[0-9]+ {
	/* decimal fps with . */
	// fprintf(stderr,"%s\n", yytext);
	yylval.fnum = String(yytext);
	// fprintf(stderr, "%f\n", std::stof(*yylval.floatnumber));
	return FLOATNUMBER;
}

<INITIAL>0[xX][0-9a-fA-F]*[\.]?[0-9a-fA-F]*[pP][\+\-]?[0-9]+ {
	// fprintf(stderr,"%s\n", yytext);
	yylval.fnum = String(yytext);
	// fprintf(stderr, "%f\n", std::stof(*yylval.floatnumber));
	return FLOATNUMBER;
}


<INITIAL>. {
    pos++;
    printf("Illegal input \"%c\"\n", yytext[0]);
}
%%


int get10(char *s, int l)
{
	int ret = 0;
	for(int i = 0; i < l; i++) {
		ret = ret * 10 + s[i] - '0';
	}
	return ret;
}

int get8(char *s, int l)
{
	int ret = 0;
	for(int i = 0; i < l; i++) {
		ret = ret * 8 + s[i] - '0';
	}
	return ret;
}

int get16(char *s, int l)
{
	int ret = 0;
	for(int i = 0; i < l; i++) {
		ret = ret * 16;
		if (s[i] <= '9' && s[i] >= '0') ret += s[i] - '0';
		else if (s[i] <= 'f' && s[i] >= 'a') ret += 10 + s[i] - 'a';
		else if (s[i] <= 'F' && s[i] >= 'A') ret += 10 + s[i] - 'A';
	}
	return ret;
}
