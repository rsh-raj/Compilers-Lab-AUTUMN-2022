// testing if else statement and nested loops
int main()
{
    int a = 1, b = 2, c = 3;
    if (a > b)
    {
        if (a > c)
        {
            a = 1;
        }
        else
        {
            a = 2;
        }
    }
    else
    {
        if (b > c)
        {
            a = 3;
        }
        else
        {
            a = 4;
        }
    }
    // test loops
    for ( i = 0; i < 10; i++)
    {
        a = a + 1;
    }
    while (a < 10)
    {
        a = a + 1;
    }
    // nested loops
    for ( i = 0; i < 10; i++)
    {
        for ( j = 0; j < 10; j++)
        {
            a = a + 1;
        }
    }
    // int m=99;
    for ( i = 0; i < m; i++)
    {
        while (i < 11)
        {
            for ( j = 0; j < 10; j++)
            {
                a = a + 1;
            }
        }
    }
    return 0;
}

