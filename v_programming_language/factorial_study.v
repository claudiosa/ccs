
// >.\v run examples\my_factorial.v
// by CCS
/*

C:\Users\Usuario\Downloads\v>.\v run examples\my_factorial.v
Fatorial of 0 is : 1
Fatorial of 1 is : 1
Fatorial of 2 is : 2
Fatorial of 3 is : 6
Fatorial of 4 is : 24
*/

fn factorial(n int) int {
	mut fact := 1
	if n >= 2
	{
	for i in 2 .. n+1
		{
		  fact = fact * i	
		  // println(' ..... ${fact} ' )
		}
	//return (fact)
	}


	if n < 0
	{
		println('Factorial must be a positive number')
	}	
	return (fact)
}

fn main() {
	for i in 0 .. 5
		{
		println('Fatorial of ${i} is : ${factorial(i)}' )
		}
}
