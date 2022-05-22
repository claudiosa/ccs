/*** a queue with priority based in 
JUST BASED
https://www.geeksforgeeks.org/priority-queue-using-linked-list/
author: ccs
TO DO: use Binary Heap to implment a Priority Queue
*/
struct Node {
	mut : 
   	data int 
    priority int // Lower values priority indicate ==> higher priority
} 

// Function to push according to priority ... the lower priority is goes ahead
//fn push (mut prior_queue [] Node, data int , priority int ) [] Node {
// do a push always sorted
//fn push<T> (mut prior_queue [] T , data int , priority int ) [] Node {	
fn push_pq <T> (mut prior_queue [] T , data int , priority int ) {		
  // mut temp := []Node{}
  mut temp := []T{}
   //temp = prior_queue.clone()
  // temp <<  Node{data , priority}
	lenght_pq := prior_queue.len

	mut i := 0
	// finding the right place for the insertion -- always ordered in according
	// with priority
	// if lenght_pq == 0 ... it jumps this loop and insert 
    for (i < lenght_pq ) && (priority > prior_queue[i].priority){
	// i in 0..(lenght_pq-1) {
    	temp << prior_queue[i]
		i++
	 }
	// INSERTING SORTED
	temp << Node{data , priority} // do the copy in the right place
	// copy the another part (tail) of original prior_queue 
	for i < lenght_pq {
    	temp <<  prior_queue[i]
		i++
	}
    // HOW TO IMPROVE THIS RETURN BY REFERENCE???
    prior_queue = temp.clone()
	// IS IT THE RIGHT WAY?
 	
}

// change the priority of a value ... exitent in pa
fn updating_priority <T> (mut prior_queue [] T , search_data int , NEW_priority int ) {		
  mut i := 0
  mut lenght_pq := prior_queue.len
  
  for i < lenght_pq {
	if search_data == prior_queue[i].data
   	{
	 prior_queue[i] = Node{search_data , NEW_priority} // do the copy in the right place	
	 break
	} 
    i++ //
	if  i >= lenght_pq // all the list was examined
   	{
	 print('\n This data ${search_data} does exist ...\n')
	 exit(1) // panic(s string)
	} 
	}
}

fn departure_priority <T> (mut prior_queue [] T  ) int {		
	mut x:= prior_queue[0].data
    prior_queue.delete(0) // or .delete_many(0, 1 )
	return x
}




fn main() {
/*
 mut x1 := Node{ 11, 22 }
 print('\n data queue: ${x1.data}')
 print('\n priority queue: ${x1.priority}')//print(x1.priority)
*/
mut a_queue := []Node{}
// inserting a first element
print('\n After ALL: ${a_queue} --> ${a_queue.len}')
push_pq(mut a_queue , 13 , 44)
print('\n Before the push queue: ${a_queue} --> ${a_queue.len}')
//push_pq(mut a_queue , 3 , 44)
//a_queue.delete(0)
updating_priority(mut a_queue, 13, 4)

print('\n a departure ${departure_priority(mut a_queue)}')
//a_queue.delete(0) // V does not support a exclusion of empty
print('\n After 1 deletes: ${a_queue} --> ${a_queue.len}')
//updating_priority(mut a_queue, 9999, 4)
//print('\n Inexist data: ${a_queue} --> ${a_queue.len}')
/*  
push_pq(mut a_queue, 77, 88)
print('\n Before the push queue: ${a_queue} --> ${a_queue.len}')
push_pq(mut a_queue, 12, 11)
print('\n Before a new  push queue: ${a_queue} --> ${a_queue.len}')
push_pq(mut a_queue, 11, 11)
print('\n Before a new  push queue: ${a_queue} --> ${a_queue.len}')

a_queue.delete_many(0, 1 ) // a_queue.delete(0)
a_queue.delete(0)
print('\n After 2 delete queue: ${a_queue} --> ${a_queue.len}')

a_queue.clear()
print('\n After ALL clear: ${a_queue}\n ')
*/
}
/*
BUG YET

>>> mut x:= [1,2]
>>> x.delete(0)
>>> print(x)
[1, 2]
>>> x.delete_many(0,1)
>>> print(x)
[1, 2]
>>> 

*/