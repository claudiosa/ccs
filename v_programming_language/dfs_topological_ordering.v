
/*

The idea of this algorithm follow :
https://www.gatevidyalay.com/topological-sort-topological-sorting/ (GREEDY)
(no cycles are detected)

(https://en.wikipedia.org/wiki/topog_sort_greedying ... just the input data)
*/

// the idea is rude: https://www.gatevidyalay.com/topological-sort-topological-sorting/

fn dfs_recursive  ( u string ,  mut  visited [] bool, graph map[string][]string, mut top_sorting[] string)
{

    print("\n visiting ${u}$" )
    visited[ u ] = true

    for v in graph[ u ]
	{
        if visited[ v ]==false
         {dfs_recursive(v, mut visited, graph, mut top_sorting)}
	}		

    top_sorting << u
}


fn a_map_nodes_bool (size int, first_node string)  map [string]  bool {
	mut my_map := map [string] bool {} // look this map ...
	mut base := first_node///////AHERE ....
	mut	key := byte(base).ascii_str()
	for i in 0 .. size {
		key = byte(base+i).ascii_str()
		my_map[key] = false  
	}
   	return my_map
 }



fn main() {	
// A map illustration to use in a graph
// adjacency matrix
	graph_01 := {
		'A': ['C', 'B']
		'B': ['D']
		'C': ['D']
		'D': []
	}

	graph_02 := {
		'A': ['B', 'C', 'D']
		'B': ['E']
		'C': ['F']
		'D': ['E']
		'E': ['H']
		'F': ['H']
		'G': ['H']
		'H': ['E', 'F','G']
	}
//from: https://en.wikipedia.org/wiki/topog_sort_greedying
	graph_03 := {
		'5': ['11']
		'7': ['11', '8']
		'3': ['8','10']
		'11': ['2','9','10']
		'2': []
		'9': []
		'10': []
	}

   // dfs(0)  
    mut graph := graph_03.clone()

	mut n_nodes := graph.len
   // mut visited := [] bool {len: n_nodes,  init: false}
   mut visited :=  map[string][] bool {len: n_nodes,  init: false}
    mut start := (graph.keys()).first() 
	mut top_sorting := [] string {}
/*
    for i in  graph.keys() 
	{  	
	if  visited[i] != true
		dfs_recursive(start, visited, graph, top_sorting)
	}
*/
    print("Toplogical order: ")
	print(top_sorting)		
  
}	
/************************************************************************/