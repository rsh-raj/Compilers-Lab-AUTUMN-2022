output.txt: a.out Asgn4_20CS10005_20CS30040_test.c
	./a.out < Asgn4_20CS10005_20CS30040_test.c > output.txt

a.out: lex.yy.o y.tab.o main.o
	gcc lex.yy.o y.tab.o main.o -lfl -o a.out

main.o: Asgn4_20CS10005_20CS30040.c
	gcc -c Asgn4_20CS10005_20CS30040.c -o main.o

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: Asgn4_20CS10005_20CS30040.l y.tab.h
	flex Asgn4_20CS10005_20CS30040.l

y.tab.c y.tab.h: Asgn4_20CS10005_20CS30040.y
	bison -dty --report=all Asgn4_20CS10005_20CS30040.y

clean:
	rm -f a.out lex.yy.* y.tab.* y.output *.o
