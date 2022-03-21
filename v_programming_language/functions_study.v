module main // my_functions
/*
// by CCS

$ v  run functions_study.v
// Creating a executable
$ v  functions_study.v -o an_executable.EXE
$ ./an_executable.EXE 

Call f1 with 1=> : 4
Call f2 with 1=> : 2

*/
//import math

fn main()
{	
	for i in 1 .. 5
		{
		print('\nCall f1 with ${i}=> : ${f1(i)}' )
		println('\nCall f2 with ${i}=> : ${f2(i)}' )
		for _ in 0 .. 25   //
			{
				print('=')
			}
		}
println('\n BYE')
}
// f1 call f2
fn f1 (n i16) i16
{
	mut temp := f2(n)  // no type in temp
	return(temp*temp)
}


// single +1
fn f2 (n i16) i16
{
	return(n+1)
}
