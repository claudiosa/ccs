
#### BY CCS
'''
#!/usr/bin/python
# -*- coding: iso-8859-15 -*-
#import os, sys

Problem Formulation 
These taskies  = [ A, B, C, D, E , F ] ,
will start from  0 . . 20 unit time
Duration = [3 ,4 ,2 ,3 ,2 ,3] ,
Usage = [ 2 , 2 , 2 , 1 , 2 , 1 ] ,
Limit = 4 ,
one expected output Start Time :  [0, 0, 3, 4, 5, 4]
'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_FUNCTION
def model_small_jbs():
    
    ## creating a model
    the_model = cp_model.CpModel()
    
    # Input Data
    duration =  [3 ,4 ,2 ,3 ,2 ,3]
    usage = [ 2 , 2 , 2 , 1 , 2 , 1 ]
    max_time = 20 ## horizon
    capacity = 4 #resource_limitation
    n = len (duration)
    a_big_value = 9999
    
    #### VARIABLES
    start_t =[the_model.NewIntVar(0, max_time, 'start_t[i]' )  \
             for i in range(n) ]
    end_t =[the_model.NewIntVar(0, max_time, 'end_t[i]' )  \
             for i in range(n) ]              
    
   # this type is required to cumulative constraint  
    intervals_t = [the_model.NewIntervalVar(start_t[i], duration[i], end_t[i], 'intervals_[i]') \
                 for i in range(n) ]
    ## capacity could be a variable also
    # capacity = the_model.NewIntVar(0, 4, "capacity") # can only cook one meal at a time   
    
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ## Constraint from the original problem
    the_model.Add( start_t[0] <= start_t[2] )
    the_model.Add( start_t[2] <= start_t[4] )
    the_model.Add( start_t[1] <= start_t[5] )
    the_model.Add( start_t[1] <= start_t[3] )
  
    ## duration (data) and start_t and end_t (variables)
    for i in range(n) :
        the_model.Add(start_t[i] + duration[i] == end_t[i])


    ### to use the Add Cumulative
    # add capacities and demands
    # intervals has a special type .... usage and capacity -> input data
    the_model.AddCumulative( intervals_t, usage, capacity )
    ### Attention: intervals type is mandatory .... special type
   

    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    #the_model.Minimize( sum (end_t) )
    ## missing something ... if you uncomment it works also
    obj_var = the_model.NewIntVar(0, a_big_value, 'makespan')
    ### Start soon ... a naive heuristic
    the_model.Add(obj_var == sum (start_t))
    the_model.Minimize( obj_var )
    
    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
   
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       my_print_VARS( start_t, end_t, duration, solver_OUT )
        
    elif (status == cp_model.INFEASIBLE) :   ##nao é UNFEASIBLE 
        print(" INSATISFATIVEL ")
        raise ValueError("No solution was found for the given input values")

    elif (status == cp_model.UNKNOWN) :
        raise ValueError("The status of the model is unknown because a search limit was reached. ")
    
    else:
        raise ValueError(" .... INVALID  MODEL ....")                        
    
    ### end of if ....
    print("END SOLVER and MODEL ")
    print_t(40)
    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, y, duration, solver_OUT):

    n = len (x)
    print('Start Time : ', [solver_OUT.Value(x[i]) for i in range(n)] )
    print('Duration Time :', [(duration[i]) for i in range(n)] )
    print('End Time : ', [solver_OUT.Value(y[i]) for i in range(n)] )
       
    for i in range(n):
        print(' Task:', i+1, 'start in:', solver_OUT.Value(x[i]), end=" ")
        print(' duration:', duration[i], end=" "),
        print(' ends in:', solver_OUT.Value(y[i]))

    print("\n ===================================\n")
    
    ####### HEADLINE -- TOP of matrix
    
   
## learning Python            
        
    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver_OUT.NumConflicts())
    print('  - branches  : %i' % solver_OUT.NumBranches())
    print('  - wall time : %f s' % solver_OUT.WallTime())
    print("\n END PRINTING \n===================================")
    return ###### end function

# =====================================================================================
#### reports =================



## learning Python
def print_t(n):   ## imprime  n tracejados
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_small_jbs()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print("\n END MAIN ", end="")
    print_t(40)
    # return ###### end function 
