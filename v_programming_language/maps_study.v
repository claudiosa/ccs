/*
by CCS

$ v  run functions_study.v
// Creating a executable
$ v  functions_study.v -o an_executable.EXE
$ ./an_executable.EXE 
*/

fn my_hello () { println("\n Hello World!!!") }

fn my_ugly_sum (an_array[] int) int {
	mut n := an_array.len
	mut s := 0
	for i in 0 .. n {
		s = s + an_array[i]
	}
	return s
}

	
fn creating_a_map (size int) [  ] string {}   i16  {
	
	my_map := map[  ] string {} i16
	mut temp := 'b'
	mut key := 'a'

	for _ in 1 .. size {
		my_map[key] = size+100
		temp = key + temp
		key = temp
	}
    print('\n My map in the function: ${my_map}' )
	return my_map
	
 }
  
  
fn main() {	
	// print('\n MY map: ${creating_a_map(10)}' )
	// mut my_map := map [string] int{} OK
	// mut my_map := map [string] i16{} //OK
    my_hello() 
	print('\n The ugly sum: ${ my_ugly_sum([4,5,6,7,8,9]) }'  )
	mut my_map2 := map [string] i16{} //OK
	my_map2['a'] = 1
	my_map2['b'] = 2
	print('\n MY map: ${my_map2}')
	println('\n BYE')
	}
/***********************************************/