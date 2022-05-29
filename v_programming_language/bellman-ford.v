/*
https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/
http://rascunhointeligente.blogspot.com/2010/10/o-algoritmo-de-bellman-ford-um.html

função BellmanFord(lista vértices, lista arestas, vértice origem)
   // Esta implementação recebe um grafo representado como uma
   // lista de vértices e arestas e modifica os vértices para
   // que que seus atributos distância e anterior armazenem 
   // os caminhos mais curtos.

   // Passo 1: Inicializar o grafo
   para cada vértice v em vértices faça:
       se v é origem então:
           v.distância = 0
       senão:
           v.distância := infinito
       v.anterior := nulo
   
   // Passo 2: Ajustar as arestas repetidamente
   repita tamanho (vértices) vezes:
       para cada aresta uv em arestas faça:
           u := uv.origem
           v := uv.destino     // uv é a aresta de u para v
           se v.distância > u.distância + uv.peso então:
               v.distância := u.distância + uv.peso
               v.anterior := u

   // Passo 3: Verificar a existência de ciclos com peso negativo
   para cada aresta uv em arestas faça:
       u := uv.origem
       v := uv.destino
       se v.distância > u.distância + uv.peso então:
           erro "O grafo contém um ciclo de peso negativo.

*/
// A V program for Bellman-Ford's single source
// shortest path algorithm.

// give a NODE v, return a list with all adjacents
// Take care, only positive EDGES
fn all_adjacents <T> ( g [][] T, v int ) [] T{
	mut temp := [] T {} // 
	for i in 0..(g.len)
	{
		if g[v][i] > 0 {
		 temp << i	
		}
	}
   return temp
}

fn build_map_edges_from_graph <T> (g [][] T ) map [T] EDGE   {
     
   n := g.len // TOTAL OF NODES for this graph -- its dimmension
   mut edges_map := map [int] EDGE {} // a graph represented by map of edges
   
   mut edge := 0 // a counter of edges
   for i in 0..n {
	   for j in 0..n {
	   if g[i][j] != 0  // if exist an arc ... include as new edge
	   {
          edges_map[edge] = EDGE{i, j ,g[i][j]}
		  edge++
	   }  
	   }
   }
	//print('${edges_map}')   
	return edges_map
   }

// The main function that finds shortest distances from src
// to all other vertices using Bellman-Ford algorithm.  The
// function also detects negative weight cycle
fn bellman_ford  ( graph[][] T , src int) 
{
	n := g.len // adjc matrix ... n nodes or vertex
	mut edges := build_map_edges_from_graph(graph)
	 // Step 1: Initialize distances from src to all other
    // vertices as INFINITE
	mut dist := []int{len: n , init:infinity} // dist with -1 instead of INIFINITY
	//mut path := []int{len: n , init:-1} // previous node of each shortest paht
	dist[src] = 0
    // Step 2: Relax all edges |V| - 1 times. A simple
    // shortest path from src to any other vertex can have
    // at-most |V| - 1 edges
    
TO DO


fn main() {
//adjacency matrix = cost or weight
graph_01 := [
	[0, 4, 0, 0, 0, 0, 0, 8, 0],
	[4, 0, 8, 0, 0, 0, 0, 11, 0],
	[0, 8, 0, 7, 0, 4, 0, 0, 2],
	[0, 0, 7, 0, 9, 14, 0, 0, 0],
	[0, 0, 0, 9, 0, 10, 0, 0, 0],
	[0, 0, 4, 14, 10, 0, 2, 0, 0],
	[0, 0, 0, 0, 0, 2, 0, 1, 6],
	[8, 11, 0, 0, 0, 0, 1, 0, 7],
	[0, 0, 2, 0, 0, 0, 6, 7, 0]
	]

graph_02 := [ 
	[0, 2, 0, 6, 0],
    [2, 0, 3, 8, 5],
    [0, 3, 0, 0, 7],
    [6, 8, 0, 0, 9],
    [0, 5, 7, 9, 0]
	]
// data from https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/
/* The graph:
        2    3
    (0)--(1)--(2)
    |    / \    |
   6|  8/   \5  |7
    |  /     \  |
    (3)-------(4)
         9     
*/

 /* Let us create following weighted graph
 From https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/?ref=lbp
                   10
              0--------1
              |  \     |
             6|   5\   |15
              |      \ |
              2--------3
                  4       
				  */
graph_03 := [ 
	[0, 10, 6, 5],
    [10, 0, 0, 15],
    [6, 0,  0, 4],
    [5, 15, 4, 0]
	]

	// To find number of coluns
	//mut cols := an_array[0].len 
    mut graph := [][] int {} // the graph: adjacency matrix
	//for index, g_value in [graph_01, graph_02, graph_03] {
	for index, g_value in [graph_01, graph_02, graph_03] {	
		
		graph = g_value.clone() // graphs_sample[g].clone() // choice your SAMPLE
        //allways starting by node 0
		start_node := 0
        println('\n\n Graph ${index+1} using Bellman-Ford algorithm algorithm (source node: ${start_node})')
//	    bellman_ford(graph, start_node)
        //print('\n ==> ${all_adjacents(graph,start_node)}')

	}
   
	println('\n BYE -- OK')
	
}
