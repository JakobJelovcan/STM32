#include<stdio.h>
#include<stdlib.h>

char buffer[10];

void print_x(char* target, float value)
{
	gcvt(value, 5, buffer);
	sprintf(target, "X:%s", buffer);
}

void print_y(char* target, float value)
{
	gcvt(value, 5, buffer);
	sprintf(target, "Y:%s", buffer);
}

void print_z(char* target, float value)
{
	gcvt(value, 5, buffer);
	sprintf(target, "Z:%s", buffer);
}

void print(char* target, int value)
{
	sprintf(target, "%d", value);
}
