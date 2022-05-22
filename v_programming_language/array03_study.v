/*
Exploring arrays 2D

by CCS
$ v   run file_name.v 
// Creating a executable
$ v  run file_name.v  -o an_executable.EXE
$ ./an_executable.EXE 
*/
//

fn main() {	
    mut an_array := [[6,7,8],[16,17,18]] //[][]int{len: 2, init: []int{len: 3}}
	mut lins := an_array.len 
	mut cols := an_array[0].len 

	for i in 0..lins {
		for j in 0..cols {
			print('  ${an_array[i][j]}' )
		}
		print('\n')
	}

	print('\n Array : ${ an_array }'  )
	print('\n Array : ${ an_array.len }'  )
	print('\n Array : ${ an_array[0].len }'  )
	print('\n Array : ${ an_array[1].len }'  )
	//print('\n Array : ${ an_array[2].len }'  )
	println('\n BYE')
	
}



/************************************************************************/