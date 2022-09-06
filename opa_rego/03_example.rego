package 03_example

import future.keywords.if

default hello := false

default test_F := false
default test_T := true


hello if input.message == "world"
test_F  if input.num > 15
test_T  if input.num > 1

#INPUT
#{
#    "message": "world",
#    "num": 10
#}
