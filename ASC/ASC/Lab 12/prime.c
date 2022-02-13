#include <stdio.h>

int Prime(int a);

int main()
{
	int a;

	printf("a= ");
	scanf_s("%d", &a);
	a = Prime(a);
	printf("The value is %d",a);


	return 0;

}