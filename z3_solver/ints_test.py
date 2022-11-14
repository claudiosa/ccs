# Example from https://www.programmerall.com/article/8587908823/

from z3 import *

## VAR
x,y,z = Ints('x y z')
s = Solver() # an instance s for this solver was created

## Constraints
s.add(2*x+3*y+z==6)
s.add(x-y+2*z==-1)
s.add(x+2*y-z==5)

## OUTPUTs
print ("the status:", s.check())
print ("the values:", s.model())
##################################