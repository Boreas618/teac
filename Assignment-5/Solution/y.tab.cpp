/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

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
#include "TeaplAst.h"

extern A_pos pos;
extern A_program root;

extern int yylex(void);
extern "C"{
extern void yyerror(const char *s); 
extern int  yywrap();
}


#line 86 "y.tab.cpp"

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

#include "y.tab.hpp"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_ID = 3,                         /* ID  */
  YYSYMBOL_UNUM = 4,                       /* UNUM  */
  YYSYMBOL_INT = 5,                        /* INT  */
  YYSYMBOL_LET = 6,                        /* LET  */
  YYSYMBOL_STRUCT = 7,                     /* STRUCT  */
  YYSYMBOL_FN = 8,                         /* FN  */
  YYSYMBOL_IF = 9,                         /* IF  */
  YYSYMBOL_ELSE = 10,                      /* ELSE  */
  YYSYMBOL_WHILE = 11,                     /* WHILE  */
  YYSYMBOL_DOT = 12,                       /* DOT  */
  YYSYMBOL_CONTINUE = 13,                  /* CONTINUE  */
  YYSYMBOL_BREAK = 14,                     /* BREAK  */
  YYSYMBOL_RETURN = 15,                    /* RETURN  */
  YYSYMBOL_SEMICOLON = 16,                 /* SEMICOLON  */
  YYSYMBOL_COMMA = 17,                     /* COMMA  */
  YYSYMBOL_COLON = 18,                     /* COLON  */
  YYSYMBOL_ARROW = 19,                     /* ARROW  */
  YYSYMBOL_ADD = 20,                       /* ADD  */
  YYSYMBOL_SUB = 21,                       /* SUB  */
  YYSYMBOL_MUL = 22,                       /* MUL  */
  YYSYMBOL_DIV = 23,                       /* DIV  */
  YYSYMBOL_OR = 24,                        /* OR  */
  YYSYMBOL_AND = 25,                       /* AND  */
  YYSYMBOL_LT = 26,                        /* LT  */
  YYSYMBOL_LE = 27,                        /* LE  */
  YYSYMBOL_GT = 28,                        /* GT  */
  YYSYMBOL_GE = 29,                        /* GE  */
  YYSYMBOL_EQ = 30,                        /* EQ  */
  YYSYMBOL_NE = 31,                        /* NE  */
  YYSYMBOL_NOT = 32,                       /* NOT  */
  YYSYMBOL_LP = 33,                        /* LP  */
  YYSYMBOL_RP = 34,                        /* RP  */
  YYSYMBOL_LB = 35,                        /* LB  */
  YYSYMBOL_RB = 36,                        /* RB  */
  YYSYMBOL_LSB = 37,                       /* LSB  */
  YYSYMBOL_RSB = 38,                       /* RSB  */
  YYSYMBOL_AS = 39,                        /* AS  */
  YYSYMBOL_NEG = 40,                       /* NEG  */
  YYSYMBOL_YYACCEPT = 41,                  /* $accept  */
  YYSYMBOL_Program = 42,                   /* Program  */
  YYSYMBOL_ProgramElementList = 43,        /* ProgramElementList  */
  YYSYMBOL_ProgramElement = 44,            /* ProgramElement  */
  YYSYMBOL_ArithExpr = 45,                 /* ArithExpr  */
  YYSYMBOL_NUM = 46,                       /* NUM  */
  YYSYMBOL_ArrayExpr = 47,                 /* ArrayExpr  */
  YYSYMBOL_ExprUnit = 48,                  /* ExprUnit  */
  YYSYMBOL_BoolExpr = 49,                  /* BoolExpr  */
  YYSYMBOL_BoolUnit = 50,                  /* BoolUnit  */
  YYSYMBOL_BoolUnit_ = 51,                 /* BoolUnit_  */
  YYSYMBOL_AssignStmt = 52,                /* AssignStmt  */
  YYSYMBOL_LeftVal = 53,                   /* LeftVal  */
  YYSYMBOL_RightVal = 54,                  /* RightVal  */
  YYSYMBOL_RightValList = 55,              /* RightValList  */
  YYSYMBOL_RightValRestList = 56,          /* RightValRestList  */
  YYSYMBOL_RightValRest = 57,              /* RightValRest  */
  YYSYMBOL_FnCall = 58,                    /* FnCall  */
  YYSYMBOL_VarDeclStmt = 59,               /* VarDeclStmt  */
  YYSYMBOL_VarDecl = 60,                   /* VarDecl  */
  YYSYMBOL_FieldDecl = 61,                 /* FieldDecl  */
  YYSYMBOL_VarDef = 62,                    /* VarDef  */
  YYSYMBOL_Type = 63,                      /* Type  */
  YYSYMBOL_VarDeclList = 64,               /* VarDeclList  */
  YYSYMBOL_VarDeclRestList = 65,           /* VarDeclRestList  */
  YYSYMBOL_VarDeclRest = 66,               /* VarDeclRest  */
  YYSYMBOL_FieldDeclList = 67,             /* FieldDeclList  */
  YYSYMBOL_FieldDeclRestList = 68,         /* FieldDeclRestList  */
  YYSYMBOL_FieldDeclRest = 69,             /* FieldDeclRest  */
  YYSYMBOL_StructDef = 70,                 /* StructDef  */
  YYSYMBOL_ParamDecl = 71,                 /* ParamDecl  */
  YYSYMBOL_FnDecl = 72,                    /* FnDecl  */
  YYSYMBOL_FnDeclStmt = 73,                /* FnDeclStmt  */
  YYSYMBOL_ReturnStmt = 74,                /* ReturnStmt  */
  YYSYMBOL_FnDef = 75,                     /* FnDef  */
  YYSYMBOL_CodeBlockStmt = 76,             /* CodeBlockStmt  */
  YYSYMBOL_CodeBlockStmtList = 77,         /* CodeBlockStmtList  */
  YYSYMBOL_CodeBlock = 78,                 /* CodeBlock  */
  YYSYMBOL_CallStmt = 79,                  /* CallStmt  */
  YYSYMBOL_IfStmt = 80,                    /* IfStmt  */
  YYSYMBOL_WhileStmt = 81                  /* WhileStmt  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




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

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
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
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
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

#if !defined yyoverflow

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
#endif /* !defined yyoverflow */

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
#define YYFINAL  18
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   221

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  41
/* YYNRULES -- Number of rules.  */
#define YYNRULES  102
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  213

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   295


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
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
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   147,   147,   154,   159,   164,   168,   172,   176,   180,
     186,   190,   194,   198,   202,   208,   212,   218,   222,   228,
     232,   236,   240,   244,   248,   254,   258,   262,   268,   272,
     276,   280,   284,   288,   292,   296,   302,   306,   310,   314,
     318,   322,   326,   330,   336,   342,   346,   350,   356,   362,
     367,   371,   376,   380,   386,   392,   396,   402,   406,   410,
     414,   420,   424,   430,   434,   438,   442,   448,   452,   458,
     463,   467,   472,   476,   482,   487,   491,   496,   500,   506,
     512,   518,   522,   528,   534,   538,   544,   550,   554,   558,
     562,   566,   570,   574,   578,   582,   588,   593,   598,   604,
     610,   614,   620
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "ID", "UNUM", "INT",
  "LET", "STRUCT", "FN", "IF", "ELSE", "WHILE", "DOT", "CONTINUE", "BREAK",
  "RETURN", "SEMICOLON", "COMMA", "COLON", "ARROW", "ADD", "SUB", "MUL",
  "DIV", "OR", "AND", "LT", "LE", "GT", "GE", "EQ", "NE", "NOT", "LP",
  "RP", "LB", "RB", "LSB", "RSB", "AS", "NEG", "$accept", "Program",
  "ProgramElementList", "ProgramElement", "ArithExpr", "NUM", "ArrayExpr",
  "ExprUnit", "BoolExpr", "BoolUnit", "BoolUnit_", "AssignStmt", "LeftVal",
  "RightVal", "RightValList", "RightValRestList", "RightValRest", "FnCall",
  "VarDeclStmt", "VarDecl", "FieldDecl", "VarDef", "Type", "VarDeclList",
  "VarDeclRestList", "VarDeclRest", "FieldDeclList", "FieldDeclRestList",
  "FieldDeclRest", "StructDef", "ParamDecl", "FnDecl", "FnDeclStmt",
  "ReturnStmt", "FnDef", "CodeBlockStmt", "CodeBlockStmtList", "CodeBlock",
  "CallStmt", "IfStmt", "WhileStmt", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-156)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-48)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     135,     8,    28,    67,  -156,    73,  -156,   135,  -156,  -156,
      79,  -156,  -156,    72,    94,    97,    40,    82,  -156,  -156,
    -156,   124,  -156,    59,   102,    23,  -156,  -156,   113,   119,
      93,    95,    95,   115,   118,    14,  -156,  -156,  -156,    55,
     134,  -156,  -156,   124,   100,  -156,  -156,  -156,  -156,  -156,
      90,  -156,   148,   123,    16,    23,   126,  -156,    -3,  -156,
      20,  -156,  -156,    80,   151,   117,    87,   152,  -156,   137,
      23,    18,   138,   138,  -156,  -156,  -156,   154,   169,   104,
      23,  -156,  -156,  -156,    23,  -156,    43,    98,    23,    23,
      23,    23,   171,    59,   102,   113,  -156,   151,  -156,    59,
     102,   119,  -156,   152,   156,   159,   143,   -13,    33,   129,
      -9,  -156,   168,  -156,  -156,  -156,   141,   142,   165,  -156,
      59,   147,  -156,     1,     1,  -156,  -156,    21,  -156,   145,
    -156,  -156,  -156,   146,  -156,  -156,    59,    23,  -156,   159,
    -156,   -13,    33,   153,   136,   120,    23,    23,    23,    23,
      23,    23,   -13,   -13,  -156,   138,  -156,  -156,  -156,   149,
      23,   167,   172,  -156,  -156,  -156,  -156,   136,  -156,    23,
      23,    23,    23,    23,    23,  -156,   155,   157,   158,   160,
     161,   162,   173,  -156,  -156,   164,   150,    59,    59,   163,
     166,   170,   174,   175,   176,  -156,  -156,  -156,  -156,  -156,
    -156,    23,  -156,  -156,  -156,  -156,  -156,  -156,  -156,  -156,
    -156,   177,  -156
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       4,     0,     0,     0,     9,     0,     2,     4,     5,     6,
       0,     7,     8,    58,     0,     0,     0,     0,     1,     3,
      83,    97,    86,     0,     0,     0,    55,    56,    75,    70,
      45,     0,     0,     0,     0,     0,    95,    46,    88,     0,
       0,    87,    92,    97,     0,    89,    90,    91,    68,    67,
      57,    15,     0,     0,    20,     0,    48,    19,    23,    14,
       0,    64,    22,     0,    77,     0,    58,    72,    80,     0,
      50,     0,     0,     0,    93,    94,    85,     0,     0,     0,
       0,    99,    96,    98,     0,    16,    60,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    74,    77,    79,     0,
       0,     0,    69,    72,    81,    52,     0,     0,     0,     0,
       0,    27,   100,   102,    84,    47,     0,     0,     0,    63,
       0,     0,    21,    10,    11,    12,    13,    24,    61,     0,
      78,    76,    57,     0,    73,    71,     0,     0,    49,    52,
      54,     0,     0,    35,    14,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    42,     0,    17,    18,    44,    59,
      50,     0,    60,    82,    53,    51,    35,     0,    43,     0,
       0,     0,     0,     0,     0,    34,     0,     0,     0,     0,
       0,     0,    26,    25,   101,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    36,    37,    38,    39,    40,
      41,    50,    66,    62,    59,    28,    29,    30,    31,    32,
      33,     0,    65
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -156,  -156,   186,  -156,   -48,   -11,    31,   -70,   -65,   -93,
     179,  -156,    42,   -25,  -155,    62,  -156,    48,    50,   -17,
     107,  -156,   -91,  -156,   103,  -156,  -156,   106,  -156,  -156,
    -156,  -156,  -156,  -156,  -156,  -156,   178,   -69,  -156,  -156,
    -156
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     5,     6,     7,    56,    57,    58,    59,   145,   111,
      72,    38,    60,   105,   106,   138,   139,    62,     8,    14,
      64,    15,    50,    68,   102,   103,    65,    96,    97,     9,
      69,    10,    11,    42,    12,    43,    44,    22,    45,    46,
      47
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      61,   109,   128,   112,   113,   186,   110,    87,   132,   -46,
      77,    13,    67,    53,   143,   152,   153,    54,    51,   141,
     142,    54,    51,    90,    91,   154,    54,    51,   -45,   159,
      76,    16,    92,   -47,   -46,    52,    54,    51,   144,    52,
     123,   124,   125,   126,    52,   163,   211,    55,   166,    70,
     107,   108,    37,   -45,    52,   118,    55,    79,   -47,   119,
      87,   120,    48,    39,    49,   141,   108,    78,   117,    40,
      17,    41,   167,    18,    37,    28,   176,   177,   178,   179,
     180,   181,   121,   129,   134,    39,   184,   182,   183,   133,
      23,    40,    79,    41,    80,    20,   203,   204,    93,   189,
     190,   191,   192,   193,   194,    99,    51,   116,    51,    24,
      26,    25,   164,    27,    21,    29,    63,    94,    88,    89,
      90,    91,    66,    52,   100,    52,    70,    30,    71,    84,
       1,    74,   122,    31,    75,    32,    83,    33,    34,    35,
      36,     1,     2,     3,   152,   153,    88,    89,    90,    91,
      81,     4,    85,    98,   175,   146,   147,   148,   149,   150,
     151,    86,   169,   170,   171,   172,   173,   174,    95,   101,
     114,   104,   115,    21,   127,   136,   137,   140,   155,   156,
     157,   158,   160,   161,   162,   187,   202,   168,   185,   195,
     188,   196,   197,    19,   198,   199,   200,   205,   153,   201,
     206,   165,   130,   131,   207,     0,   135,     0,   208,   209,
     210,    73,     0,   212,     0,     0,     0,     0,     0,     0,
       0,    82
};

