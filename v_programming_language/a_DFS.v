//   NOT READY YET
// Depth-First Search (BFS) allows you to ﬁnd a path between two nodes in the graph.
// I  follow literally code in C, done many years ago

fn depth_first_search_path(graph map[string][]string, start string, target string) []string 
 {
	mut path := []string{} // ONE PATH with SUCCESS = array
	mut stack := []string{} // a stack ... many paths
	//all_nodes := graph.keys() // get a key of this map
	n_nodes := graph.len // numbers of nodes of this graph
	mut visited := a_map_nodes_bool (n_nodes) // a map fully
	//false ... not visited yet: {'A': false, 'B': false, 'C': false, 'D': false, 'E': false}
	
	stack.prepend(start) // first arrival .... prepend = PUSH on the stack
	for (stack.len != 0) // or stack.len > 0
	{
       mut node := get_from_top( mut stack ) // get the front node and remove it
	  
	   if  visited[ node ] == false
		{// check if this node is already visited
		  // if no ... test it searchinf for a final node
		  visited[node] = true // means: visit this node
		  if node == target {
		    path = build_path_reverse(graph, start, node, visited)
			return path
		}
	// expansion of node removed from  stack
	print("\n Expansion of node ${node} (true/false): ${graph[node]}")
	for vertex in graph[node]  // take  all nodes from the node
		{
		  //println("\n ...${vertex}")	
          if visited[vertex] == false // not explored yet
		  {
           stack.prepend( vertex )
		  }
		}
		print("\n stack: ${stack} (only not visited) \n Visited: ${visited}")
		}
	} 
	path = ['Path not found, problem in the Graph, start or end nodes! ']
	return path
}

fn main() {
// Adjacency matrix as a map	
	graph := {
		'A': ['B', 'C']
		'B': ['A', 'D'] //, 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['F']      //['B', 'F']
		'F': ['C', 'E']
	}
	println('Graph: $graph')
	path := depth_first_search_path(graph, 'A', 'D')
	println('\n A first path from node A to node F is: ${path.reverse()}')
}
//////////// AUX FUNCTIONS //////////////////
// Creating a map for VISITED nodes ... 
// starting by false ===> means this node 
// was not visited yet
fn a_map_nodes_bool (size int)  map [string]  bool {
	mut my_map := map [string] bool {} // look this map ...
	base := 65
	mut	key := byte(base).ascii_str()
	for i in 0 .. size {
		key = byte(base+i).ascii_str()
		my_map[key] = false  
	}
   	return my_map
 }

// classical a departure node  from stack

fn get_from_top(mut a_stack [] string) string{
   mut x := a_stack.first() //a.first() equivalent to a[0]
   //REMOVE IT
   a_stack.delete(0) // del x in the position 0
   return x
}

// Based in the current node that is final,
// search for his father, already visited, up to the root or
// start node
fn build_path_reverse(graph map[string][]string, start string, final string, visited map [string] bool) []string {

print("\n\n Nodes visited (true) or no (false): ${visited}")
array_of_nodes := graph.keys()   
mut current := final
mut path := []string {}
path << current

for ( current != start)
{
  	for i in array_of_nodes 
	{
	 if (current in graph[i]) && (visited[i]==true)
	   { current = i
		 break // the first ocurrence is enough
	   }
	}
 path << current //update the path tracked
}
return path
}

/*
$ v run another_BFS.v 
Graph: {'A': ['B', 'C'], 'B': ['A', 'D', 'E'], 'C': ['A', 'F'], 'D': ['B'], 'E': ['B', 'F'], 'F': ['C', 'E']}

 Expansion of node A (true/false): ['B', 'C']
 stack: ['B', 'C'] (only not visited) 
 Visited: {'A': true, 'B': false, 'C': false, 'D': false, 'E': false, 'F': false}
 Expansion of node B (true/false): ['A', 'D', 'E']
 stack: ['C', 'D', 'E'] (only not visited) 
 Visited: {'A': true, 'B': true, 'C': false, 'D': false, 'E': false, 'F': false}
 Expansion of node C (true/false): ['A', 'F']
 stack: ['D', 'E', 'F'] (only not visited) 
 Visited: {'A': true, 'B': true, 'C': true, 'D': false, 'E': false, 'F': false}
 Expansion of node D (true/false): ['B']
 stack: ['E', 'F'] (only not visited) 
 Visited: {'A': true, 'B': true, 'C': true, 'D': true, 'E': false, 'F': false}
 Expansion of node E (true/false): ['B', 'F']
 stack: ['F', 'F'] (only not visited) 
 Visited: {'A': true, 'B': true, 'C': true, 'D': true, 'E': true, 'F': false}

 Nodes visited (true) or no (false): {'A': true, 'B': true, 'C': true, 'D': true, 'E': true, 'F': true}
 The shortest path from node A to node F is: ['A', 'C', 'F']
[ccs@vosges v_programming_language]$ 



SOME TESTS
>>> mut stack := []int{}
>>> stack << [2]
>>> stack << [21,45,67]
>>> print(stack)
[2, 21, 45, 67]
>>> mut x := stack[0]
>>> print(x)
21
>>> stack << [77]
>>> print(stack)
[21, 45, 67, 77]

>>> println(graph['F'])
['C', 'E']
 
 
 
 */

