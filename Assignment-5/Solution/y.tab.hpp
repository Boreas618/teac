/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_HPP_INCLUDED
# define YY_YY_Y_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ID = 258,                      /* ID  */
    UNUM = 259,                    /* UNUM  */
    INT = 260,                     /* INT  */
    LET = 261,                     /* LET  */
    STRUCT = 262,                  /* STRUCT  */
    FN = 263,                      /* FN  */
    IF = 264,                      /* IF  */
    ELSE = 265,                    /* ELSE  */
    WHILE = 266,                   /* WHILE  */
    DOT = 267,                     /* DOT  */
    CONTINUE = 268,                /* CONTINUE  */
    BREAK = 269,                   /* BREAK  */
    RETURN = 270,                  /* RETURN  */
    SEMICOLON = 271,               /* SEMICOLON  */
    COMMA = 272,                   /* COMMA  */
    COLON = 273,                   /* COLON  */
    ARROW = 274,                   /* ARROW  */
    ADD = 275,                     /* ADD  */
    SUB = 276,                     /* SUB  */
    MUL = 277,                     /* MUL  */
    DIV = 278,                     /* DIV  */
    OR = 279,                      /* OR  */
    AND = 280,                     /* AND  */
    LT = 281,                      /* LT  */
    LE = 282,                      /* LE  */
    GT = 283,                      /* GT  */
    GE = 284,                      /* GE  */
    EQ = 285,                      /* EQ  */
    NE = 286,                      /* NE  */
    NOT = 287,                     /* NOT  */
    LP = 288,                      /* LP  */
    RP = 289,                      /* RP  */
    LB = 290,                      /* LB  */
    RB = 291,                      /* RB  */
    LSB = 292,                     /* LSB  */
    RSB = 293,                     /* RSB  */
    AS = 294,                      /* AS  */
    NEG = 295                      /* NEG  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define ID 258
#define UNUM 259
#define INT 260
#define LET 261
#define STRUCT 262
#define FN 263
#define IF 264
#define ELSE 265
#define WHILE 266
#define DOT 267
#define CONTINUE 268
#define BREAK 269
#define RETURN 270
#define SEMICOLON 271
#define COMMA 272
#define COLON 273
#define ARROW 274
#define ADD 275
#define SUB 276
#define MUL 277
#define DIV 278
#define OR 279
#define AND 280
#define LT 281
#define LE 282
#define GT 283
#define GE 284
#define EQ 285
#define NE 286
#define NOT 287
#define LP 288
#define RP 289
#define LB 290
#define RB 291
#define LSB 292
#define RSB 293
#define AS 294
#define NEG 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 17 "parser.yacc"

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

#line 182 "y.tab.hpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_HPP_INCLUDED  */
