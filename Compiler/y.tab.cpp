/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "parser.yacc"

#include <stdio.h>
#include "ast.h"

extern A_prog root;

extern int yylex();
extern void yyerror(char*);
extern int  yywrap();



#line 83 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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

#line 259 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  14
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   810

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  55
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  32
/* YYNRULES -- Number of rules.  */
#define YYNRULES  108
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  228

#define YYUNDEFTOK  2
#define YYMAXUTOK   300


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    46,     2,     2,     2,     2,     2,     2,
      49,    50,     2,     2,    51,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    52,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    47,     2,    48,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    53,     2,    54,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   105,   105,   110,   115,   120,   125,   130,   135,   140,
     145,   150,   155,   160,   165,   170,   174,   179,   184,   189,
     194,   199,   204,   209,   214,   219,   224,   229,   234,   239,
     244,   249,   254,   259,   264,   269,   274,   279,   284,   289,
     294,   299,   304,   308,   314,   317,   321,   327,   330,   336,
     339,   344,   349,   354,   359,   364,   369,   374,   379,   384,
     389,   394,   399,   404,   409,   414,   419,   424,   429,   433,
     438,   443,   447,   453,   456,   461,   465,   469,   475,   478,
     482,   487,   492,   498,   502,   506,   511,   515,   519,   523,
     529,   532,   537,   541,   545,   550,   555,   559,   565,   568,
     573,   577,   583,   586,   590,   594,   600,   603,   608
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "OP_PLUS", "OP_MULTIPLY", "OP_MINUS",
  "OP_DIV", "UMINUS", "CONST", "OP_MOD", "UPLUS", "PUTINT", "PUTCH",
  "ASSIGN", "WHILE", "IF", "ELSE", "CONTINUE", "BREAK", "RETURN", "INT",
  "FLOAT", "VOID", "GETFLOAT", "PUTFLOAT", "PUTARRAY", "STARTTIME",
  "STOPTIME", "GETINT", "GETARRAY", "GETCH", "AND", "OR", "LT", "GT", "LE",
  "GE", "EQ", "NEQ", "PUTFARRAY", "GETFARRAY", "PUTF", "INTNUMBER",
  "FLOATNUMBER", "IDENTIFIER", "FMT", "'!'", "'['", "']'", "'('", "')'",
  "','", "';'", "'{'", "'}'", "$accept", "EXID", "EXP", "EXPLIST",
  "EXPREST", "EXPRESTLIST", "EXPARRLIST", "STMT", "PROG", "COMPUNIT",
  "COMPUNITLIST", "DECL", "CONSTDECL", "CONSTDEFLIST", "CONSTDEF",
  "INITVAL", "ARRAYINIT", "INITVALLIST", "INITVALREST", "INITVALRESTLIST",
  "VARDECL", "VARDEFLIST", "VARDEF", "FUNCDEF", "FUNCTYPE", "FUNCFPARAMS",
  "FUNCFPARAM", "FUNCFPARAMLIST", "FUNCFPARAMREST", "BLOCK",
  "BLOCKITEMLIST", "BLOCKITEM", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,    33,    91,    93,    40,
      41,    44,    59,   123,   125
};
# endif

