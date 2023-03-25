/*
Aditya Choudhary 20CS10005
Rishi Raj 20CS30040
*/

//testing identifiers,constants, and functions
int x = 10012;
void func(int a[],int *restrict b, volatile int c){
    auto int n;
    unsigned int n1;
    double n2;
    register int c;

}
inline int func2(char c[]){
    static int val = 0;
    extern int a;
    char n='4',m='\b';
    return n;
}
enum months {Jan=1,Feb=2,March,April,May,June,July,Aug,Sept,Oct,Nov,Dec};
int main(){
    //testing punctuators
    int arr[3] = {1,2,3};
    int k=4,b=5;
    int *pointer = &k;
    k++;
    k--;
    k=k+b;
    unsigned long n1 = +123456789;
    short n2 = 16;
    float n3 = -3.53;
    double n4 = 2.439e-2;
    _Bool n5 = !1;
    double _Complex n6;
    k=k-b;
    k+=b;
    k=~k;
    k=k%b;
    k/=b;
    k=k/b;
    k=k^b;
    k=k>>b;
    k=k<<b;
    k=k|b;
    k=(k)?k:b;
    k^=b;
    k=9,b=4;
    k=k+b+4-6^b;
    //testing switch case and if else
    switch(k)
    {
    case 1:
        k=4;
        break;
    
    default:
        break;
    }
    // testing goto
    int n2 = 3;
    LOC:
        if(n3 > n4){
            n3 -= 2;
        }
    
    while(n2--)
        goto LOC;

    // testing if else
    int i=990;
    if(k){
        k+=i;
        i++;
    }
    else{
        k--;
    }
    //testing loops
    for(;;);
    int cnt = 1;
    for(int i=0;((i<k && i<20) || cnt >= 0);i++){
        if(i>16) break;
        else continue;

    }
    do{
        i-=1;
    }while(i>10);

    //testing string literals
    char s[]="Is it working?";
    char c='a';

    return 0;
}