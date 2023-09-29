%{
#include <stdio.h>
#include <string.h>
#include "TeaplAst.h"
#include "y.tab.h"
extern A_pos pos;
int c;
int calc(char *s, int len);
A_pos A_pos_(A_pos p_pos);
A_exp A_IdExp_lex(A_pos pos, string id);
A_exp A_NumConst_lex(A_pos pos, int i);
void *checked_malloc_lex(int len);
%}

%s COMMENT1
%s COMMENT2

%%

<INITIAL>"//" { BEGIN COMMENT1; }
<COMMENT1>. ;
<COMMENT1>"\n" { pos->pos=1; ++pos->line; BEGIN INITIAL; }


<INITIAL>"/*" { pos->pos+=2; BEGIN COMMENT2; }
<COMMENT2>. { ++pos->pos; }
<COMMENT2>"\n" { pos->pos=1; ++pos->line; }
<COMMENT2>"*/" { pos->pos+=2; BEGIN INITIAL; }

<INITIAL>" " { ++pos->pos; }
<INITIAL>"\n" { pos->pos=1; ++pos->line; }
<INITIAL>"\t" { pos->pos+=4; }
<INITIAL>"\r" ;
<INITIAL>"+" { yylval.p_pos = A_pos_(pos); ++pos->pos; return PLUS; }
<INITIAL>"*" { yylval.p_pos = A_pos_(pos); ++pos->pos; return MUL; }
<INITIAL>"-" { yylval.p_pos = A_pos_(pos); ++pos->pos; return MINUS; }
<INITIAL>"/" { yylval.p_pos = A_pos_(pos); ++pos->pos; return DIV; }
<INITIAL>"||" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return OR; }
<INITIAL>"&&" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return AND; }
<INITIAL>"<" { yylval.p_pos = A_pos_(pos); pos->pos+=1; return LESS; }
<INITIAL>"<=" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return LE; }
<INITIAL>">" { yylval.p_pos = A_pos_(pos); pos->pos+=1; return GREATER; }
<INITIAL>">=" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return GE; }
<INITIAL>"==" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return EQ; }
<INITIAL>"!=" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return NE; }
<INITIAL>"true" { yylval.p_pos = A_pos_(pos); pos->pos+=4; return T; }
<INITIAL>"false" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return F; }
<INITIAL>"length" { yylval.p_pos = A_pos_(pos); pos->pos+=6; return LENGTH; }
<INITIAL>"this" { yylval.p_pos = A_pos_(pos); pos->pos+=4; return THIS; }
<INITIAL>"new" { yylval.p_pos = A_pos_(pos); pos->pos+=3; return NEW; }
<INITIAL>"!" { yylval.p_pos = A_pos_(pos); pos->pos+=1; return NOT; }
<INITIAL>"getint" { yylval.p_pos = A_pos_(pos); pos->pos+=6; return GETINT; }
<INITIAL>"getch" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return GETCH; }
<INITIAL>"getarray" { yylval.p_pos = A_pos_(pos); pos->pos+=8; return GETARRAY; }
<INITIAL>";" { yylval.p_pos = A_pos_(pos); ++pos->pos; return SEMICOLON; }
<INITIAL>"," { yylval.p_pos = A_pos_(pos); ++pos->pos; return COMMA; }
<INITIAL>"=" { yylval.p_pos = A_pos_(pos); ++pos->pos; return AS; }
<INITIAL>"putint" { yylval.p_pos = A_pos_(pos); pos->pos+=6; return PUTINT; }
<INITIAL>"putch" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return PUTCH; }
<INITIAL>"public" { yylval.p_pos = A_pos_(pos); pos->pos+=6; return PUBLIC; }
<INITIAL>"int" { yylval.p_pos = A_pos_(pos); pos->pos+=3; return INT; }
<INITIAL>"if" { yylval.p_pos = A_pos_(pos); pos->pos+=2; return IF; }
<INITIAL>"else" { yylval.p_pos = A_pos_(pos); pos->pos+=4; return ELSE; }
<INITIAL>"while" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return WHILE; }
<INITIAL>"." { yylval.p_pos = A_pos_(pos); pos->pos+=1; return DOT; }
<INITIAL>"continue" { yylval.p_pos = A_pos_(pos); pos->pos+=8; return CONTINUE; }
<INITIAL>"break" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return BREAK; }
<INITIAL>"return" { yylval.p_pos = A_pos_(pos); pos->pos+=6; return RETURN; }
<INITIAL>"putarray" { yylval.p_pos = A_pos_(pos); pos->pos+=8; return PUTARRAY; }
<INITIAL>"starttime" { yylval.p_pos = A_pos_(pos); pos->pos+=9; return STARTTIME; }
<INITIAL>"stoptime" { yylval.p_pos = A_pos_(pos); pos->pos+=8; return STOPTIME; }
<INITIAL>"main" { yylval.p_pos = A_pos_(pos); pos->pos+=4; return MAIN; }
<INITIAL>"class" { yylval.p_pos = A_pos_(pos); pos->pos+=5; return CLASS; }
<INITIAL>"extends" { yylval.p_pos = A_pos_(pos); pos->pos+=7; return EXTENDS; }
<INITIAL>"(" { yylval.p_pos = A_pos_(pos); ++pos->pos; return LP; }
<INITIAL>")" { yylval.p_pos = A_pos_(pos); ++pos->pos; return RP; }
<INITIAL>"{" { yylval.p_pos = A_pos_(pos); ++pos->pos; return LB; }
<INITIAL>"}" { yylval.p_pos = A_pos_(pos); ++pos->pos; return RB; }
<INITIAL>"[" { yylval.p_pos = A_pos_(pos); ++pos->pos; return LSB; }
<INITIAL>"]" { yylval.p_pos = A_pos_(pos); ++pos->pos; return RSB; }
<INITIAL>[a-z_A-Z][a-z_A-Z0-9]* {
    yytext[yyleng] = 0;
    yylval.e = A_IdExp_lex(A_pos_(pos), strdup(yytext));
    pos->pos+=yyleng;
    return ID;
}
<INITIAL>[1-9][0-9]* {
    yylval.e = A_NumConst_lex(A_pos_(pos), calc(yytext, yyleng));
    pos->pos+=yyleng;
    return INT_CONST;
}
<INITIAL>0 {
    yylval.e = A_NumConst_lex(A_pos_(pos), 0);
    ++pos->pos;
    return INT_CONST;
}
<INITIAL>. {
    printf("Illegal input \"%c\"\n", yytext[0]);
    ++pos->pos;
}
%%

int calc(char *s, int len) {
    /* printf("len %d\n", len); */
    int ret = 0;
    for(int i = 0; i < len; i++)
        ret = ret * 10 + (s[i] - '0');
    return ret;
}

A_pos A_pos_(A_pos p_pos) {
    A_pos pos=(A_pos)checked_malloc_lex(sizeof(*pos));
    pos->line = p_pos->line;
    pos->pos = p_pos->pos;
    return pos;
}

A_exp A_IdExp_lex(A_pos pos, string id) {
    A_exp e=(A_exp)checked_malloc_lex(sizeof(*e));
    e->pos=pos;
    e->kind=A_idExp;
    e->u.v=id;
    return e;
}

A_exp A_NumConst_lex(A_pos pos, int i) {
    A_exp e=(A_exp)checked_malloc_lex(sizeof(*e));
    e->pos=pos;
    e->kind=A_numConst;
    e->u.num=i;
    return e;
}

void *checked_malloc_lex(int len)
{void *p = malloc(len);
 if (!p) {
    fprintf(stderr,"\nRan out of memory!\n");
    exit(1);
 }
 return p;
}