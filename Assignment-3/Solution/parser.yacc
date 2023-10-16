%{
#include <stdio.h>
#include "TeaplAst.h"

extern A_pos pos;
extern A_program root;

extern int yylex(void);
extern "C"{
extern void yyerror(char *s); 
extern int  yywrap();
}

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
  A_codeBlockStmtList codeBlockStmtList;
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
%token <pos> BOOL // bool
%token <pos> VOID // void
%token <pos> LET
%token <pos> STRUCT
%token <pos> FN
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
%left LT LE GT GE EQ NE
%left ADD SUB
%left MUL DIV 
%right NOT NEG
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
%type <codeBlockStmtList> CodeBlockStmtList
%type <codeBlockStmtList> CodeBlock
%type <codeBlockStmt> CodeBlockStmt
%type <returnStmt> ReturnStmt
%type <whileStmt> WhileStmt
%type <ifStmt> IfStmt
%type <callStmt> CallStmt
%type <assignStmt> AssignStmt
%type <paramDecl> ParamDecl
%type <fnDecl> FnDecl
%type <varDeclList> VarDeclList
%type <varDeclList> VarDeclRestList
%type <varDef> VarDef
%type <varDecl> VarDecl
%type <varDecl> VarDeclRest
%type <leftVal> LeftVal
%type <rightVal> RightVal
%type <rightVal> RightValRest
%type <boolUnit> BoolUnit
%type <boolExpr> BoolExpr
%type <arithExpr> ArithExpr
%type <exprUnit> ExprUnit
%type <fnCall> FnCall
%type <rightValList> RightValList
%type <rightValList> RightValRestList
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
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_add, $1, $3));
}
| ArithExpr SUB ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_sub, $1, $3));
}
| ArithExpr MUL ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_mul, $1, $3));
}
| ArithExpr DIV ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_div, $1, $3));
}
| ExprUnit
{
  $$ = A_ExprUnit($1->pos, $1);
}
;

ArrayExpr: ID LSB ID RSB
{
  $$ = A_ArrayExpr($1->pos, $1->id, A_IdIndexExpr($3->pos, $3->id));
}
| ID LSB NUM RSB
{
  $$ = A_ArrayExpr($1->pos, $1->id, A_NumIndexExpr($3->pos, $3->num));
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
  $$ = A_ArithExprUnit($1, $2);
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
  $$ = A_ArithUExprUnit($1, A_ArithUExpr($1, A_neg, $2));
}
;

BoolExpr: BoolExpr AND BoolUnit
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_and, $1, $3));
}
| BoolExpr OR BoolUnit
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_or, $1, $3));
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
  $$ = A_BoolExprUnit($1, $2);
}
| NOT BoolUnit
{
  $$ = A_BoolUOpExprUnit($1, A_BoolUOpExpr($1, A_not, $2));
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

RightValList: RightVal RightValRestList
{
  $$ = A_RightValList($1, $2);
}
|
{
  $$ = NULL;
}
;
RightValRestList: RightValRest RightValRestList
{
  $$ = A_RightValList($1, $2);
}
|
{
  $$ = NULL;
}
;
RightValRest: COMMA RightVal
{
  $$ = $2;
}
;

FnCall: ID LP RightValList RP
{
  $$ = A_FnCall($1->pos, $1->id, $3);
}
;

VarDeclStmt: LET VarDecl SEMICOLON
{
  $$ = A_VarDeclStmt($1, $2);
}
| LET VarDef SEMICOLON
{
  $$ = A_VarDefStmt($1, $2);
}
;

VarDecl: ID COLON Type
{
  $$ = A_VarDecl_Scalar($1->pos, A_VarDeclScalar($1->pos, $1->id, $3));
}
| ID LSB NUM RSB COLON Type
{
  $$ = A_VarDecl_Array($1->pos, A_VarDeclArray($1->pos, $1->id, $3->num, $6));
}
;

VarDef: ID COLON Type AS RightVal
{
  $$ = A_VarDef_Scalar($1->pos, A_VarDefScalar($1->pos, $1->id, $3, $5));
}
| ID LSB NUM RSB COLON Type AS RightValList
{
  $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->id, $3->num, $6, $8));
}
;

Type: INT
{
  $$ = A_NativeType($1, A_intTypeKind);
}
| ID
{
  $$ = A_StructType($1->pos, $1->id);
}
| 
{
  $$ = NULL;
}
;


VarDeclList: VarDecl VarDeclRestList
{
  $$ = A_VarDeclList($1, $2);
}
|
{
  $$ = NULL;
}
;
VarDeclRestList: VarDeclRest VarDeclRestList
{
  $$ = A_VarDeclList($1, $2);
}
|
{
  $$ = NULL;
}
;
VarDeclRest: COMMA VarDecl
{
  $$ = $2;
}
;

StructDef: STRUCT ID LB VarDeclList RB
{
  $$ = A_StructDef($1, $2->id, $4);
}
;

ParamDecl: VarDeclList
{
  $$ = A_ParamDecl($1);
}
;

FnDecl: FN ID LP ParamDecl RP
{
  $$ = A_FnDecl($1, $2->id, $4, NULL);
}
| FN ID LP ParamDecl RP ARROW Type
{
  $$ = A_FnDecl($1, $2->id, $4, $7);
}
;

FnDeclStmt: FnDecl SEMICOLON
{
  $$ = A_FnDeclStmt($1->pos, $1);
}
;

ReturnStmt: RETURN RightVal SEMICOLON
{
  $$ = A_ReturnStmt($1, $2);
}
;

FnDef: FnDecl CodeBlock
{
  $$ = A_FnDef($1->pos, $1, $2);
}
;

CodeBlockStmt: VarDeclStmt
{
  $$ = A_BlockVarDeclStmt($1->pos, $1);
}
| AssignStmt
{
  $$ = A_BlockAssignStmt($1->pos, $1);
}
| CallStmt
{
  $$ = A_BlockCallStmt($1->pos, $1);
}
| IfStmt
{
  $$ = A_BlockIfStmt($1->pos, $1);
}
| WhileStmt
{
  $$ = A_BlockWhileStmt($1->pos, $1);
}
| ReturnStmt
{
  $$ = A_BlockReturnStmt($1->pos, $1);
}
| CONTINUE SEMICOLON
{
  $$ = A_BlockContinueStmt($1);
}
| BREAK SEMICOLON
{
  $$ = A_BlockBreakStmt($1);
}
| SEMICOLON
{
  $$ = A_BlockNullStmt($1);
}
;

CodeBlockStmtList: CodeBlockStmt CodeBlockStmtList
{
  $$ = A_CodeBlockStmtList($1, $2);
}
|
{
  $$ = NULL;
}
;

CodeBlock: LB CodeBlockStmtList RB
{
  $$ = $2;
}
;

CallStmt: FnCall SEMICOLON
{
  $$ = A_CallStmt($1->pos, $1);
}
;

IfStmt: IF LP BoolExpr RP CodeBlock
{
  $$ = A_IfStmt($1, $3, $5, NULL);
}
| IF LP BoolExpr RP CodeBlock ELSE CodeBlock
{
  $$ = A_IfStmt($1, $3, $5, $7);
}
;

WhileStmt: WHILE LP BoolExpr RP CodeBlock
{
  $$ = A_WhileStmt($1, $3, $5);
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


