// import datatypes

fn main() {

// start: 'A', target: 'E' for example
	graph := {
		'A': ['B', 'C']
		'B': ['A', 'D', 'E']
		'C': ['A', 'F']
		'D': ['B']
		'E': ['F', 'B', 'F']
		'F': ['C', 'E']
	}

	graph_03 := {
		'5': ['3', '7']
		'3': ['2', '4']
		'7': ['8']
		'2': []
		'4': ['8']
		'8': []
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
	mut list := dfs(mut visited, graph, 'A', 'E')
	println(list)
	//list.clear()
    empty := []string{}
    list = empty.clone()
	//:= clean_list_compiled(mut list)
	list = dfs(mut visited, graph_03, '5', '8')
	println(list)
}

// 'target string' is not used in the recursion. 
// I only wanted to share something that works, not an optimized code
fn dfs(mut visited []string, graph map[string][]string, node string, target string) []string {
	if !visited.contains(node) {
		// println(node) 
		visited << node
		mut arr := graph[node]
		arr.sort()  //only needed if the map values are not in ascending order
		for n in arr {
			dfs(mut visited, graph, n, target)
		}
	}
	return  generate(visited, target)
}

fn generate(arr []string, target string) []string {
	idx := arr.index(target)
	return arr[0..idx+1]
}

/*
fn clean_list_compiled(mut arr []string) {
	idx := arr.len
	//print('OK....${arr} size ${idx} \n' )
	arr.delete_many(0, idx)
	//print('OK ==>${arr} ' )
	return arr // but when returns ...
}
*/


// Initially, I used 'set' as in the link I shared with you. 
// But I couldn't create an array from a set, to use for the indexing

/* fn dfs(mut visited datatypes.Set[string], graph map[string][]string, node string) {
	if !visited.exists(node) {
		println(node)
		visited.add(node)
		for n in graph[node] {
			dfs(mut visited, graph, n)
		}
	}
} */