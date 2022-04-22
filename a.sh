
# for both lex and yacc only
lex cucu.l
yacc -d cucu.y
gcc lex.yy.c y.tab.c -lfl
./a.out Files/input.txt


# for to run lex only
# lex cucu.l
# cc -lfl lex.yy.c
# ./a.out