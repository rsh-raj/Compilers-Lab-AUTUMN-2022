// testing function calls
int add(int a, int b)
{
    return a + b;
}
int main()
{
    int a = 1, b = 2, c = 3;
    int d = add(a, b);
    return 0;
}
int binarySearch(int a[])
{

    int b = 0;
    int c = 9;
    int d = 5;
    while (b <= c)
    {
        int e = (b + c) / 2;
        if (a[e] == d)
        {
            return e;
        }
        else if (a[e] < d)
        {
            b = e + 1;
        }
        else
        {
            c = e - 1;
        }
    }
    return -1;
}
int main()
{
    int a[10] , b = 2, c = 3;
    int d = binarySearch(a);
    if (d == -1)
    {
        return 0;
    }
    else
    {
        return 1;
    }
    int d = add(a, b);
    return 0;
}
