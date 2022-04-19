



fn main() {
 
 mut a_stack := []int{}
 //INSERT or  push on the TOP
   a_stack.prepend(777)	
   a_stack.prepend(99)
   a_stack.prepend(11)
print("\n Value of Stack: : ${a_stack} ")
   
   //Get from the TOP
   mut x := a_stack.first() //a.first() equivalent to a[0]
   //REMOVE IT
   a_stack.delete(0) // del x position
   print("\n New value of stack: : ${a_stack} and ${x} ")
   a_stack.prepend ( 999 )
   print("\n New value of stack: : ${a_stack} and ${x} ")
   mut top := get_from_top(mut a_stack)
  print("\n New value of stack: ${a_stack} and top ${top} ")
  print('\n END \n' )
}

fn get_from_top(mut a_stack [] int) int{
     mut x := a_stack.first() //a.first() equivalent to a[0]
   //REMOVE IT
    a_stack.delete(0) // del x positio
	return x
}


// fn push (mut a_stack [] int , value int) []?{}   {
//	a_stack.prepend(value)
//  mut new_stack := a_stack.clone()
//  return [] //new_stack
//}	

