#### BY CCS to studies
'''
Problem Formulation 

Powerco has three electric power plants that supply 
the needs of four cities.† Each power plant can supply 
the following numbers of kilowatt-hours (kwh) of electricity: 
plant 1—35 million; plant 2—50 million; plant 3—40 million 
(see Table 1). The peak power demands in these cities, 
which occur at the same time (2 P.M.), are as follows 
(in kwh): city 1—45 million; city 2—20 million; 
city 3—30 million; city 4—30 million.
 The costs of sending 1 million kwh 
 of electricity from plant to city 
 depend on the distance the electricity
  must travel. Formulate an LP to minimize the cost of 
  meeting each city’s peak power demand.

Solution: To formulate Powerco’s problem as
 an LP, we begin by defining a variable for each decision 
 that Powerco must make. Because Powerco must determine 
 how much power is sent from each plant to each city,
  we define (for i  1, 2, 3 and j  1, 2, 3, 4)

xij:  number of (million) kwh produced at plant i and 
sent to city j

 http://www.producao.ufrgs.br/arquivos/disciplinas/382_winston_cap_7_transportation.pdf

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model_most_money
def model_powereco_plant():
    t = 'model_powereco_plant'  ### onde usar isto ....????
    ## creating a model
    the_model = cp_model.CpModel()

    # DATA ---
    C1 = 35 ### Capacity of a supplier ... 1 up to 3
    C2 = 50
    C3 = 40
    suppliers = 3 ### index 0 up to 2
    cities = 4   ### 0 .. 3 
    '''
    custo =  
    8*x11 +  6*x12 + 10*x13 + 9*x14 +
    9*x21 +  12*x22 + 13*x23 + 7*x24+
    14*x31 + 9*x32 + 16*x33 + 5*x34;
    '''
    ## transmission cost between suppliers (i -- rows) and cities (j--cols)
    cost = [ 
            [8,  6,  10, 9],
            [9,  12, 13, 7],
            [14, 9,  16, 5]
           ]

    ### Should be come from a file
    NINE_NINE = 999999 ### a constant
    #### VARIABLES
    ## ANOTHER IDEA AROUND THIS --- how much is going from i to j?
    ### Example x=[[s.NumVar(0,C[i][j],'')for j in range(n)]for i in range(n)
    x = [
         [the_model.NewIntVar(0, C1, 'x[0][%i]' % INDEX_1) for INDEX_1 in range(cities)] ,
         [the_model.NewIntVar(0, C2, 'x[1][%i]' % INDEX_2) for INDEX_2 in range(cities)] ,
         [the_model.NewIntVar(0, C3, 'x[2][%i]' % INDEX_3) for INDEX_3 in range(cities)] 
        ]
    ### range(start, range ) --- start in specific index   
    # 
    f_objective = the_model.NewIntVar (0, NINE_NINE, 'cost function')
    
    # CONSTRAINTS ADDED 
    ####x11 + x12 + x13 + x14 <= C1; %(Plant 1 supply constraint)
    ## C capacity of each Suppliers
    the_model.Add(sum(x[0][j] for j in range(cities)) <= C1)         
    the_model.Add(sum(x[1][j] for j in range(cities)) <= C2)
    the_model.Add(sum(x[2][j] for j in range(cities)) <= C3)

    '''
      x11 + x21 + x31 >= 45    /\
      x12 + x22 + x32 >= 20    /\
      x13 + x23 + x33 >= 30    /\ 
      x14 + x24 + x34 >= 30     ;
      >>> for i in range(1,4):    print(i)  ## learning Python
        ... 
        1
        2
        3
    '''
    ### Demand of each City 1..4 .... from these suppliers
    the_model.Add(sum(x[i][0] for i in range(suppliers)) >= 45)  
    the_model.Add(sum(x[i][1] for i in range(suppliers)) >= 20)  
    the_model.Add(sum(x[i][2] for i in range(suppliers)) >= 30)
    the_model.Add(sum(x[i][3] for i in range(suppliers)) >= 30)

    ### Objective Function
    the_model.Add(
        f_objective == sum(
            (cost[i][j] * x[i][j]) \
            for i in range(suppliers) \
            for j in  range(cities)
            )### of sum 
        )## of Add
    

    ### optmization  function or objective function 
    # OR:  the_model.Maximize(-less_DIF) 
    the_model.Minimize(f_objective)

    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)
    #print(the_model.Proto) 	
    
    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS( x , suppliers, cities,  f_objective, solver_OUT )
        print("\n END SOLVER and Model ")
       
        print_t(40)

    return ###### end function


### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, m, n, f_objective, solver_OUT  ):

    print('Min sum of x : %i' % solver_OUT.Value(f_objective))
    
    print("\n  ================= Matrix X =================")
    for i in range(m): 
        for j in range(n): 
            print(f' x[%i][%i] : %i\t' % (i+1, j+1, solver_OUT.Value( x[i][j] ) ), end =  '' )
        print("\n ======================")
## learning Python            
        
    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver_OUT.NumConflicts())
    print('  - branches  : %i' % solver_OUT.NumBranches())
    print('  - wall time : %f s' % solver_OUT.WallTime())
    print("\n END PRINTING \n ===================================")
    return ###### end function

#### print =================
## learning Python
def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n =============== RESULTS ====================")
    model_powereco_plant()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function
 