static const yytype_int16 yycheck[] =
{
      25,    71,    93,    72,    73,   160,    71,    55,    99,    12,
      35,     3,    29,    24,   107,    24,    25,     3,     4,    32,
      33,     3,     4,    22,    23,    34,     3,     4,    12,   120,
      16,     3,    12,    12,    37,    21,     3,     4,   108,    21,
      88,    89,    90,    91,    21,   136,   201,    33,   141,    33,
      32,    33,    21,    37,    21,    80,    33,    37,    37,    84,
     108,    18,     3,    21,     5,    32,    33,    12,    79,    21,
       3,    21,   142,     0,    43,    35,   146,   147,   148,   149,
     150,   151,    39,    94,   101,    43,   155,   152,   153,   100,
      18,    43,    37,    43,    39,    16,   187,   188,    18,   169,
     170,   171,   172,   173,   174,    18,     4,     3,     4,    37,
      16,    39,   137,    16,    35,    33,     3,    37,    20,    21,
      22,    23,     3,    21,    37,    21,    33,     3,    33,    39,
       6,    16,    34,     9,    16,    11,    36,    13,    14,    15,
      16,     6,     7,     8,    24,    25,    20,    21,    22,    23,
      16,    16,     4,    36,    34,    26,    27,    28,    29,    30,
      31,    38,    26,    27,    28,    29,    30,    31,    17,    17,
      16,    34,     3,    35,     3,    19,    17,    34,    10,    38,
      38,    16,    35,    38,    38,    18,    36,    34,    39,    34,
      18,    34,    34,     7,    34,    34,    34,    34,    25,    35,
      34,   139,    95,    97,    34,    -1,   103,    -1,    34,    34,
      34,    32,    -1,    36,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    43
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     6,     7,     8,    16,    42,    43,    44,    59,    70,
      72,    73,    75,     3,    60,    62,     3,     3,     0,    43,
      16,    35,    78,    18,    37,    39,    16,    16,    35,    33,
       3,     9,    11,    13,    14,    15,    16,    47,    52,    53,
      58,    59,    74,    76,    77,    79,    80,    81,     3,     5,
      63,     4,    21,    46,     3,    33,    45,    46,    47,    48,
      53,    54,    58,     3,    61,    67,     3,    60,    64,    71,
      33,    33,    51,    51,    16,    16,    16,    54,    12,    37,
      39,    16,    77,    36,    39,     4,    38,    45,    20,    21,
      22,    23,    12,    18,    37,    17,    68,    69,    36,    18,
      37,    17,    65,    66,    34,    54,    55,    32,    33,    48,
      49,    50,    78,    78,    16,     3,     3,    46,    54,    54,
      18,    39,    34,    45,    45,    45,    45,     3,    63,    46,
      61,    68,    63,    46,    60,    65,    19,    17,    56,    57,
      34,    32,    33,    50,    48,    49,    26,    27,    28,    29,
      30,    31,    24,    25,    34,    10,    38,    38,    16,    63,
      35,    38,    38,    63,    54,    56,    50,    48,    34,    26,
      27,    28,    29,    30,    31,    34,    48,    48,    48,    48,
      48,    48,    49,    49,    78,    39,    55,    18,    18,    48,
      48,    48,    48,    48,    48,    34,    34,    34,    34,    34,
      34,    35,    36,    63,    63,    34,    34,    34,    34,    34,
      34,    55,    36
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    41,    42,    43,    43,    44,    44,    44,    44,    44,
      45,    45,    45,    45,    45,    46,    46,    47,    47,    48,
      48,    48,    48,    48,    48,    49,    49,    49,    50,    50,
      50,    50,    50,    50,    50,    50,    51,    51,    51,    51,
      51,    51,    51,    51,    52,    53,    53,    53,    54,    55,
      55,    56,    56,    57,    58,    59,    59,    60,    60,    60,
      60,    61,    61,    62,    62,    62,    62,    63,    63,    64,
      64,    65,    65,    66,    67,    67,    68,    68,    69,    70,
      71,    72,    72,    73,    74,    74,    75,    76,    76,    76,
      76,    76,    76,    76,    76,    76,    77,    77,    78,    79,
      80,    80,    81
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     2,     0,     1,     1,     1,     1,     1,
       3,     3,     3,     3,     1,     1,     2,     4,     4,     1,
       1,     3,     1,     1,     3,     3,     3,     1,     5,     5,
       5,     5,     5,     5,     3,     2,     5,     5,     5,     5,
       5,     5,     3,     4,     4,     1,     1,     3,     1,     2,
       0,     2,     0,     2,     4,     3,     3,     3,     1,     6,
       4,     3,     6,     5,     3,    10,     8,     1,     1,     2,
       0,     2,     0,     2,     2,     0,     2,     0,     2,     5,
       1,     5,     7,     2,     3,     2,     2,     1,     1,     1,
       1,     1,     1,     2,     2,     1,     2,     0,     3,     2,
       3,     5,     3
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


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

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


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




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
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
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
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
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
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
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
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
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

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
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
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
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
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

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
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
  case 2: /* Program: ProgramElementList  */
#line 148 "parser.yacc"
{  
  root = A_Program((yyvsp[0].programElementList));
  (yyval.program) = A_Program((yyvsp[0].programElementList));
}
#line 1303 "y.tab.cpp"
    break;

  case 3: /* ProgramElementList: ProgramElement ProgramElementList  */
#line 155 "parser.yacc"
{
  (yyval.programElementList) = A_ProgramElementList((yyvsp[-1].programElement), (yyvsp[0].programElementList));
}
#line 1311 "y.tab.cpp"
    break;

  case 4: /* ProgramElementList: %empty  */
#line 159 "parser.yacc"
{
  (yyval.programElementList) = nullptr;
}
#line 1319 "y.tab.cpp"
    break;

  case 5: /* ProgramElement: VarDeclStmt  */
#line 165 "parser.yacc"
{
  (yyval.programElement) = A_ProgramVarDeclStmt((yyvsp[0].varDeclStmt)->pos, (yyvsp[0].varDeclStmt));
}
#line 1327 "y.tab.cpp"
    break;

  case 6: /* ProgramElement: StructDef  */
#line 169 "parser.yacc"
{
  (yyval.programElement) = A_ProgramStructDef((yyvsp[0].structDef)->pos, (yyvsp[0].structDef));
}
#line 1335 "y.tab.cpp"
    break;

  case 7: /* ProgramElement: FnDeclStmt  */
#line 173 "parser.yacc"
{
  (yyval.programElement) = A_ProgramFnDeclStmt((yyvsp[0].fnDeclStmt)->pos, (yyvsp[0].fnDeclStmt));
}
#line 1343 "y.tab.cpp"
    break;

  case 8: /* ProgramElement: FnDef  */
#line 177 "parser.yacc"
{
  (yyval.programElement) = A_ProgramFnDef((yyvsp[0].fnDef)->pos, (yyvsp[0].fnDef));
}
#line 1351 "y.tab.cpp"
    break;

  case 9: /* ProgramElement: SEMICOLON  */
#line 181 "parser.yacc"
{
  (yyval.programElement) = A_ProgramNullStmt((yyvsp[0].pos));
}
#line 1359 "y.tab.cpp"
    break;

  case 10: /* ArithExpr: ArithExpr ADD ArithExpr  */
#line 187 "parser.yacc"
{
  (yyval.arithExpr) = A_ArithBiOp_Expr((yyvsp[-2].arithExpr)->pos, A_ArithBiOpExpr((yyvsp[-2].arithExpr)->pos, A_add, (yyvsp[-2].arithExpr), (yyvsp[0].arithExpr)));
}
#line 1367 "y.tab.cpp"
    break;

  case 11: /* ArithExpr: ArithExpr SUB ArithExpr  */
#line 191 "parser.yacc"
{
  (yyval.arithExpr) = A_ArithBiOp_Expr((yyvsp[-2].arithExpr)->pos, A_ArithBiOpExpr((yyvsp[-2].arithExpr)->pos, A_sub, (yyvsp[-2].arithExpr), (yyvsp[0].arithExpr)));
}
#line 1375 "y.tab.cpp"
    break;

  case 12: /* ArithExpr: ArithExpr MUL ArithExpr  */
#line 195 "parser.yacc"
{
  (yyval.arithExpr) = A_ArithBiOp_Expr((yyvsp[-2].arithExpr)->pos, A_ArithBiOpExpr((yyvsp[-2].arithExpr)->pos, A_mul, (yyvsp[-2].arithExpr), (yyvsp[0].arithExpr)));
}
#line 1383 "y.tab.cpp"
    break;

  case 13: /* ArithExpr: ArithExpr DIV ArithExpr  */
#line 199 "parser.yacc"
{
  (yyval.arithExpr) = A_ArithBiOp_Expr((yyvsp[-2].arithExpr)->pos, A_ArithBiOpExpr((yyvsp[-2].arithExpr)->pos, A_div, (yyvsp[-2].arithExpr), (yyvsp[0].arithExpr)));
}
#line 1391 "y.tab.cpp"
    break;

  case 14: /* ArithExpr: ExprUnit  */
#line 203 "parser.yacc"
{
  (yyval.arithExpr) = A_ExprUnit((yyvsp[0].exprUnit)->pos, (yyvsp[0].exprUnit));
}
#line 1399 "y.tab.cpp"
    break;

  case 15: /* NUM: UNUM  */
#line 209 "parser.yacc"
{
  (yyval.tokenNum) = A_TokenNum((yyvsp[0].tokenNum)->pos, (yyvsp[0].tokenNum)->num);
}
#line 1407 "y.tab.cpp"
    break;

  case 16: /* NUM: SUB UNUM  */
#line 213 "parser.yacc"
{
  (yyval.tokenNum) = A_TokenNum((yyvsp[-1].pos), -(yyvsp[0].tokenNum)->num);
}
#line 1415 "y.tab.cpp"
    break;

  case 17: /* ArrayExpr: LeftVal LSB ID RSB  */
#line 219 "parser.yacc"
{
  (yyval.arrayExpr) = A_ArrayExpr((yyvsp[-3].leftVal)->pos, (yyvsp[-3].leftVal), A_IdIndexExpr((yyvsp[-1].tokenId)->pos, (yyvsp[-1].tokenId)->id));
}
#line 1423 "y.tab.cpp"
    break;

  case 18: /* ArrayExpr: LeftVal LSB NUM RSB  */
#line 223 "parser.yacc"
{
  (yyval.arrayExpr) = A_ArrayExpr((yyvsp[-3].leftVal)->pos, (yyvsp[-3].leftVal), A_NumIndexExpr((yyvsp[-1].tokenNum)->pos, (yyvsp[-1].tokenNum)->num));
}
#line 1431 "y.tab.cpp"
    break;

  case 19: /* ExprUnit: NUM  */
#line 229 "parser.yacc"
{
  (yyval.exprUnit) = A_NumExprUnit((yyvsp[0].tokenNum)->pos, (yyvsp[0].tokenNum)->num);
}
#line 1439 "y.tab.cpp"
    break;

  case 20: /* ExprUnit: ID  */
#line 233 "parser.yacc"
{
  (yyval.exprUnit) = A_IdExprUnit((yyvsp[0].tokenId)->pos, (yyvsp[0].tokenId)->id);
}
#line 1447 "y.tab.cpp"
    break;

  case 21: /* ExprUnit: LP ArithExpr RP  */
#line 237 "parser.yacc"
{
  (yyval.exprUnit) = A_ArithExprUnit((yyvsp[-2].pos), (yyvsp[-1].arithExpr));
}
#line 1455 "y.tab.cpp"
    break;

  case 22: /* ExprUnit: FnCall  */
#line 241 "parser.yacc"
{
  (yyval.exprUnit) = A_CallExprUnit((yyvsp[0].fnCall)->pos, (yyvsp[0].fnCall));
}
#line 1463 "y.tab.cpp"
    break;

  case 23: /* ExprUnit: ArrayExpr  */
#line 245 "parser.yacc"
{
  (yyval.exprUnit) = A_ArrayExprUnit((yyvsp[0].arrayExpr)->pos, (yyvsp[0].arrayExpr));
}
#line 1471 "y.tab.cpp"
    break;

  case 24: /* ExprUnit: LeftVal DOT ID  */
#line 249 "parser.yacc"
{
  (yyval.exprUnit) = A_MemberExprUnit((yyvsp[-2].leftVal)->pos, A_MemberExpr((yyvsp[-2].leftVal)->pos, (yyvsp[-2].leftVal), (yyvsp[0].tokenId)->id));
}
#line 1479 "y.tab.cpp"
    break;

  case 25: /* BoolExpr: BoolExpr AND BoolExpr  */
#line 255 "parser.yacc"
{
  (yyval.boolExpr) = A_BoolBiOp_Expr((yyvsp[-2].boolExpr)->pos, A_BoolBiOpExpr((yyvsp[-2].boolExpr)->pos, A_and, (yyvsp[-2].boolExpr), (yyvsp[0].boolExpr)));
}
#line 1487 "y.tab.cpp"
    break;

  case 26: /* BoolExpr: BoolExpr OR BoolExpr  */
#line 259 "parser.yacc"
{
  (yyval.boolExpr) = A_BoolBiOp_Expr((yyvsp[-2].boolExpr)->pos, A_BoolBiOpExpr((yyvsp[-2].boolExpr)->pos, A_or, (yyvsp[-2].boolExpr), (yyvsp[0].boolExpr)));
}
#line 1495 "y.tab.cpp"
    break;

  case 27: /* BoolExpr: BoolUnit  */
#line 263 "parser.yacc"
{
  (yyval.boolExpr) = A_BoolExpr((yyvsp[0].boolUnit)->pos, (yyvsp[0].boolUnit));
}
#line 1503 "y.tab.cpp"
    break;

  case 28: /* BoolUnit: LP ExprUnit LT ExprUnit RP  */
#line 269 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_lt, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1511 "y.tab.cpp"
    break;

  case 29: /* BoolUnit: LP ExprUnit LE ExprUnit RP  */
#line 273 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_le, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1519 "y.tab.cpp"
    break;

  case 30: /* BoolUnit: LP ExprUnit GT ExprUnit RP  */
#line 277 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_gt, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1527 "y.tab.cpp"
    break;

  case 31: /* BoolUnit: LP ExprUnit GE ExprUnit RP  */
#line 281 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_ge, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1535 "y.tab.cpp"
    break;

  case 32: /* BoolUnit: LP ExprUnit EQ ExprUnit RP  */
#line 285 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_eq, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1543 "y.tab.cpp"
    break;

  case 33: /* BoolUnit: LP ExprUnit NE ExprUnit RP  */
#line 289 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_ne, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1551 "y.tab.cpp"
    break;

  case 34: /* BoolUnit: LP BoolExpr RP  */
#line 293 "parser.yacc"
{
  (yyval.boolUnit) = A_BoolExprUnit((yyvsp[-2].pos), (yyvsp[-1].boolExpr));
}
#line 1559 "y.tab.cpp"
    break;

  case 35: /* BoolUnit: NOT BoolUnit  */
#line 297 "parser.yacc"
{
  (yyval.boolUnit) = A_BoolUOpExprUnit((yyvsp[-1].pos), A_BoolUOpExpr((yyvsp[-1].pos), A_not, (yyvsp[0].boolUnit)));
}
#line 1567 "y.tab.cpp"
    break;

  case 36: /* BoolUnit_: LP ExprUnit LT ExprUnit RP  */
#line 303 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_lt, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1575 "y.tab.cpp"
    break;

  case 37: /* BoolUnit_: LP ExprUnit LE ExprUnit RP  */
#line 307 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_le, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1583 "y.tab.cpp"
    break;

  case 38: /* BoolUnit_: LP ExprUnit GT ExprUnit RP  */
#line 311 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_gt, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1591 "y.tab.cpp"
    break;

  case 39: /* BoolUnit_: LP ExprUnit GE ExprUnit RP  */
#line 315 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_ge, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1599 "y.tab.cpp"
    break;

  case 40: /* BoolUnit_: LP ExprUnit EQ ExprUnit RP  */
#line 319 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_eq, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1607 "y.tab.cpp"
    break;

  case 41: /* BoolUnit_: LP ExprUnit NE ExprUnit RP  */
#line 323 "parser.yacc"
{
  (yyval.boolUnit) = A_ComExprUnit((yyvsp[-3].exprUnit)->pos, A_ComExpr((yyvsp[-3].exprUnit)->pos, A_ne, (yyvsp[-3].exprUnit), (yyvsp[-1].exprUnit)));
}
#line 1615 "y.tab.cpp"
    break;

  case 42: /* BoolUnit_: LP BoolExpr RP  */
#line 327 "parser.yacc"
{
  (yyval.boolUnit) = A_BoolExprUnit((yyvsp[-2].pos), (yyvsp[-1].boolExpr));
}
#line 1623 "y.tab.cpp"
    break;

  case 43: /* BoolUnit_: LP NOT BoolUnit RP  */
#line 331 "parser.yacc"
{
  (yyval.boolUnit) = A_BoolUOpExprUnit((yyvsp[-2].pos), A_BoolUOpExpr((yyvsp[-2].pos), A_not, (yyvsp[-1].boolUnit)));
}
#line 1631 "y.tab.cpp"
    break;

  case 44: /* AssignStmt: LeftVal AS RightVal SEMICOLON  */
#line 337 "parser.yacc"
{
  (yyval.assignStmt) = A_AssignStmt((yyvsp[-3].leftVal)->pos, (yyvsp[-3].leftVal), (yyvsp[-1].rightVal));
}
#line 1639 "y.tab.cpp"
    break;

  case 45: /* LeftVal: ID  */
#line 343 "parser.yacc"
{
  (yyval.leftVal) = A_IdExprLVal((yyvsp[0].tokenId)->pos, (yyvsp[0].tokenId)->id);
}
#line 1647 "y.tab.cpp"
    break;

  case 46: /* LeftVal: ArrayExpr  */
#line 347 "parser.yacc"
{
  (yyval.leftVal) = A_ArrExprLVal((yyvsp[0].arrayExpr)->pos, (yyvsp[0].arrayExpr));
}
#line 1655 "y.tab.cpp"
    break;

  case 47: /* LeftVal: LeftVal DOT ID  */
#line 351 "parser.yacc"
{
  (yyval.leftVal) = A_MemberExprLVal((yyvsp[-2].leftVal)->pos, A_MemberExpr((yyvsp[-2].leftVal)->pos, (yyvsp[-2].leftVal), (yyvsp[0].tokenId)->id));
}
#line 1663 "y.tab.cpp"
    break;

  case 48: /* RightVal: ArithExpr  */
#line 357 "parser.yacc"
{
  (yyval.rightVal) = A_ArithExprRVal((yyvsp[0].arithExpr)->pos, (yyvsp[0].arithExpr));
}
#line 1671 "y.tab.cpp"
    break;

  case 49: /* RightValList: RightVal RightValRestList  */
#line 363 "parser.yacc"
{
  (yyval.rightValList) = A_RightValList((yyvsp[-1].rightVal), (yyvsp[0].rightValList));
}
#line 1679 "y.tab.cpp"
    break;

  case 50: /* RightValList: %empty  */
#line 367 "parser.yacc"
{
  (yyval.rightValList) = nullptr;
}
#line 1687 "y.tab.cpp"
    break;

  case 51: /* RightValRestList: RightValRest RightValRestList  */
#line 372 "parser.yacc"
{
  (yyval.rightValList) = A_RightValList((yyvsp[-1].rightVal), (yyvsp[0].rightValList));
}
#line 1695 "y.tab.cpp"
    break;

  case 52: /* RightValRestList: %empty  */
#line 376 "parser.yacc"
{
  (yyval.rightValList) = nullptr;
}
#line 1703 "y.tab.cpp"
    break;

  case 53: /* RightValRest: COMMA RightVal  */
#line 381 "parser.yacc"
{
  (yyval.rightVal) = (yyvsp[0].rightVal);
}
#line 1711 "y.tab.cpp"
    break;

  case 54: /* FnCall: ID LP RightValList RP  */
#line 387 "parser.yacc"
{
  (yyval.fnCall) = A_FnCall((yyvsp[-3].tokenId)->pos, (yyvsp[-3].tokenId)->id, (yyvsp[-1].rightValList));
}
#line 1719 "y.tab.cpp"
    break;

  case 55: /* VarDeclStmt: LET VarDecl SEMICOLON  */
#line 393 "parser.yacc"
{
  (yyval.varDeclStmt) = A_VarDeclStmt((yyvsp[-2].pos), (yyvsp[-1].varDecl));
}
#line 1727 "y.tab.cpp"
    break;

  case 56: /* VarDeclStmt: LET VarDef SEMICOLON  */
#line 397 "parser.yacc"
{
  (yyval.varDeclStmt) = A_VarDefStmt((yyvsp[-2].pos), (yyvsp[-1].varDef));
}
#line 1735 "y.tab.cpp"
    break;

  case 57: /* VarDecl: ID COLON Type  */
#line 403 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Scalar((yyvsp[-2].tokenId)->pos, A_VarDeclScalar((yyvsp[-2].tokenId)->pos, (yyvsp[-2].tokenId)->id, (yyvsp[0].type)));
}
#line 1743 "y.tab.cpp"
    break;

  case 58: /* VarDecl: ID  */
