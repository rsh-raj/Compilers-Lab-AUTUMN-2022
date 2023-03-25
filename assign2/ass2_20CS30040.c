#include "myl.h"
int printStr(char *s)
{
    int bytes = 0; // number of bytes to be printed
    while (s[bytes++])
        ; // count the number of bytes in the string

    __asm__ __volatile__( // print the string
        "movl $1, %%eax \n\t"
        "movq $1,%%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(s), "d"(bytes)

    );
    return bytes-1; // return the number of bytes printed
}
int readStr(char *buff, int *len)
{

    __asm__ __volatile__( // read the string
        "movl $0, %%eax \n\t"
        "movq $0,%%rdi \n\t"
        "syscall \n\t"
        : "=a"(*len)
        : "S"(buff), "d"(BUFF)

    );
    return OK;
}
int printInt(int n)
{

    char buff[BUFF];         // buffer to store the string representation of n
    int i = 0, lessZero = 0; // i is the index of the current character in buff, lessZero is 1 if n is less than 0
    if (n == 0)              // if n is 0, print 0
        buff[i++] = '0';
    else
    {

        if (n < 0)
            buff[i++] = '-', n = -n, lessZero = 1; // if n is less than 0, - to buffer and make n positive
        while (n)
        {
            if (i >= BUFF) // if the buffer is full, return error
                return ERR;

            buff[i++] = '0' + n % 10; // get the next digit and add it to the buffer
            n /= 10;                  // remove the digit from n
        }
        //  reverse the string in the buffer
        for (int j = lessZero; j < (i + 1) / 2; j++)
        {
            int shift = lessZero ? 0 : 1;

            // swap the jth and (i - j)th digits
            char temp = buff[j];
            buff[j] = buff[i - shift - j];
            buff[i - shift - j] = temp;
        }
    }

    buff[i] = '\0';
    printStr(buff); // print the string representation of n

    return i;
}
int printFlt(float f)
{
    int intPart = (int)f;
    float floatPart = f - intPart;
    int status = printInt(intPart); // Prints the integer part
    if (status == ERR)              // if the integer part is not printed, return error
        return ERR;

    char buff[2] = {'.', '\0'}; // buffer to store the decimal point
    printStr(buff);             // print the decimal point
    if (floatPart < 0)
        floatPart *= -1;

    status += printInt(floatPart * DIGITS); // Prints the fractional part
    if (status == ERR)                     // if the fractional part is not printed, return error
        return ERR;
    return status+1;
}
int power(int a, int p) // utility function to calculate a^p
{
    int ans = 1;
    for (int i = 0; i < p; i++)
        ans *= a;
    return ans;
}
int readInt(int *n)
{
    *n = 0;          // initialize n to 0
    char buff[BUFF]; // buffer to store the string representation of n
    int len = 0;
    readStr(buff, &len); // read the string representation of n
    int i = 0, flag = 0;
    len -= 1; // removing the contribution null char from totalLen
    if (buff[i] == '-' || buff[i] == '+')
        i++, flag = 1;

    while (i < len) // count the number of characters in the string

    {

        if (buff[i] < '0' || buff[i] > '9') // ignoring the characters other than digits
            return ERR;
        i++;
    }
    for (int i = flag; i < len; i++)
    {

        (*n) += power(10, len - i - 1) * ((int)(buff[i] - '0')); // converting the string to integer
    }
    if (buff[0] == '-')
        (*n) *= -1;
    return OK;
}
int readFlt(float *f)
{

    int intPart = 0, floatPart = 0;
    char buff[BUFF];
    int totaLen = 0, intLen = 0;
    readStr(buff, &totaLen); // read the string
    totaLen--;               // removing the contribution null char from totalLen

    int i = 0, flag = 0;
    if (buff[i] == '-' || buff[i] == '+')
        i++, flag = 1;
    int nDots = 0;
    while (i < totaLen)
    {
        if (buff[i] == '.')
        {
            nDots++;
            i++;
            continue;
        }

        if (buff[i] < '0' || buff[i] > '9') // ignoring the characters other than digits
            return ERR;
        i++;
    }
    if (nDots > 1)
        return ERR;

    for (; intLen < totaLen; intLen++) // calculates the int part length
    {
        if (buff[intLen] == '.')
            break;
    }
    for (int i = flag; i < intLen; i++) // convert the string int part to integer
    {

        (intPart) += power(10, intLen - i - 1) * ((int)(buff[i] - '0'));
    }

    for (int i = intLen + 1; i < totaLen; i++) // convert the float part string to integer
    {

        floatPart += ((int)(buff[i] - '0')) * power(10, totaLen - i - 1);
    }
    float x = floatPart, y = power(10, totaLen - intLen - 1);
    *f = (float)intPart + x / y; // calculate the final number
    if (buff[0] == '-')
        (*f) *= -1;

    return OK;
}
