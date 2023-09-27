from ortools.linear_solver import pywraplp
# from pulp import LpMinimize, LpProblem, LpVariable, lpSum
import pandas as pd
# Parâmetros e Dados de Entrada
T = 30  # Número de períodos
D_i = [300, 300, 360, 360, 340, 340, 340, 340, 104, 69, 114, 104, 69, 114, 150, 160, 18, 18, 160, 150]
N = len(D_i)  # Número de Produtos
S = 10  # Tempo de Setup (em segundos)
C_i = [14 for i in range(N)]  # Custos de Carregamento/Excesso
TP_i = [14 for i in range(N)]  # Tempo de Produção do item i
Sixty_hours = 16 * 60 * 60
CP_t = [Sixty_hours for t in range(T)]  # Capacidade de Produção no dia t
Demandas_mensais = [7500, 7500, 9000, 9000, 8500, 8500, 8500, 8500, 2588, 1725, 2847, 2588, 1725, 2847, 3750, 4000, 450, 450, 4000, 3750]
M_BIG = sum(Demandas_mensais) * 2

# Cria o solver
solver = pywraplp.Solver.CreateSolver('GLOP')

# Adiciona variáveis
X_it = {}
Y_it = {}
I_it = {}
for i in range(N):
    for t in range(T):
        X_it[i, t] = solver.NumVar(0, solver.infinity(), f'X_{i}_{t}')
        #Y_it[i, t] = solver.BoolVar(f'Y_{i}_{t}')
        Y_it[i, t] = solver.NumVar(0, 1, f'Y_{i}_{t}')
        I_it[i, t] = solver.NumVar(0, solver.infinity(), f'I_{i}_{t}')

f_objective = solver.NumVar (0, solver.infinity(), f'cost function')



# Adiciona restrições

## BALANCO
for i in range(N):
    for t in range(T - 1):
        solver.Add(X_it[i, t] + I_it[i, t] - D_i[i] == I_it[i, t + 1])

##Demanda mensal    
for i in range(N):    
    solver.Add(solver.Sum([X_it[i, t] for t in range(T)]) >= Demandas_mensais[i])

# se há produção ... esta é positiva
for i in range(N):    
    for t in range(T):
        solver.Add(X_it[i, t] <= M_BIG * Y_it[i, t])

# produçao dia ...
for t in range(T):
    solver.Add(solver.Sum([(X_it[i, t] * TP_i[i]) + (S * Y_it[i, t]) for i in range(N)]) <= CP_t[t])

# Para um determinado dia ... limitar o numero de SETUP ... mas não está funcionando ...
for t in range(T):
    solver.Add(solver.Sum( [ Y_it[i,t] for i in range(N) ] )  <=  7)

# Adiciona a função objetivo
#f_objective = solver.Objective()

#for i in range(N):    
#    for t in range(T):
solver.Add(f_objective == solver.Sum( (Y_it[i,t] + I_it[i,t] + X_it[i,t]) for i in range(N) for t in range(T) ) )

solver.Minimize(f_objective)

'''
for i in range(N):
    for t in range(T):
        objective.SetCoefficient(Y_it[i, t], 1)
        objective.SetCoefficient(I_it[i, t], 1)
        objective.SetCoefficient(X_it[i, t], 1)
objective.SetMinimization()
'''


# Resolve o problema
status = solver.Solve()

# Exibe os resultados
if status == pywraplp.Solver.OPTIMAL:
    print(f'Solution:')
    print(f'Objective value = {solver.Objective().Value()}')
    for i in range(N):
        for t in range(T):
            print(f"Product {i+1}, Day {t+1}: Production = {int(X_it[i, t].solution_value())}, Setup = {int(Y_it[i, t].solution_value())}, Inventory = {int(I_it[i, t].solution_value())}")


# OUTPUT
for i in range(N):
    print(f"\n Product {i+1}: ")
    for t in range(T):
         print(f" {int(X_it[i, t].solution_value())}", end="")

print(("\n======="))
print(f"Total F_OBJECTIVE: { f_objective.solution_value() }")
# OUTPUT


'''
DEPOIS

# Salvando os resultados em um arquivo Excel
rows = []
for i in range(N):
    for t in range(T):
        rows.append({
            "Product": i + 1,
            "Day": t + 1,
            "Production": X_it[i, t].solution_value(),
            "Setup": Y_it[i, t].solution_value(),
            "Inventory": I_it[i, t].solution_value()
        })
df = pd.DataFrame(rows)
df.to_excel("production_results_ortools.xlsx", index=False)
print("Results saved to production_results_ortools.xlsx")
'''