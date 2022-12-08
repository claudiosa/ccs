import os
import arrays { chunk, sum }
// sum not used

fn main() {

//lines := os.read_lines('inp_test_day03.txt') !
lines := os.read_lines('day03_inp.txt') !
//print(lines)

//String values are immutable. You cannot mutate elements
mut x, mut y  :=  '', ''
mut letter_2_sides := [] u8{}

//PART I
mut sum_pri := 0
for l in lines {
	//println(' ==> ${typeof( l ).name }')
	x , y = divide_line( l )
	// println('${x} -- ${y}')
	// println('${ all_common (x,y).bytestr() }')
	letter_2_sides = all_common (x,y)
	//println('${letter_2_sides[0].ascii_str()} <== ')
    sum_pri += convert_prio(letter_2_sides[0])
}
println('\n PART I -- SUM : ${sum_pri}')


// PART II
    sum_pri = 0
	mut groups_of_three := chunk(lines, 3)
	mut in_3_lines  := [] u8{}
	mut letter_2_sides_aux  := [] u8{}
    //print(groups_of_three)
    for l in groups_of_three {
		letter_2_sides = all_common (l[0],l[1])
		letter_2_sides_aux = all_common (l[1],l[2])
		in_3_lines = all_common (letter_2_sides,letter_2_sides_aux)

		// println('${ letter_2_sides.bytestr()} <==>  ${letter_2_sides_aux.bytestr()}')
		// print('SO ===> ${in_3_lines}')
		// print('${letter_2_sides[0].ascii_str()} <==> ')
		// println('${letter_2_sides_aux[0].ascii_str()} ')
		sum_pri += convert_prio(in_3_lines[0])
	}

	// letter_2_sides = all_common (x,y)
	// print('${letter_2_sides[0].str()} <== \n')
println('\n PART II -- SUM : ${sum_pri}')

} // end main


fn divide_line(line  string ) ( string ,  string ) {
	half := line.len/2
	if (line.len % 2) != 0{
		print('\n A wrong input :${line} LENGHT: ${line.len}')
	//	panic('invalid rucksack :${line}')
	}else
	{
	 //print('\n Correct input :${line} LENGHT: ${line.len}')	
	}
	// part is copied from AoC in V -- repository
	mut left, mut right  :=  '', ''
	left = line[0..half]
	right = line[half..]
	return  left , right
}

// part is copied from AoC in V -- repository
// a list with all chars
fn all_common <T> (left T, right T) []u8 {
	mut all_chars := [] u8 {}
	for sl in left {
		for sr in right {
			if sl == sr {
				all_chars << sl
			}
		}
	}
  return all_chars
}


// copied from AoC in V -- repository
fn convert_prio(byte_val u8) int {
	r := match byte_val {
		`A`...`Z` { byte_val - `A` + 27 } // Uppercase item types A through Z have priorities 27 through 52.
		`a`...`z` { byte_val - `a` + 1 } // Lowercase item types a through z have priorities 1 through 26.
		else { panic('invalid byte ${byte_val}') }
	}
	return int(r)
}


