
output.txt: parser.out
	./parser.out < test/test1.c > output/output1.txt
	./parser.out < test/test2.c > output/output2.txt
	./parser.out < test/test3.c > output/output3.txt
	./parser.out < test/test4.c > output/output4.txt
	./parser.out < test/test5.c > output/output5.txt
	./parser.out < test/test6.c > output/output6.txt

parser.out: lex.yy.o translator.o y.tab.o
	g++ lex.yy.o y.tab.o translator.o -o parser.out

translator.o: translator.cxx translator.h
	g++ -c translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

y.tab.o: y.tab.c
	g++ -c y.tab.c

lex.yy.c: lex2.l y.tab.h translator.h
	flex lex2.l

y.tab.c y.tab.h: bison2.y
	bison -dty --report=all bison2.y

clean:
	rm parser.out translator.o lex.yy.* y.tab.* y.output