#line 407 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Scalar((yyvsp[0].tokenId)->pos, A_VarDeclScalar((yyvsp[0].tokenId)->pos, (yyvsp[0].tokenId)->id, nullptr));
}
#line 1751 "y.tab.cpp"
    break;

  case 59: /* VarDecl: ID LSB NUM RSB COLON Type  */
#line 411 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Array((yyvsp[-5].tokenId)->pos, A_VarDeclArray((yyvsp[-5].tokenId)->pos, (yyvsp[-5].tokenId)->id, (yyvsp[-3].tokenNum)->num, (yyvsp[0].type)));
}
#line 1759 "y.tab.cpp"
    break;

  case 60: /* VarDecl: ID LSB NUM RSB  */
#line 415 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Array((yyvsp[-3].tokenId)->pos, A_VarDeclArray((yyvsp[-3].tokenId)->pos, (yyvsp[-3].tokenId)->id, (yyvsp[-1].tokenNum)->num, nullptr));
}
#line 1767 "y.tab.cpp"
    break;

  case 61: /* FieldDecl: ID COLON Type  */
#line 421 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Scalar((yyvsp[-2].tokenId)->pos, A_VarDeclScalar((yyvsp[-2].tokenId)->pos, (yyvsp[-2].tokenId)->id, (yyvsp[0].type)));
}
#line 1775 "y.tab.cpp"
    break;

  case 62: /* FieldDecl: ID LSB NUM RSB COLON Type  */
