import rand
import math    // for abs

/*
Exploring maps and functions

by CCS
$ v  run maps_study.v 
// Creating a executable
$ v  maps_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/

//
fn my_hello () { println("\n Hello World!!!") }

// an array in the argument
fn my_ugly_sum (an_array[] int) int {
	mut n := an_array.len
	mut s := 0
	for i in 0 .. n {
		s +=  an_array[i] // shorted notation
	}
	return s
}

//RANDOM POSITIVE from intn
fn my_rand_pos (MAX int) ? int {
 	return rand.intn(MAX)  
}


//creating_a_map
fn creating_a_map (size i16)  map [string]  i32 {
	mut my_map := map [string] i32 {} 
	mut the_a := "a"
	mut the_b := "b"
	mut key := "a"
	//mut a_value := math.abs(rand.i16()  % 69) //[ rand.intn(size)  ? ]
	mut a_value := ( my_rand_pos (79) )
	//print("\n .... ${a_value}")

	for _ in 0 .. size {
		//my_map[key] = math.abs(rand.i16()  % 128)  // a random from -128 ... 127
		//my_map[key] = rand.i64() % 128   // a random from -128 ... 127 
		//my_map[key] =  i32(rand.intn(size)) //?}  UNCOMPLETE
		my_map[key] = a_value  //math.abs(rand.i16()  % size)  
		key = key + the_b + the_a // concat string
		a_value = ( my_rand_pos (79) )
		//a_value = math.abs(rand.i16()  % 69) //new random
	}
    // print('\n My map in the function: ${my_map}' )
	return my_map
 }

// receving and printing a map
fn printing_a_map ( my_map map [string] i32)  {
	mut array_of_keys := my_map.keys()
	// println(m.keys()) // ['one', 'two']
	println("\n Printing a map:")
	for i in array_of_keys {
	  print('\n the key: [${i}] has the contents: ${my_map[i]} ' )
	}
	//print('\n My map in the function: ${array_of_keys}' )
 }



fn main() {	
    // mut my_map := map [string] int{} OK
	// mut my_map := map [string] i16{} //OK
	print('\n Creating map from a function: ${creating_a_map(10)}' )
	
	printing_a_map( creating_a_map(7) )
    my_hello() 
	print('\n The ugly sum: ${ my_ugly_sum([4,5,6,7,8,9]) }'  )
	mut my_map_2 := map [string] i16{} //OK
	my_map_2['a'] = 1
	my_map_2['b'] = 2
	print('\n MY map: ${my_map_2}')

	println('\n BYE')
	
}

/************************************************************************/