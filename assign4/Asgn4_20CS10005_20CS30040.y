%{
    #include <stdio.h>
    #include <string.h>
    extern int yylex();
    extern int yylineno;
    void yyerror(char *);
    void yyreduce(char *);
%}

%union {
    int intVal;
    float floatVal;
    char *charName;
    char *stringName;
}


%token AUTO
%token ENUM
%token RESTRICT
%token UNSIGNED
%token BREAK
%token EXTERN
%token RETURN
%token VOID
%token CASE
%token FLOAT
%token SHORT
%token VOLATILE
%token CHAR
%token FOR
%token SIGNED
%token WHILE
%token CONST
%token GOTO
%token SIZEOF
%token BOOL
%token CONTINUE
%token IF
%token STATIC
%token COMPLEX
%token DEFAULT
%token INLINE
%token STRUCT
%token IMAGINARY
%token DO
%token INT
%token SWITCH
%token DOUBLE
%token LONG
%token TYPEDEF
%token ELSE
%token REGISTER
%token UNION

%token<stringName> IDENTIFIER
%token<intVal> INTEGER_CONSTANT
%token<floatVal> FLOATING_CONSTANT
%token<charName> CHARACTER_CONSTANT
%token<stringName> STRING_LITERAL

%token ARROW
%token INCREMENT
%token DECREMENT
%token LEFT_SHIFT
%token RIGHT_SHIFT
%token LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL
%token EQUAL
%token NOT_EQUAL
%token LOGICAL_AND
%token LOGICAL_OR
%token THREE_DOT
%token MULTIPLY_ASSIGN
%token DIVIDE_ASSIGN
%token MOD_ASSIGN
%token ADD_ASSIGN
%token SUB_ASSIGN
%token SHIFT_LEFT_ASSIGN
%token SHIFT_RIGHT_ASSIGN
%token AND_ASSIGN
%token XOR_ASSIGN
%token OR_ASSIGN

%token UNEXPECTED

%nonassoc RIGHT_PARENTHESES
%nonassoc ELSE

%start translation_unit

%%

