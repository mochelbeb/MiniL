%{
    #include "MiniL.c"
    void yyerror(char* err);
    int div_zero = 0;
    int t1[100];
    float t2[100];
    char *t3[100];

    char *M1[100];
    char *M2[100];
    char *M3[100];

    int i =0;int j=0;int k=0;
%}
%token OUTKEY DPP INKEY BIBLANG INTKEY PVG FLOATKEY Signformattageint Signformattagefloat Signformattagestr STRKEY BIBIO PUBLICKEY PROTECTEDKEY FORKEY MAINKEY CLASSKEY IMPORTKEY CONSTANT TABLEKEY LETTER NUMBER CHAR PLUS MINUS DIV MUL OP CP OA CA OC CC VRG EQ NEQ SUP INF INFEQ SUPEQ ANDOP OROP apostrophe NOT
%union{
  char* chr;
  int int_type;
  double real_type;
}
%token <chr> KEYWORD 
%token <int_type> INTEGER
%token <real_type> REAL
%token <chr> STR
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
VARDECLARATION : INTKEY KEYWORD EQ INTEGER PVG {t1[i] = $4;M1[i] = $2; printf("%s %d",M1[i],t1[i]);i++;} 
                | INTKEY KEYWORD OTHERVAR_int PVG {t1[i] = 0;M1[i]=$2;i++;}
                | FLOATKEY KEYWORD EQ REAL PVG {t2[j]=$4;M2[j]=$2;j++;}
                | FLOATKEY KEYWORD OTHERVAR_real PVG {t2[j]=0;M2[j]=$2;j++;}
                | STRKEY KEYWORD EQ STR PVG {t3[k]=$4;M3[k]=$2;k++;}| STRKEY KEYWORD OTHERVAR_str PVG{t3[k]="";M3[k]=$2;k++;};
OTHERVAR_int : VRG KEYWORD OTHERVAR_int{M1[i]=$2;t1[i]=0;i++;}|;
OTHERVAR_real: VRG KEYWORD OTHERVAR_real {M2[j]=$2;t2[j]=0;j++;}|;
OTHERVAR_str: VRG KEYWORD OTHERVAR_str {M3[k]=$2;t3[k]="";i++;}|;
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