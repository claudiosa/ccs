import os
// please, see the Jalon's solution is shorter

fn main() {

mut total_calories := []int{}
mut calories := 0

lines := os.read_lines('day01_inp.txt') !
//print(lines)


for l in lines {
    if l == '' {
        total_calories << calories
        calories = 0
        continue //to resume the count in this loop
        }
    calories += l.int()
}

//DEBBUGING
//println('\n All all calories: ${total_calories}')
//println('\n Find the MOST: ${find_max (mut total_calories) }')
//println('\n Remove the x: ${remove_x (mut total_calories, total_calories[0]) }')

mut sum_3 := 0
mut one_max := 0

for _ in 0 .. 3{
	one_max = find_max(mut total_calories)
	total_calories = remove_x(mut total_calories, one_max)
	sum_3 += one_max
	//println('-> ${i}')
}

//print(sum_3)
println('\n Top 3 calories: ${sum_3}')

} // end main

// find the max positive in a list
fn find_max (mut list [] int ) int {
    mut max := list[0]
	//mut lenght := list.len
	for value in list {
		if value > max {
			max = value
		}
	}
    return max
	
}
// remove a specific x from a mut list ... returning a new list
fn remove_x (mut list [] int , x int) [] int {
    mut new_list := []int{}
	for value in list {
		if value != x {
			new_list << value
		}
	}
    return new_list
}
