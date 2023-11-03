#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int _main(int argc, char *argv[])
{
	char grade[5];
	char name[10];
	
	strcpy(grade, "nil");

	gets(name); // read until a null terminator; overwrite subsequent memory.
	
	printf("Hi %s! Your grade is %s.\n", name, grade);
	
	exit(0);	
}
