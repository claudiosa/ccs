import os //{get_raw_line}
import regex { regex_opt }
import datatypes { Stack }
//fn os.get_raw_lines_joined() string
//you can use if os.is_atty(0) == 0 { to check if the standart input is redirected from a file/pipe


fn main() {
    lines := os.get_raw_lines_joined()
	//print('\n\n File from input []string: ${lines}')
    temp := lines.split('\n\n')
	conf := temp[0].split_into_lines().reverse()
	//movts := temp[1]
	//print('\n\n lenght Temp[0]...: ${temp[0].len}')
	//print('\n\n ...: ${movts[0].str()}')
	print('\n Configuration\n${conf}')
	rows := conf[1..]
	new := rows.map(it.replace('] [', ','))
	print('\n rows \n${typeof(rows).name} == ${rows}')
	print('\n new \n${typeof(new).name} == ${new}')
	new2 := new.map(it.replace('  ', ', '))
	print('\n new \n${typeof(new2).name} == ${new2}')
	// print('\n\n Configuration: ${movts}')

}

/*
>>> mut w1 := ['hel[lo', 'wo[rld']
>>> print( w1.map(it.replace('[',',')) )
['hel,lo', 'wo,rld']

*/

