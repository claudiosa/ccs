import rand

/*
Exploring arrays and randon numbers

by CCS
$ v   run array01_study.v 
// Creating a executable
$ v  run array01_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/
//

fn main() {	
	ten  := 10
	mut an_array := ["brazil","argentina","uruguay", "chile", "peru"]
	mut size := an_array.len
    //mut a_rnd_number := fn_positive_rnd(size)
	mut a_rnd_number := ( my_rand_pos (size) ) // (0,size]
    for _ in 1 .. ten
	{
	print('\n A random index is: ${a_rnd_number} the country selected is: ${an_array[a_rnd_number] } ' )
    a_rnd_number = ( my_rand_pos (size) ) //fn_positive_rnd(size) // you can add a time here or get from cpu time
	}
	print('\n All array: ${ an_array }'  )
	println('\n BYE')
	
}
// a positive random from 0 to (size-1)
// a function, I can not find the abs function until now
fn fn_positive_rnd(size int) int {
	mut a_rnd_number :=	(rand.int() % size)
	if a_rnd_number < 0 
	{
	 return(a_rnd_number * (-1))
	}
	return a_rnd_number
}

// a positive value up to (0 MAX]
fn my_rand_pos (MAX int) ? int {
 	return rand.intn(MAX)  
}

/************************************************************************/