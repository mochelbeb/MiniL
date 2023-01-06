/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
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

#ifndef YY_YY_MINIL_TAB_H_INCLUDED
# define YY_YY_MINIL_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     OUTKEY = 258,
     DPP = 259,
     INKEY = 260,
     BIBLANG = 261,
     INTKEY = 262,
     PVG = 263,
     FLOATKEY = 264,
     Signformattageint = 265,
     Signformattagefloat = 266,
     Signformattagestr = 267,
     STRKEY = 268,
     BIBIO = 269,
     PUBLICKEY = 270,
     PROTECTEDKEY = 271,
     FORKEY = 272,
     MAINKEY = 273,
     CLASSKEY = 274,
     IMPORTKEY = 275,
     CONSTANT = 276,
     TABLEKEY = 277,
     LETTER = 278,
     NUMBER = 279,
     CHAR = 280,
     PLUS = 281,
     MINUS = 282,
     DIV = 283,
     MUL = 284,
     OP = 285,
     CP = 286,
     OA = 287,
     CA = 288,
     OC = 289,
     CC = 290,
     VRG = 291,
     EQ = 292,
     NEQ = 293,
     SUP = 294,
     INF = 295,
     INFEQ = 296,
     SUPEQ = 297,
     ANDOP = 298,
     OROP = 299,
     apostrophe = 300,
     NOT = 301,
     KEYWORD = 302,
     INTEGER = 303,
     REAL = 304,
     STR = 305
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 16 "MiniL.y"

  char* chr;
  int int_type;
  double real_type;


/* Line 2058 of yacc.c  */
#line 114 "MiniL.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_MINIL_TAB_H_INCLUDED  */
