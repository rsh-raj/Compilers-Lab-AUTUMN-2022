assembly: tinyC libass2_20CS10005.a
	@echo "-------------------Please wait! Generation of quads in progress---------------"

	./tinyC 1 > ass6_20CS10005_quads1.out
	./tinyC 2 > ass6_20CS10005_quads2.out
	./tinyC 3 > ass6_20CS10005_quads3.out
	./tinyC 4 > ass6_20CS10005_quads4.out
	./tinyC 5 > ass6_20CS10005_quads5.out
	./tinyC 6 > ass6_20CS10005_quads6.out
	./tinyC 7 > ass6_20CS10005_quads7.out
	@echo "----------------Assembly and quads have been generated successfully, use make run to compile the test cases------------"
libass2_20CS10005.a:
	gcc -c ass2_20CS10005.c
	ar -rcs libass2_20CS10005.a ass2_20CS10005.o

tinyC: lex.yy.o ass6_20CS10005.tab.o ass6_20CS10005_translator.o ass6_20CS10005_target_translator.o
	g++ lex.yy.o ass6_20CS10005.tab.o ass6_20CS10005_translator.o \
	ass6_20CS10005_target_translator.o -o tinyC

ass6_20CS10005_target_translator.o: ass6_20CS10005_target_translator.cxx
	g++ -c ass6_20CS10005_target_translator.cxx

ass6_20CS10005_translator.o: ass6_20CS10005_translator.cxx ass6_20CS10005_translator.h
	g++ -c ass6_20CS10005_translator.h
	g++ -c ass6_20CS10005_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

ass6_20CS10005.tab.o: ass6_20CS10005.tab.c
	g++ -c ass6_20CS10005.tab.c

lex.yy.c: ass6_20CS10005.l ass6_20CS10005.tab.h ass6_20CS10005_translator.h
	flex ass6_20CS10005.l

ass6_20CS10005.tab.c: ass6_20CS10005.y
	bison -dtv ass6_20CS10005.y -W

ass6_20CS10005.tab.h: ass6_20CS10005.y
	bison -dtv ass6_20CS10005.y -W
	
clean:
	rm -f lex.yy.c\
	   ass6_20CS10005.tab.c\
	   ass6_20CS10005.tab.h\
	   *.o\
	   *.out\
	   *.s\
	   tinyC\
	   ass6_20CS10005_translator.h.gch\
	   libass2_20CS10005.a 
run:

	@echo "\n-------------    Please wait! Generation of object files in progress ---------------\n"

	gcc -c ass6_20CS10005_1.s
	gcc -c ass6_20CS10005_2.s
	gcc -c ass6_20CS10005_3.s
	gcc -c ass6_20CS10005_4.s
	gcc -c ass6_20CS10005_5.s
	gcc -c ass6_20CS10005_6.s
	gcc -c ass6_20CS10005_7.s

	@echo "\n-------------    Please Wait! Compilation of test files in progress  ---------------\n"

	gcc ass6_20CS10005_1.o -o test1.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_2.o -o test2.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_3.o -o test3.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_4.o -o test4.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_5.o -o test5.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_6.o -o test6.out -L. -lass2_20CS10005 -no-pie
	gcc ass6_20CS10005_7.o -o test7.out -L. -lass2_20CS10005 -no-pie

	@echo "\n###########  Use ./test<i>.out for testing the ith file  ##########\n"