#define YYPACT_NINF (-200)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     136,    -8,  -200,  -200,  -200,     8,   136,  -200,  -200,  -200,
    -200,  -200,   744,   766,  -200,  -200,  -200,  -200,  -200,  -200,
    -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,  -200,   -34,
     -31,   -33,  -200,   -31,   -28,    -8,   645,     4,   766,   -27,
      13,   766,   -21,   766,   -15,   -14,   645,   645,   -11,    -6,
      -5,    19,    23,  -200,  -200,    25,   645,   645,  -200,   673,
     203,   -33,  -200,   203,   -28,  -200,    15,    26,    -8,  -200,
     -14,    29,    29,    27,    30,   645,    33,   645,   645,    29,
     412,   645,   645,   645,   645,   645,   645,   645,   645,   645,
     645,   645,   645,   645,   645,   -31,   203,   710,  -200,  -200,
    -200,  -200,  -200,    38,    70,  -200,  -200,  -200,  -200,  -200,
     448,  -200,   468,   334,    52,  -200,    24,    29,    24,    29,
      29,   431,   728,    61,    61,    61,    61,   132,   132,   692,
    -200,    56,    49,   -31,    66,    68,    69,    71,    72,    73,
     248,    78,    79,    81,    97,    98,    99,  -200,   298,  -200,
    -200,   766,  -200,    95,    70,  -200,  -200,   645,   100,  -200,
    -200,   -31,   203,    56,  -200,  -200,  -200,   645,   645,   645,
     645,  -200,  -200,  -200,   187,   645,   645,   102,   103,   645,
     105,   645,  -200,  -200,  -200,   710,  -200,  -200,  -200,  -200,
     488,   508,   528,   548,  -200,   568,   355,   107,   108,   391,
     100,   232,   110,   112,   158,   158,   126,   645,  -200,  -200,
     645,   104,  -200,  -200,  -200,  -200,   164,  -200,   588,   608,
     137,   158,   142,   143,  -200,  -200,  -200,  -200
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
      73,     0,    94,    95,    96,     0,    73,    69,    70,    74,
      75,    71,     0,     0,     1,    72,     4,     3,    11,     5,
       7,    15,    14,    10,    12,     9,     8,    13,     6,     2,
      49,    90,     2,    49,    78,    98,     0,    91,     0,     0,
       0,     0,     0,     0,     0,   102,     0,     0,    11,    10,
      12,     9,    13,    16,    17,     2,     0,     0,    18,     0,
       0,    90,    88,     0,    78,    76,    99,     0,     0,    97,
     102,    33,    32,     0,     0,     0,     0,     0,    44,    36,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    49,    83,    80,    92,    81,
      89,    79,    77,     0,   106,    93,   103,   101,    39,    37,
       0,    38,     0,    47,     0,    34,    19,    20,    21,    22,
      23,    24,    25,    26,    27,    28,    29,    30,    31,     0,
      48,    86,     0,    49,     4,     3,     0,     0,     0,     0,
       0,     5,     7,    15,    14,     8,     6,    68,     0,   108,
     107,     0,    54,     0,   106,    40,    41,     0,    47,    43,
      42,    49,     0,    86,    84,    82,   100,     0,     0,     0,
       0,    58,    59,    61,     0,     0,     0,     0,     0,     0,
       0,     0,    67,   104,   105,    45,    46,    35,    85,    87,
       0,     0,     0,     0,    60,     0,     0,     0,     0,     0,
      47,     0,     0,     0,     0,     0,     0,     0,    65,    66,
       0,     0,    50,    51,    52,    57,    56,    53,     0,     0,
       0,     0,     0,     0,    64,    55,    62,    63
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -200,    -9,   -36,  -200,  -200,  -139,   -32,  -199,  -200,  -200,
     197,   -95,  -200,   141,   168,   -56,  -200,  -200,  -200,    50,
    -200,   151,   178,  -200,     1,  -200,   149,   170,  -200,   181,
      96,  -200
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,    58,   148,   114,   158,   159,    37,   149,     5,     6,
       7,     8,     9,    42,    34,    98,    99,   132,   163,   164,
      10,    39,    31,    11,    12,    44,    45,    69,    70,   152,
     153,   154
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      59,    40,    13,    30,    33,   215,   216,   101,    14,   150,
      71,    72,     2,     3,     4,    35,    36,    60,    38,   186,
      79,    80,   225,    41,    97,    62,    63,    97,    82,    30,
      84,    65,    33,    85,    66,    67,    43,    68,    73,   110,
     131,   112,   113,    74,    75,   116,   117,   118,   119,   120,
     121,   122,   123,   124,   125,   126,   127,   128,   129,   150,
      97,   211,   103,   130,    81,    82,    83,    84,    76,    43,
      85,    94,    77,    46,    78,    47,    94,   108,     1,   104,
     109,   134,   135,   111,   136,   137,   133,   138,   139,   140,
       2,     3,     4,    48,   141,   142,   143,   144,    49,    50,
      51,   166,   160,   165,   174,   151,   188,   162,    94,   145,
      52,   146,    53,    54,    55,   167,    56,   168,   169,    57,
     170,   185,   147,   104,   171,   172,    97,   175,   176,   187,
     177,   190,   191,   192,   193,    81,    82,    83,    84,   195,
     196,    85,    30,   199,     1,   201,   178,   179,   180,   183,
     200,   157,   197,   198,   220,   151,     2,     3,     4,   208,
     209,    46,   213,    47,   214,    88,    89,    90,    91,   134,
     135,   218,   136,   137,   219,   138,   139,   140,   217,    94,
     221,    48,   141,   142,   143,   144,    49,    50,    51,   224,
      81,    82,    83,    84,   226,   227,    85,   145,    52,   146,
      53,    54,    55,    15,    56,   102,    46,    57,    47,    64,
     147,   104,   100,   189,    16,    17,    61,   106,    86,    87,
      88,    89,    90,    91,    92,    93,    48,    19,    20,    21,
      22,    49,    50,    51,    94,    81,    82,    83,    84,   194,
     107,    85,    26,    52,    28,    53,    54,    55,   105,    56,
     184,    46,    57,    47,     0,     0,    96,     0,     0,    16,
      17,     0,     0,    86,    87,    88,    89,    90,    91,    92,
      93,    48,    19,    20,    21,    22,    49,    50,    51,    94,
       0,     0,     0,     0,   212,     0,     0,    26,    52,    28,
      53,    54,    55,     0,    56,     0,     0,    57,     0,     0,
     173,    81,    82,    83,    84,     0,     0,    85,     0,     0,
       0,   181,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    86,
      87,    88,    89,    90,    91,    92,    93,    81,    82,    83,
      84,     0,     0,    85,     0,    94,     0,     0,     0,     0,
     182,     0,     0,     0,     0,     0,     0,     0,    81,    82,
      83,    84,     0,     0,    85,    86,    87,    88,    89,    90,
      91,    92,    93,     0,     0,     0,     0,     0,     0,     0,
       0,    94,     0,     0,     0,   157,    86,    87,    88,    89,
      90,    91,    92,    93,    81,    82,    83,    84,     0,     0,
      85,     0,    94,     0,     0,     0,   207,     0,     0,     0,
       0,     0,     0,     0,     0,    81,    82,    83,    84,     0,
       0,    85,    86,    87,    88,    89,    90,    91,    92,    93,
       0,     0,     0,     0,    81,    82,    83,    84,    94,     0,
      85,     0,   210,    86,    87,    88,    89,    90,    91,    92,
      93,    81,    82,    83,    84,     0,     0,    85,     0,    94,
       0,     0,   115,     0,    88,    89,    90,    91,    92,    93,
       0,    81,    82,    83,    84,     0,     0,    85,    94,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   155,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   156,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   202,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   203,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   204,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   205,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,    81,    82,    83,    84,    94,     0,    85,   206,    86,
      87,    88,    89,    90,    91,    92,    93,     0,     0,     0,
       0,     0,     0,     0,     0,    94,     0,     0,   222,    86,
      87,    88,    89,    90,    91,    92,    93,     0,    46,     0,
      47,     0,     0,     0,     0,    94,    16,    17,   223,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    48,    19,
      20,    21,    22,    49,    50,    51,    81,    82,    83,    84,
       0,     0,    85,     0,    26,    52,    28,    53,    54,    55,
       0,    56,     0,     0,    57,    81,    82,    83,    84,     0,
       0,    85,     0,     0,    86,    87,    88,    89,    90,    91,
      92,    93,     0,    81,    82,    83,    84,     0,     0,    85,
      94,    95,     0,    86,    87,    88,    89,    90,    91,    92,
      93,    81,    82,    83,    84,     0,     0,    85,     0,    94,
     161,    86,    87,    88,    89,    90,    91,    92,    93,     0,
       0,     0,     0,     0,     0,    16,    17,    94,     0,    86,
       0,    88,    89,    90,    91,    92,    93,    18,    19,    20,
      21,    22,    23,    24,    25,    94,     0,    16,    17,     0,
       0,     0,     0,    26,    27,    28,     0,     0,    29,    18,
      19,    20,    21,    22,    23,    24,    25,     0,     0,     0,
       0,     0,     0,     0,     0,    26,    27,    28,     0,     0,
      32
};

