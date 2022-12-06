//import os
//import arrays { chunk, sum }

fn main() {

l := "abc"

mut x :=  []string{}
mut y :=  '' //''    //string{}
//[]u8{} 


 println('${l} ==> ${typeof( l ).name }')
 println('${x} ==> ${typeof( x ).name }')

 println('${y} ==> ${typeof( y ).name }')
 y = l
 println('${y} ==> ${typeof( y ).name }')
 println (' comp: ${t1(y)}')
 t2(y)
}
fn t1 (x string) int {
	mut y := ''
	y = x
	return int (y.len)

}


fn t2 (x string)  {
	for i in x {
	println('${i} ==> ${typeof( i ).name }')	
    //  println( i.bytestr())
	println( i.ascii_str())
	}
	return 
}

