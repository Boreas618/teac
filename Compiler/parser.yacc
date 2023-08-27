%{
#include <stdio.h>
#include "ast.h"

extern A_prog root;

extern int yylex();
extern void yyerror(char*);
extern int  yywrap();


%}

%union
{
    A_pos token; // 例：数字类
    A_stmt stmt; // 例：自定义的类
    A_exp exp;
    A_expList expList;
    A_prog prog;
    A_compUnit compUnit;
    A_compUnitList compUnitList;
    A_decl decl;
    A_funcDef funcDef;
    A_constDecl constDecl;
    A_varDecl varDecl;
    A_constDefList constDefList;
    A_constDef constDef;
    A_constExp constExp;
    A_constExpList constExpList;
    A_varDef varDef;
    A_varDefList varDefList;
    A_funcFParams funcFParams;
    A_funcFParamList funcFparamList;
    A_funcFParam funcFParam;
    enum A_funcType funcType;
    A_block block;
    A_blockItem blockItem;
    A_blockItemList blockItemList;
    A_initVal initVal;
    A_arrayInit arrayInit;
    A_initValList initValList;
    int inum;
    string fnum;
    string id;
    string fmt;
}

// token的类
// %token <name in union> token_name_1 token_name_2
%token <token> OP_PLUS OP_MULTIPLY OP_MINUS OP_DIV UMINUS CONST OP_MOD UPLUS
%token <token> PUTINT PUTCH ASSIGN WHILE IF ELSE CONTINUE BREAK RETURN INT FLOAT VOID GETFLOAT PUTFLOAT
%token <token> PUTARRAY STARTTIME STOPTIME GETINT GETARRAY GETCH AND OR LT GT LE GE EQ NEQ PUTFARRAY GETFARRAY PUTF
%token <inum> INTNUMBER
%token <fnum> FLOATNUMBER
%token <id> IDENTIFIER
%token <fmt> FMT

// 非终结符的类
%type <id> EXID
%type <exp> EXP EXPREST
%type <expList> EXPLIST EXPRESTLIST EXPARRLIST
%type <stmt> STMT
%type <prog> PROG
%type <compUnit> COMPUNIT
%type <compUnitList> COMPUNITLIST
%type <decl> DECL
%type <funcDef> FUNCDEF
%type <constDecl> CONSTDECL
%type <varDecl> VARDECL
%type <constDefList> CONSTDEFLIST
%type <constDef> CONSTDEF
%type <varDefList> VARDEFLIST
%type <varDef> VARDEF
%type <funcFParams> FUNCFPARAMS
%type <funcFparamList> FUNCFPARAMLIST
%type <funcFParam> FUNCFPARAM FUNCFPARAMREST
%type <funcType> FUNCTYPE
%type <block> BLOCK
%type <blockItemList> BLOCKITEMLIST
%type <blockItem> BLOCKITEM
%type <initVal> INITVAL INITVALREST
%type <arrayInit> ARRAYINIT
%type <initValList> INITVALLIST INITVALRESTLIST

%start PROG

%left OR
%left AND
%left EQ NEQ
%left LT GT LE GE
%left OP_PLUS OP_MINUS
%left OP_MULTIPLY OP_DIV OP_MOD
%left UMINUS '!' UPLUS
%left IDENTIFIER
%left '[' ']'
%left '(' ')'
%left ASSIGN
%left IF
%left ELSE


%%

EXID: IDENTIFIER 
      {
          $$ = $1;
      }
      |
      PUTCH
      {
        $$ = String("putch");
      }
      |
      PUTINT
      {
        $$ = String("putint");
      }
      |
      PUTFLOAT
      {
        $$ = String("putfloat");
      }
      |
      PUTF
      {
        $$ = String("putf");
      }
      |
      PUTARRAY
      {
        $$ = String("putarray");
      }
      |
      PUTFARRAY
      {
        $$ = String("putfarray");
      }
      |
      GETCH
      {
        $$ = String("getch");
      }
      |
      GETINT
      {
        $$ = String("getint");
      }
      |
      GETFLOAT
      {
        $$ = String("getfloat");
      }
      |
      GETARRAY
      {
        $$ = String("getarray");
      }
      |
      GETFARRAY
      {
        $$ = String("getfarray");
      }
      |
      STOPTIME
      {
        $$ = String("stoptime");
      }
      |
      STARTTIME
      {
        $$ = String("starttime");
      }