static const yytype_int16 yycheck[] =
{
      36,    33,     1,    12,    13,   204,   205,    63,     0,   104,
      46,    47,    20,    21,    22,    49,    47,    13,    51,   158,
      56,    57,   221,    51,    60,    52,    13,    63,     4,    38,
       6,    52,    41,     9,    43,    50,    35,    51,    49,    75,
      96,    77,    78,    49,    49,    81,    82,    83,    84,    85,
      86,    87,    88,    89,    90,    91,    92,    93,    94,   154,
      96,   200,    47,    95,     3,     4,     5,     6,    49,    68,
       9,    47,    49,     3,    49,     5,    47,    50,     8,    53,
      50,    11,    12,    50,    14,    15,    48,    17,    18,    19,
      20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
      30,   133,    50,    54,   140,   104,   162,    51,    47,    39,
      40,    41,    42,    43,    44,    49,    46,    49,    49,    49,
      49,   157,    52,    53,    52,    52,   162,    49,    49,   161,
      49,   167,   168,   169,   170,     3,     4,     5,     6,   175,
     176,     9,   151,   179,     8,   181,    49,    49,    49,    54,
      45,    51,    50,    50,    50,   154,    20,    21,    22,    52,
      52,     3,    52,     5,    52,    33,    34,    35,    36,    11,
      12,   207,    14,    15,   210,    17,    18,    19,    52,    47,
      16,    23,    24,    25,    26,    27,    28,    29,    30,    52,
       3,     4,     5,     6,    52,    52,     9,    39,    40,    41,
      42,    43,    44,     6,    46,    64,     3,    49,     5,    41,
      52,    53,    61,   163,    11,    12,    38,    68,    31,    32,
      33,    34,    35,    36,    37,    38,    23,    24,    25,    26,
      27,    28,    29,    30,    47,     3,     4,     5,     6,    52,
      70,     9,    39,    40,    41,    42,    43,    44,    67,    46,
     154,     3,    49,     5,    -1,    -1,    53,    -1,    -1,    11,
      12,    -1,    -1,    31,    32,    33,    34,    35,    36,    37,
      38,    23,    24,    25,    26,    27,    28,    29,    30,    47,
      -1,    -1,    -1,    -1,    52,    -1,    -1,    39,    40,    41,
      42,    43,    44,    -1,    46,    -1,    -1,    49,    -1,    -1,
      52,     3,     4,     5,     6,    -1,    -1,     9,    -1,    -1,
      -1,    13,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    31,
      32,    33,    34,    35,    36,    37,    38,     3,     4,     5,
       6,    -1,    -1,     9,    -1,    47,    -1,    -1,    -1,    -1,
      52,    -1,    -1,    -1,    -1,    -1,    -1,    -1,     3,     4,
       5,     6,    -1,    -1,     9,    31,    32,    33,    34,    35,
      36,    37,    38,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    47,    -1,    -1,    -1,    51,    31,    32,    33,    34,
      35,    36,    37,    38,     3,     4,     5,     6,    -1,    -1,
       9,    -1,    47,    -1,    -1,    -1,    51,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,     3,     4,     5,     6,    -1,
      -1,     9,    31,    32,    33,    34,    35,    36,    37,    38,
      -1,    -1,    -1,    -1,     3,     4,     5,     6,    47,    -1,
       9,    -1,    51,    31,    32,    33,    34,    35,    36,    37,
      38,     3,     4,     5,     6,    -1,    -1,     9,    -1,    47,
      -1,    -1,    50,    -1,    33,    34,    35,    36,    37,    38,
      -1,     3,     4,     5,     6,    -1,    -1,     9,    47,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,     3,     4,     5,     6,    47,    -1,     9,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    47,    -1,    -1,    50,    31,
      32,    33,    34,    35,    36,    37,    38,    -1,     3,    -1,
       5,    -1,    -1,    -1,    -1,    47,    11,    12,    50,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    23,    24,
      25,    26,    27,    28,    29,    30,     3,     4,     5,     6,
      -1,    -1,     9,    -1,    39,    40,    41,    42,    43,    44,
      -1,    46,    -1,    -1,    49,     3,     4,     5,     6,    -1,
      -1,     9,    -1,    -1,    31,    32,    33,    34,    35,    36,
      37,    38,    -1,     3,     4,     5,     6,    -1,    -1,     9,
      47,    48,    -1,    31,    32,    33,    34,    35,    36,    37,
      38,     3,     4,     5,     6,    -1,    -1,     9,    -1,    47,
      48,    31,    32,    33,    34,    35,    36,    37,    38,    -1,
      -1,    -1,    -1,    -1,    -1,    11,    12,    47,    -1,    31,
      -1,    33,    34,    35,    36,    37,    38,    23,    24,    25,
      26,    27,    28,    29,    30,    47,    -1,    11,    12,    -1,
      -1,    -1,    -1,    39,    40,    41,    -1,    -1,    44,    23,
      24,    25,    26,    27,    28,    29,    30,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    39,    40,    41,    -1,    -1,
      44
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     8,    20,    21,    22,    63,    64,    65,    66,    67,
      75,    78,    79,    79,     0,    65,    11,    12,    23,    24,
      25,    26,    27,    28,    29,    30,    39,    40,    41,    44,
      56,    77,    44,    56,    69,    49,    47,    61,    51,    76,
      61,    51,    68,    79,    80,    81,     3,     5,    23,    28,
      29,    30,    40,    42,    43,    44,    46,    49,    56,    57,
      13,    77,    52,    13,    69,    52,    56,    50,    51,    82,
      83,    57,    57,    49,    49,    49,    49,    49,    49,    57,
      57,     3,     4,     5,     6,     9,    31,    32,    33,    34,
      35,    36,    37,    38,    47,    48,    53,    57,    70,    71,
      76,    70,    68,    47,    53,    84,    81,    82,    50,    50,
      57,    50,    57,    57,    58,    50,    57,    57,    57,    57,
      57,    57,    57,    57,    57,    57,    57,    57,    57,    57,
      61,    70,    72,    48,    11,    12,    14,    15,    17,    18,
      19,    24,    25,    26,    27,    39,    41,    52,    57,    62,
      66,    79,    84,    85,    86,    50,    50,    51,    59,    60,
      50,    48,    51,    73,    74,    54,    61,    49,    49,    49,
      49,    52,    52,    52,    57,    49,    49,    49,    49,    49,
      49,    13,    52,    54,    85,    57,    60,    61,    70,    74,
      57,    57,    57,    57,    52,    57,    57,    50,    50,    57,
      45,    57,    50,    50,    50,    50,    50,    51,    52,    52,
      51,    60,    52,    52,    52,    62,    62,    52,    57,    57,
      50,    16,    50,    50,    52,    62,    52,    52
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    55,    56,    56,    56,    56,    56,    56,    56,    56,
      56,    56,    56,    56,    56,    56,    57,    57,    57,    57,
      57,    57,    57,    57,    57,    57,    57,    57,    57,    57,
      57,    57,    57,    57,    57,    57,    57,    57,    57,    57,
      57,    57,    57,    58,    58,    59,    60,    60,    61,    61,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    62,
      62,    62,    62,    62,    62,    62,    62,    62,    62,    63,
      64,    64,    65,    65,    66,    66,    67,    68,    68,    69,
      70,    70,    71,    72,    72,    73,    74,    74,    75,    76,
      76,    77,    77,    78,    79,    79,    79,    80,    80,    81,
      81,    82,    82,    83,    84,    85,    85,    86,    86
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     2,     2,     3,     5,     2,     3,     3,     3,
       4,     4,     4,     2,     0,     2,     2,     0,     4,     0,
       4,     5,     5,     5,     1,     7,     5,     5,     2,     2,
       3,     2,     7,     7,     6,     4,     4,     2,     1,     1,
       1,     1,     2,     0,     1,     1,     5,     3,     0,     4,
       1,     1,     3,     0,     2,     2,     0,     2,     4,     3,
       0,     2,     4,     6,     1,     1,     1,     2,     0,     2,
       5,     2,     0,     2,     3,     2,     0,     1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 2000
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 200000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 106 "parser.yacc"
      {
          (yyval.id) = (yyvsp[0].id);
      }
#line 1709 "y.tab.c"
    break;

  case 3:
#line 111 "parser.yacc"
      {
        (yyval.id) = String("putch");
      }
#line 1717 "y.tab.c"
    break;

  case 4:
#line 116 "parser.yacc"
      {
        (yyval.id) = String("putint");
      }
#line 1725 "y.tab.c"
    break;

  case 5:
#line 121 "parser.yacc"
      {
        (yyval.id) = String("putfloat");
      }
#line 1733 "y.tab.c"
    break;

  case 6:
#line 126 "parser.yacc"
      {
        (yyval.id) = String("putf");
      }
#line 1741 "y.tab.c"
    break;

  case 7:
#line 131 "parser.yacc"
      {
        (yyval.id) = String("putarray");
      }
#line 1749 "y.tab.c"
    break;

  case 8:
#line 136 "parser.yacc"
      {
        (yyval.id) = String("putfarray");
      }
#line 1757 "y.tab.c"
    break;

  case 9:
#line 141 "parser.yacc"
      {
        (yyval.id) = String("getch");
      }
#line 1765 "y.tab.c"
    break;

  case 10:
#line 146 "parser.yacc"
      {
        (yyval.id) = String("getint");
      }
#line 1773 "y.tab.c"
    break;

  case 11:
#line 151 "parser.yacc"
      {
        (yyval.id) = String("getfloat");
      }
#line 1781 "y.tab.c"
    break;

  case 12:
#line 156 "parser.yacc"
      {
        (yyval.id) = String("getarray");
      }
#line 1789 "y.tab.c"
    break;

  case 13:
#line 161 "parser.yacc"
      {
        (yyval.id) = String("getfarray");
      }
#line 1797 "y.tab.c"
    break;

  case 14:
#line 166 "parser.yacc"
      {
        (yyval.id) = String("stoptime");
      }
#line 1805 "y.tab.c"
    break;

  case 15:
#line 171 "parser.yacc"
      {
        (yyval.id) = String("starttime");
      }
#line 1813 "y.tab.c"
    break;

  case 16:
#line 175 "parser.yacc"
      {
          (yyval.exp) = A_IntConst(A_Pos(0,0),(yyvsp[0].inum));
      }
#line 1821 "y.tab.c"
    break;

  case 17:
#line 180 "parser.yacc"
      {
          (yyval.exp) = A_FloatConst(A_Pos(0,0),(yyvsp[0].fnum));
      }
#line 1829 "y.tab.c"
    break;

  case 18:
#line 185 "parser.yacc"
      {
          (yyval.exp) = A_IdExp(A_Pos(0,0),(yyvsp[0].id));
      }
#line 1837 "y.tab.c"
    break;

  case 19:
#line 190 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_plus, (yyvsp[0].exp));
      }
