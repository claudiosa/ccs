import os
import arrays { chunk, sum }

// Covering problem
fn main() {

//lines := os.read_lines('inp_test_day04.txt') !
lines := os.read_lines('day04_inp.txt') !
//print(lines)

//PART I

mut sum1, mut sum2 := 0, 0
for l in lines {
	pairs := l.split(',') // '5-7,7-9'
	//
    //print(pairs) //['2-3', '4-5']['5-7', '7-9']['2-8', '3-7']['6-6', '4-6']['2-6', '4-8']
	//
	left := pairs[0].split('-').map(it.int())
	right := pairs[1].split('-').map(it.int())
	x0, y0 := left[0] , right[0] // lower
	x1, y1 := left[1] , right[1] //upper
    //println('INTEGER: ${x0}-${x1} <> ${y0}-${y1}')
	sum1 += full_overlap(x0, y0, x1, y1)
	sum2 += full_disjunct(x0, y0, x1, y1)
}

// PART I
println('\n PART I -- full overlap : ${sum1}')
// PART II
println('\n PART II -- partial overlap : ${sum2}')

} // end main

//full overlap
fn full_overlap(x0 int, y0 int, x1 int, y1 int) int {
	if ( (x0 <= y0) && (x1 >= y1) )	|| ( (y0 <= x0) && (y1 >= x1) )  {
		//println('INTEGER: ${x0}-${x1} <> ${y0}-${y1}')
		return 1		
	  } else
	  {
	  	return 0
	  }	
}

// full disjunction
fn  full_disjunct(x0 int, y0 int, x1 int, y1 int) int {
	if  (x1 < y0) || (y1 < x0)   {
		//println('INTEGER: ${x0}-${x1} <> ${y0}-${y1}')
		return 0 // if full disjunct		
	  } else
	  {
	  	return 1
	  }	
}


