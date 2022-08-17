
#opa eval -i 02_input.json -d 02_example.rego data.my_interaction
#opa eval -i 02_input.json -d 02_example.rego "data.my_interaction.num_s
#opa eval -i 02_input.json -d 02_example.rego data.my_interaction
#opa eval -i 02_input.json -d 02_example.rego "data.my_interaction.num_s
package my_interaction
import future.keywords.if
import future.keywords.every # "every" implies "in"
import future.keywords.contains

default MAX := 10
default find_a_SOLUTION_1
default find_a_SOLUTION_2 := true
default temp := 0

#elements contains any_VAL if {
#a_set := num_s 
find_a_SOLUTION_1 if {

	some any_VAL in input.number 
  
    a_SET := {any_VAL}
	a_sum := sum(a_SET)
    (a_sum == 115)
    
	#a_sum == 15
	#41 in num_s
} #31 in num_s

# sum
#a_sum := 

find_a_SOLUTION_2 if {
	x := input.number
	b := {x | x % 2 != 0}
	b != {}
}

## why not is printing b
Bigger := max( xs )
SUM := sum( {input.number} )

xs := [2, 2, 4, 8, 11, 13]

larger_than_one(x) := x > 1

rule_EACH if {
	every x in xs {
		larger_than_one(x)
		x % 2 != 0 ### NONE COMMA
	}
}

## why not is printing x also  
