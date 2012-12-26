yacc -d html2latex.y
flex html2latex.l
gcc -o html2latex y.tab.c lex.yy.c -lfl
