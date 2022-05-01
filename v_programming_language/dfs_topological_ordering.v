/*
https://en.wikipedia.org/wiki/Topological_sorting

A DFS RECURSIVE ....
An alternative algorithm for topological sorting is based on depth-first search. The algorithm loops through each node of the graph, in an arbitrary order, initiating a depth-first search that terminates when it hits any node that has already been visited since the beginning 
of the topological sort or the node has no outgoing edges (i.e. a leaf node)


Discussion: https://www.gatevidyalay.com/topological-sort-topological-sorting/

$ v run dfs_topological_ordering.v 


*/

// THE DFS RECURSIVE .... classical searchig for leaves nodes
// the arguments in the function avoid global variables....
fn dfs_recursive  ( u string , mut visited map[string] bool, graph map[string] [] string, mut top_sorting[] string)
{
    print(" Visiting: ${u} -> " )
    visited[ u ] = true

    for v in graph[ u ]  // their neighbours
	{
      if visited[ v ]==false
      { dfs_recursive(v, mut visited, graph, mut top_sorting) }
	}		
    top_sorting << u
}


// Creating aa map to initialize with of visited nodes .... all with false in the init
// so these nodes are NOT VISITED YET
fn visited_init (a_graph map [string] [] string ) map [string]  bool   {
	mut array_of_keys := a_graph.keys() // get all keys of this map
	mut temp := map [string] bool {} // attention in these initializations with maps
	for i in array_of_keys 
	 {
	  temp[i] = false 
	 }
	 return temp
}
// attention here a map STRING ---> ONE BOOLEAN ... not a string

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
 //from: https://en.wikipedia.org/wiki/Topological_sorting
graph_03 := {
		'5': ['11']
		'7': ['11', '8']
		'3': ['8','10']
		'11': ['2','9','10']
		'8': ['9']
		'2': []
		'9': []
		'10': []
	}
    // for the future ... 
    // mut all_graphs := ['graph_01', 'graph_02', 'graph_03']
    // for sample in  all_graphs 
    //	{ 
	// print('\n ${sample}')
	//  graph = sample.clone()
	// }

    mut graph := map [string] [] string //the graph: adjacency matrix
	graph = graph_01.clone() // choice your SAMPLE
	//graph = graph_02.clone() // choice your SAMPLE
	//graph = graph_03.clone() // choice your SAMPLE
    
	//mut n_nodes := graph.len   
    mut visited :=  visited_init(graph)// something as// mut visited := [] bool {len: n_nodes,  init: false}
   
    //mut start := (graph.keys()).first() // arbitrary, any node if you wish
	mut top_sorting := [] string {}

    for i in  graph.keys() // advantages of map
	{  	
	if  visited[i] != true
		{
		dfs_recursive( i, mut visited, graph, mut top_sorting)
		}
	}

    print("\n Toplogical order: ")
	print(top_sorting.reverse())		
    //Toplogical order: ['3', '7', '8', '5', '11', '10', '9', '2']
	//last answer from reference
}	
/************************************************************************/