%{
  #include "symbols.h"
  #include "MiniL.c"
  #define INT_TYPE_NUM 1
  #define FLOAT_TYPE_NUM 2
  #define STRING_TYPE_NUM 3
  #define NULL_Value -135
  #define NULL_str "\null"
  int div_zero = 0;
%}
%token OUTKEY DPP INKEY BIBLANG INTKEY PVG FLOATKEY STRKEY BIBIO PUBLICKEY PROTECTEDKEY FORKEY MAINKEY CLASSKEY IMPORTKEY CONSTANT TABLEKEY LETTER NUMBER CHAR PLUS MINUS DIV MUL OP CP OA CA OC CC VRG EQ NEQ SUP INF INFEQ SUPEQ ANDOP OROP apostrophe NOT
%union{
  char* chr;
  int int_type;
  float real_type;
  value valeur;
}
%token <chr> KEYWORD Signformattageint Signformattagefloat Signformattagestr
%token <int_type> INTEGER
%token <real_type> REAL
%token <chr> STR
%type<valeur> EXP
%type<chr> chaine SIGNFORMAT
%type<chr> OTHERVAR_int OTHERVAR_real OTHERVAR_str
%start S
%left OROP
%left ANDOP 
%left NOT
%left SUP SUPEQ INF INFEQ EQ NEQ
%left PLUS MINUS
%left DIV MUL
%%

S : LISTBIB CLASSPART;
LISTBIB : BIB LISTBIB| BIB;
BIB: IMPORTKEY NOMBIB PVG;
NOMBIB : BIBIO | BIBLANG;
CLASSPART : MODIFOPTION CLASSKEY KEYWORD OA DECLARATIONPART MAINKEY OA MAINPART CA CA;
MODIFOPTION : PUBLICKEY | PROTECTEDKEY | ;
DECLARATIONPART : VARDECLARATION DECLARATIONPART | TABLEDECLARATION DECLARATIONPART |;
VARDECLARATION : INTKEY KEYWORD EQ INTEGER PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                                else{add_symbol($2,1,$4,NULL_Value,NULL_str);};} 
                | INTKEY KEYWORD OTHERVAR_int PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                                  else if(symbol_exists($3)){printf("error");exit(0);}
                                                  else{add_symbol($2,1,NULL_Value,NULL_Value,NULL_str);};} 
                | FLOATKEY KEYWORD EQ REAL PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                                else{add_symbol($2,2,NULL_Value,$4,NULL_str);};}
                | FLOATKEY KEYWORD OTHERVAR_real PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                                      else if(symbol_exists($3)){printf("error");exit(0);}
                                                      else{add_symbol($2,2,NULL_Value,NULL_Value,NULL_str);};}
                | STRKEY KEYWORD EQ STR PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                             else{add_symbol($2,3,NULL_Value,NULL_Value,$4);};}
                | STRKEY KEYWORD OTHERVAR_str PVG {if(symbol_exists($2)){printf("error in line %d : variable %s already existe ! ",yylineno,$2);exit(0);}
                                                   else if(symbol_exists($3)){printf("error");exit(0);}
                                                   else{add_symbol($2,3,NULL_Value,NULL_Value,NULL_str);};};
OTHERVAR_int : VRG KEYWORD OTHERVAR_int {$$=$2;}|;
OTHERVAR_real: VRG KEYWORD OTHERVAR_real {$$=$2;}|;
OTHERVAR_str: VRG KEYWORD OTHERVAR_str {$$=$2;}|
;
TABLEDECLARATION : TYPEOPTION KEYWORD OC NUMBER CC PVG| TYPEOPTION KEYWORD OC CC PVG; // INT T[10];
TYPEOPTION : INTKEY| FLOATKEY| STRKEY;
MAINPART : OPTIONINST MAINPART |;
OPTIONINST : LISTaff | LISTboucle | LISTread | LISTwrite ;
LISTaff : KEYWORD DPP EQ EXP PVG {
  if($1 != $4.type){
    printf("error in line %d : ",yylineno);
    printf("%s is not of type %d\n",$1,$4.type);
    exit(0);
  }else 
  if (div_zero){
    printf("error in line %d : ",yylineno);
    printf("division sur 0\n");
    exit(0);
    }else{
      symbol_t* s = get_symbol($1); 
      if(s!=NULL){
        if ($4.type == INT_TYPE_NUM) {
                s->value = $4;
        } else{
                s->value = $4;
        }
      }
    }
  }
  ;
