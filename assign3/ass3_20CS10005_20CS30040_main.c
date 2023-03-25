#include <stdio.h>
#include "header.h"
extern int yylex();
extern int yylineno;
extern char *yytext; 
int main()
{
    int token = yylex();
    while (token)
    {
        switch (token)
        {
        case 1:
            printf("< KEYWORD, %s >", yytext);
            break;
        case 2:
            printf("< IDENTIFIER , %s>", yytext);
            break;
        case 3:
            printf("< INTEGER-CONSTANT , %s >", yytext);
            break;
        case 4:
            printf("< FLOATING-CONSTANT , %s >", yytext);
            break;
        case 5:
            printf("< CHARARCTER-CONSTANT , %s >", yytext);
            break;
        case 6:
            printf("< STRING-LITERAL , %s >", yytext);
            break;
        case 7:
            printf("< PUNCTUATOR , %s >", yytext);
            break;
        case 8:
            printf("< COMMENT , %s >", yytext);
            break;
        case 9:
            printf("< SINGLE-LINE-COMMENT >");
            break;
        case 10:
            printf("< MULTI-LINE-COMMENTS >");
            break;
        default:
            printf("< UNEXPECTED , %s >", yytext);
        }
        printf("\n");
        token=yylex();
    }

    return 0;
}