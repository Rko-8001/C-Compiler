%{
    #include <stdio.h>
    #include <string.h>
    #define YYSTYPE char*
    #include "y.tab.h"
%}

%%
([ |\n]+)                   {}
(\/\*(.|\n)*\*\/)           {}
(int|char[ \t\n]*\*)        { yylval = strdup(yytext); fprintf(yyout,"TYPE: %s\n", yytext);                 return TYPE; }
(if)                        { yylval = strdup(yytext); fprintf(yyout,"IF: %s\n", yytext);                   return IF; }
(else)                      { yylval = strdup(yytext); fprintf(yyout,"ELSE: %s\n", yytext);                 return ELSE; }
(while)                     { yylval = strdup(yytext); fprintf(yyout,"WHILE: %s\n", yytext);                return WHILE; }
(return)                    { yylval = strdup(yytext); fprintf(yyout,"RETURN: %s\n", yytext);               return RETURN; }
([a-zA-Z][a-zA-Z0-9_]*)     { yylval = strdup(yytext); fprintf(yyout,"ID: %s \n", yytext);                  return ID; }
([0-9]+)                    { yylval = strdup(yytext); fprintf(yyout,"NUM: %s\n", yytext);                  return NUM; }
([!=<>]=|<|>)               { yylval = strdup(yytext); fprintf(yyout,"RELATIONAL_OPERATOR: %s\n", yytext);  return RELATIONAL_OPERATOR; }
[;]+                        { yylval = strdup(yytext); fprintf(yyout,"SEMI: %s\n", yytext);                 return yytext[0]; }
(\+)                        { yylval = strdup(yytext); fprintf(yyout, "PLUS: %s\n", yytext);                return yytext[0]; }
(\-)                        { yylval = strdup(yytext); fprintf(yyout,"MIN: %s\n", yytext);                  return yytext[0]; }
(\*)                        { yylval = strdup(yytext); fprintf(yyout,"MULTIPLY: %s\n", yytext);             return yytext[0]; }
(\/)                        { yylval = strdup(yytext); fprintf(yyout,"DIVIDE: %s\n", yytext);               return yytext[0]; }
(=)                         { yylval = strdup(yytext); fprintf(yyout,"ASSIGN: %s\n", yytext);               return yytext[0]; }
(\()                        { yylval = strdup(yytext); fprintf(yyout,"RIGHT_PARANTHESIS: %s\n", yytext);    return yytext[0]; }
(\))                        { yylval = strdup(yytext); fprintf(yyout,"LEFT_PARANTHESIS: %s\n", yytext);     return yytext[0]; }
(\{)                        { yylval = strdup(yytext); fprintf(yyout,"RIGHT_CURLY_BRACKET: %s\n", yytext);  return yytext[0]; }
(\})                        { yylval = strdup(yytext); fprintf(yyout,"LEFT_CURLY_BRACKET: %s\n", yytext);   return yytext[0]; }
(,)                         { yylval = strdup(yytext); fprintf(yyout,"COMMA: %s\n", yytext);                return yytext[0];}
.                           {fprintf(yyout,"INVALID\n"); }
<<EOF>>                     {return END;}                 

%%