#line 425 "parser.yacc"
{
  (yyval.varDecl) = A_VarDecl_Array((yyvsp[-5].tokenId)->pos, A_VarDeclArray((yyvsp[-5].tokenId)->pos, (yyvsp[-5].tokenId)->id, (yyvsp[-3].tokenNum)->num, (yyvsp[0].type)));
}
#line 1783 "y.tab.cpp"
    break;

  case 63: /* VarDef: ID COLON Type AS RightVal  */
#line 431 "parser.yacc"
{
  (yyval.varDef) = A_VarDef_Scalar((yyvsp[-4].tokenId)->pos, A_VarDefScalar((yyvsp[-4].tokenId)->pos, (yyvsp[-4].tokenId)->id, (yyvsp[-2].type), (yyvsp[0].rightVal)));
}
#line 1791 "y.tab.cpp"
    break;

  case 64: /* VarDef: ID AS RightVal  */
#line 435 "parser.yacc"
{
  (yyval.varDef) = A_VarDef_Scalar((yyvsp[-2].tokenId)->pos, A_VarDefScalar((yyvsp[-2].tokenId)->pos, (yyvsp[-2].tokenId)->id, nullptr, (yyvsp[0].rightVal)));
}
#line 1799 "y.tab.cpp"
    break;

  case 65: /* VarDef: ID LSB NUM RSB COLON Type AS LB RightValList RB  */
