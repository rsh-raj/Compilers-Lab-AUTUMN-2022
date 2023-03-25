output.txt: a.out ass3_20CS10005_20CS30040_test.c
	./a.out<ass3_20CS10005_20CS30040_test.c>output.txt
a.out: header.h lex.yy.c ass3_20CS10005_20CS30040_main.c
	gcc lex.yy.c ass3_20CS10005_20CS30040_main.c
lex.yy.c: header.h ass3_20CS10005_20CS30040.l
	flex ass3_20CS10005_20CS30040.l
clean: output.txt a.out lex.yy.c
	rm output.txt a.out lex.yy.c