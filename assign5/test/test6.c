
//miscellaneous tests
inline int uselessFunction(int a)
{
    return a;
}
int bin_exp(int a, int p, int m)
{
    int ans = 1;
    while (p)
    {
        if (p & 1)
            ans = (ans * a) % m;
        a = (a * a) % m;
        p >>= 1;
    }
    return ans;
}
int main()
{
    int t=9, n=99;
   
    for ( i = 1; i <= t; i++)
    {

       
        int a[n+1];
        for( i=0;i<n;i++){
        
        }

        
    }
    //do while
    int i = 0;
    do
    {
        i++;
    } while (i < 10);
       return 0;
}
