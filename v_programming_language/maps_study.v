/*
by CCS

$ v  run functions_study.v
// Creating a executable
$ v  functions_study.v -o an_executable.EXE
$ ./an_executable.EXE 

*/

fn creating_a_map (size int) [ ]i16{}
{
	mut my_map := map[string]i16{}
	mut temp := 'b'
	mut key := 'a'
	
	for _ in 1 .. size{
		my_map[key] = size+100
		temp = key + temp
		key = temp

	}
    print('\n My map in the function: ${my_map}')
	return my_map
}

fn main() {	
	// print('\n MY map: ${creating_a_map(10)}' )
	// mut my_map := map [string] int{} OK
	// mut my_map := map [string] i16{} //OK
   
	mut my_map := map [string] i16{} //OK
	my_map['a'] = 1
	my_map['b'] = 2
	print('\n MY map: ${my_map}')
	println('\n BYE')
}
/***********************************************/