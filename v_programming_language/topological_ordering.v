
/*

The idea of this algorithm follow :
https://www.gatevidyalay.com/topological-sort-topological-sorting/
https://en.wikipedia.org/wiki/Topological_sorting
*/
//

fn topological_sort(graph map [string] [] string) [] string
{
 	n_nodes := graph.len // numbers of nodes of this graph
	mut top_order := [] string {} // a vector with sequence of nodes visited
	// ad the end ... reverse it
	//Ex ['C','A','B'] 

    mut count := 0 //
	/*
     IDEA ( a greedy algorythm):

	 1. choose allways the node with lesser input degree
	 2. visit it
	 3. put it in the output vector
	 4. remove it from graph
	 5. update the graph (a new graph)
	 6. find the vector degree (new)
	 7. until all nodes has been visited

*/
   mut v_degree := in_degree( graph ) //return: map [string] int 
   print("\n V Degree ${v_degree}")
   mut small_degree := min_degree(v_degree)
   mut new_graph := remove_node_from_graph(small_degree, graph)
   top_order << small_degree

   count++
   for(count < n_nodes)
   {
   v_degree = in_degree( new_graph ) //return: map [string] int 
   print("\n V Degree ${v_degree}")
   small_degree = min_degree(v_degree)
   new_graph = remove_node_from_graph(small_degree, new_graph)

   top_order << small_degree
   count++
   }
   //print("\n New Graph ${new_graph}")

   return top_order
}

// Give a node, return a list with all nodes incidents or fathers of this node
fn all_fathers (node string , a_map map [string] [] string ) [] string   {
	mut array_of_keys := a_map.keys() // get a key of this map
	mut all_incident := []string{}
	for i in array_of_keys 
	 {
	   if node in a_map[i]   // in : function
	   { 
		 all_incident << i  // a queue of this search
	   }
	 }
	 return all_incident
	}

// input: a map with values, return the key with smallest value
fn min_degree(a_map map [string] int ) string {
   mut array_of_keys := a_map.keys() // get a key of this map
   the_first := array_of_keys.first()
   mut min := a_map[the_first]
   mut key_min := the_first
   // print("\n MIN: ${min} \t  key_min: ${key_min}  ")
   for i in array_of_keys 
	{ 
	   if min > a_map[i] // there is a smaller
	   {
         min = a_map[i]
		 key_min = i
	   }
	}
	return key_min // the key with smallest value
}


// Given a graph ... return a list of integer with degree of each node
fn in_degree(a_map map [string] [] string ) map [string] int  {
   mut array_of_keys := a_map.keys() // get a key of this map
   //print(array_of_keys)
   mut degree := map [string] int {}
   for i in array_of_keys 
	{ 
	 degree [i] = all_fathers(i, a_map).len
	}
	//print("\n Degree ${in_degree}" )
	return degree // a vector of the indegree graph
}

// REMOVE A NODE FROM A GRAPH AND RETURN ANOTHER GRAPH
fn remove_node_from_graph(node string, a_map map [string] [] string ) map [string] [] string  {
   // mut new_graph := map [string] string {}
   mut new_graph := a_map.clone() // copy the graph
   new_graph.delete(node)
   mut all_nodes := new_graph.keys() // get all nodes of this graph
   // FOR THE FUTURE
   //for i in all_nodes {
   //	   new_graph[i] = new_graph[i].filter(index(it) != node)	
   // }  
   // A HELP FROM V discussion	
   for key in all_nodes {
     i := new_graph[key].index(node)
     if i >= 0 {
      new_graph[key].delete(i)
       }
	}
	//print("\n NEW ${new_graph}" )
	return new_graph
}

fn main() {	
// A map illustration to use in a graph
// adjacency matrix
	graph_01 := {
		'A': ['B', 'C','D']
		'B': ['C','D']
		'C': ['E']
		'D': ['E']
		'E': []
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
		'2': []
		'9': []
		'10': []
	}

    //
	//printing_a_map(graph)
	
    print('\n The Topological Order of G1:  ${topological_sort( graph_01)} ')
    print('\n The Topological Order of G2:  ${topological_sort( graph_02)} ')
	print('\n The Topological Order of G3:  ${topological_sort( graph_03)} ')
    
	println('\n BYE')
}	
/************************************************************************/