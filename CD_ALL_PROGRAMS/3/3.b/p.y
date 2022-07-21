%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern FILE *yyout;
int count;
%}

%token ID NUM FOR LE GE EQ NE OR AND
%right "="
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%left '!'

%%
ST       : FOR '(' E ';' E2 ';' E ')' DEF {count++;}
           ;
DEF    : '{' BODY '}'
           | E';'
           | ST
           |
           ;
BODY  : BODY BODY
           | E ';'       
           | ST
           |            
           ;
       
E        : ID '=' E
          | E '+' E
          | E '-' E
          | E '*' E
          | E '/' E
          | E '<' E
          | E '>' E
          | E LE E
          | E GE E
          | E EQ E
          | E NE E
          | E OR E
          | E AND E
          | E '+' '+'
          | E '-' '-'
          | ID 
          | NUM
          ;

   
E2     : E'<'E
         | E'>'E
         | E LE E
         | E GE E
         | E EQ E
         | E NE E
         | E OR E
         | E AND E
         ;   
%%


int main(int argc,char* argv[]) {
    yyin=fopen(argv[1],"r");
    yyparse();
    printf("%d",count);
}     

int yyerror(){
    printf("error : input rejected\n");
    exit(0);
}
