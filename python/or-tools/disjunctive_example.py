from ortools.sat.python import cp_model
###TODO
def main():
    # Criando o modelo
    model = cp_model.CpModel()

    # Definindo os dados
    durations = [3, 2, 5, 4]  # Duração de cada tarefa

    # Definindo as variáveis
    num_tasks = len(durations)
    starts = [model.NewIntVar(0, 100, f'start_{i}') for i in range(num_tasks)]  # Início de cada tarefa

    # Adicionando a restrição disjuntiva
    #model.AddDis(starts, durations)
    model.AddDisjunctive( 
    # Criando o solver e resolvendo o problema
    solver = cp_model.CpSolver()
    status = solver.Solve(model)

    # Exibindo os resultados
    if status == cp_model.OPTIMAL or status == cp_model.FEASIBLE:
        for i in range(num_tasks):
            print(f"Tarefa {i+1} começa em {solver.Value(starts[i])}")

if __name__ == "__main__":
    main()


""" 
TODO

disjunctive_tasks(Tasks): Tasks is a list of terms. Each term has the form
disj_tasks(S1,D1,S2,D2), where S1 and S2 are two integer-domain variables, 
and D1 and D2 are two positive integers. 
This constraint is equivalent to posting the disjunctive constraint 
S1+D1 #=< S2 #\/ S2+D2 #=< S1 for each term in Tasks; 
however the constraint may be more efficient, 
because it converts the disjunctive tasks into global constraints.
 """
# No overlapping of tasks s1 and s2
# NOT TESTED yet
def no_overlap_HAKAN(self, model, s1, d1, s2, d2):
        """
    no_overlap(model, s1, d1, s2, d2)  Ensure that there are no overlap of task 1 (`s1` + `d1`)
    and task 2 (`s2` + `d2`)
        """
        b1 = model.NewBoolVar("b1") 
        model.Add(s1 + d1 <= s2).OnlyEnforceIf(b1)
        b2 = model.NewBoolVar("b1") 
        model.Add(s2 + d2 <= s1).OnlyEnforceIf(b2)
        model.Add(b1 + b2 >= 1) ### esta restrição será postada se não houver overlapp

