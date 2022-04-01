import rand
//import crypto.rand
/*
Exploring maps and functions

by CCS
$ v  run maps_study.v 
// Creating a executable
$ v  maps_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/

fn main() {	
	an_array := ['check', 'whether', 'contains', 'an', 'element']
	test1 := [rand.i64_in_range(0,64) ?] // as an Option
	test2 := [ rand.intn(69) ?] // as an Option
	
	
	mut test3 := ( rand.intn(69) )      // ( ) as a function
	print('\nGuessing :  ${test3} '  )
	test3 = ( rand.intn(69) )
    print('\nGuessing again:  ${test3} '  )
	
	
	
	x := ( rand.i64_in_range(0,64) ) // as a function
	println('x: ${x}')
	
	//test3 := (rand.string_from_set({'ax': 'bx': 'cx': } , 2)  ?)
	
	println('A number: ${test1} and ${test2} and ${test3}')
	print('Guessing what:  ${test1} '  )
	println('A number: ${test1[0]} and ${test2[0]}')
	println('A number: ${rand.i64() % 69}')
	println('A number: ${rand.intn(69)}'  )
	println('A number: ${rand.i64_in_range(0,64)}') // Option(.....)
	println('A number: ${rand.int_in_range(0,64)}') 
	println('A number: ${rand.int_in_range(0,an_array.len) ? }')
	println('A number: ${an_array[rand.intn(an_array.len) ? ]}')

   /* println('A string: ${rand.string_from_set({'a','b','c'} , 2) ?}' )*/
    
	println('\n BYE')
	
}

/************************************************************************/