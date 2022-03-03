
### Python is calling V
### $ python3 test.py 

from ctypes import *
import math, os

n=10
# lib.square and sqrt_of_sum_of_.. are written in V
so_file="./a_v_code.so"
## if WINDOWS
if os.name=="nt":
  so_file="./a_name_of_module.dll"
lib = CDLL(so_file)
## to validate the call
assert lib.square(10) == 100, "Cannot validate V square()."

lib.sqrt_of_sum_of_squares.restype = c_double
assert lib.sqrt_of_sum_of_squares(c_double(1.1), c_double(2.2)) == math.sqrt(1.1*1.1 + 2.2*2.2), "Cannot validate V sqrt_of_sum_of_squares()."


# USING the MODULE 
for i in range(n):
  print(i, ": ==> ", lib.square(i), end='\n')

for i in range(10):
  print(i, ": ==> ", lib.sqrt_of_sum_of_squares(c_double(i),c_double(i)), end='\n')

print ("\n The End")