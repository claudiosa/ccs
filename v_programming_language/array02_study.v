/*
Exploring arrays and randon numbers

by CCS
$ v   run array02_study.v 
// Creating a executable
$ v  run array02_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/
//

fn main() {	
    mut any_map := new_map_letters_to_bool(05)
	print('\n A boolean map: ${ any_map }'  )
	print('\n An direct comparision: ${ any_map['A']==false }'  )
	print('\n the size: ${ any_map.len }'  ) //inner of struct from map definition
	
	println('\n BYE')
	
}

fn new_map_letters_to_bool (size int)  map [string]  bool {
	mut my_map := map [string] bool {} 
	base := 65
    mut	key := byte(base).ascii_str()
	for i in 0 .. size {
		key = byte(base+i).ascii_str()
		my_map[key] = false  
	}
    //print('\n My map in the function: ${my_map}' )
	return my_map
 }

/************************************************************************/