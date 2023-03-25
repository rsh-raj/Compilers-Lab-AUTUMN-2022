a.out: main1.o libIO.a
	gcc main1.o -L. -lIO
main1.o: main1.c myl.h
	gcc -c main1.c
libIO.a: libIO.o
	ar rcs libIO.a libIO.o
libIO.o: myl.h
	gcc -c -o libIO.o ass2_20CS30040.c
clean:
	rm main1.o libIO.a a.out libIO.o
