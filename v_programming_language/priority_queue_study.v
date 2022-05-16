/*** a queue with priority based in 
https://www.geeksforgeeks.org/priority-queue-using-linked-list/
author: ccs
TO DO: Binary Heap 
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
fn push_pq<T> (mut prior_queue [] T , data int , priority int ) {		
  // mut temp := []Node{}
  mut temp := []T{}
   //temp = prior_queue.clone()
    // temp <<  Node{data , priority}
	lenght_q := prior_queue.len

    if  lenght_q == 0 {
		//temp  << Node{data , priority}
		prior_queue <<  Node{data , priority}
		//return( temp )
	}
	else{
	mut i := 0
	// finding the right place for the insertion -- always ordered in according
	// with priority
    for (i < lenght_q ) && (priority > prior_queue[i].priority){
	//i in 0..(lenght_q-1) {
    	temp << prior_queue[i]
		i++
	}
	
	temp << Node{data , priority} // do the copy in the right place
	// copy the another part or prior_queue
	for i < lenght_q {
    	temp <<  prior_queue[i]
		i++
	}

    prior_queue = temp.clone()
 //return temp
	}
}

fn main() {

 mut x1 := Node{ 11, 22 }
 print('\n data queue: ${x1.data}')
 print('\n priority queue: ${x1.priority}')//print(x1.priority)

mut a_queue := []Node{}
// inserting a first element

push_pq(mut a_queue , 3 , 44)
push_pq(mut a_queue , 33 , 44)

print('\n All queue: ${a_queue}')

//print('\n TOP data queue: ${a_queue[0].data}')
//print('\n TOP queue: ${a_queue[0].priority} --> ${a_queue.len}')
  
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

}
