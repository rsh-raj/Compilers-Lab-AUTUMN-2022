%{
#include"header.h"
%}
keyword ("auto"|"enum"|"restrict"|"unsigned"|"break"|"extern"|"return"|"void"|"case"|"float"|"short"|"volatile"|"char"|"for"|"signed"|"while"|"const"|"goto"|"sizeof"|"_Bool"|"continue"|"if"|"static"|"_Complex"|"default"|"inline"|"struct"|"_Imaginary"|"do"|"int"|"switch"|"double"|"long"|"typedef"|"else"|"register"|"union")

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
punctuator "["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"

%%
{keyword} {return KEYWORD;}
{identifier} {return IDENTIFIER;}
{integerConstant} {return INTEGERCONSTANT;}
{floatingConstant} {return FLOATINGCONSTANT;}
{characterConstant} {return CHARACTERCONSTANT;}
{stringLiteral} {return STRINGLITERAL;}
{punctuator} {return PUNCTUATOR;}
"//"(.*) {return SINGLELINECOMMENT;}
"/*"([^*]|\*+[^*/])*\*+"/" {return MULTILINECOMMENT;}
[ \n\t] ; 
. {return UNEXPECTED;}
%%
int yywrap(void)
{
return 1;
}