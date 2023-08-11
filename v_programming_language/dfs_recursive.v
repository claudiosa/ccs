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

https://favtutor.com/blogs/depth-first-search-python#:~:text=The%20Depth-First%20Search%20is,if%20potential%2C%20else%20by%20backtracking.
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

	// Example 03
	graph_03 := {
		'5': ['3', '7']
		'3': ['2', '4']
		'7': ['8']
		'2': []
		'4': ['8']
		'8': []
	}

	// println('Graph: $graph')
	mut visited := visited_init(graph_01) // a map fully with false in all vertex
	// false ... not visited yet: {'A': false, 'B': false, 'C': false, 'D': false, 'E': false}
	dfs_recursive(mut visited, graph_01, 'A', 'E')

	visited = visited_init(graph_02) // a map fully with false in all vertex
	dfs_recursive(mut visited, graph_02, 'A', 'H')

	visited = visited_init(graph_03) // a map fully with false in all vertex
	dfs_recursive(mut visited, graph_03, '5', '8')
}

// Depth-First Search (BFS) allows you to find a path between two nodes in the graph.
fn dfs_recursive(mut visited map[string]bool, graph map[string][]string, current string, target string) {
	if visited[current] == false {
		visited[current] = true
		// print('\t Visiting: ${current} ')
		print(' => ${current} ||')
		if current == target {
			print('\n The node target was found:  ${target} \n')
			// exit(1)
		}
	}
	// mut adjacent_nodes_not_visited := [] string {}
	adjacent_nodes_not_visited := neighbours_not_visited(graph, current, visited)
	//	neighbours or adjacent nodes NOT VISITED ... with true

	for node in adjacent_nodes_not_visited {
		dfs_recursive(mut visited, graph, node, target)
	}
}

// END of recursive DFS

fn neighbours_not_visited(a_graph map[string][]string, current string, visited map[string]bool) []string {
	mut not_visited := []string{} // [type ] string with empty
	all_adjacents := a_graph[current] // all nodes adjacents from current node because it is map
	// print('\n => Adjacents of ${current} \t and ${all_adjacents}')
	for node in all_adjacents {
		if visited[node] == false {
			not_visited.insert(0, node)
		}
	}
	// pre-order of dfs ... reverse()
	return not_visited.reverse()
}

// Creating a map to initialize with of visited nodes .... all with false in the init
// so these nodes are NOT VISITED YET
fn visited_init(a_graph map[string][]string) map[string]bool {
	array_of_nodes := a_graph.keys() // get all keys of this map ... NODES in this case
	mut visited_array := map[string]bool{} // attention in these initializations with maps
	for node in array_of_nodes {
		visited_array[node] = false
	}
	return visited_array
}

//*****************************************************
