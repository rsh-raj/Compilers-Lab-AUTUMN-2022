

int printStr(char *ch)
{
    int i = 0;
    for (i = 0; ch[i] != '\0'; i++)
        ;
    __asm__ __volatile__("syscall" ::"a"(1), "D"(1), "S"(ch), "d"(i));
    return (i);
}

int printInt(int n)
{
    char buff[100];
    int i = 0, j, k, bytes;
    if (n == 0)
        buff[i++] = '0';
    else
    {
        if (n < 0)
        {
            buff[i++] = '-';
            n = -n;
        }
        int dg = 0;
        while (n)
        {
            dg = n % 10;
            buff[i++] = (char)(dg + '0');
            n /= 10;
        }
        if (buff[0] == '-')
            j = 1;
        else
            j = 0;
        k = i - 1;
        char temp;
       
        while (j < k)
        {
            temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
    }
    bytes = i;
    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(buff), "d"(bytes));
    return bytes;
}

int printFloat(float f)
{
    char buff[100];
    int i = 0, j, count = 0, k, bytes;
    if (f == 0)
        buff[i++] = '0';
    else
    {
        if (f < 0)
        {
            buff[i++] = '-';
            f = -f;
        }
        while (f != (int)f)
        {
            f *= 10;
            count++;
        }
        int dg = 0, n = (int)f;
        if (count == 0)
            count = -2;
        while (n)
        {
            if (count == 0)
            {
                buff[i++] = '.';
                count = -2;
            }
            else
            {
                dg = n % 10;
                buff[i++] = (char)(dg + '0');
                n /= 10;
                count--;
            }
        }
        if (buff[0] == '-')
            j = 1;
        else
            j = 0;
        k = i - 1;
        char temp;
        /*reversing the array*/
        while (j < k)
        {
            temp = buff[j];
            buff[j++] = buff[k];
            buff[k--] = temp;
        }
    }
    bytes = i;

    __asm__ __volatile__(
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        : "S"(buff), "d"(bytes));
    return bytes;
}

int readInt(int *ep)
{
    char buff[1];
    char n[20];
    int num = 0, len = 0, i;
    while (1)
    {
        __asm__ __volatile__("syscall" ::"a"(0), "D"(0), "S"(buff), "d"(1));
        if (buff[0] == '\t' || buff[0] == '\n' || buff[0] == ' ')
            break;
        else if (((int)buff[0] - '0' > 9 || (int)buff[0] - '0' < 0) && buff[0] != '-')
            *ep = 1;
        else
        {
            n[len++] = buff[0];
        }
    }
    if (len > 9 || len == 0)
    {
        *ep = 1;
        return 0;
    }
    if (n[0] == '-')
    {
        if (len == 1)
        {
            *ep = 1;
            return 0;
        }
        for (i = 1; i < len; i++)
        {
            if (n[i] == '-')
                *ep = 1;
            num *= 10;
            num += (int)n[i] - '0';
        }
        num = -num;
    }
    else
    {
        for (i = 0; i < len; i++)
        {
            if (n[i] == '-')
                *ep = 1;
            num *= 10;
            num += (int)n[i] - '0';
        }
    }
    return num;
}

int readFloat(float *ep)
{
    char buff[1];
    char n[20];
    float num = 0.0;
    int len = 0, i, flag = 0;

    while (1)
    {

        __asm__ __volatile__("syscall" ::"a"(0), "D"(0), "S"(buff), "d"(1));
        if (buff[0] == '\t' || buff[0] == '\n' || buff[0] == ' ')
            break;
        else if (((int)buff[0] - '0' > 9 || (int)buff[0] - '0' < 0) && buff[0] != '-' && buff[0] != '.')
            return 1;
        else
        {
            n[len++] = buff[0];
        }
    }
    float mul = 1.0;
    if (len > 12 || len == 0)
    {
        *ep = 0.0;
        return 1;
    }
    if (n[0] == '.')
        return 1;
    if (n[0] == '-')
    {
        if (len == 1)
        {
            *ep = 0.0;
            return 1;
        }
        if (n[1] == '.')
            return 1;
        for (i = 1; i < len; i++)
        {
            if (n[i] == '-')
                return 1;
            if (n[i] == '.' && flag == 1)
                return 1;
            if (n[i] == '.' && flag == 0)
            {
                flag = 1;
                continue;
            }
            if (flag)
            {
                mul *= 10.0;
                num += (float)((int)n[i] - '0') / mul;
            }
            else
            {
                num *= 10;
                num += (float)((int)n[i] - '0');
            }
        }
        num = -num;
    }

    else
    {
        for (i = 0; i < len; i++)
        {
            if (n[i] == '-')
                return 1;
            if (n[i] == '.' && flag == 1)
                return 1;
            if (n[i] == '.' && flag == 0)
            {
                flag = 1;
                continue;
            }
            if (flag)
            {
                mul *= 10.0;
                num += (float)((int)n[i] - '0') / mul;
            }
            else
            {
                num *= 10;
                num += (float)((int)n[i] - '0');
            }
        }
    }
    *ep = num;
    return 0;
}