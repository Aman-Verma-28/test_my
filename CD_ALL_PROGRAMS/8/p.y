%{
#include<ctype.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
extern char *yytext;
char st[100][10];
int top=0;
char i_[2]="0";
char temp[2]="t";

void push();
void codegen();
void codegen_umin();
void codegen_assign();
%}


%token ID NUM
%right '='
%left '+' '-'
%left '*' '/'
%left UMINUS


%%
    start : S {printf("valid \n");exit(0);}
    S:ID{push();} '='{push();} E{codegen_assign();}
    ;
    E:E'+'{push();} T{codegen();}
    |E'-'{push();} T{codegen();}
    | T
    ;
    T:T'*'{push();} F{codegen();}
    |T'/'{push();} F{codegen();}
    |F
    ;
    F:'(' E ')'
    |'-'{push();} F{codegen_umin();} %prec UMINUS
    |ID{push();}
    |NUM{push();}
    ;
%%


int main()
{
    printf("Enter the expression : ");
    yyparse();
    exit(0);
}
void push()
{
    strcpy(st[++top],yytext);
}
void codegen()
{
    strcpy(temp,"t");
    strcat(temp,i_);
    printf("%s = %s %s %s\n",temp,st[top-2],st[top-1],st[top]);
    top-=2;
    strcpy(st[top],temp);
    i_[0]++;
}

void codegen_umin()
{
    strcpy(temp,"t");
    strcat(temp,i_);
    printf("%s = -%s\n",temp,st[top]);
    top--;
    strcpy(st[top],temp);
    i_[0]++;
}
void codegen_assign()
{
    printf("%s = %s\n",st[top-2],st[top]);
    top-=2;
}

int yyerror(){
    printf("Invalid expression\n");
    exit(0);
}
