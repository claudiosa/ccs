import rand

/*
Exploring arrays and randon numbers

by CCS
$ v   run array01_study.v 
// Creating a executable
$ v   run array01_study.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/
//

fn main() {	
	ten  := 10
	mut an_array := ["brazil","argentina","uruguay", "chile"]
	mut size := an_array.len
    mut a_rnd_number := fn_positive_rnd(size)
    for _ in 1 .. ten
	{
	print('\n A random index is: ${a_rnd_number} the country selected is: ${an_array[a_rnd_number] } ' )
    a_rnd_number = fn_positive_rnd(size) // you can add a time here or get from cpu time
	}
	print('\n All array: ${ an_array }'  )
	println('\n BYE')
	
}
// a positive random from 0 to (size-1)
// a function, I can not find the abs function until now
fn fn_positive_rnd(size int) int {
	mut a_rnd_number :=	(rand.int() % size)
	if (a_rnd_number < 0)
	{ return(a_rnd_number * (-1))
	}
	return a_rnd_number
}

/************************************************************************/