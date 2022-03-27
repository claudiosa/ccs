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
	test := [rand.i64_in_range(0,64) ?]
	println('A number: ${test}')
	print('Guessing what:  ${test} \n'  )
	println('A number: ${test[0]}')
	println('A number: ${rand.i64() % 69}')
	println('A number: ${rand.i64_in_range(0,64)}') // Option(.....)
	println('A number: ${rand.int_in_range(0,64)}') 
	println('A number: ${rand.int_in_range(0,an_array.len) ? }')
	println('A number: ${an_array[rand.intn(an_array.len) ? ]}')

    println('A string: ${rand.string_from_set({'a','b','c'}, 2) ?}' )


	println('\n BYE')
	
}

/************************************************************************/