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

/*
>>> print('57'.runes())
[`5`, `7`]
>>> print(rune(166))
¦
>>> print(rune(48))
0
>>> print(rune(66))
B
>>>  print('21'.int())
21
>>> mut y  := '210'.int()
>>> print(typeof(y).name)
int
>>> x:=[' 1   2   3   4   5   6   7   8   9 ']

>>> print( x[0].split(' '))
['', '1', '', '', '2', '', '', '3', '', '', '4', '', '', '5', '', '', '6', '', '', '7', '', '', '8', '', '', '9', '']
>>> print( x[0].split(' ').map(it.trim_space().int()))
[0, 1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5, 0, 0, 6, 0, 0, 7, 0, 0, 8, 0, 0, 9, 0

>>> k := arrays.max(z) !
>>> print(k)
9
>>> 
>>> print (z)
[1, 2, 3, 0, 9]
>>> print(z.filter(it != 0))
[1, 2, 3, 9]
>>> 

*/




