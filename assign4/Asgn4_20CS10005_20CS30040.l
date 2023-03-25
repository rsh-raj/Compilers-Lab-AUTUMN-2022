%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
%}

%option yylineno
idNonDigit [a-zA-Z_]
idDigit [0-9]
identifier {idNonDigit}({idNonDigit}|{idDigit})*

nonZeroDigit [1-9]
integerConstant {nonZeroDigit}({idDigit})*|0
digitSequence {idDigit}+
fractionalConstant (({digitSequence}?)\.{digitSequence})|({digitSequence}\.)
sign [+-]
exponentPart [eE]{sign}?{digitSequence}
floatingConstant ({fractionalConstant}{exponentPart}?)|({digitSequence}{exponentPart})
enumerationConstant {identifier}
escapeSequence "\\\'"|"\\\""|"\\?"|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
cChar [^\'\\\n]|{escapeSequence}
cCharSequence {cChar}+
characterConstant \'{cCharSequence}\'

sChar [^\"\\\n]|{escapeSequence}
sCharSequence {sChar}+
stringLiteral [\"]({sCharSequence}?)[\"]
punctuator_single "["|"]"|"("|")"|"{"|"}"|"."|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<"|">"|"^"|"|"|"?"|":"|";"|"="|","|"#"
newline \n
whitespace [ \t]
%%
"auto" { return AUTO; }
"enum" { return ENUM; }
"restrict" { return RESTRICT; }
"unsigned" { return UNSIGNED; }
"break" { return BREAK; }
"extern" { return EXTERN; }
"return" { return RETURN; }
"void" { return VOID; }
"case" { return CASE; }
"float" { return FLOAT; }
"short" { return SHORT; }
"volatile" { return VOLATILE; }
"char" { return CHAR; }
"for" { return FOR; }
"signed" { return SIGNED; }
"while" { return WHILE; }
"const" { return CONST; }
"goto" { return GOTO; }
"sizeof" { return SIZEOF; }
"_Bool" { return BOOL; }
"continue" { return CONTINUE; }
"if" { return IF; }
"static" { return STATIC; }
"_Complex" { return COMPLEX; }
"default" { return DEFAULT; }
"inline" { return INLINE; }
"struct" { return STRUCT; }
"_Imaginary" { return IMAGINARY; }
"do" { return DO; }
"int" { return INT; }
"switch" { return SWITCH; }
"double" { return DOUBLE; }
"long" { return LONG; }
"typedef" { return TYPEDEF; }
"else" { return ELSE; }
"register" { return REGISTER; }
"union" { return UNION; }
"->" { return ARROW; }
"++" { return INCREMENT; }
"--" { return DECREMENT; }
"<<" { return LEFT_SHIFT; }
">>" { return RIGHT_SHIFT; }
"<=" { return LESS_THAN_EQUAL; }
">=" { return GREATER_THAN_EQUAL; }
"==" { return EQUAL; }
"!=" { return NOT_EQUAL; }
"&&" { return LOGICAL_AND; }
"||" { return LOGICAL_OR; }
"..." { return THREE_DOT; }
"*=" { return MULTIPLY_ASSIGN; }
"/=" { return DIVIDE_ASSIGN; }
"%=" { return MOD_ASSIGN; }
"+=" { return ADD_ASSIGN; }
"-=" { return SUB_ASSIGN; }
"<<=" { return SHIFT_LEFT_ASSIGN; }
">>=" { return SHIFT_RIGHT_ASSIGN; }
"&=" { return AND_ASSIGN; }
"^=" { return XOR_ASSIGN; }
"|=" { return OR_ASSIGN; }
{identifier}            { yylval.stringName = strdup(yytext); return IDENTIFIER; }                   
{integerConstant}       { yylval.intVal = atoi(yytext); return INTEGER_CONSTANT;}                   
{floatingConstant}      { yylval.floatVal = atof(yytext); return FLOATING_CONSTANT;}                    
{characterConstant}     { yylval.charName = strdup(yytext); return CHARACTER_CONSTANT; }              
{stringLiteral}         { yylval.stringName = strdup(yytext); return STRING_LITERAL; }        
{punctuator_single} { return yytext[0]; }
"//"(.*) {  }
"/*"([^*]|\*+[^*/])*\*+"/" { }
{newline} { printf("\n<---------PARSING LINE NUMBER %d---------->\n\n\n", yylineno); }
{whitespace} {  }
. { }
%%
int yywrap(void)
{
    return 1;
}