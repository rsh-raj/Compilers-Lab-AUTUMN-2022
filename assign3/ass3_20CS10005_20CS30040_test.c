/*
Aditya Choudhary (20CS10005)///testing single line comment inside a multiline comment
Rishi Raj (20CS30040)
*/
//////////testing multi single line comments
#define TRUE 1;
#define FALSE 0;

inline int find(int x){
    return x*x;
}

struct keyword_test{
    auto int a = 1;
    register int b;
    extern int c;
    volatile int d;
};

int recur(int n){
    static int x = 0;
    if(n == 1) return x;
    else{
        x++;
        return 1+recur(n-1);
    }
}

struct data{
    _Bool b;
    _Complex c;
    _Imaginary i;
    int data;
    struct data *next;
};

union lex{
    int a,b;
};

enum lexinum{
    Mon, Tue
};

typedef struct keyword_test test;
typedef struct data node;

void main(){
    int arr[] = {1,2,3,4};
    int n;
    n = sizeof(arr)/sizeof(arr[0]);

    for(int i = 0; i < n; i++){
        int x = arr[i];
        x = x<<2;
        x += -5;
        
        int temp = 6;
        x = x && temp;

        x /= 2;
        x *= 2;
        x += 2;
        x -= 2;

        x = x ^ temp;
        x = x | temp;
        temp &= x;

        if(temp > x) temp >>= 2;
        else temp <<= 2;

        temp = x >= 5 ? 0 : 1;
        arr[i] = temp;
    }   

    // defining various variables for testing purpose
    double di = 12;
    double dj = +12.e2;
    double dk = 12.E-2;
    double dl = 12e-2;

    float f1 = .12E-2;
    float f2 = 12.12E+2;
    const float f3 = 10.002;

    unsigned int mod = 1e9+7;
    long long int MAX_INT = 1<<31-1;

    // testing strings
    char c[] = "Hello World !!";
    char *s = "Football // /* Hala Madrid */ //\n\t\a\f";
    char charconst2 = 'T_T';
    char charconst1 = 'india ^_^';

    // checking pointers
    node *cnt;
    cnt = (node *)malloc(sizeof(node));
    cnt->data = 0;
    cnt->next = cnt;

    // checking switch case
    while(!cnt->next){
        cnt->data++;
        switch(cnt->data){
            case 1:
                cnt->data = 0;
                cnt->next = NULL;
                break;
            default:
                cnt->data = MAX_INT;
        }

        if(cnt->data == 0){
            goto here;
        }

        continue;

        here:
            break;
    }

    return;
}