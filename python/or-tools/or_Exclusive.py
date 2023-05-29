
# TOY PROGRAM to illustrate the CP
from ortools.sat.python import cp_model

# a main function about a model

def or_exclusive_example():

    # Create the model.
    # the_model is an object created by cp_model method from  CpModel class
    the_model = cp_model.CpModel()  # 'Channeling Example')

    #
    # data
    #
    n = 3  # a constant ... not var

    #
    # Creating CP variables
    #
    
    # bool_var
    b1_var = the_model.NewBoolVar('b1')
    b2_var = the_model.NewBoolVar('b2')
    # Other vars in the_model created by the method NewIntVar
    x = the_model.NewIntVar(10, 20, 'x')
    y = the_model.NewIntVar(0, 20, 'y')
   
    # NewIntVar(self, lb, ub, name)
    #
    # constraints
    #
    ###
    # x >= 5 and x < 10 then write as:
    the_model.Add(x >= 5) . OnlyEnforceIf(b1_var)
    the_model.Add(y >= 5) . OnlyEnforceIf(b2_var)

    #### TESTs
    #the_model.AddBoolOr([b1_var , b2_var]) 
    #the_model.AddBoolXOr([b1_var , b2_var])
    the_model.AddBoolAnd([b1_var , b2_var])
    #

    # Objective Function
    the_model.Maximize(x + y)
        
    # search with Strategy DecisionStrategy
    the_model.AddDecisionStrategy( [x,y], 
        cp_model.CHOOSE_FIRST,cp_model.SELECT_MIN_VALUE )
    #
    # Create a solver and solve with a strategy search.
    solver = cp_model.CpSolver()
    #solver.parameters.max_time_in_seconds = 10.0
    status = solver.Solve(the_model)
    ### 
    if (status == cp_model.FEASIBLE):
      print_output_VARS(solver.Value(x), solver.Value(y), solver.Value(b1_var)
                       , solver.Value(b2_var))
    else:
      print ("Others Status: ", solver.StatusName(status))
      print_output_VARS(solver.Value(x), solver.Value(y), solver.Value(b1_var)
                       , solver.Value(b2_var))
    
    ##################################################
    print('\n\n** Final Statistics **')
    print('  - status from solver : %s' % solver.StatusName(status))
    print('  - conflicts : %i' % solver.NumConflicts())
    print('  - branches  : %i' % solver.NumBranches())
    print('  - wall time : %f s' % solver.WallTime())
    print("=====Stats:======")
    print(solver.SolutionInfo())
    print(solver.ResponseStats())
    print("\n END SOLVER ===================================")

def print_output_VARS(X ,Y ,B1 ,B2):

    print("\n Showing the Answers: ")   
    print('x = ' , X )
    print('y = ' , Y )
    print('b1 VAR = ' , B1)
    print('b2 VAR = ' , B2)
   
    print("\n END FUNCTION ===================================")
   
# main program ....
if __name__ == '__main__':
  or_exclusive_example()
  print("\n END MAIN ===================================")


