Hi Everyone, 
This time, I worked on a Syntax Analyser. What is does is: You input the code in input.txt in files folder then it
will tokenized it and will map the lexems acc to their tokens and ouptut it in Lexer.txt in Files folder.

Moreover, I worked on Semantics Analyser. it will parse it and sematics analysis is performed and output it in Parser.txt in  Files folder.

HOW TO RUN:
            Enter these commands in terminal.
                lex cucu.l
                yacc -d cucu.y
                gcc lex.yy.c y.tab.c -lfl
                ./a.out Files/input.txt

                        or
            Just enter the command:
                bash a.sh 

ASSUMPTIONS:   

    I have some assumptions for the code you entered in input.txt and are mentioned below:
            * WHILE, IF, IF-ELSE, FUNCTION DEFINATION bodies should contain
            curly braces. It is also applies on nested loops, if-else;
            * MODULO Operator not supported.
            * FOR loop not supported.
            * ONLY 2 Data Types are allowed i.e. int and char*
            * Comments and unneccessary whitespace will be ignored.
            * Single line comments i.e. //  are not allowed
            * Bitwise operators are not allowed.
            * Increment and decrement operator are not allowed.
            * Else if is not allowed.
            * variable definaton only in not allowed. i.e. b = c; this is not allowed.
            * Outside of a function only you can declare or define are:
                    - function declaration.     For Eg. : int add(); 
                    - variable declaration.     For Eg. : int a;
                    - variable definaton.       For Eg. : int a = b+c;
                    - function definaton.       For Eg. : int main() { }


What to Expect: 
        It will parse the code and tokenized it.
        Lexemes with tokens will be shown in lexer.txt
        whereas,
        parsed code will be printed in parser.txt if code is correct. 
        if not it will print syntax error.



