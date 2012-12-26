%{ 


#include "y.tab.h"
#include<stdio.h>
#include<string.h>

int intext = 0, incomment = 0;
%}

ws  	[ \t]+
integer		[0-9]+
punc            (\.|\,|\!|\?|\:|\;)
word		({punc}|[a-zA-Z0-9])+
special         (\%|\_|\&|\$|\#)

%%

"<html>"		{printf(" %s \n", yytext);fflush(stdout); return(HTMLBEGIN);}
"</html>"		{printf(" %s \n", yytext);fflush(stdout); return(HTMLEND);}
"<head>"		{printf(" %s \n", yytext);fflush(stdout); return(HEADBEGIN);}
"</head>"		{printf(" %s \n", yytext);fflush(stdout); return(HEADEND);}
"<title>"		{printf(" %s \n", yytext);fflush(stdout); return(TITLEBEGIN);}
"</title>"		{printf(" %s \n", yytext);fflush(stdout); return(TITLEEND);}
"<body>"		{printf(" %s \n", yytext);fflush(stdout); return(BODYBEGIN);}
"</body>"		{printf(" %s \n", yytext);fflush(stdout); return(BODYEND);}
"<table>"		{printf(" %s \n", yytext);fflush(stdout); return(TABLEBEGIN);}
"</table>"		{printf(" %s \n", yytext);fflush(stdout); return(TABLEEND);}
"<tr>"			{printf(" %s \n", yytext);fflush(stdout); return(ROWBEGIN);}
"</tr>"			{printf(" %s \n", yytext);fflush(stdout); return(ROWEND);}
"<td>"			{printf(" %s \n", yytext);fflush(stdout); return(CELLBEGIN);}
"</td>"			{printf(" %s \n", yytext);fflush(stdout); return(CELLEND);}
{integer}		{printf(" %s \n", yytext);fflush(stdout); yylval.val = atoi(yytext); return(INTEGER);}
{word}			{printf(" %s \n", yytext);fflush(stdout); yylval.arr = strdup(yytext); return(WORD);}
{ws}                    {printf(" %s \n", yytext);fflush(stdout); return(WS);}
"\\n"			{incomment = 0;}
%%
