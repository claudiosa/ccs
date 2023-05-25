

'''
#### BY CCS
Modelling of a job-shop schedulling, based in a classical book of OR

'''


'''
hakank:

* Added a better objective: obj_var 
    the_model.AddMaxEquality(obj_var,[job_end[i][j] for i in range(machines) for j in range(jobs)])
* Also in ORDERING OF SEQUENCE I changed
    the_model.Add(job_end[i][j] < job_start[i][k] )
  to
    the_model.Add(job_end[i][j] <= job_start[i][k] )
  so I can compare with my Picat model


* With Claudio s original constraint, i.e. just non-overlap jobs

 Machine:  1
| Job:1  73 ... 149|| Job:2  150 ... 223|| Job:3  0 ... 72|
========================

 Machine:  2
| Job:1  144 ... 200|| Job:2  0 ... 74|| Job:3  75 ... 143|
========================

 Machine:  3
| Job:1  0 ... 56|| Job:2  114 ... 169|| Job:3  57 ... 113|
 Job  for each Machine 

========================

 Job: 1
| Mac:1 => 73 .. 149|| Mac:2 => 144 .. 200|| Mac:3 => 0 .. 56|
========================

 Job: 2
| Mac:1 => 150 .. 223|| Mac:2 => 0 .. 74|| Mac:3 => 114 .. 169|
========================

 Job: 3
| Mac:1 => 0 .. 72|| Mac:2 => 75 .. 143|| Mac:3 => 57 .. 113|
Obj:  223

 ===================================

** Final Statistics **
  - conflicts : 10
  - branches  : 38
  - wall time : 0.007589 s

Overlap of jobs!
Job1:  M3      M1        M2
       0..56   73..149  144..200   Overlap of M1 and M2!
       
Job2:  M2      M1        M3
       0..74   114..169  150..223  Overlap of M1 and M3!
       
Job3  M1       M3        M2       
      0..72    57..113   75..143   Overlap M1 and M3, Overlap M3 and M2

No overlaps for the machines.
M1:  J3     J1       J2
     0..72  73..149  150..223

M2: J2      J3      J1
     0..74  75..143 144..200

M3: J1     J3       J2
    0..56  57..113  114..169

* With only my Cumulative (and no non-overlap jobs)

 Machine:  1
| Job:1  72 ... 148|| Job:2  183 ... 256|| Job:3  0 ... 72|
========================

 Machine:  2
| Job:1  196 ... 252|| Job:2  0 ... 74|| Job:3  128 ... 196|
========================

 Machine:  3
| Job:1  0 ... 56|| Job:2  128 ... 183|| Job:3  72 ... 128|
 Job  for each Machine 

========================

 Job: 1
| Mac:1 => 72 .. 148|| Mac:2 => 196 .. 252|| Mac:3 => 0 .. 56|
========================

 Job: 2
| Mac:1 => 183 .. 256|| Mac:2 => 0 .. 74|| Mac:3 => 128 .. 183|
========================

 Job: 3
| Mac:1 => 0 .. 72|| Mac:2 => 128 .. 196|| Mac:3 => 72 .. 128|
Obj:  256

 Here are no overlaps of jobs or machines
 Job1:  M3     M1       M2
        0..56  72..148  196..252

 Job2: M2     M3        M1
       0..74  128..183  183..256

 Job3: M1     M3       M2
       0..72  72..128  128..196


 M1: J3     J1       J2
     0..72  72..148  183..256

 M2: J2     J3        J1
     0..74  128..196  196..252

 M3: J1     J3       J2
     0..56  72..128  128..183
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
    end_VALUE =  9999

    # jobs j in machine i
    '''
    sequence = [ [2, 3, 1],
                 [3, 1, 2] ,
                 [1, 3, 2]
                ]
    '''

    # This is Claudio's original problem
    jobs = 3
    machines = 3

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


    # hakank: Testing with The Newspaper problem (from http://hakank.org/picat/jobshop.pi/)
    # The Picat model has 138 as the optimal value
    '''
    jobs = 4
    machines = 4

    # Adjusted for Python 0-based index
    #           Guardian  FT   Express  Sun
    sequence = [
        [1,       0,     2,      3],  # Algy
        [0,       2,     1,      3],  # Bertie
        [1,       2,     0,      3],  # Charlie
        [2,       1,     3,      0]   # Digby
    ]

    #              Guard.  FT  Express  Sun
    duration =   [
        [30,    60,    2,      5],  # Algy
        [75,    25,    3,     10],  # Bertie
        [15,    10,    5,     30],  # Charlie
        [ 1,     1,    1,     90]   # Digby
    ]
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
 
    # CONSTRAINTS ADDED of the problem
            
    ### 
    ## Constraint from the original problem
    
    ## duration (data) and start_t and end_t (variables)
    for i in range(machines) :
        for j in range(jobs):
            the_model.Add( job_end[i][j] == job_start[i][j] + duration[i][j] )  

    # non-overlap jobs  
    # for i in range(machines) :
    #     for j in range(jobs):
    #         for k in range(jobs):
    #             if j == k:
    #                 continue;
    #             the_model.Add(job_start[i][k] > job_start[i][j] + duration[i][j]) . OnlyEnforceIf (x[i][j][k]  ) 
    #             the_model.Add(job_start[i][j] > job_start[i][k] + duration[i][k]) . OnlyEnforceIf (x[i][j][k].Not()  ) 

    # hakank: Using Cumulative instead
    for j in range(jobs):
        intervals = [the_model.NewIntervalVar(job_start[m][j],duration[m][j],job_end[m][j],f"intervals[{m},{j}]")  for m in range(machines)]
        the_model.AddCumulative(intervals, [1 for m in range(machines)], 1)

    
    '''
    FROM PICAT ... of HAKAN
     % handle EndTimes
  foreach(M in 1..NumMachines, J in 1..NumJobs)
      JobEnd[M,J] #= JobStart[M,J] + JobTimes[M,J]
  end,

  % check the job order
  foreach(M in 1..NumMachines)
     foreach(J1 in 1..NumJobs, J2 in 1..NumJobs, J1 < J2) 
        if JobOrder[M,J1] < JobOrder[M,J2] then
           before(JobEnd[M,J1], JobStart[M,J2])
        else 
           after(JobStart[M,J1], JobEnd[M,J2])
        end
     end
  end,
  '''  
    # ORDERING OR SEQUENCE from sequence matrix
    for i in range(machines) :
        for j in range(jobs):
            for k in range(jobs):
                if j == k:
                    continue;
                if( (sequence[i][j] < sequence[i][k]) ):
                    # hakank: This should probably be <= instead of <
                    the_model.Add(job_end[i][j] <= job_start[i][k] ) 
                else:
                    the_model.Add(job_end[i][j] > job_start[i][k] ) 
    
    ###
    ### optmization  function or objective function 
    obj_var = the_model.NewIntVar(0, end_VALUE, 'optmization_var')
    ### Start soon ... a naive heuristic
    # hakank: This does not optimize of max time
    # ORIG:
    # the_model.Add(obj_var == sum (
    #      job_end[i][j]   \
    #         for i in range(machines)    \
    #         for j in range(jobs) 
    #     )  
    #   )

    # hakank: This is better: This is the max end time (to be minimized)
    the_model.AddMaxEquality(obj_var,[job_end[i][j] for i in range(machines) for j in range(jobs)])


    the_model.Minimize( obj_var )
    
    ### 
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 100
    solver_OUT.parameters.cp_model_probing_level = 0 # hakank
    
    status = solver_OUT.Solve(the_model)
   
    
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       # print(solver_OUT.Value(job_end))
       #print(obj_var)
       #print(solver_OUT.Value.job_start)
       my_print_VARS(x, job_start, duration, job_end, solver_OUT, obj_var )
        
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
def my_print_VARS( x,  start, duration, end, solver_OUT, obj_var):
    
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
            
            
    print("\n Job  for each Machine ")      
    for j in range(jobs):
        print("\n========================")
        print('\n Job:', j+1)
        for i in range(machines):
            print('| Mac:%i =>' %(i+1), solver_OUT.Value(start[i][j]), end=" ")
            print('..', solver_OUT.Value(end[i][j]), end="|"),
            #print("\n========================")
        #print(' ends in:', solver_OUT.Value(y[i]))
    print("\nObj: ", solver_OUT.Value(obj_var))
   
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
