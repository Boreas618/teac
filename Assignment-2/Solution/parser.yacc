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
  A_pos pos;
  A_tokenId tokenId;
  A_tokenNum tokenNum;
  A_type type;
  A_program program;
  A_programElementList programElementList;
  A_programElement programElement;
  A_fnDef fnDef;
  A_fnDeclStmt fnDeclStmt;
  A_structDef structDef;
  A_varDeclStmt varDeclStmt;
  A_codeBlockStmt codeBlockStmt;
  A_returnStmt returnStmt;
  A_whileStmt whileStmt;
  A_ifStmt ifStmt;
  A_callStmt callStmt;
  A_assignStmt assignStmt;
  A_paramDecl paramDecl;
  A_fnDecl fnDecl;
  A_varDeclList varDeclList;
  A_varDef varDef;
  A_varDecl varDecl;
  A_leftVal leftVal;
  A_rightVal rightVal;
  A_boolUnit boolUnit;
  A_boolExpr boolExpr;
  A_arithExpr arithExpr;
  A_exprUnit exprUnit;
  A_fnCall fnCall;
  A_rightValList rightValList;
  A_arrayExpr arrayExpr;
}

%token <tokenId> ID
%token <tokenNum> NUM
%token <pos> INT
%token <pos> STRUCT
%token <pos> IF
%token <pos> ELSE
%token <pos> WHILE
%token <pos> DOT
%token <pos> CONTINUE
%token <pos> BREAK
%token <pos> RETURN
%token <pos> SEMICOLON // ;
%token <pos> COMMA // ,
%token <pos> COLON // :
%token <pos> ARROW // ->
%token <pos> ADD
%token <pos> SUB
%token <pos> MUL
%token <pos> DIV
%token <pos> OR
%token <pos> AND
%token <pos> LT
%token <pos> LE
%token <pos> GT
%token <pos> GE
%token <pos> EQ
%token <pos> NE
%token <pos> NOT
%token <pos> LP // (
%token <pos> RP // )
%token <pos> LB // {
%token <pos> RB // }
%token <pos> LSB // [
%token <pos> RSB // ]
%token <pos> AS // =

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
%left NOT NEG
%right LSB 
%left RSB 

%left DOT
%right LP
%left RP

%type <type> Type
%type <program> Program
%type <programElementList> ProgramElementList
%type <programElement> ProgramElement
%type <fnDef> FnDef
%type <fnDeclStmt> FnDeclStmt
%type <structDef> StructDef
%type <varDeclStmt> VarDeclStmt
%type <codeBlockStmt> CodeBlockStmt
%type <returnStmt> ReturnStmt
%type <whileStmt> WhileStmt
%type <ifStmt> IfStmt
%type <callStmt> CallStmt
%type <assignStmt> AssignStmt
%type <paramDecl> ParamDecl
%type <fnDecl> FnDecl
%type <varDeclList> VarDeclList
%type <varDef> VarDef
%type <varDecl> VarDecl
%type <leftVal> LeftVal
%type <rightVal> RightVal
%type <boolUnit> BoolUnit
%type <boolExpr> BoolExpr
%type <arithExpr> ArithExpr
%type <exprUnit> ExprUnit
%type <fnCall> FnCall
%type <rightValList> RightValList
%type <arrayExpr> ArrayExpr

%start Program

%%                   /* beginning of rules section */

Program: ProgramElementList 
{  
  root = A_Program($1);
  $$ = A_Program($1);
}
;

ProgramElementList: ProgramElement ProgramElementList
{
  $$ = A_ProgramElementList($1, $2);
}
|
{
  $$ = NULL;
}
;

ProgramElement: VarDeclStmt
{
  $$ = A_ProgramVarDeclStmt($1->pos, $1);
}
| StructDef
{
  $$ = A_ProgramStructDef($1->pos, $1);
}
| FnDeclStmt
{
  $$ = A_ProgramFnDeclStmt($1->pos, $1);
}
| FnDef
{
  $$ = A_ProgramFnDef($1->pos, $1);
}
| SEMICOLON
{
  $$ = A_ProgramNullStmt($1);
}
;

ArithExpr: ArithExpr ADD ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_add, $3));
}
| ArithExpr SUB ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_sub, $3));
}
| ArithExpr MUL ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_mul, $3));
}
| ArithExpr DIV ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_div, $3));
}
| ExprUnit
{
  $$ = A_ExprUnit($1->pos, $1);
}
;

ArrayExpr: ID LSB ID RSB
{
  $$ = A_ArrayExpr($1->pos, $1, A_IdIndexExpr($3->pos, $3->id));
}
| ID LSB NUM RSB
{
  $$ = A_ArrayExpr($1->pos, $1, A_NumIndexExpr($3->pos, $3->num));
}
;

ExprUnit: NUM
{
  $$ = A_NumExprUnit($1->pos, $1->num);
}
| ID
{
  $$ = A_IdExprUnit($1->pos, $1->id);
}
| LP ArithExpr RP
{
  $$ = A_ArithExprUnit($1->pos, $2);
}
| FnCall
{
  $$ = A_CallExprUnit($1->pos, $1);
}
| ArrayExpr
{
  $$ = A_ArrayExprUnit($1->pos, $1);
}
| ID DOT ID
{
  $$ = A_MemberExprUnit($1->pos, A_MemberExpr($1->pos, $1->id, $3->id));
}
| SUB ExprUnit %prec NEG
{
  $$ = A_ArithUExprUnit($1->pos, A_ArithUExpr($1->pos, A_neg, $2));
}
;

BoolExpr: BoolExpr AND BoolUnit
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_and, $3));
}
| BoolExpr OR BoolUnit
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_or, $3));
}
| BoolUnit
{
  $$ = A_BoolExpr($1->pos, $1);
}
;

BoolUnit: LP ExprUnit LT ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_lt, $2, $4));
}
| LP ExprUnit LE ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_le, $2, $4));
}
| LP ExprUnit GT ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_gt, $2, $4));
}
| LP ExprUnit GE ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_ge, $2, $4));
}
| LP ExprUnit EQ ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_eq, $2, $4));
}
| LP ExprUnit NE ExprUnit RP
{
  $$ = A_ComExprUnit($1, A_ComExpr($2->pos, A_ne, $2, $4));
}
| LP BoolExpr RP
{
  $$ = A_BoolExprUnit($1->pos, $2);
}
| NOT BoolUnit
{
  $$ = A_BoolUOpExprUnit($1->pos, A_BoolUOpExpr($1->pos, A_not, $2));
}
;

AssignStmt: LeftVal AS RightVal SEMICOLON
{
  $$ = A_AssignStmt($1->pos, $1, $3);
}
;

LeftVal: ID
{
  $$ = A_IdExprLVal($1->pos, $1->id);
}
| ArrayExpr
{
  $$ = A_ArrExprLVal($1->pos, $1);
}
| ID DOT ID
{
  $$ = A_MemberExprLVal($1->pos, A_MemberExpr($1->pos, $1->id, $3->id));
}
;

RightVal: ArithExpr
{
  $$ = A_ArithExprRVal($1->pos, $1);
}
| BoolExpr
{
  $$ = A_BoolExprRVal($1->pos, $1);
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
          MINUS INT_CONST %prec NEG
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
      MINUS Exp %prec NEG
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


