
import datatypes {Stack}

struct Array_of_Stack[T]{
  pub mut:
    v_stack [] Stack [T]
 }

fn main() {
/* 
see the lib of V
struct Stack[T] {
mut:
	elements []T
}
*/

 mut test := Stack[u8]{}
 mut test2 := Stack[string]{}
 mut test3 := Stack[rune]{}
 mut test4 := [12]Stack[rune]{} // an array of many stacks
 //mut test5 := [3]Stack[string]{} // an array of many stacks
 mut test5 := Array_of_Stack[rune]{} // an array of many stacks
 test.elements << 432
 test2.elements << 'A' // a string
 test3.push(`A`) // it is a rune .... 
 test4[0].push(`A`)
 test4[0].push(`B`)
 test4[1].push(`C`)
 test4[1].push(`D`)
 /*
 test5[0].elements << 'A'
 test5[0].elements << 'B'
 test5[1].elements << 'C'
 test5[1].elements << 'D'
 */
 print('\n Type.... ${typeof(test5).name} INFO: ${typeof(test5).mod}')
 print('\n ${test} ==> ${test2} ==> ${test3.elements}')
 print('\n .... ${test4[0].elements} ..${test4[0]}.. ${test4.len}')
 //print('\n .... ${test5[0].elements} ..${test5[0]}.. ${test5.len}')
 
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
    a_stack.delete(0) // del x position
	return x
}

// FOR the FUTURE 
// fn push (mut a_stack [] int , value int) []?{}   {
//	a_stack.prepend(value)
//  mut new_stack := a_stack.clone()
//  return [] //new_stack
//}	