#line 1845 "y.tab.c"
    break;

  case 20:
#line 195 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_times, (yyvsp[0].exp));
      }
#line 1853 "y.tab.c"
    break;

  case 21:
#line 200 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_minus, (yyvsp[0].exp));
      }
#line 1861 "y.tab.c"
    break;

  case 22:
#line 205 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_div, (yyvsp[0].exp));
      }
#line 1869 "y.tab.c"
    break;

  case 23:
#line 210 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_mod, (yyvsp[0].exp));
      }
#line 1877 "y.tab.c"
    break;

  case 24:
#line 215 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_and, (yyvsp[0].exp));
      }
#line 1885 "y.tab.c"
    break;

  case 25:
#line 220 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_or, (yyvsp[0].exp));
      }
#line 1893 "y.tab.c"
    break;

  case 26:
#line 225 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_less, (yyvsp[0].exp));
      }
#line 1901 "y.tab.c"
    break;

  case 27:
#line 230 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_greater, (yyvsp[0].exp));
      }
#line 1909 "y.tab.c"
    break;

  case 28:
#line 235 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_le, (yyvsp[0].exp));
      }
#line 1917 "y.tab.c"
    break;

  case 29:
#line 240 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_ge, (yyvsp[0].exp));
      }
#line 1925 "y.tab.c"
    break;

  case 30:
