#### MODIFIED BY CCS to studies

### -- from ortools.linear_solver import pywraplp                                
## from ortools.constraint_solver import pywrapcp

### VERY VERY IMPORTANT
from ortools.sat.python import cp_model

def model_coexistence():
  t = 'Amphibian coexistence' ### a name 
  ##s = pywraplp.Solver(t,pywraplp.Solver.GLOP_LINEAR_PROGRAMMING) 
  # model s is created by this sequence
  s = cp_model.CpModel() 

  # VARS .... take care the supported types of cp_model
  x = [s.NewIntVar(0, 1000,'x[%i]' % i) for i in range(3)]       
  pop = s.NewIntVar(0, 3000, 'pop') 

  # CONSTRAINTS ADDED
  s.Add(2*x[0] + x[1] + x[2] <= 1500)                           
  s.Add(x[0] + 3*x[1] + 2*x[2] <= 3000)                          
  s.Add(x[0] + 2*x[1] + 3*x[2] <= 4000)                          
  s.Add(pop == x[0] + x[1] + x[2]) 

### optmization function       
  s.Maximize(pop)                                

  ###data_from_model =  call the solver for model s
  # code calls the solver
  solver_OUT = cp_model.CpSolver() 
  solver_OUT.parameters.max_time_in_seconds = 10
  status = solver_OUT.Solve(s)

  if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
    raise ValueError("No solution was found for the given input values")
  else:   

###return pop.SolutionValue(),[e.SolutionValue() for e in x]
    print('POP = %i' % solver_OUT.Value(pop))
    print('x0 = %i' % solver_OUT.Value( x[0] ) )
    print('x1 = %i' % solver_OUT.Value(x[1]) )
    print('x2 = %i' % solver_OUT.Value(x[2]) )
    ####print([count.Value() for count in x])

if __name__ == '__main__':
	print("\n =============== RESULTS ====================")
	model_coexistence()
	print("\n END MAIN \n ======================================")