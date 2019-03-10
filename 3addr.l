%{
    #include<stdio.h>
    #include"y.tab.h"
%}

%%
"while"		yylval.str=strdup(yytext);return WHILE;
"if"		yylval.str=strdup(yytext);return IF;
"else"		yylval.str=strdup(yytext);return ELSE;
"("		yylval.str=strdup(yytext);return OP;
")"		yylval.str=strdup(yytext);return CP;
"{"		yylval.str=strdup(yytext);return OB;
"}"		yylval.str=strdup(yytext);return CB;
"+"		yylval.str=strdup(yytext);return ADD;
"-"		yylval.str=strdup(yytext);return SUB;
"*"		yylval.str=strdup(yytext);return MUL;
"/"		yylval.str=strdup(yytext);return DIV;
"="		yylval.str=strdup(yytext);return ASSIGN;
"%"		yylval.str=strdup(yytext);return MOD;

"<"		return LE;
">"		return GE;

[a-zA-Z_][a-zA-Z0-9_]* 		yylval.str=strdup(yytext);return ID;
[0-9]+ 				yylval.str=strdup(yytext);return ID;

[\n \t] ;
%%


int yywrap()
{
    return 1;
}