#line 245 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_eq, (yyvsp[0].exp));
      }
#line 1933 "y.tab.c"
    break;

  case 31:
#line 250 "parser.yacc"
      {
          (yyval.exp) = A_OpExp(A_Pos((yyvsp[-2].exp)->pos->line,(yyvsp[-2].exp)->pos->pos),(yyvsp[-2].exp), A_ne, (yyvsp[0].exp));
      }
#line 1941 "y.tab.c"
    break;

  case 32:
#line 255 "parser.yacc"
      {
        (yyval.exp) = A_MinusExp(A_Pos((yyvsp[-1].token)->line,(yyvsp[-1].token)->pos),(yyvsp[0].exp));
      }
#line 1949 "y.tab.c"
    break;

  case 33:
#line 260 "parser.yacc"
      {
        (yyval.exp) = (yyvsp[0].exp);
      }
#line 1957 "y.tab.c"
    break;

  case 34:
#line 265 "parser.yacc"
      {
        (yyval.exp) = (yyvsp[-1].exp);
      }
#line 1965 "y.tab.c"
    break;

  case 35:
#line 270 "parser.yacc"
      {
        (yyval.exp) = A_ArrayExp(A_Pos((yyvsp[-4].exp)->pos->line,(yyvsp[-4].exp)->pos->pos),(yyvsp[-4].exp),A_ExpList((yyvsp[-2].exp),(yyvsp[0].expList)));
      }
#line 1973 "y.tab.c"
    break;

  case 36:
#line 275 "parser.yacc"
      {
        (yyval.exp) = A_NotExp(A_Pos((yyvsp[0].exp)->pos->line,(yyvsp[0].exp)->pos->pos),(yyvsp[0].exp));
      }
#line 1981 "y.tab.c"
    break;

  case 37:
#line 280 "parser.yacc"
      {
        (yyval.exp) = A_Getint((yyvsp[-2].token));
      }
#line 1989 "y.tab.c"
    break;

  case 38:
#line 285 "parser.yacc"
      {
        (yyval.exp) = A_Getch((yyvsp[-2].token));
      }
#line 1997 "y.tab.c"
    break;

  case 39:
#line 290 "parser.yacc"
      {
        (yyval.exp) = A_Getfloat((yyvsp[-2].token));
      }
#line 2005 "y.tab.c"
    break;

  case 40:
#line 295 "parser.yacc"
      {
        (yyval.exp) = A_Getarray(A_Pos((yyvsp[-3].token)->line,(yyvsp[-3].token)->pos),(yyvsp[-1].exp));
      }
