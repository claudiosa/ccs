#include "fila_INT.h"
// original http://www.codingalpha.com/depth-first-search-algorithm-c-program/ 
// BFS by CCS -- 2018
// 
#define MAX 100
 
#define aberto 1 // ou NAO VISITADO -- true o false -- na fila
#define visitado 2  // NOH FECHADO
  
void lendo_grafo(void); // reading the graph
void graph_traversal(void); // visiting
void BFS(int vertex, fila *); // using a queue

// VARIAVEIS GLOBAIS ....  simplificacao ...
int vertices; // TOTAL DE VERTICES
int adjacent_matrix[MAX][MAX];
int vertex_status[MAX]; // VETOR de nos abertos ou fechados
 
void imp_NUM_LETRAS(int ); 
int vertex_status[MAX];
//==================================================================== 
int main(void)
{
      lendo_grafo(); // leitura da matriz de adjacencia
      graph_traversal();
      return 0;
}
//==================================================================== 
void graph_traversal(void)
{
	  fila * F = cria_fila ( MAX ); 
	  // criando FISICAMENTE a FILA .... MUITOS ESQUECEM isto e ... segmentation fault
	  int vertex; 
	  for(vertex = 0; vertex < vertices; vertex++) 
	  { // marca que nenhum foi visitado 
		vertex_status[vertex] = aberto;
	  } 
	  printf("\n Entre com um NOH de PARTIDA para o BFS:\t");
	  scanf("%d", &vertex);
	  printf("\n COMEÇANDO com o NOH: %d ou ", vertex);
	  imp_NUM_LETRAS(vertex);
	  printf("\n ============================\n");
	  BFS(vertex,F);
	  printf("\n fim do BFS \n");

}
//==================================================================== 
void BFS(int vertex, fila * F)
{
  int count;
  chegada(vertex, F);  // adiciona de imediato a na RAIZ fila ou no de partida
  while( ! fila_vazia (F) ) //eh verdade em caso de fila VERDADE
  {
  	vertex = partida(F);	// toma o cabeca da FILA
  	if(vertex_status[vertex] == aberto) // nao visitado
  	{ // verifica se eh no aberto
  		  //printf("%3d", vertex);
  		  imp_NUM_LETRAS(vertex);
        // AQUI PODES INSERIR UM TESTE QUALQUER
        // AQUI EH A VISITA ... so imprime
  		  vertex_status[vertex] = visitado;
  		  // muda o status
  	 }
  // BFS pela esquerda ou pela direita .... veja explicacao em sala  
  // for(count = vertices - 1; count >= 0; count--) // PILHA
  //  pela direita ao contrário da PILHA a numeracao segue do menor ao maior
  // logo:
  	for(count = 0; count < vertices ; count++)
  	    {
  	     if((adjacent_matrix[vertex][count] == 1) && 
             (vertex_status[count] == aberto))
  	     {
  		  //insere na filha os IMEDIATOS, NAO VISITADOS ou ABERTOS
  		 // VIZINHOS DE VERTEX
  		//a PARTIR DE VERTEX ... ou seja... os imediatos ao topo da pilha
  		    chegada(count, F); 
  	     } // FIM DO IF
  	}// FIM DO FOR
  }// FIM DO WHILE 
 return; 
}
// ha versoes recursivas do BFS ... mas nao eh o caso 
//====================================================================
 void imp_NUM_LETRAS(int N)
 {
  int a[26]={'a','b','c','d','e','f','g','h','i','j','k',
           'l','m','n','o','p','q','r','s','t','u','v',
            'w','x','y','z'}; 

    if(N > 26 && N < 0) // até 26 vertices...
	 {
	   printf("\n Problema ... imp_NUM_LETRAS");
	   return;
	 }
	printf(" %c", toupper(a[ N ])); // ver tabela ASCII
  return;
 }  
//====================================================================	 

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
//====================================================================
