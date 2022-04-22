%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*

	extern int yylex();

	extern FILE* yyin;
	extern FILE* yyout;
	extern void yyerror(char* msg);
	char * printing( char *x, char *y)
	{
		int lenx = strlen(x);
		int leny = strlen(y);

		char * ans = malloc((lenx + leny + 1)*sizeof(char));
		

		for(int i=0; i<leny; i++)
		{
			ans[i+lenx] = y[i];
		}

		for(int i=0; i<lenx; i++)
		{
			ans[i] = x[i];
		}
		ans[lenx+leny] = '\0';
		return ans;
	}
	char* intro()
	{
		char * a = "NAME: \t\t    YADWINDER SINGH\n";
		char * b = "ENTRY NO: \t\t2020CSB1143\n";
		char * c = "*************************************\n";
		char * d = "\tWELCOME TO MY PARSER.\n";
		char *f = printing(a,b);
		char *g = printing(f,c);
		char *h = printing(g,d);
		char *i = printing(h,c);
		return i;
	}
%}

%token TYPE IF ELSE WHILE RETURN ID NUM RELATIONAL_OPERATOR END
%%

	TOP:			AISEHI END {printf("%s", $1); return 1;}

	AISEHI: 		PROGRAM
	{
		$$ = intro();
		$$ = printing($$, "\n\n");
		$$ = printing($$, $1);
	}

	PROGRAM:		PRG_STMT	{$$ = $1;}
	|				PROGRAM PRG_STMT	{$$ = printing($1, $2);}
	;

	PRG_STMT: 		VAR_DEC		{$$ = $1;}
	| 				FUN_DEC 	{$$ = $1;}
	|				VAR_BOTH	{$$ = $1;}
	| 				FUN_DEF		{$$ = $1;}
	;

	VAR_DEC: 		TYPE ID ';'							
	{
		$$ = printing("\nVARIABLE DECLARATION:", " ");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " ID:");
		$$ = printing($$, $2);
		$$ = printing($$, "\n");
	}
	;
	
	FUN_DEC: 		TYPE ID '(' ')' ';'							
	{
		$$ = printing( "\nFUNCTION DECLARATION: ", "\n");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " id:");
		$$ = printing($$, $2);
		$$ = printing($$, "\nARGUMENT: none\n");
	}
	|				TYPE ID '(' ARG_LIS ')' ';'
	{
		$$ = printing("\nFUNCTION DECLARATION: " ,"\n");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " id:");
		$$ = printing($$, $2);
		$$ = printing($$, "\n");
		$$ = printing($$, $4);
	}
	;
	
	ARG_LIS:		ARG_DEC				
	{
		$$ = $1;
	}			
	|				ARG_LIS ',' ARG_DEC
	{
		$$ = printing($$, $3);
	}
	;	
	
	ARG_DEC: 		TYPE ID								
	{
		$$ = printing("ARGUMENT:", " ");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " ID:");
		$$ = printing($$, $2);
		$$ = printing($$, "\n");
	}
	;
	
	FUN_DEF:		FUN_INI '{' FUN_SMT '}'				
	{
		$$ = $1;
		$$ = printing($$, "\nFUNCTION BODY:\n");
		$$ = printing($$, $3);
		$$ = printing($$, "FUNCTION ENDS");
	}
	;
	
	FUN_INI: 		TYPE ID '(' ')' 
	{
		$$ = printing("\nFUNCTION DECLARATION:", "\n");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " id:");
		$$ = printing($$, $2);
		$$ = printing($$, "ARGUMENT: none\n");
	}
	|				TYPE ID '(' ARG_LIS ')'
	{
		$$ = printing("\nFUNCTION DEFINATION:", "\n");
		$$ = printing($$, "TYPE:");
		$$ = printing($$, $1);
		$$ = printing($$, " id:");
		$$ = printing($$, $2);
		$$ = printing($$, "\n");
		$$ = printing($$, $4);
	}
	;

	FUN_SMT: 		STATMENT			{$$ = $1;}
	|				FUN_SMT STATMENT	{$$ = $1; $$ = printing($$,$2);}
	;

	STATMENT:		VAR_DEF			{$$ = $1;}
	|				VAR_BOTH		{$$ = $1;}
	|				VAR_DEC			{$$ = $1;}
	|				FUN_CAL			{$$ = $1;}
	|				IF_SMT			{$$ = $1;}
	|				WHILE_SMT		{$$ = $1;}
	|				RET_SMT			{$$ = $1;}
	;

	VAR_BOTH: 		TYPE ID '=' EXP ';'				
	{
		$$ = printing("VARIABLE ASSIGN:", "\n");
		$$ = printing($$, "TYPE: ");
		$$ = printing($$, $1);
		$$ = printing($$, "id: ");
		$$ = printing($$, $2);
		$$ = printing($$, " ASSIGN: = \n");
		$$ = printing($$, $4);
	}
	;

	VAR_DEF: 	 	ID '=' EXP ';'			       		{fprintf(stdout, "VARIABLE DEFINATION: id: %s\n\n", $1 );}
	;

	EXP: 			EXP_TERM
	{
		$$ = $1;
	}				
	|				EXP '-' EXP_TERM					
	{
		$$ = $1;
		$$ = printing($$, " op:- ");
		$$ = printing($$, $3);
	}
	|				EXP '+' EXP_TERM					
	{
		$$ = $1;
		$$ = printing($$, " op:+ ");
		$$ = printing($$, $3);
	}
	;

	EXP_TERM:		EXP_TERM '/' OTH_FAC				
	{
		$$ = $1;
		$$ = printing($$, " op:/ ");
		$$ = printing($$, $3);
	}
	|				EXP_TERM '*' OTH_FAC				
	{
		$$ = $1;
		$$ = printing($$, " op:* ");
		$$ = printing($$, $3);
	}
	|				OTH_FAC
	;
	
	OTH_FAC:		NUM							
	{
		$$ = "const-";
		$$ = printing($$, $1);
		$$ = printing($$, " ");
	}
	|				ID									
	{
		$$ = "id: ";
		$$ = printing($$, $1);
		$$ = printing($$, " ");
	}
	|				'(' EXP ')'						
	{
		$$ = "BRACKETS: ( ";
		$$ = printing($$, $2);
		$$ = " BRACKETS: ) ";
	}
	;

	FUN_CAL: 		ID '(' ')' ';'						
	{
		$$ = "\nFUNCTION CALLING:\n";
		$$ = printing($$ , "id:");
		$$ = printing($$, $1);
		$$ = printing($$, "\nARGUMENT: none\n");
		$$ = printing($$, "\nFunction calling ends.\n");
	}
	| 				ID '(' ID_LIS ')' ';'				
	{
		$$ = "\nFUNCTION CALLING:\n";
		$$ = printing($$ , "id:");
		$$ = printing($$, $1);
		$$ = printing($$, "\nARGUMENT: ");
		$$ = printing($$, $3);
		$$ = printing($$, "\n");
		$$ = printing($$, "\nFunction calling ends.\n");
	}
	;

	ID_LIS:			EXP  
	{
		$$ = $1;
	}
	|				ID_LIS ',' EXP
	{
		$$ = $1;
		$$ = printing($$,$3);
	}
	;

	IF_SMT: 		IF '(' BOOL_EXPR ')' '{' FUN_SMT '}' 
	{
		$$ = "\nIF STATEMENT:\n";
		$$ = printing($$, "BOOLEAN OPERATOR: ");
		$$ = printing($$, $2);
		$$ = printing($$, "\nIF BODY:\n");
		$$ = printing($$, $6);
		$$ = printing($$, "\n");
		$$ = printing($$, "\nif stmt ends.\n");
	}
	|				IF '(' BOOL_EXPR ')' '{' FUN_SMT '}' ELSE '{' FUN_SMT '}' 
	{
		$$ = "\nIF-ELSE STATEMENT:\n";
		$$ = printing($$, $3);
		$$ = printing($$, "\nIF BODY:\n");
		$$ = printing($$, $6);
		$$ = printing($$, "\nif stmt ends.\n");
		$$ = printing($$, "\nELSE BODY:\n");
		$$ = printing($$, $10);
		$$ = printing($$, "\n");
		$$ = printing($$, "\nelse stmt ends.\n");
	}
	;
	WHILE_SMT:		WHILE '(' BOOL_EXPR ')' '{' FUN_SMT '}'
	{
		$$ = "\nWHILE STATEMENT:\n";
		$$ = printing($$, $3);
		$$ = printing($$, "\nWHILE BODY:\n");
		$$ = printing($$, $6);
		$$ = printing($$, "\n");
		$$ = printing($$, "\nwhile stmt ends.\n");
	}
	;

	RET_SMT:		RETURN SOMETHING ';' 
	{
		$$ = "\nRETURN STATEMENT\n";
		$$ = printing($$, $2);
	}
	|				RETURN ';'
	{
		$$ = "\nRETURN STATEMENT\n returning nothing\n";
	}
	;
	SOMETHING: 		EXP			{$$ = $1;}
	|				FUN_CAL     {$$ = $1;}
	;

	BOOL_EXPR:		EXP RELATIONAL_OPERATOR EXP		
	{
		$$ = "\nRELATIONAL OPERATION:\n";
		$$ = printing($$, "\nBOOL OP: ");
		$$ = printing($$, $2);
		$$ = printing($$, "\t");
		$$ = printing($$, $1);
		$$ = printing($$, "  ");
		$$ = printing($$, $3);
	}
	|				'(' EXP RELATIONAL_OPERATOR EXP ')'  
	{
		$$ = "\nRELATIONAL OPERATION:\n";
		$$ = printing($$, "BRACKETS OPEN\n");
		$$ = printing($$, "\nBOOL OP: ");
		$$ = printing($$, $2);
		$$ = printing($$, "\t");
		$$ = printing($$, $3);
		$$ = printing($$, $4);
		$$ = printing($$, "BRACKETS CLOSE\n");
	}
	;

%%
int main(int argc, char ** argv)
{
	if(argc < 2)
	{
		printf("Your Syntax is %s <filename>\n" , argv[0]);
		return 0;		
	}

	yyin = fopen(argv[1], "r");
	yyout = fopen("Files/Lexer.txt", "w");
	stdout = fopen("Files/Parser.txt", "w");
	yyparse();
}

void yyerror(char* msg)
{
	printf("%s\n", msg);
	free(yylval);
}