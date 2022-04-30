
/*
Exploring maps and functions

by CCS
$ v  run maps03_study.v 
// Creating a executable
$ v  maps03_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/

//
fn a_hello () { println("\n Hello World!!!") }

// receiving and printing a map
fn printing_a_map ( a_map map [string] [] string )  {
	mut array_of_keys := a_map.keys()
	// println(m.keys()) // ['one', 'two']
	println("\n Printing a map:")
	for i in array_of_keys {
	  print('\n the key: ${i} has the contents: ${a_map[i]} ' )
	}
	print('\n All the keys are: ${array_of_keys}' )
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

// REMOVE A EDGE (u -> v ) FROM A GRAPH AND RETURN ANOTHER GRAPH
fn remove_a_edge_from_graph(u string, v string, a_map map [string] [] string ) map [string] [] string  {
   // mut new_graph := map [string] string {}
   mut new_graph := a_map.clone() // copy the graph
   
   if (v in new_graph[u]) == false {
     print('\n ERROR: There is no node from  ${u} to ${v} ')
	 return new_graph 
    }
   
   mut i := new_graph[u].index(v)
   if i >= 0 {
     new_graph[u].delete(i)
    }

	//print("\n NEW ${new_graph}" )
	return new_graph
}

// Input: a map with input degree values, return the key with smallest value
fn min_degree(a_map map [string] int ) string {
   mut array_of_keys := a_map.keys() // get a key of this map
   mut key_min := array_of_keys.first()
   mut val_min := a_map[key_min]
   //print("\n MIN: ${val_min} \t  key_min: ${key_min}  \n the map inp_degree: ${a_map}")
   for i in array_of_keys 
	{ 
	   if val_min > a_map[i] // there is a smaller
	   {
         val_min = a_map[i]
		 key_min = i
	   }
	}
	return key_min // the key with smallest value
}


fn main() {	
// A map illustration to use in a graph
// adjacency matrix
	graph_01 := {
		'A': ['B', 'C']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['B', 'F']
		'F': ['C', 'E']
	}
	graph_02 := {
		'A': ['B', 'C','D']
		'B': ['E']
		'C': ['F']
		'D': ['E']
		'E': ['H']
		'F': ['H']
		'G': ['H']
		'H':  ['E', 'F','G']
	}
    //
	//printing_a_map(graph)
	print('\n Small Degree: ${min_degree( in_degree (graph_01) )}' )
	print('\n Small Degree: ${min_degree( in_degree (graph_02) )}' )
	print('\n Degree of this map:  ${in_degree (graph_01)}')
    print('\n Remove Edge -> New graph:  ${remove_a_edge_from_graph('B', 'E', graph_02)} ')
	print('\n Remove Edge -> New graph:  ${remove_a_edge_from_graph('B', 'E', graph_02)} ')
    //print('\n New graph:  ${remove_node_from_graph ('A', graph_02)} ')
	//print('\n New graph:  ${remove_node_from_graph ('H', graph_02)} ')
    
    print('\n Remove Node -> New graph:  ${remove_node_from_graph ('A', graph_02)} ')
	print('\n Remove Node -> New graph:  ${remove_node_from_graph ('H', graph_02)} ')

	/*
	print('\n Degree of this map:  ${in_degree (graph_01)}')
	print('\n Degree of this map:  ${in_degree (graph_02)}')
	print('\n Query 01:  ${who_is_father_node ('F' , graph)}')
	print('\n Query 02:  ${who_is_father_node ('X' , graph)}')
	print('\n Query 03:  ${all_fathers ('B' , graph)}')
	print('\n Query 04:  ${all_fathers ('X' , graph)}')
*/
	println('\n BYE')
}	
/************************************************************************/