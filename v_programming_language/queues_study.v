



fn main() {
 
 mut a_queue := []int{}
 a_queue << [2222] //a first arrival = push
 a_queue << [21,45,67]
 a_queue << [3333] //a last arrival = push
 print('\n Original queue: ${a_queue}')
 mut last := a_queue.pop() // remove the LAST element
 mut front := a_queue[0]  // get the first
 a_queue.delete(0) // remove it

 print("\n New value of queue: ${a_queue} 
 	and last: ${last} 
	and front: ${front}")

  print('\n A new departure: ${ departure(mut a_queue) }' )
  print('\n A new value of queue: ${a_queue} and lenght:  ${a_queue.len} \n' )
}

fn departure (mut queue [] int ) int {
	mut x := queue[0]
    queue.delete(0)
	//print("\n a queue in the function ${queue}")
    return x
}	

