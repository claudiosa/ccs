#$ opa eval -i 03_input.json -d 03_example.rego data.example_03

package example_03

import future.keywords.if

default hello := false
default hello2 := true


default test_F := false
default test_T := true
default test_EQ := true


hello if input.message == "world"
hello2 if (input.message == "world2") == true

#test_F  if input.num > 15
##test_T  if input.num > 11
#test_EQ  if input.num == 11