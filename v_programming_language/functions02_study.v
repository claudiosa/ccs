/*
// by CCS

*/
//import math

fn main()
{  	mut x := 10
   	mut y := [10,20,30]
   	mut letters := ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'] 

	
	for i in 1 .. 5
		{
		x = f1( x + i ) 	
		print(' Modify x in the function  with ${i} => : ${x} \n' )
		}
		
	   print('\n Call an array and modify it : ${f2( y )} \n' )
       f3( letters ) /// call it alone
	   
	   mut v_bool := []bool{len: 3,  init: false}
	   print('\n Vector of bool : ${v_bool}' )
	
		
println('\n BYE')
}

fn f1 (n int) int
{
	mut temp := n * 10
	return ( temp )
}

fn f2 (a_array  [] int) [] int {
	 mut temp := a_array.clone()   /// by reference
	 for i in 0 .. (a_array.len) /// goes from ZERO ... up to len-1
	  {
		 temp[i] =  temp[i] + i // silly
		 print('\t f2: temp[${i}] : ${ temp[i] }' )
	  }
	return  temp // by reference
}

fn f3 (a_array  [] string)  {
	for i, value in a_array /// goes from ZERO ... up to len-1
	  {
		 print('\t f3: temp[${i}] : ${ a_array[i] }:: ${ value } ' )
	  }
// Does not necessary the return  
}
