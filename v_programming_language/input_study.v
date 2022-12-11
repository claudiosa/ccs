import os
//fn os.get_raw_lines_joined() string
//you can use if os.is_atty(0) == 0 { to check if the standart input is redirected from a file/pipe

fn main() {
	line := os.get_raw_line()
	println('===> ${line} ... ${line.trim_right('\n')} ')	
	//println('===> ${line} ... ${line.trim_space('\n')} ')	
	//print('${file_from()}')
	println('type: ===> ${typeof(line).name}')
	
	//print('${file_from()}')
    //println('type: ===> ${typeof(file_from).name}')

}

//reading an input file from console
// equivalent os.get_raw_lines_joined()
fn file_from() [] string{
    mut file := []string{}
	for {
    line := os.get_raw_line()
    if line == '' {
        break
    } 
	file << dump(line.trim_right('\n'))
	//print('===> ${line}')
	}
    //print(file) 
	return file
}