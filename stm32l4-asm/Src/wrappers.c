/*
 * wrappers.c
 *
 *  Created on: 28. mar. 2023
 *      Author: Jakob
 */

#include<math.h>

float atan2f(float x, float y)
{
	return (float)atan2(x, y);
}

float tanf(float a)
{
	return (float)tan(a);
}

float sinf(float a)
{
	return (float)sin(a);
}

float cosf(float a)
{
	return (float)cos(a);
}

float atanf(float a)
{
	return (float)atan(a);
}

float asinf(float a)
{
	return (float)asin(a);
}

float acosf(float a)
{
	return (float)acos(a);
}