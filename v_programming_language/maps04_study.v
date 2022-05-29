
// a structure to represent a weighted edge in graph
struct EDGE {
    mut :
	src int
	dest int 
	weight int
}

fn main() {	
// A map illustration to use in a graph
// adjacency matrix
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
graph := [ 
	[0, 10, 6, 5],
    [10, 0, 0, 15],
    [6, 0,  0, 4],
    [5, 15, 4, 0]
	]

	mut edge := build_map_edges_from_graph(graph)
	print(edge)
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