#line 439 "parser.yacc"
{
  (yyval.varDef) = A_VarDef_Array((yyvsp[-9].tokenId)->pos, A_VarDefArray((yyvsp[-9].tokenId)->pos, (yyvsp[-9].tokenId)->id, (yyvsp[-7].tokenNum)->num, (yyvsp[-4].type), (yyvsp[-1].rightValList)));
}
#line 1807 "y.tab.cpp"
    break;

  case 66: /* VarDef: ID LSB NUM RSB AS LB RightValList RB  */
#line 443 "parser.yacc"
{
  (yyval.varDef) = A_VarDef_Array((yyvsp[-7].tokenId)->pos, A_VarDefArray((yyvsp[-7].tokenId)->pos, (yyvsp[-7].tokenId)->id, (yyvsp[-5].tokenNum)->num, nullptr, (yyvsp[-1].rightValList)));
}
#line 1815 "y.tab.cpp"
    break;

  case 67: /* Type: INT  */
#line 449 "parser.yacc"
{
  (yyval.type) = A_NativeType((yyvsp[0].pos), A_intTypeKind);
}
#line 1823 "y.tab.cpp"
    break;

  case 68: /* Type: ID  */
#line 453 "parser.yacc"
{
  (yyval.type) = A_StructType((yyvsp[0].tokenId)->pos, (yyvsp[0].tokenId)->id);
}
#line 1831 "y.tab.cpp"
    break;

  case 69: /* VarDeclList: VarDecl VarDeclRestList  */
