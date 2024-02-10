from turing_test.function_01 import call_sum
from turing_test.function_02 import call_mult




def f_main(x,y) :
    print("\n ... sum:", call_sum(x,y), end="" )
    print("\n ... mult:", call_mult(x,y) , end="" )


if __name__ == '__main__':
    print("What is the package: ??? ", __package__ , end="" )
    f_main(4,3)