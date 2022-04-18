
/*
Exploring maps and functions

by CCS
$ v  run maps02_study.v 
// Creating a executable
$ v  maps02_study.v  -o an_executable.EXE
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

// return the FIRST father found it
fn who_is_father_node (node string  , a_map map [string] [] string ) string {
	mut array_of_keys := a_map.keys()
	for i in array_of_keys 
	 {
	   if node in a_map[i]
	   { //print("\t ... ")
		 return i
	   }
	 }
	 return 'THIS NODE HAS NOT A FATHER'
	}

// Give a node, return a list with all nodes incidents or fathers of this node
fn all_fathers (node string , a_map map [string] [] string ) [] string   {
	mut array_of_keys := a_map.keys() // get a key of this map
	mut all_roots := []string{}
	for i in array_of_keys 
	 {
	   if node in a_map[i]   // in : function
	   { 
		 all_roots << i  // a queue of this search
	   }
	 }
	 return all_roots
	}


fn main() {	
// A map illustration to use in a graph
// adjacency matrix
	graph := {
		'A': ['B', 'C']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['B', 'F']
		'F': ['C', 'E']
	}

    printing_a_map(graph)
	print('\n Query 01:  ${who_is_father_node ('F' , graph)}')
	print('\n Query 02:  ${who_is_father_node ('X' , graph)}')
	print('\n Query 03:  ${all_fathers ('B' , graph)}')
	print('\n Query 04:  ${all_fathers ('X' , graph)}')

	println('\n BYE')
	
/************************************************************************/