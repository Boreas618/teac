/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    OP_PLUS = 258,
    OP_MULTIPLY = 259,
    OP_MINUS = 260,
    OP_DIV = 261,
    UMINUS = 262,
    CONST = 263,
    OP_MOD = 264,
    UPLUS = 265,
    PUTINT = 266,
    PUTCH = 267,
    ASSIGN = 268,
    WHILE = 269,
    IF = 270,
    ELSE = 271,
    CONTINUE = 272,
    BREAK = 273,
    RETURN = 274,
    INT = 275,
    FLOAT = 276,
    VOID = 277,
    GETFLOAT = 278,
    PUTFLOAT = 279,
    PUTARRAY = 280,
    STARTTIME = 281,
    STOPTIME = 282,
    GETINT = 283,
    GETARRAY = 284,
    GETCH = 285,
    AND = 286,
    OR = 287,
    LT = 288,
    GT = 289,
    LE = 290,
    GE = 291,
    EQ = 292,
    NEQ = 293,
    PUTFARRAY = 294,
    GETFARRAY = 295,
    PUTF = 296,
    INTNUMBER = 297,
    FLOATNUMBER = 298,
    IDENTIFIER = 299,
    FMT = 300
  };
#endif
/* Tokens.  */
#define OP_PLUS 258
#define OP_MULTIPLY 259
#define OP_MINUS 260
#define OP_DIV 261
#define UMINUS 262
#define CONST 263
#define OP_MOD 264
#define UPLUS 265
#define PUTINT 266
#define PUTCH 267
#define ASSIGN 268
#define WHILE 269
#define IF 270
#define ELSE 271
#define CONTINUE 272
#define BREAK 273
#define RETURN 274
#define INT 275
#define FLOAT 276
#define VOID 277
#define GETFLOAT 278
#define PUTFLOAT 279
#define PUTARRAY 280
#define STARTTIME 281
#define STOPTIME 282
#define GETINT 283
#define GETARRAY 284
#define GETCH 285
#define AND 286
#define OR 287
#define LT 288
#define GT 289
#define LE 290
#define GE 291
#define EQ 292
#define NEQ 293
#define PUTFARRAY 294
#define GETFARRAY 295
#define PUTF 296
#define INTNUMBER 297
#define FLOATNUMBER 298
#define IDENTIFIER 299
#define FMT 300

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "parser.yacc"

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

#line 181 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
