// leitura e escrita TEXTO
#include <stdio.h>
#include <stdlib.h>

int main(void){

int num_linhas;
int um_ou_zero;
int i,j;
/*
 adj_mat = 
 [| 0, 0, 1, 1, 0, 1, 0, 1, 1, 1 |
    0, 0, 0, 1, 1, 1, 1, 0, 1, 1 |
    ......................
    1, 1, 0, 1, 1, 0, 0, 1, 0, 1 |
    1, 1, 1, 0, 1, 1, 0, 0, 1, 0 |];

*/

scanf("%d",  &num_linhas); 
printf(" N = %d ;\n ",num_linhas);
printf("adj_mat = [| \n ");  
   for(i=0;i< num_linhas ;++i)
    {

      for(j=0;j< num_linhas ;++j)
        {
        scanf("%d" ,  &um_ou_zero); 
        if( j >= (num_linhas-1))
         printf("%d " , um_ou_zero); // sem a virgula
         else printf("%d, ", um_ou_zero); // com
        }
       if( i >= (num_linhas-1))
          printf("|];\n");
        // \n /** FIM DA ENTRADA */
         else  printf("|\n ");//nova linha 
	
    }
     //printf("];\n ");
    exit(1);
 
 }