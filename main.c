/*- include files **/
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <errno.h> 
#include <time.h>

int main(int argc, char **argv){
	int i;

	printf("Hello world!\n");
	for (i=0; i<argc; i++){
		printf("%s\n",argv[i]);
	}
}