EXP : INTEGER {
    $$.int_val = $1;
    $$.type = 1;
  }
  | EXP PLUS EXP {
    if ($1.type == INT_TYPE_NUM && $3.type == FLOAT_TYPE_NUM) {
        $$.float_val = (float) $1.int_val + $3.float_val;
        $$.type = FLOAT_TYPE_NUM;
    }
    else if ($1.type == FLOAT_TYPE_NUM && $3.type == INT_TYPE_NUM) {
        $$.float_val = $1.float_val + (float) $3.int_val;
        $$.type = FLOAT_TYPE_NUM;
    }
    else if ($1.type == 1 && $3.type == 1) {
        $$.int_val = $1.int_val + $3.int_val;
        $$.type = INT_TYPE_NUM;
    }
    else {
        $$.float_val = $1.float_val + $3.float_val;
        $$.type = FLOAT_TYPE_NUM;
    }
  }
  |  EXP MINUS EXP {
    if ($1.type == 1 && $3.type == 2) {
        $$.float_val = (float) $1.int_val - $3.float_val;
        $$.type = 2;
    }
    else if ($1.type == 2 && $3.type == 1) {
        $$.float_val = $1.float_val - (float) $3.int_val;
        $$.type = 2;
    }
    else if ($1.type == 1 && $3.type == 1) {
        $$.int_val = $1.int_val - $3.int_val;
        $$.type = 1;
    }
    else {
        $$.float_val = $1.float_val - $3.float_val;
        $$.type = FLOAT_TYPE_NUM;
    }
  }
  |  EXP MUL EXP {
     if ($1.type == INT_TYPE_NUM && $3.type == FLOAT_TYPE_NUM) {
        $$.float_val = (float) $1.int_val * $3.float_val;
        $$.type = FLOAT_TYPE_NUM;
    }
    else if ($1.type == FLOAT_TYPE_NUM && $3.type == INT_TYPE_NUM) {
        $$.float_val = $1.float_val * (float) $3.int_val;
        $$.type = FLOAT_TYPE_NUM;
    }
    else if ($1.type == INT_TYPE_NUM && $3.type == INT_TYPE_NUM) {
        $$.int_val = $1.int_val * $3.int_val;
        $$.type = INT_TYPE_NUM;
    }
    else {
        $$.float_val = $1.float_val * $3.float_val;
        $$.type = FLOAT_TYPE_NUM;
    }
  }
  |  EXP DIV EXP {
    if ($3.float_val == 0.0) {
        div_zero = 1;
    } else {
        if ($1.type == INT_TYPE_NUM && $3.type == FLOAT_TYPE_NUM) {
            $$.float_val = (float) $1.int_val / $3.float_val;
            $$.type = FLOAT_TYPE_NUM;
        } else if ($1.type == FLOAT_TYPE_NUM && $3.type == INT_TYPE_NUM) {
            $$.float_val = $1.float_val / (float) $3.int_val;
            $$.type = FLOAT_TYPE_NUM;
        } else {
            $$.float_val = $1.float_val / $3.float_val;
            $$.type = FLOAT_TYPE_NUM;
        }
    }
  }
  | REAL {
    $$.type = 2;
    $$.float_val = $1;
  }
  | KEYWORD {
    $$.type = INT_TYPE_NUM;
    $$.int_val = $1;
  }
  ;
LISTboucle : FORKEY OP condition CP OA boucleinstru CA;
condition : KEYWORD DPP EQ INTEGER PVG KEYWORD conditionoption INTEGER PVG KEYWORD PLUS PLUS;
conditionoption : EQ | NEQ | SUP | INF | INFEQ | SUPEQ;
boucleinstru : MAINPART;


LISTread : INKEY OP chaine CP PVG
; // IN('%d',A);
chaine : apostrophe SIGNFORMAT apostrophe VRG KEYWORD {print_symbol($5);}
;
SIGNFORMAT :   Signformattageint 
             | Signformattagefloat
             | Signformattagestr
             ;

LISTwrite : OUTKEY OP chainewrite CP PVG; // OUT('%d',A);
chainewrite : apostrophe SIGNFORMAT apostrophe VRG KEYWORD {input_symbol($5);}
;

%%

void yyerror(char* s){
		printf("erreur syntaxique : %s a la ligne %d\n",yytext,yylineno);
}
void main()
{
	yyparse();
	printf("fin de analyse syntaxique");

}