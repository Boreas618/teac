%{
#include <stdio.h>
#include "TeaplAst.h"

extern A_pos pos;
extern A_prog root;

extern int yylex(void);

extern "C"{
extern void yyerror(char *s); 
extern int  yywrap();
}

// extern int yydebug = 1;

%}


%union {
  A_pos p_pos;
  A_type type;
  A_prog p;
  A_mainMethod mm;
  A_classDecl cd;
  A_classDeclList cdl;
  A_methodDecl md;
  A_methodDeclList mdl;
  A_formal f;
  A_formalList fl;
  A_varDecl vd;
  A_varDeclList vdl;
  A_stmList sl;
  A_stm s;
  A_exp e;
  A_expList el;
  int t;
  string str;
}

%token <e> ID
%token <e> INT_CONST
%token <p_pos> PUBLIC
%token <p_pos> INT
%token <p_pos> MAIN
%token <p_pos> CLASS
%token <p_pos> EXTENDS
%token <p_pos> IF
%token <p_pos> ELSE
%token <p_pos> WHILE
%token <p_pos> DOT
%token <p_pos> CONTINUE
%token <p_pos> BREAK
%token <p_pos> RETURN
%token <p_pos> PUTARRAY
%token <p_pos> STARTTIME
%token <p_pos> STOPTIME
%token <p_pos> PUTINT
%token <p_pos> PUTCH
%token <p_pos> SEMICOLON /*';'*/
%token <p_pos> COMMA /*','*/
%token <p_pos> PLUS
%token <p_pos> MINUS
%token <p_pos> MUL
%token <p_pos> DIV
%token <p_pos> OR
%token <p_pos> AND
%token <p_pos> LESS
%token <p_pos> LE
%token <p_pos> GREATER
%token <p_pos> GE
%token <p_pos> EQ
%token <p_pos> NE
%token <p_pos> T
%token <p_pos> F
%token <p_pos> LENGTH
%token <p_pos> THIS
%token <p_pos> NEW
%token <p_pos> NOT
%token <p_pos> GETINT
%token <p_pos> GETCH
%token <p_pos> GETARRAY 
%token <p_pos> LP /*'('*/
%token <p_pos> RP /*')'*/
%token <p_pos> LB /*'{'*/
%token <p_pos> RB /*'}'*/
%token <p_pos> LSB /*'['*/
%token <p_pos> RSB /*']'*/
%token <p_pos> AS /*'='*/

%left SEMICOLON
%left COMMA
%left WHILE
%left IF
%left ELSE
%left ID
%left AS
%left AND OR
%left LESS LE GREATER GE EQ NE
%left PLUS MINUS
%left MUL DIV 
%left NOT UMINUS
%right LSB 
%left RSB 

%left DOT
%right LP
%left RP

%type <type> Type
%type <p> Program
%type <mm> MainMethod
%type <cd> ClassDecl
%type <cdl> ClassDeclList
%type <md> MethodDecl
%type <mdl> MethodDeclList
%type <fl> FormalList
%type <fl> FormalRestList
%type <f> FormalRest
%type <vd> VarDecl
%type <vdl> VarDeclList
%type <sl> StatementList
%type <s> Statement
%type <e> Exp
%type <el> ExpList
%type <e> ExpRest
%type <el> ExpRestList
%type <e> IntConst
%type <el> IntConstList
%type <e> IntConstRest
%type <el> IntConstRestList

%start Program

%%                   /* beginning of rules section */

Program:  MainMethod ClassDeclList
          {
            root = A_Prog($1->pos, $1, $2);
            $$ = A_Prog($1->pos, $1, $2);
          }
          ;
MainMethod: PUBLIC INT MAIN LP RP LB VarDeclList StatementList RB
            {
              $$ = A_MainMethod($1, $7, $8);
            }
            ;
ClassDeclList:  ClassDecl ClassDeclList
                {
                  $$ = A_ClassDeclList($1, $2);
                }
                |
                {
                  $$ = NULL;
                }
                ;
ClassDecl:  PUBLIC CLASS ID LB VarDeclList MethodDeclList RB
            {
              $$ = A_ClassDecl($1, $3->u.v, NULL, $5, $6);
            }
            |
            PUBLIC CLASS ID EXTENDS ID LB VarDeclList MethodDeclList RB
            {
              $$ = A_ClassDecl($1, $3->u.v, $5->u.v, $7, $8);
            }
            ;
