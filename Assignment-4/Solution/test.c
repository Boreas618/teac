#include <stdio.h>
int aa;
int bb = 1;
int cc[4000] = {1};

struct Ca
{
    int a;
    int b;
};

struct Cb
{
    int a[100];
    struct Ca c;
};
struct Ca caa[1000];
struct Cb cbb;

int sum1(int a[10],int n)
{
    int ret = a[1];
    return ret;
}

int sum(int x,int y,int z)
{
    int a = x + y + z;
    a = a + 1;
    if(a > 0)
    {
        a = a - 1;
    }
    else
    {
        a = a + x;
    }
    return a;
}

int main()
{
    int a[10] = {1,2,3};
    printf("%d\n",sum1(a,10));
    return 0;
}