EXP: INTNUMBER
      {
          $$ = A_IntConst(A_Pos(0,0),$1);
      }
      |
      FLOATNUMBER
      {
          $$ = A_FloatConst(A_Pos(0,0),$1);
      }
      | 
      EXID 
      {
          $$ = A_IdExp(A_Pos(0,0),$1);
      }
      |
      EXP OP_PLUS EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_plus, $3);
      } 
      | 
      EXP OP_MULTIPLY EXP
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_times, $3);
      }
      |
      EXP OP_MINUS EXP 
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_minus, $3);
      }
      |
      EXP OP_DIV EXP
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_div, $3);
      }
      |
      EXP OP_MOD EXP
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_mod, $3);
      }
      |
      EXP AND EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_and, $3);
      } 
      | 
      EXP OR EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_or, $3);
      } 
      | 
      EXP LT EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_less, $3);
      } 
      | 
      EXP GT EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_greater, $3);
      } 
      | 
      EXP LE EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_le, $3);
      } 
      | 
      EXP GE EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_ge, $3);
      } 
      | 
      EXP EQ EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_eq, $3);
      } 
      | 
      EXP NEQ EXP  
      {
          $$ = A_OpExp(A_Pos($1->pos->line,$1->pos->pos),$1, A_ne, $3);
      } 
      | 
      OP_MINUS EXP %prec UMINUS
      {
        $$ = A_MinusExp(A_Pos($1->line,$1->pos),$2);
      }
      |
      OP_PLUS EXP %prec UPLUS
      {
        $$ = $2;
      }
      |
      '(' EXP ')'
      {
        $$ = $2;
      }
      |
      EXP '[' EXP ']' EXPARRLIST
      {
        $$ = A_ArrayExp(A_Pos($1->pos->line,$1->pos->pos),$1,A_ExpList($3,$5));
      }
      |
      '!' EXP
      {
        $$ = A_NotExp(A_Pos($2->pos->line,$2->pos->pos),$2);
      }
      |
      GETINT '(' ')'
      {
        $$ = A_Getint($1);
      }
      |
      GETCH '(' ')'
      {
        $$ = A_Getch($1);
      }
      |
      GETFLOAT '(' ')'
      {
        $$ = A_Getfloat($1);
      }
      |
      GETARRAY '(' EXP ')'
      {
        $$ = A_Getarray(A_Pos($1->line,$1->pos),$3);
      }
      |
      GETFARRAY '(' EXP ')'
      {
        $$ = A_Getfarray(A_Pos($1->line,$1->pos),$3);
      }
      |
      IDENTIFIER '(' EXPLIST ')'
      {
        $$ = A_CallExp(A_Pos(0,0),String($1),$3);
      }
EXPLIST: EXP EXPRESTLIST
    {
        $$ = A_ExpList($1,$2);
    }
    |

    {
        $$ = NULL;
    }
EXPREST: ',' EXP
    {
        $$ = $2;
    }
EXPRESTLIST: EXPREST EXPRESTLIST
    {
        $$ = A_ExpList($1,$2);
    }
    |

    {
        $$ = NULL;
    }
EXPARRLIST: '[' EXP ']' EXPARRLIST
    {
        $$ = A_ExpList($2,$4);
    }
    |

    {
        $$ = NULL;
    }
STMT: EXP ASSIGN EXP ';'
    {
        $$ = A_AssignStm(A_Pos($1->pos->line,$1->pos->pos),$1,$3);
    }
    |
    PUTINT '(' EXP ')' ';'
    {
        $$ = A_Putint(A_Pos($1->line,$1->pos),$3);
    }
    |
    PUTCH '(' EXP ')' ';'
    {
        $$ = A_Putch(A_Pos($1->line,$1->pos),$3);
    }
    |
    PUTFLOAT '(' EXP ')' ';'
    {
        $$ = A_Putfloat(A_Pos($1->line,$1->pos),$3);
    }
    |
    BLOCK
    {
        $$ = A_BlockStm(A_Pos($1->pos->line,$1->pos->pos),$1);
    }
    |
    IF '(' EXP ')' STMT ELSE STMT
    {
        $$ = A_IfStm(A_Pos($1->line,$1->pos),$3,$5,$7);
    }
    |
    IF '(' EXP ')' STMT  
    {
        $$ = A_IfStm(A_Pos($1->line,$1->pos),$3,$5,NULL);
    }
    |
    WHILE '(' EXP ')' STMT
    {
        $$ = A_WhileStm(A_Pos($1->line,$1->pos),$3,$5);
    }
    |
    CONTINUE ';'
    {
        $$ = A_Continue($1);
    }
    |
    BREAK ';'
    {
        $$ = A_Break($1);
    }
    |
    RETURN EXP ';'
    {
        $$ = A_Return(A_Pos($1->line,$1->pos),$2);
    }
    |
    RETURN ';'
    {
        $$ = A_Return(A_Pos($1->line,$1->pos),NULL);
    }
    |
    PUTARRAY '(' EXP ',' EXP ')' ';'
    {
        $$ = A_Putarray(A_Pos($1->line,$1->pos),$3,$5);
    }
    |
    PUTFARRAY '(' EXP ',' EXP ')' ';'
    {
        $$ = A_Putfarray(A_Pos($1->line,$1->pos),$3,$5);
    }
    |
    PUTF '(' FMT EXPRESTLIST ')' ';'
    {
        $$ = A_Putf(A_Pos($1->line,$1->pos),$3,$4);
    }
    |
    STARTTIME '(' ')' ';'
    {
        $$ = A_Starttime($1);
    }
    |
    STOPTIME '(' ')' ';'
    {
        $$ = A_Stoptime($1);
    }
    |
    EXP ';'
    {
        $$ = A_ExpStm($1->pos,$1);
    }
    |
    ';'
    {
        $$ = A_ExpStm(A_Pos(0,0),NULL);
    }