VarDeclList:  VarDecl VarDeclList
              {
                $$ = A_VarDeclList($1, $2);
              }
              |
              {
                $$ = NULL;
              }
              ;
VarDecl:  CLASS ID ID SEMICOLON
          {
            $$ = A_VarDecl($1, A_Type($1, A_idType, $2->u.v), $3->u.v, NULL);
          }
          |
          INT ID SEMICOLON
          {
            $$ = A_VarDecl($1, A_Type($1, A_intType, NULL), $2->u.v, NULL);
          }
          |
          INT ID AS IntConst SEMICOLON
          {
            $$ = A_VarDecl($1, A_Type($1, A_intType, NULL), $2->u.v, A_ExpList($4, NULL));
          }
          |
          INT LSB RSB ID SEMICOLON
          {
            $$ = A_VarDecl($1, A_Type($1, A_intArrType, NULL), $4->u.v, NULL);
          }
          |
          INT LSB RSB ID AS LB IntConstList RB SEMICOLON
          {
            $$ = A_VarDecl($1, A_Type($1, A_intArrType, NULL), $4->u.v, $7);
          }
          ;
IntConst:  INT_CONST
          {
            $$ = $1;
          }
          |
          MINUS INT_CONST %prec UMINUS
          {
            $$ = A_NumConst($1, -($2->u.num));
          }
          ;
IntConstList: IntConst IntConstRestList
              {
                $$ = A_ExpList($1, $2);
              }
              |
              {
                $$ = NULL;
              }
              ;
IntConstRestList: IntConstRest IntConstRestList
                  {
                    $$ = A_ExpList($1, $2);
                  }
                  |
                  {
                    $$ = NULL;
                  }
                  ;
IntConstRest: COMMA IntConst
              {
                $$ = $2;
              }
              ;
MethodDeclList: MethodDecl MethodDeclList
                {
                  $$ = A_MethodDeclList($1, $2);
                }
                |
                {
                  $$ = NULL;
                }
                ;
MethodDecl: PUBLIC Type ID LP FormalList RP LB VarDeclList StatementList RB
                {
                  $$ = A_MethodDecl($1, $2, $3->u.v, $5, $8, $9);
                }
                ;
FormalList: Type ID FormalRestList
            {
              $$ = A_FormalList(A_Formal($1->pos, $1, $2->u.v), $3);
            }
            |
            {
              $$ = NULL;
            }
            ;
FormalRestList: FormalRest FormalRestList
                {
                  $$ = A_FormalList($1, $2);
                }
                |
                {
                  $$ = NULL;
                }
                ;
FormalRest: COMMA Type ID
            {
              $$ = A_Formal($1, $2, $3->u.v);
            }
            ;
Type: CLASS ID
      {
        $$ = A_Type($1, A_idType, $2->u.v);
      }
      |
      INT
      {
        $$ = A_Type($1, A_intType, NULL);
      }
      |
      INT LSB RSB
      {
        $$ = A_Type($1, A_intArrType, NULL);
      }
      ;
StatementList:  Statement StatementList
                {
                  $$ = A_StmList($1, $2);
                }
                |
                {
                  $$ = NULL;
                }
                ;
Statement:  LB StatementList RB
            {
              $$ = A_NestedStm($1, $2);
            }
            |
            IF LP Exp RP Statement ELSE Statement
            {
              $$ = A_IfStm($1, $3, $5, $7);
            }
            |
            IF LP Exp RP Statement %prec IF
            {
              $$ = A_IfStm($1, $3, $5, NULL);
            }
            |
            WHILE LP Exp RP Statement
            {
              $$ = A_WhileStm($1, $3, $5);
            }
            |
            WHILE LP Exp RP SEMICOLON
            {
              $$ = A_WhileStm($1, $3, NULL);
            }
            |
            Exp AS Exp SEMICOLON
            {
              $$ = A_AssignStm($1->pos, $1, $3);
            }
            |
            Exp LSB RSB AS LB ExpList RB SEMICOLON
            {
              $$ = A_ArrayInit($1->pos, $1, $6);
            }
            |
            Exp DOT ID LP ExpList RP SEMICOLON
            {
              $$ = A_CallStm($1->pos, $1, $3->u.v, $5);
            }
            |
            CONTINUE SEMICOLON
            {
              $$ = A_Continue($1);
            }
            |
            BREAK SEMICOLON
            {
              $$ = A_Break($1);
            }
            |
            RETURN Exp SEMICOLON
            {
              $$ = A_Return($1, $2);
            }
            |
            PUTINT LP Exp RP SEMICOLON
            {
              $$ = A_Putint($1, $3);
            }
            |
            PUTCH LP Exp RP SEMICOLON
            {
              $$ = A_Putch($1, $3);
            }
            |
            PUTARRAY LP Exp COMMA Exp RP SEMICOLON
            {
              $$ = A_Putarray($1, $3, $5);
            }
            |
            STARTTIME LP RP SEMICOLON
            {
              $$ = A_Starttime($1);
            }
            |
            STOPTIME LP RP SEMICOLON
            {
              $$ = A_Stoptime($1);
            }
            ;
