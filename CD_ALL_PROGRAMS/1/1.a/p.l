%{
#include<stdio.h>
int nlines,nwords,nchars,sp;
%}

%%
\n {
	nlines++; 
	}
[ ]  {sp++;}
[^ \n\t]+ {nwords++, nchars=nchars+yyleng;}
. {nchars++;}
%%
int yywrap(void)  
{
 return 1;
}
int main(int argc, char*argv[]) 
{
 yyin=fopen(argv[1],"r");
 yylex();
 printf("Lines = %d\nChars=%d\nWords=%d\nSpace=%d\n",nlines,nchars,nwords,sp);

 return 0;
} 

