#include <stdio.h>

int QuickMaths(int a, int b, int c); // we declare our function

int main()
{
	int a, b, c, sum;

	printf("a= "); // we print "a="
	scanf_s("%d", &a); //we read a
	printf("b= "); // we print "b="
	scanf_s("%d", &b); // we read b
	printf("c= "); // we print "c="
	scanf_s("%d", &c); // we read c
	sum = QuickMaths(a, b, c); // we give the variable sum the result of a+b-c
	printf("The result of a + b - c is : %d", sum); // we print the value on the screen
	

	return 0;

}