#line 2013 "y.tab.c"
    break;

  case 41:
#line 300 "parser.yacc"
      {
        (yyval.exp) = A_Getfarray(A_Pos((yyvsp[-3].token)->line,(yyvsp[-3].token)->pos),(yyvsp[-1].exp));
      }
#line 2021 "y.tab.c"
    break;

  case 42:
#line 305 "parser.yacc"
      {
        (yyval.exp) = A_CallExp(A_Pos(0,0),String((yyvsp[-3].id)),(yyvsp[-1].expList));
      }
#line 2029 "y.tab.c"
    break;

  case 43:
#line 309 "parser.yacc"
    {
        (yyval.expList) = A_ExpList((yyvsp[-1].exp),(yyvsp[0].expList));
    }
#line 2037 "y.tab.c"
    break;

  case 44:
#line 314 "parser.yacc"
    {
        (yyval.expList) = NULL;
    }
#line 2045 "y.tab.c"
    break;

  case 45:
#line 318 "parser.yacc"
    {
        (yyval.exp) = (yyvsp[0].exp);
    }
#line 2053 "y.tab.c"
    break;

  case 46:
#line 322 "parser.yacc"
    {
        (yyval.expList) = A_ExpList((yyvsp[-1].exp),(yyvsp[0].expList));
    }
#line 2061 "y.tab.c"
    break;

  case 47:
#line 327 "parser.yacc"
    {
        (yyval.expList) = NULL;
    }
#line 2069 "y.tab.c"
    break;

  case 48:
#line 331 "parser.yacc"
    {
        (yyval.expList) = A_ExpList((yyvsp[-2].exp),(yyvsp[0].expList));
    }
#line 2077 "y.tab.c"
    break;

  case 49:
#line 336 "parser.yacc"
    {
        (yyval.expList) = NULL;
    }
#line 2085 "y.tab.c"
    break;

  case 50:
#line 340 "parser.yacc"
    {
        (yyval.stmt) = A_AssignStm(A_Pos((yyvsp[-3].exp)->pos->line,(yyvsp[-3].exp)->pos->pos),(yyvsp[-3].exp),(yyvsp[-1].exp));
    }
#line 2093 "y.tab.c"
    break;

  case 51:
#line 345 "parser.yacc"
    {
        (yyval.stmt) = A_Putint(A_Pos((yyvsp[-4].token)->line,(yyvsp[-4].token)->pos),(yyvsp[-2].exp));
    }
#line 2101 "y.tab.c"
    break;

  case 52:
#line 350 "parser.yacc"
    {
        (yyval.stmt) = A_Putch(A_Pos((yyvsp[-4].token)->line,(yyvsp[-4].token)->pos),(yyvsp[-2].exp));
    }
#line 2109 "y.tab.c"
    break;

  case 53:
#line 355 "parser.yacc"
    {
        (yyval.stmt) = A_Putfloat(A_Pos((yyvsp[-4].token)->line,(yyvsp[-4].token)->pos),(yyvsp[-2].exp));
    }
#line 2117 "y.tab.c"
    break;

  case 54:
#line 360 "parser.yacc"
    {
        (yyval.stmt) = A_BlockStm(A_Pos((yyvsp[0].block)->pos->line,(yyvsp[0].block)->pos->pos),(yyvsp[0].block));
    }
#line 2125 "y.tab.c"
    break;

  case 55:
#line 365 "parser.yacc"
    {
        (yyval.stmt) = A_IfStm(A_Pos((yyvsp[-6].token)->line,(yyvsp[-6].token)->pos),(yyvsp[-4].exp),(yyvsp[-2].stmt),(yyvsp[0].stmt));
    }
#line 2133 "y.tab.c"
    break;

  case 56:
#line 370 "parser.yacc"
    {
        (yyval.stmt) = A_IfStm(A_Pos((yyvsp[-4].token)->line,(yyvsp[-4].token)->pos),(yyvsp[-2].exp),(yyvsp[0].stmt),NULL);
    }
#line 2141 "y.tab.c"
    break;

  case 57:
#line 375 "parser.yacc"
    {
        (yyval.stmt) = A_WhileStm(A_Pos((yyvsp[-4].token)->line,(yyvsp[-4].token)->pos),(yyvsp[-2].exp),(yyvsp[0].stmt));
    }
#line 2149 "y.tab.c"
    break;

  case 58:
#line 380 "parser.yacc"
    {
        (yyval.stmt) = A_Continue((yyvsp[-1].token));
    }
#line 2157 "y.tab.c"
    break;

  case 59:
#line 385 "parser.yacc"
    {
        (yyval.stmt) = A_Break((yyvsp[-1].token));
    }
#line 2165 "y.tab.c"
    break;

  case 60:
#line 390 "parser.yacc"
    {
        (yyval.stmt) = A_Return(A_Pos((yyvsp[-2].token)->line,(yyvsp[-2].token)->pos),(yyvsp[-1].exp));
    }
#line 2173 "y.tab.c"
    break;

  case 61:
#line 395 "parser.yacc"
    {
        (yyval.stmt) = A_Return(A_Pos((yyvsp[-1].token)->line,(yyvsp[-1].token)->pos),NULL);
    }
#line 2181 "y.tab.c"
    break;

  case 62:
#line 400 "parser.yacc"
    {
        (yyval.stmt) = A_Putarray(A_Pos((yyvsp[-6].token)->line,(yyvsp[-6].token)->pos),(yyvsp[-4].exp),(yyvsp[-2].exp));
    }
