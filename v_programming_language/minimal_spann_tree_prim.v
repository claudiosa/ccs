/*
Exploring  Dijkstra,
The data example is from
https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/


by CCS


PS: all the pre-requisites of Dijkstra are considered

$ v   run file_name.v 
// Creating a executable
$ v  run file_name.v  -o an_executable.EXE
$ ./an_executable.EXE 

Code based from : Data Structures and Algorithms Made Easy: Data Structures and Algorithmic Puzzles, Fifth Edition (English Edition) 
pseudo code written in C
This idea is quite different: it uses a priority queue to store the current
shortest path evaluted
The priority queue structure built using a list to simulate 
the queue. A heap is not used in this case.
*/

// a structure
struct NODE {
	mut : 
   	data int 
    priority int // Lower values priority indicate ==> higher priority
} 

// Function to push according to priority ... the lower priority is goes ahead
// The "push" always sorted in pq
fn push_pq <T> (mut prior_queue [] T , data int , priority int ) {		
  mut temp := []T{}
  lenght_pq := prior_queue.len

   mut i := 0
   for (i < lenght_pq ) && (priority > prior_queue[i].priority){
	   	temp << prior_queue[i]
		i++
	}
	// INSERTING SORTED in the queue
	temp << NODE{data , priority} // do the copy in the right place
	// copy the another part (tail) of original prior_queue 
	for i < lenght_pq {
    	temp <<  prior_queue[i]
		i++
	}
    prior_queue = temp.clone() //I am not sure if it the right way
	// IS IT THE RIGHT WAY?
}

// Change the priority of a value/node ... exist a value, change its priority
fn updating_priority <T> (mut prior_queue [] T , search_data int , NEW_priority int ) {		
  mut i := 0
  mut lenght_pq := prior_queue.len
  
  for i < lenght_pq {
	if search_data == prior_queue[i].data
   	{
	 prior_queue[i] = NODE{search_data , NEW_priority} // do the copy in the right place	
	 break
	} 
    i++ 
	if  i >= lenght_pq // all the list was examined
   	{
	 print('\n This data ${search_data} does exist ... PRIORITY QUEUE problem\n')
	 exit(1) // panic(s string)
	} 
  } //end for
}

// a single departure or remove from queue
fn departure_priority <T> (mut prior_queue [] T  ) int {		
	mut x:= prior_queue[0].data
    prior_queue.delete(0) // or .delete_many(0, 1 )
	return x
}

// give a NODE v, return a list with all adjacents
// Take care, only positive EDGES
fn all_adjacents <T> ( g [][] T, v int ) [] int{
	mut temp := [] int {} // 
	for i in 0..(g.len)
	{
		if g[v][i] > 0 {
		 temp << i	
		}
	}
   return temp
}

// print the costs from origin up to all nodes
fn print_solution  (path [] int , g [][] int ) {
    print('\n Edge \t Weight\n')
    for node in 1 .. (path.len){
     print('\n ${path[node]} -- ${node}  \t ${g[node][path[node]]}')
    }
}
/*
// A utility function to print the
// constructed MST stored in parent[]
void printMST(int parent[], int graph[V][V])
{
    cout<<"Edge \tWeight\n";
    for (int i = 1; i < V; i++)
        cout<<parent[i]<<" - "<<i<<" \t"<<graph[i][parent[i]]<<" \n";
}
*/

//print all  paths and their cost or weight
fn print_paths_dist <T>  (path [] T, dist [] T) {
    print('\n\n Read the nodes from right to left (EDGES): \n')
	
      for node in 1 ..(path.len){
		  print('\n ${node} ')
		  mut i := node
		  for path[i] != -1 {
			print(' <=> ${path[i]} ')
			i = path[i]
       }
	   print('\t Weight: ${dist[node]}')
  
}
}

//check structure from: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
// s: source for all nodes
// Two results are obtained ... cost and paths
fn prim_mst( g[][] int , s int) {
 	mut pq_queue := []NODE{} // creating a priority queue
	push_pq(mut pq_queue, s, 0) // goes s with priority 0
    mut n := g.len 

    mut dist := []int{len: n , init:-1} // dist with -1 instead of INIFINITY
	mut path := []int{len: n , init:-1} // previous node of each shortest paht
	
	// Distance of source vertex from itself is always 0
	dist[s] = 0
	    
	for pq_queue.len != 0 {
		mut v := departure_priority(mut pq_queue)
		//for all W adjcents vertices of v 
		mut adjs_of_v := all_adjacents(g, v) // all_ADJ of v ....
		//print('\n ADJ ${v} is ${adjs_of_v}')
		mut new_dist := 0
		for w in adjs_of_v {
			new_dist =  g[v][w]
			if dist[w] == -1 {
				dist[w] = new_dist
				push_pq(mut pq_queue, w, dist[w])
				path[w] = v // collecting the previous node -- lowest weight
			}
			if dist[w] > new_dist {
			   dist[w] = new_dist
			   updating_priority(mut pq_queue, w, dist[w])
			   path[w] = v //
			}
		}
	}		

// print the constructed distance array
	//print('\n \n Previous node of shortest path: ${path}')
	print_paths_dist(path , dist)
	print_solution(path, g)
}//end function

/*
Solution Expected graph_02
Edge   Weight
0 - 1    2
1 - 2    3
0 - 3    6
1 - 4    5
*/

fn main() {
//adjacency matrix = cost or weight
/*
    graph_01 := [
		   [0, 4, 0, 0, 0, 0, 0, 8, 0],
           [4, 0, 8, 0, 0, 0, 0, 11, 0],
           [0, 8, 0, 7, 0, 4, 0, 0, 2],
           [0, 0, 7, 0, 9, 14, 0, 0, 0],
           [0, 0, 0, 9, 0, 10, 0, 0, 0],
           [0, 0, 4, 14, 10, 0, 2, 0, 0],
           [0, 0, 0, 0, 0, 2, 0, 1, 6],
           [8, 11, 0, 0, 0, 0, 1, 0, 7],
           [0, 0, 2, 0, 0, 0, 6, 7, 0]
		   ]

*/
//g = Graph(5)
graph_02 := [ 
	[0, 2, 0, 6, 0],
    [2, 0, 3, 8, 5],
    [0, 3, 0, 0, 7],
    [6, 8, 0, 0, 9],
    [0, 5, 7, 9, 0]
	]
/* The graph:
        2    3
    (0)--(1)--(2)
    | / \ |
    6| 8/ \5 |7
    | / \ |
    (3)-------(4)
         9     
*/
//g.primMST();

	// to find number of coluns
	//mut cols := an_array[0].len 

	prim_mst(graph_02, 0)
	println('\n BYE -- OK')
	
}

/************************************************************************/