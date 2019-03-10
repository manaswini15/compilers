%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int k=0,lab=1;
void gencode(char* first,char op,char* second, char* rtn)
{
    char temp[100];
    char start[100] = "t";
    printf("t%d = %s %c %s\n", k, first, op, second);
    
    int t = k;
    k++;
    sprintf(temp,"%d",t);
    strcat(start,temp);
    strcpy(rtn, start);
}

void gencondition(char* first,char op,char* second, char* rtn)
{
    char temp[100];
    char start[100] = "t";
    printf("t%d = %s %c %s\n", k, first, op, second);
    
   	    printf("if(t%d) goto L%d:\n",k,lab);
	    printf("goto L%d:\n",lab+1);
	    lab+=2;
    

    int t = k;
    k++;
    printf("\n");
    sprintf(temp,"%d",t);
    strcat(start,temp);
    strcpy(rtn, start);
}


%}

%union{
    char* str;
}

%token <str> ID ADD SUB MUL DIV ASSIGN OP CP MOD OB CB IF ELSE WHILE GE LE
%type <str> condition stmt expr
%left '+' '-'
%left '*' '/' '%'
%right '='
%start S

%%
S 	: WHILE OP condition CP OB stmt CB
  	;

condition : ID LE ID {printf("L%d:\n",lab); lab++ ;  char temp[100]; gencondition($1,'<',$3,temp); strcpy($$,temp);}
	  | ID GE ID {printf("L%d:\n",lab); lab++ ; char temp[100]; gencondition($1,'>',$3,temp); strcpy($$,temp);}
	  ;
	
stmt	: IF OP condition CP stmt ELSE stmt 
	| ID ASSIGN expr  { printf("%s = %s \n", $1, $3); printf("goto L%d:\n\n",lab);}
	;

expr	: ID ADD ID {printf("L%d:\n",lab); char temp[100]; gencode($1,'+',$3,temp); strcpy($$,temp); }
	| ID SUB ID {printf("L%d:\n",lab); char temp[100]; gencode($1,'-',$3,temp); strcpy($$,temp); }
	;
%%

int main()
{
	FILE *f1=fopen("inp.txt","r");
	yyset_in(f1);
	
	yyparse();
}

int yyerror(char *s)
{
	printf("%s\n",s);
}
