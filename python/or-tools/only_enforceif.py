from ortools.sat.python import cp_model
model = cp_model.CpModel()
#x = bool(1)
#print(x)

#print(x.Not())
bool_r = model.NewBoolVar("Uma nova var bool CP para usar no onlyEnforceif")
n = model.NewIntVar(0,200,'um inteiro qualquer')

model.Add(n == 199) 
print('Var CP:...', bool_r , '.... NAO INSTANCIADA....') 
model.Add( n <= 100  ) . OnlyEnforceIf (bool_r) 
model.Add( n > 100  ) . OnlyEnforceIf (bool_r . Not()) 
solver_OUT = cp_model.CpSolver()
status = solver_OUT.Solve(model)
print("Status do Solver", status)
print('Var CP:', solver_OUT.Value(bool_r))
print(solver_OUT.Value(n))