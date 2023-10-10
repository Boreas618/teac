%{
#include <stdio.h>
#include <string.h>
#include "TeaplAst.h"
#include "y.tab.hpp"
extern int line, col;
int c;
int calc(char *s, int len);
%}

%s COMMENT1
%s COMMENT2

%%

<INITIAL>"//" { BEGIN COMMENT1; }
<COMMENT1>. ;
<COMMENT1>"\n" { col=1; ++line; BEGIN INITIAL; }


<INITIAL>"/*" { col+=2; BEGIN COMMENT2; }
<COMMENT2>. { ++col; }
<COMMENT2>"\n" { col=1; ++line; }
<COMMENT2>"*/" { col+=2; BEGIN INITIAL; }

<INITIAL>" " { ++col; }
<INITIAL>"\n" { col=1; ++line; }
<INITIAL>"\t" { col+=4; }
<INITIAL>"\r" ;
<INITIAL>"+" { yylval.pos = A_Pos(line, col); ++col; return ADD; }
<INITIAL>"*" { yylval.pos = A_Pos(line, col); ++col; return MUL; }
<INITIAL>"-" { yylval.pos = A_Pos(line, col); ++col; return SUB; }
<INITIAL>"/" { yylval.pos = A_Pos(line, col); ++col; return DIV; }
<INITIAL>"||" { yylval.pos = A_Pos(line, col); col+=2; return OR; }
<INITIAL>"&&" { yylval.pos = A_Pos(line, col); col+=2; return AND; }
<INITIAL>"<" { yylval.pos = A_Pos(line, col); ++col; return LT; }
<INITIAL>"<=" { yylval.pos = A_Pos(line, col); col+=2; return LE; }
<INITIAL>">" { yylval.pos = A_Pos(line, col); ++col; return GT; }
<INITIAL>">=" { yylval.pos = A_Pos(line, col); col+=2; return GE; }
<INITIAL>"==" { yylval.pos = A_Pos(line, col); col+=2; return EQ; }
<INITIAL>"!=" { yylval.pos = A_Pos(line, col); col+=2; return NE; }
<INITIAL>"!" { yylval.pos = A_Pos(line, col); ++col; return NOT; }
<INITIAL>";" { yylval.pos = A_Pos(line, col); ++col; return SEMICOLON; }
<INITIAL>"," { yylval.pos = A_Pos(line, col); ++col; return COMMA; }
<INITIAL>":" { yylval.pos = A_Pos(line, col); ++col; return COLON; }
<INITIAL>"->" { yylval.pos = A_Pos(line, col); col+=2; return ARROW; }
<INITIAL>"=" { yylval.pos = A_Pos(line, col); ++col; return AS; }
<INITIAL>"int" { yylval.pos = A_Pos(line, col); col+=3; return INT; }
<INITIAL>"bool" { yylval.pos = A_Pos(line, col); col+=4; return BOOL; }
<INITIAL>"void" { yylval.pos = A_Pos(line, col); col+=4; return VOID; }
<INITIAL>"let" { yylval.pos = A_Pos(line, col); col+=3; return LET; }
<INITIAL>"fn" { yylval.pos = A_Pos(line, col); col+=2; return FN; }
<INITIAL>"if" { yylval.pos = A_Pos(line, col); col+=2; return IF; }
<INITIAL>"else" { yylval.pos = A_Pos(line, col); col+=4; return ELSE; }
<INITIAL>"while" { yylval.pos = A_Pos(line, col); col+=5; return WHILE; }
<INITIAL>"." { yylval.pos = A_Pos(line, col); ++col; return DOT; }
<INITIAL>"continue" { yylval.pos = A_Pos(line, col); col+=8; return CONTINUE; }
<INITIAL>"break" { yylval.pos = A_Pos(line, col); col+=5; return BREAK; }
<INITIAL>"ret" { yylval.pos = A_Pos(line, col); col+=3; return RETURN; }
<INITIAL>"struct" { yylval.pos = A_Pos(line, col); col+=6; return STRUCT; }
<INITIAL>"(" { yylval.pos = A_Pos(line, col); ++col; return LP; }
<INITIAL>")" { yylval.pos = A_Pos(line, col); ++col; return RP; }
<INITIAL>"{" { yylval.pos = A_Pos(line, col); ++col; return LB; }
<INITIAL>"}" { yylval.pos = A_Pos(line, col); ++col; return RB; }
<INITIAL>"[" { yylval.pos = A_Pos(line, col); ++col; return LSB; }
<INITIAL>"]" { yylval.pos = A_Pos(line, col); ++col; return RSB; }
<INITIAL>[a-z_A-Z][a-z_A-Z0-9]* {
    yytext[yyleng] = 0;
    yylval.tokenId = A_TokenId(A_Pos(line, col), strdup(yytext));
    col+=yyleng;
    return ID;
}
<INITIAL>[1-9][0-9]* {
    yylval.tokenNum = A_TokenNum(A_Pos(line, col), calc(yytext, yyleng));
    col+=yyleng;
    return NUM;
}
<INITIAL>0 {
    yylval.tokenNum = A_TokenNum(A_Pos(line, col), 0);
    ++col;
    return NUM;
}
<INITIAL>. {
    printf("Illegal input \"%c\"\n", yytext[0]);
    ++col;
}
%%

int calc(char *s, int len) {
    int ret = 0;
    for(int i = 0; i < len; i++)
        ret = ret * 10 + (s[i] - '0');
    return ret;
}