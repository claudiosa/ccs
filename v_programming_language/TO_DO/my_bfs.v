// Breadth-First Search (BFS) allows you to ﬁnd the shortest distance between two nodes in the graph.
// Partially copied from ....
// I will follow literally my C code
fn breadth_first_search_path(graph map[string][]string, vertex string, target string) []string 
 {

	mut path := []string{}
	mut visited := []string{init: vertex}
	mut queue := [][][]string{}
	queue << [[vertex], path]

	}
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
	path := breadth_first_search_path(graph, 'A', 'F')
	println('The shortest path from node A to node F is: $path')
}