PROG: COMPUNITLIST
    {
        root = A_Prog(A_Pos(0,0),$1);
        $$ = A_Prog(A_Pos(0,0),$1);
    }
COMPUNIT: DECL
    {
        $$ = A_CompUnitDecl($1->pos,$1);
    }
    |
    FUNCDEF
    {
        $$ = A_CompUnitFuncDef($1->pos,$1);
    }
COMPUNITLIST: COMPUNIT COMPUNITLIST
    {
        $$ = A_CompUnitList($1,$2);
    }
    |

    {
        $$ = NULL;
    }
DECL: CONSTDECL
    {
        $$ = A_DeclConst($1->pos,$1);
    }
    |
    VARDECL
    {
        $$ = A_DeclVar($1->pos,$1);
    }
CONSTDECL: CONST FUNCTYPE CONSTDEF CONSTDEFLIST ';'
    {
        $$ = A_ConstDecl($1,$2,A_ConstDefList($3,$4));
    }
CONSTDEFLIST: ',' CONSTDEF CONSTDEFLIST
    {
        $$ = A_ConstDefList($2,$3);
    }
    |

    {
        $$ = NULL;
    }
CONSTDEF: EXID EXPARRLIST ASSIGN INITVAL
    {
        $$ = A_ConstDef(A_Pos(0,0),String($1),$2,$4);
    }
INITVAL: EXP 
    {
        $$ = A_InitValExp($1->pos,$1);
    } 
    | 
    ARRAYINIT 
    {
        $$ = A_InitValArray($1->pos,$1);
    }

ARRAYINIT: '{' INITVALLIST '}' 
    {
        $$ = A_ArrayInit(A_Pos(0,0),$2);
    }

INITVALLIST: 
    {
        $$ = NULL;
    } 
    |  
    INITVAL INITVALRESTLIST
    {
        $$ = A_InitValList($1,$2);
    }
INITVALREST: ',' INITVAL
    {
        $$ = $2;
    }
INITVALRESTLIST: 
    {
        $$ = NULL;
    } 
    |  
    INITVALREST INITVALRESTLIST
    {
        $$ = A_InitValList($1,$2);
    }
VARDECL: FUNCTYPE VARDEF VARDEFLIST ';'
    {
        $$ = A_VarDecl($2->pos,$1,A_VarDefList($2,$3));
    }
VARDEFLIST: ',' VARDEF VARDEFLIST
    {
        $$ = A_VarDefList($2,$3);
    }
    |

    {
        $$ = NULL;
    }
VARDEF: EXID EXPARRLIST
    {
        $$ = A_VarDef(A_Pos(0,0),String($1),$2,NULL);
    }
    |
    EXID EXPARRLIST ASSIGN INITVAL
    {
        $$ = A_VarDef(A_Pos(0,0),String($1),$2,$4);
    }
FUNCDEF: FUNCTYPE IDENTIFIER '(' FUNCFPARAMS ')' BLOCK
    {
        $$ = A_FuncDef(A_Pos(0,0),$1,String($2),$4,$6);
    }
FUNCTYPE: INT
    {
        $$ = A_FuncType(0);
    }
    |
    FLOAT
    {
        $$ = A_FuncType(1);
    }
    |
    VOID
    {
        $$ = A_FuncType(2);
    }
FUNCFPARAMS: FUNCFPARAM FUNCFPARAMLIST
    {
        $$ = A_FuncFParams($1->pos,A_FuncFParamList($1,$2));
    }
    |

    {
        $$ = A_FuncFParams(NULL,NULL);
    }
FUNCFPARAM: FUNCTYPE EXID
    {
        $$ = A_FuncFParam(A_Pos(0,0),$1,String($2),NULL,0);
    }
    |
    FUNCTYPE EXID '[' ']' EXPARRLIST
    {
        $$ = A_FuncFParam(A_Pos(0,0),$1,String($2),$5,1);
    }
FUNCFPARAMLIST: FUNCFPARAMREST FUNCFPARAMLIST
    {
        $$ = A_FuncFParamList($1,$2);
    }
    |

    {
        $$ = NULL;
    }
FUNCFPARAMREST: ',' FUNCFPARAM
    {
        $$ = $2;
    }
BLOCK: '{' BLOCKITEMLIST '}'
    {
        $$ = A_Block(A_Pos(0,0),$2);
    }
BLOCKITEMLIST: BLOCKITEM BLOCKITEMLIST
    {
        $$ = A_BlockItemList($1,$2);
    }
    |

    {
        $$ = NULL;
    }
BLOCKITEM: DECL
    {
        $$ = A_BlockItemDecl($1->pos,$1);
    }
    |
    STMT
    {
        $$ = A_BlockItemStmt($1->pos,$1);
    }

%%

void yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}

int yywrap()
{
  return(1);
}