primary_expression: 
                    IDENTIFIER 
                        { yyreduce("primary_expression --> IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $1); }
                    | INTEGER_CONSTANT 
                        { yyreduce("primary_expression --> INTEGER_CONSTANT"); printf("\t\t\t\tINTEGER_CONSTANT = %d\n", $1); }
                    | FLOATING_CONSTANT 
                        { yyreduce("primary_expression --> FLOATING_CONSTANT"); printf("\t\t\t\tFLOATING_CONSTANT = %f\n", $1); }
                    | CHARACTER_CONSTANT 
                        { yyreduce("primary_expression --> CHARACTER_CONSTANT"); printf("\t\t\t\tCHARACTER_CONSTANT = %s\n", $1); }
                    | STRING_LITERAL 
                        { yyreduce("primary_expression --> STRING_LITERAL"); printf("\t\t\t\tSTRING_LITERAL = %s\n", $1); }
                    | '(' expression ')'
                        { yyreduce("primary_expression --> ( expression )"); }
                    ;

postfix_expression:
                    primary_expression
                        { yyreduce("postfix_expression --> primary_expression"); }
                    | postfix_expression '[' expression ']'
                        { yyreduce("postfix_expression --> postfix_expression [ expression ]"); }
                    | postfix_expression '(' argument_expression_list_opt ')'
                        { yyreduce("postfix_expression --> postfix_expression ( argument_expression_list_opt )"); }
                    | postfix_expression '.' IDENTIFIER
                        { 
                            yyreduce("postfix_expression --> postfix_expression . IDENTIFIER");
                            printf("\t\t\t\tIDENTIFIER = %s\n", $3); 
                        }
                    | postfix_expression ARROW IDENTIFIER
                        { 
                            yyreduce("postfix_expression --> postfix_expression -> IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $3); 
                        }
                    | postfix_expression INCREMENT
                        { yyreduce("postfix_expression --> postfix_expression ++"); }
                    | postfix_expression DECREMENT
                        { yyreduce("postfix_expression --> postfix_expression --"); }
                    | '(' type_name ')' '{' initialiser_list '}'
                        { yyreduce("postfix_expression --> ( type_name ) { initialiser_list }"); }
                    | '(' type_name ')' '{' initialiser_list ',' '}'
                        { yyreduce("postfix_expression --> ( type_name ) { initialiser_list , }"); }
                    ;

argument_expression_list_opt:
                                argument_expression_list
                                    { yyreduce("argument_expression_list_opt --> argument_expression_list"); }
                                |
                                    { yyreduce("argument_expression_list_opt --> e"); }
                                ;

argument_expression_list :
                    assignment_expression
                        { yyreduce("argument_expression_list --> assignment_expression"); }
                    | argument_expression_list ',' assignment_expression
                        { yyreduce("argument_expression_list --> argument_expression_list , assignment_expression"); }
                     ;
                   
unary_expression:
                    postfix_expression
                        { yyreduce("unary_expression --> postfix_expression"); }
                    | INCREMENT unary_expression
                        { yyreduce("unary_expression --> ++ unary_expression"); }
                    | DECREMENT unary_expression
                        { yyreduce("unary_expression --> -- unary_expression"); }
                    | unary_operator cast_expression
                        { yyreduce("unary_expression --> unary_operator cast_expression"); }
                    | SIZEOF unary_expression
                        { yyreduce("unary_expression --> sizeof unary_expression"); }
                    | SIZEOF '(' type_name ')'
                        { yyreduce("unary_expression --> sizeof ( type_name )"); }
                    ;

unary_operator:
                '&'
                    { yyreduce("unary_operator --> &"); }
                | '*'
                    { yyreduce("unary_operator --> *"); }
                | '+'
                    { yyreduce("unary_operator --> +"); }
                | '-'
                    { yyreduce("unary_operator --> -"); }
                | '~'
                    { yyreduce("unary_operator --> ~"); }
                | '!'
                    { yyreduce("unary_operator --> !"); }
                ;

cast_expression:
                unary_expression
                    { yyreduce("cast_expression --> unary_expression"); }
                | '(' type_name ')' cast_expression
                    { yyreduce("cast_expression --> ( type_name ) cast_expression"); }
                ;

multiplicative_expression:
                            cast_expression
                                { yyreduce("multiplicative_expression --> cast_expression"); }
                            | multiplicative_expression '*' cast_expression
                                { yyreduce("multiplicative_expression --> multiplicative_expression * cast_expression"); }
                            | multiplicative_expression '/' cast_expression
                                { yyreduce("multiplicative_expression --> multiplicative_expression / cast_expression"); }
                            | multiplicative_expression '%' cast_expression
                                { yyreduce("multiplicative_expression --> multiplicative_expression % cast_expression"); }
                            ;

additive_expression:
                    multiplicative_expression
                        { yyreduce("additive_expression --> multiplicative_expression"); }
                    | additive_expression '+' multiplicative_expression
                        { yyreduce("additive_expression --> additive_expression + multiplicative_expression"); }
                    | additive_expression '-' multiplicative_expression
                        { yyreduce("additive_expression --> additive_expression - multiplicative_expression"); }
                    ;

shift_expression:
                    additive_expression
                        { yyreduce("shift_expression --> additive_expression"); }
                    | shift_expression LEFT_SHIFT additive_expression
                        { yyreduce("shift_expression --> shift_expression << additive_expression"); }
                    | shift_expression RIGHT_SHIFT additive_expression
                        { yyreduce("shift_expression --> shift_expression >> additive_expression"); }
                    ;

relational_expression:
                        shift_expression
                            { yyreduce("relational_expression --> shift_expression"); }
                        | relational_expression '<' shift_expression
                            { yyreduce("relational_expression --> relational_expression < shift_expression"); }
                        | relational_expression '>' shift_expression
                            { yyreduce("relational_expression --> relational_expression > shift_expression"); }
                        | relational_expression LESS_THAN_EQUAL shift_expression
                            { yyreduce("relational_expression --> relational_expression <= shift_expression"); }
                        | relational_expression GREATER_THAN_EQUAL shift_expression
                            { yyreduce("relational_expression --> relational_expression >= shift_expression"); }
                        ;

equality_expression:
                    relational_expression
                        { yyreduce("equality_expression --> relational_expression"); }
                    | equality_expression EQUAL relational_expression
                        { yyreduce("equality_expression --> equality_expression == relational_expression"); }
                    | equality_expression NOT_EQUAL relational_expression
                        { yyreduce("equality_expression --> equality_expression != relational_expression"); }
                    ;

AND_expression:
                equality_expression
                    { yyreduce("AND_expression --> equality_expression"); }
                | AND_expression '&' equality_expression
                    { yyreduce("AND_expression --> AND_expression & equality_expression"); }
                ;

exclusive_OR_expression:
                        AND_expression
                            { yyreduce("exclusive_OR_expression --> AND_expression"); }
                        | exclusive_OR_expression '^' AND_expression
                            { yyreduce("exclusive_OR_expression --> exclusive_OR_expression ^ AND_expression"); }
                        ;

inclusive_OR_expression:
                        exclusive_OR_expression
                            { yyreduce("inclusive_OR_expression --> exclusive_OR_expression"); }
                        | inclusive_OR_expression '|' exclusive_OR_expression
                            { yyreduce("inclusive_OR_expression --> inclusive_OR_expression | exclusive_OR_expression"); }
                        ;

logical_AND_expression:
                        inclusive_OR_expression
                            { yyreduce("logical_AND_expression --> inclusive_OR_expression"); }
                        | logical_AND_expression LOGICAL_AND inclusive_OR_expression
                            { yyreduce("logical_AND_expression --> logical_AND_expression && inclusive_OR_expression"); }
                        ;

logical_OR_expression:
                        logical_AND_expression
                            { yyreduce("logical_OR_expression --> logical_AND_expression"); }
                        | logical_OR_expression LOGICAL_OR logical_AND_expression
                            { yyreduce("logical_OR_expression --> logical_OR_expression || logical_AND_expression"); }
                        ;

conditional_expression:
                        logical_OR_expression
                            { yyreduce("conditional_expression --> logical_OR_expression"); }
                        | logical_OR_expression '?' expression ':' conditional_expression
                            { yyreduce("conditional_expression --> logical_OR_expression ? expression : conditional_expression"); }
                        ;

assignment_expression:
                        conditional_expression
                            { yyreduce("assignment_expression --> conditional_expression"); }
                        | unary_expression assignment_operator assignment_expression
                            { yyreduce("assignment_expression --> unary_expression assignment_operator assignment_expression"); }
                        ;

assignment_operator:
                    '='
                        { yyreduce("assignment_operator --> ="); }
                    | MULTIPLY_ASSIGN
                        { yyreduce("assignment_operator --> *="); }
                    | DIVIDE_ASSIGN
                        { yyreduce("assignment_operator --> /="); }
                    | MOD_ASSIGN
                        { yyreduce("assignment_operator --> %="); }
                    | ADD_ASSIGN
                        { yyreduce("assignment_operator --> += "); }
                    | SUB_ASSIGN
                        { yyreduce("assignment_operator --> -= "); }
                    | SHIFT_LEFT_ASSIGN
                        { yyreduce("assignment_operator --> <<="); }
                    | SHIFT_RIGHT_ASSIGN
                        { yyreduce("assignment_operator --> >>="); }
                    | AND_ASSIGN
                        { yyreduce("assignment_operator --> &="); }
                    | XOR_ASSIGN
                        { yyreduce("assignment_operator --> ^="); }
                    | OR_ASSIGN
                        { yyreduce("assignment_operator --> |="); }
                    ;

expression:
            assignment_expression
                { yyreduce("expression --> assignment_expression"); }
            | expression ',' assignment_expression
                { yyreduce("expression --> expression , assignment_expression"); }
            ;

constant_expression:
                    conditional_expression
                        { yyreduce("constant_expression --> conditional_expression"); }
                    ;

/* <----------------------------------------------------------------------------------------->*/
/* DECLARATIONS */

declaration:
            declaration_specifiers init_declarator_list_opt ';'
                { yyreduce("declaration --> declaration_specifiers init_declarator_list_opt ;"); }
            ;

init_declarator_list_opt:
                            init_declarator_list
                                { yyreduce("init_declarator_list_opt --> init_declarator_list"); }
                            |
                                { yyreduce("init_declarator_list_opt --> e"); }
                            ;

declaration_specifiers:
                        storage_class_specifier declaration_specifiers_opt
                            { yyreduce("declaration_specifiers --> storage_class_specifier declaration_specifiers_opt"); }
                        | type_specifier declaration_specifiers_opt
                            { yyreduce("declaration_specifiers --> type_specifier declaration_specifiers_opt"); }
                        | type_qualifier declaration_specifiers_opt
                            { yyreduce("declaration_specifiers --> type_qualifier declaration_specifiers_opt"); }
                        | function_specifier declaration_specifiers_opt
                            { yyreduce("declaration_specifiers --> function_specifier declaration_specifiers_opt"); }
                        ;

declaration_specifiers_opt:
                            declaration_specifiers
                                { yyreduce("declaration_specifiers_opt --> declaration_specifiers"); }
                            | 
                                { yyreduce("declaration_specifiers_opt --> e"); }
                            ;

init_declarator_list:
                        init_declarator
                            { yyreduce("init_declarator_list --> init_declarator"); }
                        | init_declarator_list ',' init_declarator
                            { yyreduce("init_declarator_list --> init_declarator_list , init_declarator"); }
                        ;

init_declarator:
                declarator
                    { yyreduce("init_declarator --> declarator"); }
                | declarator '=' initialiser
                    { yyreduce("init_declarator --> declarator = initialiser"); }
                ;

storage_class_specifier:
                        EXTERN
                            { yyreduce("storage_class_specifier --> extern"); }
                        | STATIC
                            { yyreduce("storage_class_specifier --> static"); }
                        | AUTO
                            { yyreduce("storage_class_specifier --> auto"); }
                        | REGISTER
                            { yyreduce("storage_class_specifier --> register"); }
                        ;

type_specifier:
                VOID
                    { yyreduce("type_specifier --> void"); }
                | CHAR
                    { yyreduce("type_specifier --> char"); }
                | SHORT
                    { yyreduce("type_specifier --> short"); }
                | INT
                    { yyreduce("type_specifier --> int"); }
                | LONG
                    { yyreduce("type_specifier --> long"); }
                | FLOAT
                    { yyreduce("type_specifier --> float"); }
                | DOUBLE
                    { yyreduce("type_specifier --> double"); }
                | SIGNED
                    { yyreduce("type_specifier --> signed"); }
                | UNSIGNED
                    { yyreduce("type_specifier --> unsigned"); }
                | BOOL
                    { yyreduce("type_specifier --> _Bool"); }
                | COMPLEX
                    { yyreduce("type_specifier --> _Complex"); }
                | IMAGINARY
                    { yyreduce("type_specifier --> _Imaginary"); }
                | enum_specifier 
                    { yyreduce("type_specifier --> enum_specifier"); }
                ;

specifier_qualifier_list:
                            type_specifier specifier_qualifier_list_opt
                                { yyreduce("specifier_qualifier_list --> type_specifier specifier_qualifier_list_opt"); }
                            | type_qualifier specifier_qualifier_list_opt
                                { yyreduce("specifier_qualifier_list --> type_qualifier specifier_qualifier_list_opt"); }
                            ;

specifier_qualifier_list_opt:
                                specifier_qualifier_list
                                    { yyreduce("specifier_qualifier_list_opt --> specifier_qualifier_list"); }
                                | 
                                    { yyreduce("specifier_qualifier_list_opt --> e"); }
                                ;

enum_specifier:
                ENUM identifier_opt '{' enumerator_list '}' 
                    { yyreduce("enum_specifier --> enum identifier_opt { enumerator_list }"); }
                | ENUM identifier_opt '{' enumerator_list ',' '}'
                    { yyreduce("enum_specifier --> enum identifier_opt { enumerator_list , }"); }
                | ENUM IDENTIFIER
                    { yyreduce("enum_specifier --> enum IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $2); }
                ;

identifier_opt:
                IDENTIFIER 
                    { yyreduce("identifier_opt --> IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $1); }
                | 
                    { yyreduce("identifier_opt --> e"); }
                ;

enumerator_list:
                enumerator 
                    { yyreduce("enumerator_list --> enumerator"); }
                | enumerator_list ',' enumerator
                    { yyreduce("enumerator_list --> enumerator_list , enumerator"); }
                ;

enumerator:
            IDENTIFIER 
                { yyreduce("enumerator --> enumeration_constant"); }
            | IDENTIFIER '=' constant_expression
                { yyreduce("enumerator --> enumeration_constant = constant_expression"); }
            ;

type_qualifier:
                CONST
                    { yyreduce("type_qualifier --> const"); }
                | RESTRICT
                    { yyreduce("type_qualifier --> restrict"); }
                | VOLATILE
                    { yyreduce("type_qualifier --> volatile"); }
                ;

function_specifier:
                    INLINE
                        { yyreduce("function_specifier --> inline"); }
                    ;

declarator:
            pointer_opt direct_declarator
                { yyreduce("declarator --> pointer_opt direct_declarator"); }
            ;

pointer_opt:
            pointer
                { yyreduce("pointer_opt --> pointer"); }
            |
                { yyreduce("pointer_opt --> e"); }
            ;

direct_declarator:
                    IDENTIFIER 
                        { yyreduce("direct_declarator --> IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $1); }
                    | '(' declarator ')'
                        { yyreduce("direct_declarator --> ( declarator )"); }
                    | direct_declarator '[' type_qualifier_list_opt assignment_expression_opt ']'
                        { yyreduce("direct_declarator --> direct_declarator [ type_qualifier_list_opt assignment_expression_opt ]"); }
                    | direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
                        { yyreduce("direct_declarator --> direct_declarator [ static type_qualifier_list_opt assignment_expression ]"); }
                    | direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
                        { yyreduce("direct_declarator --> direct_declarator [ type_qualifier_list static assignment_expression ]"); }
                    | direct_declarator '[' type_qualifier_list_opt '*' ']'
                        { yyreduce("direct_declarator --> direct_declarator [ type_qualifier_list_opt * ]"); }
                    | direct_declarator '(' parameter_type_list ')'
                        { yyreduce("direct_declarator --> direct_declarator ( parameter_type_list )"); }
                    | direct_declarator '(' identifier_list_opt ')'
                        { yyreduce("direct_declarator --> direct_declarator ( identifier_list_opt )"); }
                    ;

type_qualifier_list_opt:
                        type_qualifier_list
                            { yyreduce("type_qualifier_list_opt --> type_qualifier_list"); }
                        |
                            { yyreduce("type_qualifier_list_opt --> e"); }
                        ;

assignment_expression_opt:
                            assignment_expression
                                { yyreduce("assignment_expression_opt --> assignment_expression"); }
                            |
                                { yyreduce("assignment_expression_opt --> e"); }
                            ;

identifier_list_opt:
                    identifier_list
                        { yyreduce("identifier_list_opt --> identifier_list"); }
                    |
                        { yyreduce("identifier_list_opt --> e"); }
                    ;

pointer:
        '*' type_qualifier_list_opt
            { yyreduce("pointer --> * type_qualifier_list_opt"); }
        | '*' type_qualifier_list_opt pointer
            { yyreduce("pointer --> * type_qualifier_list_opt pointer"); }
        ;

type_qualifier_list:
                    type_qualifier
                        { yyreduce("type_qualifier_list --> type_qualifier"); }
                    | type_qualifier_list type_qualifier
                        { yyreduce("type_qualifier_list --> type_qualifier_list type_qualifier"); }
                    ;

parameter_type_list:
                    parameter_list
                        { yyreduce("parameter_type_list --> parameter_list"); }
                    | parameter_list ',' THREE_DOT
                        { yyreduce("parameter_type_list --> parameter_list , ..."); }
                    ;

parameter_list:
                parameter_declaration
                    { yyreduce("parameter_list --> parameter_declaration"); }
                | parameter_list ',' parameter_declaration
                    { yyreduce("parameter_list --> parameter_list , parameter_declaration"); }
                ;

parameter_declaration:
                        declaration_specifiers declarator
                            { yyreduce("parameter_declaration --> declaration_specifiers declarator"); }
                        | declaration_specifiers
                            { yyreduce("parameter_declaration --> declaration_specifiers"); }
                        ;

identifier_list:
                IDENTIFIER 
                    { yyreduce("identifier_list --> IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $1); }
                | identifier_list ',' IDENTIFIER
                    { yyreduce("identifier_list --> identifier_list , IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $3); }
                ;

type_name:
            specifier_qualifier_list
                { yyreduce("type_name --> specifier_qualifier_list"); }
            ;

initialiser:
            assignment_expression
                { yyreduce("initialiser --> assignment_expression"); }
            | '{' initialiser_list '}'
                { yyreduce("initialiser --> { initialiser_list }"); }  
            | '{' initialiser_list ',' '}'
                { yyreduce("initialiser --> { initialiser_list , }"); }
            ;

initialiser_list:
                    designation_opt initialiser
                        { yyreduce("initialiser_list --> designation_opt initialiser"); }
                    | initialiser_list ',' designation_opt initialiser
                        { yyreduce("initialiser_list --> initialiser_list , designation_opt initialiser"); }
                    ;

designation_opt:
                designation
                    { yyreduce("designation_opt --> designation"); }
                |
                    { yyreduce("designation_opt --> e"); }
                ;

designation:
            designator_list '='
                { yyreduce("designation --> designator_list ="); }
            ;

designator_list:
                designator
                    { yyreduce("designator_list --> designator"); }
                | designator_list designator
                    { yyreduce("designator_list --> designator_list designator"); }
                ;

designator:
            '[' constant_expression ']'
                { yyreduce("designator --> [ constant_expression ]"); }
            | '.' IDENTIFIER
                { yyreduce("designator --> . IDENTIFIER"); printf("\t\t\t\tIDENTIFIER = %s\n", $2); }   
            ;

/* <--------------------------------------------------------------------------------> */
/* STATEMENTS */

statement:
            labeled_statement
                { yyreduce("statement --> labeled_statement"); }
            | compound_statement
                { yyreduce("statement --> compound_statement"); }
            | expression_statement
                { yyreduce("statement --> expression_statement"); }
            | selection_statement
                { yyreduce("statement --> selection_statement"); }
            | iteration_statement
                { yyreduce("statement --> iteration_statement"); }
            | jump_statement
                { yyreduce("statement --> jump_statement"); }
            ;

labeled_statement:
                    IDENTIFIER ':' statement
                        { yyreduce("labeled_statement --> IDENTIFIER : statement"); printf("\t\t\t\tIDENTIFIER = %s\n", $1); }
                    | CASE constant_expression ':' statement
                        { yyreduce("labeled_statement --> case constant_expression : statement"); }    
                    | DEFAULT ':' statement
                        { yyreduce("labeled_statement --> default : statement"); }
                    ;

compound_statement:
                    '{' block_item_list_opt '}'
                        { yyreduce("compound_statement --> { block_item_list_opt }"); }
                    ;

block_item_list_opt:
                    block_item_list
                        { yyreduce("block_item_list_opt --> block_item_list"); }
                    |
                        { yyreduce("block_item_list_opt --> e"); }
                    ;

block_item_list:
                block_item
                    { yyreduce("block_item_list --> block_item"); }
                | block_item_list block_item
                    { yyreduce("block_item_list --> block_item_list block_item"); }
                ;

block_item:
            declaration
                { yyreduce("block_item --> declaration"); }
            | statement
                { yyreduce("block_item --> statement"); }
            ;

expression_statement:
                        expression_opt ';'
                            { yyreduce("expression_statement --> expression_opt ;"); }
                        ;

expression_opt:
                expression
                    { yyreduce("expression_opt --> expression"); }
                |
                    { yyreduce("expression_opt --> e"); }
                ;

selection_statement:
                    IF '(' expression ')' statement
                        { yyreduce("selection_statement --> if ( expression ) statement"); }
                    | IF '(' expression ')' statement ELSE statement
                        { yyreduce("selection_statement --> if ( expression ) statement else statement"); }
                    | SWITCH '(' expression ')' statement
                        { yyreduce("selection_statement --> switch ( expression ) statement"); }
                    ;

iteration_statement:
                    WHILE '(' expression ')' statement
                        { yyreduce("iteration_statement --> while ( expression ) statement"); }
                    | DO statement WHILE '(' expression ')' ';'
                        { yyreduce("iteration_statement --> do statement while ( expression ) ;"); }
                    | FOR '(' expression_opt ';' expression_opt ';' expression_opt ')' statement
                        { yyreduce("iteration_statement --> for ( expression_opt ; expression_opt ; expression_opt ) statement"); }
                    | FOR '(' declaration expression_opt ';' expression_opt ')' statement
                        { yyreduce("iteration_statement --> for ( declaration expression_opt ; expression_opt ) statement"); }
                    ;

jump_statement:
                GOTO IDENTIFIER ';'
                    { yyreduce("jump_statement --> goto IDENTIFIER ;"); printf("\t\t\t\tIDENTIFIER = %s\n", $2); }    
                | CONTINUE ';'
                    { yyreduce("jump_statement --> continue ;"); }
                | BREAK ';'
                    { yyreduce("jump_statement --> break ;"); }
                | RETURN expression_opt ';'
                    { yyreduce("jump_statement --> return expression_opt ;"); }
                ;

/* <------------------------------------------------------------------------------> */
/* EXTERNAL DEFINITIONS*/

translation_unit:
                    external_declaration
                        { yyreduce("translation_unit --> external_declaration"); }
                    | translation_unit external_declaration
                        { yyreduce("translation_unit --> translation_unit external_declaration"); }
                    ;

external_declaration:
                        function_definition
                            { yyreduce("external_declaration --> function_definition"); }
                        | declaration
                            { yyreduce("external_declaration --> declaration"); }
                        ;

function_definition:
                    declaration_specifiers declarator declaration_list_opt compound_statement
                        { yyreduce("function_definition --> declaration_specifiers declarator declaration_list_opt compound_statement"); }
                    ;

declaration_list_opt:
                        declaration_list
                            { yyreduce("declaration_list_opt --> declaration_list"); }
                        |
                            { yyreduce("declaration_list_opt --> e"); }
                        ;

declaration_list:
                    declaration
                        { yyreduce("declaration_list --> declaration"); }
                    | declaration_list declaration
                        { yyreduce("declaration_list --> declaration_list declaration"); }
                    ;

%%

void yyerror(char *msg){
    printf("ERROR : %s in line %d\n", msg, yylineno);
    return ;
}

void yyreduce(char *s){
    printf("Derivation [Line %d] : %s\n", yylineno,s);
}
