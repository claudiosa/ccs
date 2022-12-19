import os //{get_raw_line}
import arrays
//import regex { regex_opt }
import datatypes { Stack }
//fn os.get_raw_lines_joined() string
//you can use if os.is_atty(0) == 0 { to check if the standart input is redirected from a file/pipe
/*
struct Instruction {
	count int
	from  int
	to    int
}
*/


fn main() {
	//$ v run day05.v < inp_day05.txt 
    lines := os.get_raw_lines_joined()
	//print('\n\n File from input []string: ${lines}')
    temp := lines.split('\n\n')
	conf := temp[0].split_into_lines().reverse()
	// movts := temp[1]
	// print('\n\n lenght Temp[0]...: ${temp[0].len}')
	// print('\n\n ...: ${movts[0].str()}')
	print('\n Configuration\n${conf} ==> ${typeof(conf).name} ')
	print('\n Sizes ${conf.map(it.len)} || a line ${conf[0].len} \n')
    //print(conf[0].split(' ').map(it.trim_space().int()))
	n_stack := arrays.max(conf[0].split(' ').map(it.trim_space().int())) !
    print('\n N_STACKS: ${n_stack}')
	n_init_lines := conf.len  
	n_cols := conf[0].len 
	print("\n INPUT print the matrix \n\n")
	for i in 1..n_init_lines {  //discard line 0 [ 1 .... 9]
		for j in 0..n_cols {
		// print(' ${conf[n_init_lines-i][j].ascii_str()}') // to see better
		print(' ${conf[i][j].ascii_str()}')
		}
		print("\n")
	}	

    /*** to populate N stacks with inverted data ***********/

	
	
	
	//print('\n N_lines_input: ${conf.len -1 }')
	//n_lines := 
	
	//print('\n INT ${str_to_int(conf[0])}')
	//find_n := conf[0].map(it.str())
	//print('\n N stacks ${find_n}')
	//print('\n N stacks ${conf[0].int()}')

	/*
	re-think everything ...
	rows := conf[1..]
	
	new := rows.map(it.replace('] [', ','))
	print('\n rows \n${typeof(rows).name} == ${rows}')
	print('\n new \n${typeof(new).name} == ${new}')
	new2 := new.map(it.replace('], ', ','))
	print('\n new2 \n${typeof(new2).name} == ${new2}')
	// print('\n\n Configuration: ${movts}')
    */ 
}

/*
>>> mut w1 := ['hel[lo', 'wo[rld']
>>> print( w1.map(it.replace('[',',')) )
['hel,lo', 'wo,rld']

*/
fn str_to_int( text  string ) [] int {
	mut r := []int{}
	for i in text {
		if i >= 48 && i <= 57 {
		//if int(i) >= 0 && int(i) <= 9 {	
		 r << int(i)-48
		 //print('\t =>${int(i)-48}<=')
		}else
		{print('.')
		 //print('\t ${i}<=')
		}	

	}
	//print('\n backing =>${r.map(it .)}')
	return r

	}
	
