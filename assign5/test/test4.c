//typecasting and pointers
void swap(int *a, int *b)
{
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}
void inversionCount(int a[], int n)
{
    int count = 0;
    for ( i = 0; i < n; i++)
    {
        for (j = i + 1; j < n; j++)
        {
            if (a[i] > a[j])
            {
                count++;
            }
        }
    }
    printf("Inversion count is %d", count);
}
int main()
{
    int a = 1, b = 2,c=(int)3.3;
    float m=9;
    int array[10];
    inversionCount(array, 10);

    swap(&a, &b);
    return 0;
}