Exp:  Exp PLUS Exp
      {
        $$ = A_OpExp($1->pos, $1, A_plus, $3);
      }
      |
      Exp MINUS Exp
      {
        $$ = A_OpExp($1->pos, $1, A_minus, $3);
      }
      |
      Exp MUL Exp
      {
        $$ = A_OpExp($1->pos, $1, A_times, $3);
      }
      |
      Exp DIV Exp
      {
        $$ = A_OpExp($1->pos, $1, A_div, $3);
      }
      |
      Exp OR Exp
      {
        $$ = A_OpExp($1->pos, $1, A_or, $3);
      }
      |
      Exp AND Exp
      {
        $$ = A_OpExp($1->pos, $1, A_and, $3);
      }
      |
      Exp LESS Exp
      {
        $$ = A_OpExp($1->pos, $1, A_less, $3);
      }
      |
      Exp LE Exp
      {
        $$ = A_OpExp($1->pos, $1, A_le, $3);
      }
      |
      Exp GREATER Exp
      {
        $$ = A_OpExp($1->pos, $1, A_greater, $3);
      }
      |
      Exp GE Exp
      {
        $$ = A_OpExp($1->pos, $1, A_ge, $3);
      }
      |
      Exp EQ Exp
      {
        $$ = A_OpExp($1->pos, $1, A_eq, $3);
      }
      |
      Exp NE Exp
      {
        $$ = A_OpExp($1->pos, $1, A_ne, $3);
      }
      |
      Exp LSB Exp RSB
      {
        $$ = A_ArrayExp($1->pos, $1, $3);
      }
      |
      Exp DOT ID LP ExpList RP
      {
        $$ = A_CallExp($1->pos, $1, $3->u.v, $5);
      }
      |
      Exp DOT ID
      {
        $$ = A_ClassVarExp($1->pos, $1, $3->u.v);
      }
      |
      INT_CONST
      {
        $$ = $1;
      }
      |
      T
      {
        $$ = A_BoolConst($1, TRUE);
      }
      |
      F
      {
        $$ = A_BoolConst($1, FALSE);
      }
      |
      LENGTH LP Exp RP
      {
        $$ = A_LengthExp($1, $3);
      }
      |
      ID
      {
        $$ = $1;
      }
      |
      THIS
      {
        $$ = A_ThisExp($1);
      }
      |
      NEW INT LSB Exp RSB
      {
        $$ = A_NewIntArrExp($1, $4);
      }
      |
      NEW ID LP RP
      {
        $$ = A_NewObjExp($1, $2->u.v);
      }
      |
      NOT Exp
      {
        $$ = A_NotExp($1, $2);
      }
      |
      MINUS Exp %prec UMINUS
      {
        $$ = A_MinusExp($1, $2);
      }
      |
      LP Exp RP
      {
        $$ = $2;
      }
      |
      LP LB StatementList RB Exp RP
      {
        $$ = A_EscExp($1, $3, $5);
      }
      |
      GETINT LP RP
      {
        $$ = A_Getint($1);
      }
      |
      GETCH LP RP
      {
        $$ = A_Getch($1);
      }
      |
      GETARRAY LP Exp RP
      {
        $$ = A_Getarray($1, $3);
      }
      ;
ExpList:  Exp ExpRestList
          {
            $$ = A_ExpList($1, $2);
          }
          |
          {
            $$ = NULL;
          }
          ;
ExpRestList:  ExpRest ExpRestList
              {
                $$ = A_ExpList($1, $2);
              }
              |
              {
                $$ = NULL;
              }
              ;
ExpRest:  COMMA Exp
          {
            $$ = $2;
          }
          ;

%%

extern "C"{
void yyerror(char * s)
{
  fprintf(stderr, "%s\n",s);
}

int yywrap()
{
  return(1);
}
}


