// import datatypes

fn main() {

// start: 'A', target: 'E' for example
	graph := {
		'A': ['B','C'],
		'B': ['D','E'],
		'D': [],
		'E':['F']
		'C': ['F'],
		'F': [],
	}

// start: '5', target: '8' for example
/* 	graph := {
		'5': ['3','7'],
		'3': ['2','4'],
		'2': [],
		'4': ['8'],
		'8': [],
		'7': ['8'],
	} */


// start: '1', target: '6' for example
/* 	graph := {
		'1': ['2','3'],
		'2': ['4','5'],
		'3': ['6','7'],
		'4': [],
		'5': [],
		'6': [],
		'7': []
	} */

// start: '1', target: '7' for example
/* 	graph := {
		'1': ['2','4','5'],
		'2': ['3','6','7']
		'3': [],
		'5': [],
		'4': [],
		'6':[],
		'7':[]
	} */

	mut visited := []string{}
	list := dfs(mut visited, graph, 'A', 'E')
	println(list)
}


fn dfs(mut visited []string, graph map[string][]string, node string, target string) []string {
	// make the recursive call here. The call will return the whole DFS nodes.
	dfs_nodes := dfs_rec(mut visited, graph, node)
	// println(dfs_nodes)

	// then generate the path to the target node.
	return generate(dfs_nodes, target)	
}

fn dfs_rec(mut visited []string, graph map[string][]string, node string) []string {
	if !visited.contains(node) {
		visited << node
		mut arr := graph[node]
		// arr.sort()  only needed if the map values are not in ascending order
			for n in arr {
					dfs_rec(mut visited, graph, n)		
			}
	}
	return visited
}

fn generate(arr []string, target string) []string {
	idx := arr.index(target)
	return arr[0..idx+1]  // I am doing array slicing here. Check notes below
	// if we have, nums := [0, 10, 20, 30, 40], then
	// println(nums[0..4]) will return [0, 10, 20]. The 4 in 0..4 is not included
	// So after getting the idx in the generate function, we need to add 1 so that
	// we can get the target node.
}
