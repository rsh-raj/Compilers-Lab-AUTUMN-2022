a.out: test.o libIO.a
	gcc test.o -L. -lIO
test.o: test.c myl.h
	gcc -c test.c
libIO.a: libIO.o
	ar rcs libIO.a libIO.o
libIO.o: myl.h
	gcc -c -o libIO.o ass2_20CS30040.c
clean:
	rm test.o libIO.a a.out libIO.o