#line 2189 "y.tab.c"
    break;

  case 63:
#line 405 "parser.yacc"
    {
        (yyval.stmt) = A_Putfarray(A_Pos((yyvsp[-6].token)->line,(yyvsp[-6].token)->pos),(yyvsp[-4].exp),(yyvsp[-2].exp));
    }
#line 2197 "y.tab.c"
    break;

  case 64:
#line 410 "parser.yacc"
    {
        (yyval.stmt) = A_Putf(A_Pos((yyvsp[-5].token)->line,(yyvsp[-5].token)->pos),(yyvsp[-3].fmt),(yyvsp[-2].expList));
    }
#line 2205 "y.tab.c"
    break;

  case 65:
#line 415 "parser.yacc"
    {
        (yyval.stmt) = A_Starttime((yyvsp[-3].token));
    }
#line 2213 "y.tab.c"
    break;

  case 66:
#line 420 "parser.yacc"
    {
        (yyval.stmt) = A_Stoptime((yyvsp[-3].token));
    }
#line 2221 "y.tab.c"
    break;

  case 67:
#line 425 "parser.yacc"
    {
        (yyval.stmt) = A_ExpStm((yyvsp[-1].exp)->pos,(yyvsp[-1].exp));
    }
#line 2229 "y.tab.c"
    break;

  case 68:
#line 430 "parser.yacc"
    {
        (yyval.stmt) = A_ExpStm(A_Pos(0,0),NULL);
    }
#line 2237 "y.tab.c"
    break;

  case 69:
#line 434 "parser.yacc"
    {
        root = A_Prog(A_Pos(0,0),(yyvsp[0].compUnitList));
        (yyval.prog) = A_Prog(A_Pos(0,0),(yyvsp[0].compUnitList));
    }
#line 2246 "y.tab.c"
    break;

  case 70:
#line 439 "parser.yacc"
    {
        (yyval.compUnit) = A_CompUnitDecl((yyvsp[0].decl)->pos,(yyvsp[0].decl));
    }
#line 2254 "y.tab.c"
    break;

  case 71:
#line 444 "parser.yacc"
    {
        (yyval.compUnit) = A_CompUnitFuncDef((yyvsp[0].funcDef)->pos,(yyvsp[0].funcDef));
    }
#line 2262 "y.tab.c"
    break;

  case 72:
#line 448 "parser.yacc"
    {
        (yyval.compUnitList) = A_CompUnitList((yyvsp[-1].compUnit),(yyvsp[0].compUnitList));
    }
#line 2270 "y.tab.c"
    break;

  case 73:
#line 453 "parser.yacc"
    {
        (yyval.compUnitList) = NULL;
    }
#line 2278 "y.tab.c"
    break;

  case 74:
#line 457 "parser.yacc"
    {
        (yyval.decl) = A_DeclConst((yyvsp[0].constDecl)->pos,(yyvsp[0].constDecl));
    }
#line 2286 "y.tab.c"
    break;

  case 75:
#line 462 "parser.yacc"
    {
        (yyval.decl) = A_DeclVar((yyvsp[0].varDecl)->pos,(yyvsp[0].varDecl));
    }
#line 2294 "y.tab.c"
    break;

  case 76:
#line 466 "parser.yacc"
    {
        (yyval.constDecl) = A_ConstDecl((yyvsp[-4].token),(yyvsp[-3].funcType),A_ConstDefList((yyvsp[-2].constDef),(yyvsp[-1].constDefList)));
    }
#line 2302 "y.tab.c"
    break;

  case 77:
#line 470 "parser.yacc"
    {
        (yyval.constDefList) = A_ConstDefList((yyvsp[-1].constDef),(yyvsp[0].constDefList));
    }
#line 2310 "y.tab.c"
    break;

  case 78:
#line 475 "parser.yacc"
    {
        (yyval.constDefList) = NULL;
    }
#line 2318 "y.tab.c"
    break;

  case 79:
#line 479 "parser.yacc"
    {
        (yyval.constDef) = A_ConstDef(A_Pos(0,0),String((yyvsp[-3].id)),(yyvsp[-2].expList),(yyvsp[0].initVal));
    }
#line 2326 "y.tab.c"
    break;

  case 80:
#line 483 "parser.yacc"
    {
        (yyval.initVal) = A_InitValExp((yyvsp[0].exp)->pos,(yyvsp[0].exp));
    }
#line 2334 "y.tab.c"
    break;

  case 81:
#line 488 "parser.yacc"
    {
        (yyval.initVal) = A_InitValArray((yyvsp[0].arrayInit)->pos,(yyvsp[0].arrayInit));
    }
#line 2342 "y.tab.c"
    break;

  case 82:
#line 493 "parser.yacc"
    {
        (yyval.arrayInit) = A_ArrayInit(A_Pos(0,0),(yyvsp[-1].initValList));
    }
#line 2350 "y.tab.c"
    break;

  case 83:
#line 498 "parser.yacc"
    {
        (yyval.initValList) = NULL;
    }
#line 2358 "y.tab.c"
    break;

  case 84:
#line 503 "parser.yacc"
    {
        (yyval.initValList) = A_InitValList((yyvsp[-1].initVal),(yyvsp[0].initValList));
    }
#line 2366 "y.tab.c"
    break;

  case 85:
#line 507 "parser.yacc"
    {
        (yyval.initVal) = (yyvsp[0].initVal);
    }
