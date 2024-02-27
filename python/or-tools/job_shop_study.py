

'''
#### BY CCS
Modelling of a job-shop schedulling, based in a classical book of OR

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_FUNCTION
def model_job_shop():
    # DATA from a file
    # 
    
    ## creating a model
    the_model = cp_model.CpModel()
    
    # Input Data
    
    jobs = 3
    machines = 3
    # jobs j in machine i
    '''
    sequence = [ [2, 3, 1],
                 [3, 1, 2] ,
                 [1, 3, 2]
                ]
    '''

  ### modify to use in Python directly
    sequence = [ [1, 2, 0],  # Job 1 must starts in machine 3
                 [2, 0, 1] ,
                 [0, 2, 1]   # Job 3 must starts in machine 1
                ]
    
    # time duration of jobs i in  machines  j
    duration = [ 
            [ 76, 73, 72] ,
	    [ 56, 74, 68 ],
	    [ 56, 55, 56]
        ]



    # Computes horizon dynamically as the sum of all durations.
    end_VALUE = sum(map(sum, duration)) ### TWO FORs
    High_Value = end_VALUE
    print("\nHorizont max", end_VALUE)
    '''
    temp = 0
    for i in range(jobs):
        for j in range(machines):
            temp += duration[i][j]  
    print("\nHorizont max", temp)
    '''
    #### VARIABLES
    # when the job i starts on machine j?
    job_start = [
         [the_model.NewIntVar(0,end_VALUE, 'job_start[i][j]')
            for j in range(machines) ] \
                for i in range(jobs)  
        ]
  
    ### equally to the finish timie
    job_end = [
         [the_model.NewIntVar(0,end_VALUE,'job_end[i][j]') \
          for j in range(machines) ] \
                for i in range(jobs)  
            #for j in range(jobs) ] \
            #for i in range(machines)
        ]

    # a decision var X:  job j preceeds job k on machine i,
    # or machine i, has the job j preceeding   the job k
    x = [
        [
         [the_model.NewIntVar(0,1,'x[i][j][k]') \
            for i in range(machines) ] \
            for j in range(jobs) ] \
            for k in range(jobs)
        ]
    #tmp = the_model.NewBoolVar('b')
    y = [
        [
         [the_model.NewIntVar(0,1,'y[i][j][k]') \
            for j in range(jobs) ] \
            for m1 in range(machines) ] \
            for m2 in range(machines)
        ]
 
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ## Constraint from the original problem
    
    ## duration (data) and start_t and end_t (variables)
    for i in range(machines) :
        for j in range(jobs):
            the_model.Add( job_end[i][j] == job_start[i][j] + duration[i][j] )  

    # non-overlap jobs  
    for i in range(machines) :
        for j in range(jobs):
            for k in range(jobs):
                #if j == k:
                #    continue;
                if j < k:                    
                    the_model.Add(job_start[i][k] >= job_start[i][j] + duration[i][j]) . OnlyEnforceIf (x[i][j][k]) 
                    the_model.Add(job_start[i][j] >= job_start[i][k] + duration[i][k]) . OnlyEnforceIf (x[i][j][k].Not())               


    for i in range(machines):
        for j in range(jobs):
            for k in range(jobs):
                #if j == k:
                #    continue;
                if j < k:  ### MORE EFFICIENT
                    the_model.Add(job_start[i][j] - job_start[i][k] <= (-duration[i][j] + High_Value*(1 - x[i][j][k]) ) ) . OnlyEnforceIf (x[i][j][k]) 
                    the_model.Add(job_start[i][j] - job_start[i][k] <= (-duration[i][j] + High_Value*(1 - x[i][j][k]) ) ) . OnlyEnforceIf (x[i][j][k].Not()) 

    for i in range(machines):
        for j in range(jobs):
            for k in range(jobs):
                #if j == k:
                #    continue;
                if j < k:  ### MORE EFFICIENT
                    the_model.Add(job_start[i][k] - job_start[i][j] <= (-duration[i][k] + High_Value*(x[i][j][k]) ) ) . OnlyEnforceIf (x[i][j][k]) 
                    the_model.Add(job_start[i][k] - job_start[i][j] <= (-duration[i][k] + High_Value*(x[i][j][k]) ) ) . OnlyEnforceIf (x[i][j][k].Not()) 
        
    # ORDERING OR SEQUENCE from sequence matrix
    for i in range(machines) :
        for j in range(jobs):
            for k in range(jobs):
                #if j == k:
                #    continue;
                if j < k:  ### MORE EFFICIENT
                    if( (sequence[i][j] < sequence[i][k]) ):    
                        the_model.Add(job_end[i][j] <= job_start[i][k] ) 
                    else:
                        the_model.Add(job_end[i][j] > job_start[i][k] ) 
    
    ###
    ### optmization  function or objective function 
    obj_var = the_model.NewIntVar(0, end_VALUE, 'optmization_var')
    ### Start soon ... a naive heuristic
    '''
    the_model.Add(obj_var == sum (
         job_end[i][j]   \
            for i in range(machines)    \
            for j in range(jobs) 
        )  
      )
    ''' 
    # by Hakan 
    the_model.AddMaxEquality(obj_var,[job_end[i][j] for i in range(machines) for j in range(jobs)])
    the_model.Minimize( obj_var )
    
    ### 
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 100
    status = solver_OUT.Solve(the_model)
    print('The status is:' , solver_OUT.StatusName(status))
    #print("s_1  s_2:::", solver_OUT.Value(s_1), solver_OUT.Value(s_2))

    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       # print(solver_OUT.Value(job_end))
       
      
       my_print_VARS(x, job_start, duration, job_end, obj_var, solver_OUT )
       
        
    elif (status == cp_model.INFEASIBLE) :   ##nao é UNFEASIBLE 
        print(" INFEASIBLE ")
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
def my_print_VARS( x,  start, duration, end, obj_var, solver_OUT):
    
    machines = len(start) # lines
    jobs = len(start[0]) # cols
    print(machines)
    print(jobs)

    print("\n\n Duration: Job(row) x Machine (col) ")
    for j in range(jobs):
        print('\n Job: %i '  %(j+1), end=" ")
        for i in range(machines):
            print( duration[i][j], end=" ")


    print("\n\n Machine for each Job ")
    for i in range(machines):
        print("\n========================")
        print('\n Machine: ', i+1)
        for j in range(jobs):
            print('| Job:%i ' %(j+1), solver_OUT.Value(start[i][j]), end=" ")
            print('...', solver_OUT.Value(end[i][j]), end="|")
            #print(' Duration:', duration[i][j], end=" ")
            #print(' Task/job:', j+1, 'starts:', solver_OUT.Value(start[i][j]), end=" ")
            
            
    print("\n\n Job  for each Machine ")      
    for j in range(jobs):
        print("\n========================")
        print('\n Job:', j+1)
        for i in range(machines):
            print('| Mac:%i =>' %(i+1), solver_OUT.Value(start[i][j]), end=" ")
            print('..', solver_OUT.Value(end[i][j]), end="|"),
            #print("\n========================")
        #print(' ends in:', solver_OUT.Value(y[i]))

    print("\n Span time (OBJ):", solver_OUT.Value(obj_var))
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
'''
NOT FINISHED ...
def sequence_in_order(sequence):   ## imprime  n tracejados
    
    rows = len(sequence) # lines
    cols = len(sequence[0]) # cols
    order =[]
    for i in range(rows):
        for j in range(cols):
            sequence[i][j]
    print()
    return
'''



if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_job_shop()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print("\n END MAIN ", end="")
    print_t(40)
    # return ###### end function 