#line 459 "parser.yacc"
{
  (yyval.varDeclList) = A_VarDeclList((yyvsp[-1].varDecl), (yyvsp[0].varDeclList));
}
#line 1839 "y.tab.cpp"
    break;

  case 70: /* VarDeclList: %empty  */
#line 463 "parser.yacc"
{
  (yyval.varDeclList) = nullptr;
}
#line 1847 "y.tab.cpp"
    break;

  case 71: /* VarDeclRestList: VarDeclRest VarDeclRestList  */
#line 468 "parser.yacc"
{
  (yyval.varDeclList) = A_VarDeclList((yyvsp[-1].varDecl), (yyvsp[0].varDeclList));
}
#line 1855 "y.tab.cpp"
    break;

  case 72: /* VarDeclRestList: %empty  */
#line 472 "parser.yacc"
{
  (yyval.varDeclList) = nullptr;
}
#line 1863 "y.tab.cpp"
    break;

  case 73: /* VarDeclRest: COMMA VarDecl  */
#line 477 "parser.yacc"
{
  (yyval.varDecl) = (yyvsp[0].varDecl);
}
#line 1871 "y.tab.cpp"
    break;

  case 74: /* FieldDeclList: FieldDecl FieldDeclRestList  */
#line 483 "parser.yacc"
{
  (yyval.varDeclList) = A_VarDeclList((yyvsp[-1].varDecl), (yyvsp[0].varDeclList));
}
#line 1879 "y.tab.cpp"
    break;

  case 75: /* FieldDeclList: %empty  */
