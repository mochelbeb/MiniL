%{
    #include "MiniL.c"
    void yyerror(char* err);
    int div_zero = 0;
    int t[100];
    char *M[100];
    int i =0;
%}
%token OUTKEY DPP INKEY BIBLANG INTKEY PVG FLOATKEY Signformattageint Signformattagefloat Signformattagestr STRKEY BIBIO PUBLICKEY PROTECTEDKEY FORKEY MAINKEY CLASSKEY IMPORTKEY CONSTANT TABLEKEY LETTER NUMBER STR CHAR PLUS MINUS DIV MUL OP CP OA CA OC CC VRG EQ NEQ SUP INF INFEQ SUPEQ ANDOP OROP apostrophe NOT
%union{
  char* chr;
  int int_type;
  double real_type;
}
%token <chr> KEYWORD 
%token <int_type> INTEGER
%token <real_type> REAL
%type<int_type> EXP
%type<chr> chaine
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
VARDECLARATION : INTKEY KEYWORD EQ INTEGER PVG {t[i] = $4;M[i] = $2;i++; printf("%s %d %s %d",$2,$4,M[0],t[0]);} 
                | INTKEY KEYWORD OTHERVAR PVG
                | FLOATKEY KEYWORD EQ REAL PVG
                | FLOATKEY KEYWORD OTHERVAR PVG
                | STRKEY KEYWORD EQ STR PVG | STRKEY KEYWORD OTHERVAR PVG;
OTHERVAR : VRG KEYWORD |;
TABLEDECLARATION : TYPEOPTION KEYWORD OC NUMBER CC PVG | TYPEOPTION KEYWORD OC CC PVG; // INT T[10];
TYPEOPTION : INTKEY | FLOATKEY | STRKEY;
MAINPART : OPTIONINST MAINPART |;
OPTIONINST : LISTaff | LISTboucle | LISTread | LISTwrite ;
LISTaff : KEYWORD DPP EQ EXP PVG {if (div_zero){printf("division sur 0 in line : %d",yylineno);} else{$1 = $4;}};
EXP :EXP PLUS EXP {$$ = $1 + $3; printf("resultat = %d",$$);}
  |  EXP MINUS EXP {$$ = $1 - $3;}
  |  EXP MUL EXP {$$ = $1 * $3;}
  |  EXP DIV EXP {if($3 != 0){ $$ = $1 / $3;} else{div_zero = 1;}}
  | INTEGER {$$ = $1;}
  | REAL {$$ = $1;}
  | KEYWORD {$$ = $1;}
  ;
LISTboucle : FORKEY OP condition CP OA boucleinstru CA;
condition : KEYWORD DPP EQ INTEGER PVG KEYWORD conditionoption INTEGER PVG KEYWORD PLUS PLUS;
conditionoption : EQ | NEQ | SUP | INF | INFEQ | SUPEQ;
boucleinstru : MAINPART;


LISTread : INKEY OP chaine CP PVG {printf("%d",$3);}
; // IN('%d',A);
chaine : apostrophe SIGNFORMAT apostrophe VRG KEYWORD {$$ = $5;}
;
SIGNFORMAT : Signformattageint | Signformattagefloat | Signformattagestr;

LISTwrite : OUTKEY OP chainewrite CP PVG; // OUT('%d',A);
chainewrite : apostrophe SIGNFORMAT apostrophe VRG KEYWORD;
%%

void yyerror(char* s){
		printf("erreur syntaxique : %s a la ligne %d\n",yytext,yylineno);
}
void main()
{
	yyparse();
	printf("fin de analyse syntaxique");

}