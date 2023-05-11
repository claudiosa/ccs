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
    n_players = 15 #35
    n_days = 5
    players_per_group = 3
    return n_players, n_days, players_per_group 

# these will come in handy
''' 
   Attention
>>> n_days = 4
>>> days = list(range(n_days))
>>> print(days)
[0, 1, 2, 3]
'''

    

# model_most_money
def model_social_golfers():
    t = 'model_assignment'  ### onde usar isto ....
    ## creating a model
    the_model = cp_model.CpModel()
    # DATA 
    ### should be come from a file
    n_players, n_days, players_per_group = f_data()

    n_groups = n_players // players_per_group
    
    players = list(range(n_players)) 
    days = list(range(n_days))
    groups = list(range(n_groups))


    ### Many tricks to a sum of a MATRIX           
    #MAX = sum(sum(cost,[])) ### an additional constant
    
    #### VARIABLES
    # define variables --- other trick -- Classical
    # Decision variables
    # 0-1 decisions variables: x[gf][w][gr]=1 if golfer gf is in group gr on week w
    x = {}
    for i in range(n_players): 
        for j in range(n_days):
            for k in range(n_groups):
    #   OR         x[(i,j,k)] = the_model.NewIntVar(0, 1, 'x[i][j][k]' )
              x[i,j, k] = the_model.NewIntVar(0, 1, 'x[%i,%i,%i]' % (i, j, k))
     #x = [[[model.bool() for gf in range(nb_golfers)]
     #     for gr in range(nb_groups)] for w in range(nb_weeks)]    
    ### range(start, range ) --- start in specific index   
    ### index accept ... only "i" .... WHY ....
    # 

    # Each week, each golfer is assigned to exactly one group
    # each player must be in a single group on each day
    #for i in range(n_players): 
    #    for j in range(n_days):
    #        the_model.Add( sum( x[i,j,indx_group] for indx_group in range(n_groups)) == 1) 

    # Each week, each group contains exactly group_size golfers
    #for j in range(n_days):
    #    for k in range(n_groups):
    #        the_model.Add( sum( x[indx_player,j,k] for indx_player in range(n_players)) == 1) 
    
    for p1, p2 in range(n_players): 
        if p1 < p2:
            continue;
            for j in range(n_days):
                for k in range(n_groups):
                    the_model.Add( ( x[p1,j,indx_group] for indx_group in range(n_groups)) == 1) 


    # CONSTRAINTS ADDED of the problem
    '''
      INCOMPLETE ....
    
    '''
    # % Each member of each group must be distinct. 
    #for j in range(n_days):
    #    the_model.AllDifferent(x[(indx_player , j, indx_group)] for indx_player in range(n_players) for indx_group in range(n_groups) )  


    
    ## SEARCH or OPTIMIZATION
    #the_model.AddDecisionStrategy(x, cp_model.CHOOSE_FIRST,cp_model.SELECT_MIN_VALUE)
    
    # Force the solver to follow the decision strategy exactly.
    #solver_OUT.parameters.search_branching = cp_model.FIXED_SEARCH

    #the_model.Minimize(f_objective)
    ### data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)

    #solution_printer = SimpleSolutionCounter(2)
    #solution_printer = SolutionPrinter(x)
    #status = solver_OUT.SearchForAllSolutions(cp_model, solution_printer)

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else :
        my_print_VARS( x , n_players, n_days, n_groups,  solver_OUT )
        #print( x , end='\n')
        #print('x = %i' % solver_OUT.Value(x))
        #print(f'x = {solver_OUT.Value(x)}')
        print("\n END SOLVER and Model ")
        print_t(40)

    return ###### end function

### PRINTING FUNCTION
## learning Python
def my_print_VARS( x, m, n, l,  solver_OUT  ):
    #print('Min sum of x : %i' % solver_OUT.Value(f_objective))
    
    print("\n  ================= Matrix X =================")
    for i in range(m): 
        for j in range(n): 
            for k in range(l): 
                print(f' x[%i][%i][%i] : %i\t' % (i+1, j+1, k+1, solver_OUT.Value( x[(i,j,k)] ) ), end =  '' )
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
    model_social_golfers()
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function 
