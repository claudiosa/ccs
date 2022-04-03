#include<stdio.h>
#include<stdlib.h>
#include <ctype.h> // usado para toupper ... 
// original http://www.codingalpha.com/depth-first-search-algorithm-c-program/ 
// MODIFICADO by CCS

// original http://www.codingalpha.com/depth-first-search-algorithm-c-program/ 

#define MAX 100
 
#define aberto 1 // ou NAO VISITADO -- true o false
#define visitado 2  // NOH FECHADO
 
void lendo_grafo(void);
void graph_traversal(void);
void DFS(int vertex);

//minimo de pilha
void push(int vertex);
int pop(void);
int isEmpty(void);
 

// GLOBAIS ....  uma pena ... fica facil de ler neste momento
// embora menos elegante
int stack[MAX];
int top = -1;
int vertices; // TOTAL DE VERTICES
int adjacent_matrix[MAX][MAX];
int vertex_status[MAX]; // abertos ou fechados
 
void imp_NUM_LETRAS(int ); 
int vertex_status[MAX];
 
int main(void)
{
      lendo_grafo();
      graph_traversal();
      return 0;
}
 
void graph_traversal(void)
{
	  int vertex; 
	  for(vertex = 0; vertex < vertices; vertex++)
	  {
		vertex_status[vertex] = aberto;
	  } 
	  printf("\n Entre com um NOH de PARTIDA para o DFS:\t");
	  scanf("%d", &vertex);
	  printf("\n COMEÇANDO com o NOH: %d ou ", vertex);
	  imp_NUM_LETRAS(vertex);
	  printf("\n ============================\n");
	  DFS(vertex);
	  printf("\n fim do DFS \n");

}
 
void DFS(int vertex)
{
  int count;
  push(vertex);  // empilha a RAIZ
  while(!isEmpty())
  {
  	vertex = pop();		// toma o topo da pilha
  	if(vertex_status[vertex] == aberto)
  	{ // verifica se eh no aberto
  		  //printf("%3d", vertex);
  		  imp_NUM_LETRAS(vertex);
        // AQUI PODE INSERIR UM TESTE QUALQUER
        // AQUI EH A VISITA ... so imprime
  		  vertex_status[vertex] = visitado;
  		  // muda o status
  	 }
  // DFS pela esquerda ou pela direita .... veja explicacao em sala  
        for(count = vertices - 1; count >= 0; count--)
  //     pela direita
  //		for(count = 0; count < vertices ; count++)
  	    {
  	     if((adjacent_matrix[vertex][count] == 1) && 
             (vertex_status[count] == aberto))
  	     {
  		  //coloca na pilha os IMEDIATOS, NAO VISITADOS ou ABERTOS
  		 // VIZINHOS DE VERTEX
  		//a PARTIR DE VERTEX ... ou seja... os imediatos ao topo da pilha
  		    push(count);
  	     } // FIM DO IF
  	}// FIM DO FOR
  }// FIM DO WHILE 
 return; 
}

// ha versoes recursivas do DFS ... mas nao eh o caso 
 
 void imp_NUM_LETRAS(int N)
 {
  int a[26]={'a','b','c','d','e','f','g','h','i','j','k',
           'l','m','n','o','p','q','r','s','t','u','v',
            'w','x','y','z'}; 

    if(N > 26 && N < 0) // até 26 vertices...
	 {
	   printf("\n problema ... imp_NUM_LETRAS");
	   return;
	 }

	printf(" %c", toupper(a[ N ])); // ver tabela ASCII

  return;
 }  
	  	 
	 
 
void push(int vertex)
{
      if(top == (MAX - 1))
      {
            printf("Stack Overflow\n");
            return;
      }
      top = top + 1;
      stack[top] = vertex;
}
 
int pop(void)
{
      int vertex;
      if(top == -1)
      {
            printf("Stack Underflow\n");
            exit(1);
      }
      else
      {
            vertex = stack[top];
            top = top - 1;
            return vertex;
      }
}
 
int isEmpty(void)
{
      if(top == -1)
      {
            return 1;
      }
      else 
      {
            return 0;
      }
}

// LE E ESCREVE 
void lendo_grafo(void) // MATRIZ ADJACENCIA
{    
      int lin, col ;
      printf("Entre total de vertices:\t");
      scanf("%d ", &vertices);
      printf("\nVertices: %d", vertices);
     // maximum_edges = vertices * (vertices - 1);
    for(lin = 0; lin < vertices ; lin++)
    {
		  for(col = 0; col < vertices ; col++)
		  {
        scanf("%d ", &adjacent_matrix[lin][col]);
      }
    }
      // imprimindo a matriz ...
      printf(" MATRIZ LIDA \n    " );
      for(col = 0; col < vertices ; col++)
      imp_NUM_LETRAS(col);
      printf("\n");
      
    for(lin = 0; lin < vertices ; lin++)
      {
  		 imp_NUM_LETRAS(lin);  
  		 printf(": ");
  		 for(col = 0; col < vertices ; col++)
  		 {
        printf(" %d", adjacent_matrix[lin][col]);
       }
       printf("\n" ); 
     }
     
     return; 
}
