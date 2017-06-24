

all :
	bison -d sl_bison.y
	flex sl_flex.l
	gcc -c lex.yy.c -o lex.yy.o
	gcc -c sl_bison.tab.c -o sl_bison.tab.o
	gcc -o sl  sl_bison.tab.o lex.yy.o -lfl -lm
	
clean:
	rm sl_bison.tab.o lex.yy.o sl_bison.tab.c sl_bison.tab.h lex.yy.c sl