#line 487 "parser.yacc"
{
  (yyval.varDeclList) = nullptr;
}
#line 1887 "y.tab.cpp"
    break;

  case 76: /* FieldDeclRestList: FieldDeclRest FieldDeclRestList  */
#line 492 "parser.yacc"
{
  (yyval.varDeclList) = A_VarDeclList((yyvsp[-1].varDecl), (yyvsp[0].varDeclList));
}
#line 1895 "y.tab.cpp"
    break;

  case 77: /* FieldDeclRestList: %empty  */
#line 496 "parser.yacc"
{
  (yyval.varDeclList) = nullptr;
}
#line 1903 "y.tab.cpp"
    break;

  case 78: /* FieldDeclRest: COMMA FieldDecl  */
#line 501 "parser.yacc"
{
  (yyval.varDecl) = (yyvsp[0].varDecl);
}
#line 1911 "y.tab.cpp"
    break;

  case 79: /* StructDef: STRUCT ID LB FieldDeclList RB  */
#line 507 "parser.yacc"
{
  (yyval.structDef) = A_StructDef((yyvsp[-4].pos), (yyvsp[-3].tokenId)->id, (yyvsp[-1].varDeclList));
}
#line 1919 "y.tab.cpp"
    break;

  case 80: /* ParamDecl: VarDeclList  */
#line 513 "parser.yacc"
{
  (yyval.paramDecl) = A_ParamDecl((yyvsp[0].varDeclList));
}
#line 1927 "y.tab.cpp"
    break;

  case 81: /* FnDecl: FN ID LP ParamDecl RP  */
#line 519 "parser.yacc"
{
  (yyval.fnDecl) = A_FnDecl((yyvsp[-4].pos), (yyvsp[-3].tokenId)->id, (yyvsp[-1].paramDecl), nullptr);
}
#line 1935 "y.tab.cpp"
    break;

  case 82: /* FnDecl: FN ID LP ParamDecl RP ARROW Type  */
