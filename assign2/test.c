#include "myl.h"
int main()
{
    int i;
    printStr("--------Test integer printing-------\n\n");
    printStr("Enter an integer: ");
    readInt(&i);
    printStr("You entered: ");
    int Count1 = printInt(i);
    printStr("\n");
    printStr("No of characters printed is: ");
    printInt(Count1);
    printStr("\n");
    printStr("\n--------Test float printing-----------\n\n");
    float n;
    printStr("Enter a float: ");
    readFlt(&n);
    printStr("You entered: ");
    int count2 = printFlt(n);
    printStr("\n");
    printStr("No of characters printed is: ");
    printInt(count2);
    printStr("\n");
    printStr("\n--------Test string printing-----------\n\n");
    char *str = "Is this feature working?";
    int count3 = printStr(str);
    printStr("\n");
    printStr("No of characters printed is: ");
    printInt(count3);
    printStr("\n");

    return 0;
}