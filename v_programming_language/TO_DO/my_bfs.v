// Breadth-First Search (BFS) allows you to ﬁnd the shortest distance between two nodes in the graph.
// Partially copied from ....
// I will follow literally my C code
fn breadth_first_search_path(graph map[string][]string, start string, target string) []string 
 {
	mut path := []string{} //ONE PATH with SUCCESS = map
	mut queue := []string{} // a queue ... many paths
	//all_nodes := graph.keys() // get a key of this map
	n_nodes := graph.len // numbers of nodes

	mut visited := new_map_letters_to_bool (n_nodes) // a map fully
	//false ... not visited yet: {'A': false, 'B': false, 'C': false, 'D': false, 'E': false}
    path  << [start] // build a path
	//visited[start] = true // first visit
	queue << [start] // first arrival

   for (queue.len != 0) // or queue.len > 0
	{
        mut node := departure( mut queue ) // get the front node, but it not deleted
    
	    if  visited[ node ] == false
		{
          // check if this already visited
		  // if no ... test if is it a final node?
		  visited[node] = true
		  if node == target {
			path << node
			return path
		}
	// MISSING >>>> whereis the valid path????
    // expansion of node removed from  queue
	print("\n Expansion of node ${node} are (true/false): ${graph[node]}")
		for vertex in graph[node]  // take  all nodes from the node
		{
		  //println("\n ...${vertex}")	
          if visited[vertex] == false // not explored yet
		  {
           queue << vertex
		  }
      
		}
		  print("\n Status: Q: ${queue} (only not visited) \n V: ${visited}")

		}
		
	} 
	//[]string{init: vertex}
    
	return path
}

fn main() {
	graph := {
		'A': ['B', 'C']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['B', 'F']
		'F': ['C', 'E']
	}
	println('Graph: $graph')
	path := breadth_first_search_path(graph, 'A', 'D')
	println('\n The shortest path from node A to node F is: $path')
}

fn new_map_letters_to_bool (size int)  map [string]  bool {
	mut my_map := map [string] bool {} 
	base := 65
    mut	key := byte(base).ascii_str()
	for i in 0 .. size {
		key = byte(base+i).ascii_str()
		my_map[key] = false  
	}
   	return my_map
 }

fn departure (mut queue [] string ) string {
	mut x := queue[0]
    queue.delete(0)
	//print("\n a queue in the function ${queue}")
    return x
}

/*
>>> mut queue := []int{}
>>> queue << [2]
>>> queue << [21,45,67]
>>> print(queue)
[2, 21, 45, 67]
>>> mut x := queue[0]
>>> print(x)
21
>>> queue << [77]
>>> print(queue)
[21, 45, 67, 77]

>>> println(graph['F'])
['C', 'E']


 */