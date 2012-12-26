%{ 

#include <stdio.h>
#include <ctype.h>
#include <string.h>

FILE *newtex ;

%}

%union 
{
  char*	arr;
	int	val;
}

%start htmlstatement

%token  HTMLBEGIN	HTMLEND		HEADBEGIN	HEADEND		TITLEBEGIN	TITLEEND	BODYBEGIN
%token	BODYEND		TABLEBEGIN	TABLEEND	ROWBEGIN	ROWEND		CELLBEGIN	CELLEND
%token					WS

%token <arr> WORD
%token <val> INTEGER
%type  <arr> text
%%

htmlstatement	: HTMLBEGIN {fprintf(newtex,"\\documentclass{article}\n"); } head BODYBEGIN body BODYEND HTMLEND {fprintf(newtex,"\n\\end{document}"); } 
		;

head		: HEADBEGIN TITLEBEGIN {fprintf(newtex,"\\title{"); } text TITLEEND {fprintf(newtex,"}\n\\begin{document}\n\\maketitle\n"); } HEADEND
		|
		;

body		: text body
		| table body
		|
		;

text	        :  text WORD {fprintf(newtex,"%s",$2); }
	        |  text INTEGER {fprintf(newtex,"%d",$2); }
		|  text WS {fprintf(newtex," "); }
                |  WORD {fprintf(newtex,"%s",$1); }
	        |  INTEGER {fprintf(newtex,"%d",$1); }
		|  WS {fprintf(newtex," "); }
                ;

table		: TABLEBEGIN {fprintf(newtex,"\n\\begin{tabular}\n"); } rows TABLEEND {fprintf(newtex,"\n\\end{tabular}\n"); }
		;

rows		: ROWBEGIN rowbody ROWEND {fprintf(newtex," \\\\\n"); } rows
		| 
		;

rowbody		: rowbody {fprintf(newtex," & "); } CELLBEGIN text CELLEND 
		| CELLBEGIN text CELLEND
		;

%%

int main(){
	newtex = fopen("output.tex","w+");
	return yyparse();
	}


int yyerror (char *msg) {
	return fprintf (stderr, "YACC: %s\n", msg);
	}
