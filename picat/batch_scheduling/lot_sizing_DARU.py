from pulp import LpMinimize, LpProblem, LpVariable, lpSum
import pandas as pd
import openpyxl

# Parâmetros e Dados de Entrada
T = 30  # Número de períodos
# Demanda por dia do item i, constante para cada item ao longo do período
# Capacidades Diárias
D_i = [300, 300, 360, 360, 340, 340, 340, 340, 104, 69, 114, 104, 69, 114, 150, 160, 18, 18, 160, 150]
N = len(D_i)  # Número de Produtos
S = 10  # Tempo de Setup (em segundos)
C_i = [ 14 for i in range(N)] # Custos de Carregamento/Excesso (Cada estoque de um dia para outro computa o tempo gasto em antecipação)
TP_i = [ 14 for i in range(N) ]  # Tempo de Produção do item i
CP_t = [ 16*60*60 for t in range(T) ] #Capacidade de Produção no dia t
Demandas_mensais=  [7500, 7500, 9000, 9000, 8500, 8500, 8500, 8500, 2588, 1725, 2847, 2588, 1725, 2847, 3750, 4000, 450, 450, 4000, 3750]
M_BIG = sum(Demandas_mensais)*2

# Variáveis
# Produção do item i no dia t
X_it = LpVariable.dicts("X", [(i, t) for i in range(N) for t in range(T)], 0, None)
# Setup do item i no dia t
Y_it = LpVariable.dicts("Y", [(i, t) for i in range(N) for t in range(T)], 0, 1, cat='Binary')
#Estoque no fim do dia do item i no dia t
I_it = LpVariable.dicts("I", [(i, t) for i in range(N) for t in range(T)], 0, None)

# Problema
model = LpProblem("Optimize_Production", LpMinimize)

# Função Objetivo
#Soma dos tempos de setup mais soma dos tempos gastos para produzir estoque (custos de carregamento)
model += lpSum([ (S * Y_it[i, t] +  C_i[i] * I_it[i, t]) for i in range(N) for t in range(T)])

# Restrições

# C1: Equação de Balanço para o estoque
for i in range(N):
    for t in range(T-1):
        model += (X_it[i, t] + I_it[i, t] - D_i[i] == I_it[i, t+1])

# C2: Capacidade de Produção Diária
for t in range(T):
    model += lpSum([X_it[i, t] * TP_i[i] + S * Y_it[i,t] for i in range(N)]) <= CP_t[t]

# C3: Equações de Acoplamento - Produção implica Setup
for i in range(N):
    for t in range(T):
        model += X_it[i, t] <= M_BIG * Y_it[i, t]

# C4: Produção MENSAL - respeitar o  minimo dessa entrega mensal
for i in range(N):
    model += lpSum([X_it[i, t]  for t in range(T)]) >= Demandas_mensais[i]


# Solve
model.solve()

# # Print results
for i in range(N):
    for t in range(T):
         print(f"Product {i+1}, Day {t+1}: Production = {X_it[i, t].varValue}, Setup = {Y_it[i, t].varValue}, Inventory = {I_it[i, t].varValue}")
# OUTPUT
for i in range(N):
    print(f"\n Product {i+1}: ")
    for t in range(T):
         print(f" {X_it[i, t].varValue}", end="")

print(f"Total Cost: {model.objective.value()}")


rows = []
for i in range(N):
    for t in range(T):
        rows.append({
            "Product":i+1,
            "Day": t + 1,
            "Production": X_it[i, t].varValue,
            "Setup": Y_it[i, t].varValue,
            "Inventory": I_it[i, t].varValue
        })
df = pd.DataFrame(rows)

# Write DataFrame to Excel
df.to_excel("production_results.xlsx", index=False)

print("Results saved to production_results.xlsx")
