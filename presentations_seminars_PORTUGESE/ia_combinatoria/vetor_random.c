#include <stdio.h>
#include <stdlib.h>
// ./a.out > ent100.dzn
int main(void)
{
	int i, N;
	scanf("%d", &N);
       	printf("n = %d; \npeso = [" , N );
	for (i = 0; i < (N-1); i++)
	printf("%d, " , (rand() % 150) );
	//ULTIMO
        printf(" %d];\n", (rand() % 150) );

	return 0;
}