#line 2374 "y.tab.c"
    break;

  case 86:
#line 511 "parser.yacc"
    {
        (yyval.initValList) = NULL;
    }
#line 2382 "y.tab.c"
    break;

  case 87:
#line 516 "parser.yacc"
    {
        (yyval.initValList) = A_InitValList((yyvsp[-1].initVal),(yyvsp[0].initValList));
    }
#line 2390 "y.tab.c"
    break;

  case 88:
#line 520 "parser.yacc"
    {
        (yyval.varDecl) = A_VarDecl((yyvsp[-2].varDef)->pos,(yyvsp[-3].funcType),A_VarDefList((yyvsp[-2].varDef),(yyvsp[-1].varDefList)));
    }
#line 2398 "y.tab.c"
    break;

  case 89:
#line 524 "parser.yacc"
    {
        (yyval.varDefList) = A_VarDefList((yyvsp[-1].varDef),(yyvsp[0].varDefList));
    }
#line 2406 "y.tab.c"
    break;

  case 90:
#line 529 "parser.yacc"
    {
        (yyval.varDefList) = NULL;
    }
#line 2414 "y.tab.c"
    break;

  case 91:
#line 533 "parser.yacc"
    {
        (yyval.varDef) = A_VarDef(A_Pos(0,0),String((yyvsp[-1].id)),(yyvsp[0].expList),NULL);
    }
#line 2422 "y.tab.c"
    break;

  case 92:
#line 538 "parser.yacc"
    {
        (yyval.varDef) = A_VarDef(A_Pos(0,0),String((yyvsp[-3].id)),(yyvsp[-2].expList),(yyvsp[0].initVal));
    }
#line 2430 "y.tab.c"
    break;

  case 93:
#line 542 "parser.yacc"
    {
        (yyval.funcDef) = A_FuncDef(A_Pos(0,0),(yyvsp[-5].funcType),String((yyvsp[-4].id)),(yyvsp[-2].funcFParams),(yyvsp[0].block));
    }
#line 2438 "y.tab.c"
    break;

  case 94:
#line 546 "parser.yacc"
    {
        (yyval.funcType) = A_FuncType(0);
    }
#line 2446 "y.tab.c"
    break;

  case 95:
#line 551 "parser.yacc"
    {
        (yyval.funcType) = A_FuncType(1);
    }
#line 2454 "y.tab.c"
    break;

  case 96:
#line 556 "parser.yacc"
    {
        (yyval.funcType) = A_FuncType(2);
    }
#line 2462 "y.tab.c"
    break;

  case 97:
#line 560 "parser.yacc"
    {
        (yyval.funcFParams) = A_FuncFParams((yyvsp[-1].funcFParam)->pos,A_FuncFParamList((yyvsp[-1].funcFParam),(yyvsp[0].funcFparamList)));
    }
#line 2470 "y.tab.c"
    break;

  case 98:
#line 565 "parser.yacc"
    {
        (yyval.funcFParams) = A_FuncFParams(NULL,NULL);
    }
#line 2478 "y.tab.c"
    break;

  case 99:
#line 569 "parser.yacc"
    {
        (yyval.funcFParam) = A_FuncFParam(A_Pos(0,0),(yyvsp[-1].funcType),String((yyvsp[0].id)),NULL,0);
    }
#line 2486 "y.tab.c"
    break;

  case 100:
#line 574 "parser.yacc"
    {
        (yyval.funcFParam) = A_FuncFParam(A_Pos(0,0),(yyvsp[-4].funcType),String((yyvsp[-3].id)),(yyvsp[0].expList),1);
    }
#line 2494 "y.tab.c"
    break;

  case 101:
#line 578 "parser.yacc"
    {
        (yyval.funcFparamList) = A_FuncFParamList((yyvsp[-1].funcFParam),(yyvsp[0].funcFparamList));
    }
#line 2502 "y.tab.c"
    break;

  case 102:
#line 583 "parser.yacc"
    {
        (yyval.funcFparamList) = NULL;
    }
#line 2510 "y.tab.c"
    break;

  case 103:
#line 587 "parser.yacc"
    {
        (yyval.funcFParam) = (yyvsp[0].funcFParam);
    }
#line 2518 "y.tab.c"
    break;

  case 104:
#line 591 "parser.yacc"
    {
        (yyval.block) = A_Block(A_Pos(0,0),(yyvsp[-1].blockItemList));
    }
#line 2526 "y.tab.c"
    break;

  case 105:
#line 595 "parser.yacc"
    {
        (yyval.blockItemList) = A_BlockItemList((yyvsp[-1].blockItem),(yyvsp[0].blockItemList));
    }
#line 2534 "y.tab.c"
    break;

  case 106:
#line 600 "parser.yacc"
    {
        (yyval.blockItemList) = NULL;
    }
#line 2542 "y.tab.c"
    break;

  case 107:
#line 604 "parser.yacc"
    {
        (yyval.blockItem) = A_BlockItemDecl((yyvsp[0].decl)->pos,(yyvsp[0].decl));
    }
#line 2550 "y.tab.c"
    break;

  case 108:
#line 609 "parser.yacc"
    {
        (yyval.blockItem) = A_BlockItemStmt((yyvsp[0].stmt)->pos,(yyvsp[0].stmt));
    }
#line 2558 "y.tab.c"
    break;


#line 2562 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 613 "parser.yacc"


void yyerror(char *s)
{
  fprintf(stderr, "%s\n",s);
}

int yywrap()
{
  return(1);
}
