/*
Exploring  Dijkstra,
https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
by CCS
Dijkstra's single
source shortest path algorithm. The program is
for adjacency matrix representation of the graph
$ v   run file_name.v 
// Creating a executable
$ v  run file_name.v  -o an_executable.EXE
$ ./an_executable.EXE 

Code based from : Data Structures and Algorithms Made Easy: Data Structures and Algorithmic Puzzles, Fifth Edition (English Edition) 
pseudo code written in C
This idea is quite different: it uses a priority queue to store the current
shortest path evaluted
*/

struct NODE {
	mut : 
   	data int 
    priority int // Lower values priority indicate ==> higher priority
} 

// Function to push according to priority ... the lower priority is goes ahead
// do a push always sorted
//fn push<T> (mut prior_queue [] T , data int , priority int ) [] NODE {	
fn push_pq <T> (mut prior_queue [] T , data int , priority int ) {		
  mut temp := []T{}
  lenght_pq := prior_queue.len

   mut i := 0
   for (i < lenght_pq ) && (priority > prior_queue[i].priority){
	   	temp << prior_queue[i]
		i++
	 }
	// INSERTING SORTED
	temp << NODE{data , priority} // do the copy in the right place
	// copy the another part (tail) of original prior_queue 
	for i < lenght_pq {
    	temp <<  prior_queue[i]
		i++
	}
    prior_queue = temp.clone() //I am not sure if it the right way
	// IS IT THE RIGHT WAY?
}

// change the priority of a value ... exist a value, change its priority
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
	 print('\n This data ${search_data} does exist ...\n')
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

fn print_solution <T>  (dist [] T) {
    print('Vertex \tDistance from Source')
      for node in 0 ..(dist.len){
        print('\n ${node} \t ${dist[node]}')
       }
}



//check structure from: https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/

fn dijkstra( g[][] int , s int) {
 	mut pq_queue := []NODE{} // creating a priority queue
	push_pq(mut pq_queue, s, 0) // goes s with priority 0
    mut n := g.len 

    mut dist := []int{len: n , init:-1} // dist with -1 instead of INIFINITY
	// Distance of source vertex from itself is always 0
	dist[s] = 0
	    
	for pq_queue.len != 0 {
		mut v := departure_priority(mut pq_queue)
		//for all w adjcents vertices of v 
		mut adjs_of_v := all_adjacents(g, v) // all_ADJ of v ....
		//print('\n ADJ ${v} is ${adjs_of_v}')
		for w in adjs_of_v {
			mut new_dist := dist[v] + g[v][w]
			if dist[w] == -1 {
				dist[w] = new_dist
				push_pq(mut pq_queue, w, dist[w])
				//
			}
			if dist[w] > new_dist {
			   dist[w] = new_dist
			   updating_priority(mut pq_queue, w, dist[w])
			   //
			}
		}
	}		

// print the constructed distance array
    print_solution(dist)
	//print(dist)
}//end function

/*
Solution Expected
Vertex   Distance from Source
0                0
1                4
2                12
3                19
4                21
5                11
6                9
7                8
8                14
*/

fn main() {
//adjacency matrix = cost or weight
    graph := [
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

	// to find number of coluns
	//mut cols := an_array[0].len 

	dijkstra(graph, 0)
	println('\n BYE -- OK')
	
}

/************************************************************************/