#line 523 "parser.yacc"
{
  (yyval.fnDecl) = A_FnDecl((yyvsp[-6].pos), (yyvsp[-5].tokenId)->id, (yyvsp[-3].paramDecl), (yyvsp[0].type));
}
#line 1943 "y.tab.cpp"
    break;

  case 83: /* FnDeclStmt: FnDecl SEMICOLON  */
#line 529 "parser.yacc"
{
  (yyval.fnDeclStmt) = A_FnDeclStmt((yyvsp[-1].fnDecl)->pos, (yyvsp[-1].fnDecl));
}
#line 1951 "y.tab.cpp"
    break;

  case 84: /* ReturnStmt: RETURN RightVal SEMICOLON  */
#line 535 "parser.yacc"
{
  (yyval.returnStmt) = A_ReturnStmt((yyvsp[-2].pos), (yyvsp[-1].rightVal));
}
#line 1959 "y.tab.cpp"
    break;

  case 85: /* ReturnStmt: RETURN SEMICOLON  */
#line 539 "parser.yacc"
{
  (yyval.returnStmt) = A_ReturnStmt((yyvsp[-1].pos), nullptr);
}
#line 1967 "y.tab.cpp"
    break;

  case 86: /* FnDef: FnDecl CodeBlock  */
#line 545 "parser.yacc"
{
  (yyval.fnDef) = A_FnDef((yyvsp[-1].fnDecl)->pos, (yyvsp[-1].fnDecl), (yyvsp[0].codeBlockStmtList));
}
#line 1975 "y.tab.cpp"
    break;

  case 87: /* CodeBlockStmt: VarDeclStmt  */
#line 551 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockVarDeclStmt((yyvsp[0].varDeclStmt)->pos, (yyvsp[0].varDeclStmt));
}
#line 1983 "y.tab.cpp"
    break;

  case 88: /* CodeBlockStmt: AssignStmt  */
#line 555 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockAssignStmt((yyvsp[0].assignStmt)->pos, (yyvsp[0].assignStmt));
}
#line 1991 "y.tab.cpp"
    break;

  case 89: /* CodeBlockStmt: CallStmt  */
#line 559 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockCallStmt((yyvsp[0].callStmt)->pos, (yyvsp[0].callStmt));
}
#line 1999 "y.tab.cpp"
    break;

  case 90: /* CodeBlockStmt: IfStmt  */
#line 563 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockIfStmt((yyvsp[0].ifStmt)->pos, (yyvsp[0].ifStmt));
}
#line 2007 "y.tab.cpp"
    break;

  case 91: /* CodeBlockStmt: WhileStmt  */
#line 567 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockWhileStmt((yyvsp[0].whileStmt)->pos, (yyvsp[0].whileStmt));
}
#line 2015 "y.tab.cpp"
    break;

  case 92: /* CodeBlockStmt: ReturnStmt  */
#line 571 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockReturnStmt((yyvsp[0].returnStmt)->pos, (yyvsp[0].returnStmt));
}
#line 2023 "y.tab.cpp"
    break;

  case 93: /* CodeBlockStmt: CONTINUE SEMICOLON  */
#line 575 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockContinueStmt((yyvsp[-1].pos));
}
#line 2031 "y.tab.cpp"
    break;

  case 94: /* CodeBlockStmt: BREAK SEMICOLON  */
#line 579 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockBreakStmt((yyvsp[-1].pos));
}
#line 2039 "y.tab.cpp"
    break;

  case 95: /* CodeBlockStmt: SEMICOLON  */
#line 583 "parser.yacc"
{
  (yyval.codeBlockStmt) = A_BlockNullStmt((yyvsp[0].pos));
}
#line 2047 "y.tab.cpp"
    break;

  case 96: /* CodeBlockStmtList: CodeBlockStmt CodeBlockStmtList  */
#line 589 "parser.yacc"
{
  (yyval.codeBlockStmtList) = A_CodeBlockStmtList((yyvsp[-1].codeBlockStmt), (yyvsp[0].codeBlockStmtList));
}
#line 2055 "y.tab.cpp"
    break;

  case 97: /* CodeBlockStmtList: %empty  */
#line 593 "parser.yacc"
{
  (yyval.codeBlockStmtList) = nullptr;
}
#line 2063 "y.tab.cpp"
    break;

  case 98: /* CodeBlock: LB CodeBlockStmtList RB  */
#line 599 "parser.yacc"
{
  (yyval.codeBlockStmtList) = (yyvsp[-1].codeBlockStmtList);
}
#line 2071 "y.tab.cpp"
    break;

  case 99: /* CallStmt: FnCall SEMICOLON  */
#line 605 "parser.yacc"
{
  (yyval.callStmt) = A_CallStmt((yyvsp[-1].fnCall)->pos, (yyvsp[-1].fnCall));
}
#line 2079 "y.tab.cpp"
    break;

  case 100: /* IfStmt: IF BoolUnit_ CodeBlock  */
#line 611 "parser.yacc"
{
  (yyval.ifStmt) = A_IfStmt((yyvsp[-2].pos), (yyvsp[-1].boolUnit), (yyvsp[0].codeBlockStmtList), nullptr);
}
#line 2087 "y.tab.cpp"
    break;

  case 101: /* IfStmt: IF BoolUnit_ CodeBlock ELSE CodeBlock  */
#line 615 "parser.yacc"
{
  (yyval.ifStmt) = A_IfStmt((yyvsp[-4].pos), (yyvsp[-3].boolUnit), (yyvsp[-2].codeBlockStmtList), (yyvsp[0].codeBlockStmtList));
}
#line 2095 "y.tab.cpp"
    break;

  case 102: /* WhileStmt: WHILE BoolUnit_ CodeBlock  */
#line 621 "parser.yacc"
{
  (yyval.whileStmt) = A_WhileStmt((yyvsp[-2].pos), (yyvsp[-1].boolUnit), (yyvsp[0].codeBlockStmtList));
}
#line 2103 "y.tab.cpp"
    break;


#line 2107 "y.tab.cpp"

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
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

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
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
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
  ++yynerrs;

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

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
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
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
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
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 626 "parser.yacc"


extern "C"{
void yyerror(const char * s)
{
  fprintf(stderr, "%s\n",s);
}
int yywrap()
{
  return(1);
}
}

