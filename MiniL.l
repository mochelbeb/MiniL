%{
    #include "MiniL.tab.h"
%}

%option noyywrap
%option yylineno

NUMBER [0-9]
LETTER [a-zA-Z]
INTEGER ("+"|"-")?[0-9]+
CONSTANT {NUMBER}+
REAL ("+"|"-")?{NUMBER}+"."{NUMBER}*
STR [a-zA-Z]+
keyword "$"[a-zA-Z][a-zA-Z0-9]*
%%
import return IMPORTKEY;
class return CLASSKEY;
main return MAINKEY;
int return INTKEY;
float return FLOATKEY;
str return STRKEY;
for return FORKEY;
public return PUBLICKEY;
protected return PROTECTEDKEY;
MiniL.io return BIBIO;
MiniL.lang return BIBLANG;
IN return INKEY;
OUT return OUTKEY;
{keyword} {yylval.chr = malloc(yyleng+1);strcpy(yylval.chr,yytext); return KEYWORD;}
{STR} return STR; 
{INTEGER} {yylval.int_type = atoi(yytext); return INTEGER;}
{REAL} {yylval.real_type = atof(yytext); return REAL;}
"+" return PLUS;
"-" return MINUS;
"/" return DIV;
"*" return MUL;
"(" return OP;
")" return CP;
"{" return OA;
"}" return CA;
"[" return OC;
"]" return CC;
"," return VRG;
"=" return EQ;
":" return DPP;
"!=" return NEQ;
">" return SUP;
"<" return INF;
"<=" return INFEQ;
">=" return SUPEQ;
"&" return ANDOP;
"|" return OROP;
"!" return NOT;
";" return PVG;
"%d" return Signformattageint;
"%f" return Signformattagefloat;
"%s" return Signformattagestr;
"'" return apostrophe;
[ \t\n]
. printf("erreur lexicale: %s a la ligne %d\n",yytext,yylineno);
%%