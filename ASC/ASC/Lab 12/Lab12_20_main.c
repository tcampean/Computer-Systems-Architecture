#include <stdio.h>
int Prime(int x);

int main()
{
    int n, a[100];
    printf("n= ");
    scanf("%d", &n);


    printf("the list of numbers: ");
    for (int i = 1; i <= n; ++i)
        scanf("%d", &a[i]);

    printf("the list of prime numbers: ");
    for (int i = 1; i <= n; ++i)
        if (Prime(a[i]) != -1)
            printf("%d ", a[i]);

    return 0;
}
