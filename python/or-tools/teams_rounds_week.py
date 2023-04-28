#### BY CCS to studies

'''
My Problem Formulation 

 A country has a number of soccer teams that play rounds/weeks in groups (the number of
 teams is a multiple of the number of groups).  Each round/week, a team
 plays with a group of different team, such that the same pair of teams
 never play together twice.

Problem Defintion

FROM
https://phaethonprime.wordpress.com/2019/09/04/using-google-or-tools-for-social-golfers/

To set up our social golfers, we need to think in terms of constraints that must be satisfied. There are three primary constraints:

Each golfer must be in exactly one group per day
Each golfer cannot play with a golfer they’ve played with before
Each group must contain the right number of golfers


Where p is the player number, d is the day, and g is the group number. 
X_{p,d,g}=1 when player p is playing on 
day d in group g. Let us say there are P golfers, 
D days, G groups, and Y golfers per group.

I will follow this description due its documentation on its modelling

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model

def f_data():

        # define the problem (use smaller numbers of players for testing)
    n_players = 44
    n_days = 4
    players_per_group = 4
 
# these will come in handy
    n_groups = n_players // players_per_group
    players = list(range(n_players))
    days = list(range(n_days))
    groups = list(range(n_groups))
''' 
attention
>>> n_days = 4
>>> days = list(range(n_days))
>>> print(days)
[0, 1, 2, 3]
'''

    return ..... todo

# model_most_money
def model_teams():
    t = 'model_assignment'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()
    # DATA 
    ### should be come from a file


    ### Many tricks to a sum of a MATRIX           
    MAX = sum(sum(cost,[])) ### an additional constant
    
    #### VARIABLES
    # define variables --- other trick -- Classical
    x = {}
    for i in range(n_players): 
        for j in range(n_days):
            for k in range(n_groups):
            x[(i,j,k)] = the_model.NewIntVar(0, 1, 'x[i][j][k]' )
        
    ### range(start, range ) --- start in specific index   
    ### index accept ... only "i" .... WHY ....
    # 




    f_objective = the_model.NewIntVar (0, MAX, 'cost function')
    
    # CONSTRAINTS ADDED of the problem
    '''
      % exacly one assignment per row, all rows must be assigned
        constraint  
        forall(i in 1..rows) (
                sum(j in 1..cols) (x[i,j]) = 1
    '''
    ### For Line - ROWS
    for i in range(rows):
        the_model.Add( sum(x[i][j] for j in range(cols)) == 1 )
        
    ### For Cols --- there are more cols than rows -- TAKE CARE HERE
    for j in range(cols):
        the_model.Add( sum(x[i][j] for i in range(rows)) <= 1 )
    
    ### Objective Function
    the_model.Add(
        f_objective == sum(
            (cost[i][j] * x[i][j]) \
            for i in range(rows) \
            for j in  range(cols)
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

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS( x , rows, cols,  f_objective, solver_OUT )
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
    model_assignment()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function 
