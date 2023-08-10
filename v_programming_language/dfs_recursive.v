// Recursive DFS 
/*
Depth-First-Search-Kickoff( Maze m )
    Depth-First-Search( m.StartCell )
End procedure

Depth-First-Search( MazeCell c )
    If c is the goal
        Exit
    Else
        Mark c "Visit In Progress"
        Foreach neighbor n of c
            If n "Unvisited"
                Depth-First-Search( n )
        Mark c "Visited"
End procedure

OR

procedure DFS(G, v) is
    label v as discovered
    for all directed edges from v to w that are in G.adjacentEdges(v) do
        if vertex w is not labeled as discovered then
            recursively call DFS(G, w)

OR


def dfs(visited, graph, node):  #function for dfs 
    if node not in visited:
        print (node)
        visited.add(node)
        for neighbour in graph[node]:
            dfs(visited, graph, neighbour)


*/
// Recursive DFS 
// Author: CCS
// I follow literally code in C, done many years ago

fn main() {
	// Adjacency matrix as a map	
	// Example 01
	graph_01 := {
		'A': ['B', 'E']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['F', 'B', 'F']
		'F': ['C', 'E']
	}
	// Example 02
	/*
	graph_02 := {
		'A': ['B', 'C', 'D']
		'B': ['E']
		'C': ['F']
		'D': ['E']
		'E': ['H']
		'F': ['H']
		'G': ['H']
		'H': ['E', 'F', 'G']
	}
	*/
	// println('Graph: $graph')
	mut visited := visited_init(graph_01) // a map fully with false in all vertex
	// false ... not visited yet: {'A': false, 'B': false, 'C': false, 'D': false, 'E': false}
	dfs_recursive(mut visited, graph_01, 'A', 'E')
	//println('\n Graph_01: a first path from node A to node F is: $path_01.reverse()')
	//path_02 := depth_first_search_path(graph_02, 'A', 'H')
	//println('\n Graph_02: a first path from node A to node F is: $path_02.reverse()')
}

// Depth-First Search (BFS) allows you to find a path between two nodes in the graph.
fn dfs_recursive(mut visited map [string] bool,   graph map[string][]string,  current string, target string)  {
	

	if visited[current] == false {
		visited[current] = true
		print('\n Visiting: ${current} \t Target: ${target}')
		if current == target 
		{ 
			print('\n FOUND IT')
			return 
		}
	}	
	mut adjacent_nodes_not_visited := []string{}
	adjacent_nodes_not_visited = neighbours_not_visited(graph, current, mut visited)
	//	neighbour or adjacentEdges
    //print('\n => Adjacents of ${current} \t are ${adjacent_nodes_not_visited }')
		
	for i in adjacent_nodes_not_visited {
		dfs_recursive(mut visited, graph, i, target )
	}
	
}	



fn neighbours_not_visited(any_graph map[string] [] string, current string,  mut visited map [string] bool ) [] string {
	
	mut not_visited := [] string {} // [type ] string with empty
	
	mut all_adj := any_graph[current]  // all adjacents from current because it is map
	//print('\n => Adjacents of ${current} \t and ${all_adj }')
	for i in all_adj {
		if visited[i] == false
		{
		 //not_visited << i
		 not_visited.insert(0, i)
		}
	}
	return not_visited.reverse()
}		




// Creating aa map to initialize with of visited nodes .... all with false in the init
// so these nodes are NOT VISITED YET
fn visited_init(a_graph map[string][]string ) map[string] bool {
	mut array_of_keys := a_graph.keys() // get all keys of this map
	mut temp := map[string] bool {} // attention in these initializations with maps
	for i in array_of_keys {
		temp[i] = false
	}
	return temp
}

// Based in the current node that is final, search for his parent, that is already visited, up to the root or start node
fn build_path_reverse(graph map[string][]string, start string, final string, visited map[string]bool) []string {
	print('\n\n Nodes visited (true) or no (false): $visited')
	array_of_nodes := graph.keys()
	mut current := final
	mut path := []string{}
	path << current

	for current != start {
		for i in array_of_nodes {
			if (current in graph[i]) && (visited[i] == true) {
				current = i
				break // the first ocurrence is enough
			}
		}
		path << current // updating the path tracked
	}
	return path
}
//*****************************************************
