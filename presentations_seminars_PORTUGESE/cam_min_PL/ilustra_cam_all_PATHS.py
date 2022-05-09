#### CCS : Caminho Mínimo

###--from ortools.linear_solver
'''

'''

###VERY VERY IMPORTANT
from ortools.sat.python import cp_model


class VarArraySolutionPrinter(cp_model.CpSolverSolutionCallback):
    """Print intermediate solutions."""

    def __init__(self, variables):
        cp_model.CpSolverSolutionCallback.__init__(self)
        self.__variables = variables
        self.__solution_count = 0

    def on_solution_callback(self):
        self.__solution_count += 1
        for v in self.__variables:
            print('%s=%i' % (v, self.Value(v)), end=' ')
        print()

    def solution_count(self):
        return self.__solution_count

#Uma função ou classe para o problema
def modelo_cam_min():
    
    ## cria o modelo ....usa o método cp_model, da classe CpModel
    modelo = cp_model.CpModel()

    # cria as  VARIÁVEIS....As arestas como vimos nos slides
    x_12 = modelo.NewIntVar(0, 1, 'x_12')
    x_13 = modelo.NewIntVar(0, 1, 'x_13')
    x_23 = modelo.NewIntVar(0, 1, 'x_23')
    x_24 = modelo.NewIntVar(0, 1, 'x_24')
    x_32 = modelo.NewIntVar(0, 1, 'x_32')
    x_34 = modelo.NewIntVar(0, 1, 'x_34')
        
    
    f_CAM = modelo.NewIntVar(0, 9999, 'f_most')

    # RESTRICOES ADICIONADAS PARA OS FLUXOS DE ENTRADA
    # E SAÍDA DE CADA NÓ DEVEM SER IGUAIS ... uma aresta por vez eh
    # SELECIONADA
    
    modelo.Add( 1 == (x_12 + x_13 ) )    # NO 1
    modelo.Add( (x_12 + x_32) == (x_23 + x_24) ) # NO 2
    modelo.Add( (x_13 + x_23) == (x_32 + x_34 ) ) # NO 3
    modelo.Add( (x_24 + x_34) == 1) # NO 4
    
    ### FUNCAO DO CAMINHO
    modelo.Add(f_CAM ==             \
                10*x_12 + 5*x_13 +   \
                3*x_23 + 6*x_24  +   \
                4*x_32 + 20*x_34    \
                )
    
    # modelo.Add(f_CAM > 10 )
    ### MINIMIZA FUNCAO DO CAMINHO
    # modelo.Minimize(f_CAM)

    # CHAMADA DO SOLVER PARA AS BUSCAS SOBRE O MODELO
    solver_SEARCH = cp_model.CpSolver()
    solver_SEARCH.parameters.max_time_in_seconds = 10
    solution_printer = VarArraySolutionPrinter([f_CAM, x_12, x_13, x_23, x_24, x_32, x_34 ])
    status = solver_SEARCH.SearchForAllSolutions(modelo, solution_printer)
    #status = solver_SEARCH.Solve(modelo)


    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        print(" INSATISFATÍVEL ")
        raise ValueError("No solution was found for the given input values")
    elif (status == cp_model.FEASIBLE) :
        my_print_VARS(f_CAM, x_12, x_13, x_23,     
                        x_24, x_32, x_34 , 
                        solver_SEARCH )
    elif (status == cp_model.UNKNOWN) :
        raise ValueError(" The status of the model is unknown because a search limit was reached. ")
    
    #else:
    #    raise ValueError(" .... INVALID  MODEL ....")

    print("\n END SOLVER and Model ")
    print_t(40)

    return ###### end function


### PRINTING FUNCTION
def my_print_VARS(f_CAM, x_12, x_13, x_23,
                 x_24, x_32, x_34, solver_SEARCH ):

        print('MINIMIZA = %i' % solver_SEARCH.Value(f_CAM) )

        print(f'x_12:%i || x_13:%i || x_23:%i || x_24:%i || x_32:%i || x_34:%i ' 
            % ( 
            solver_SEARCH.Value(x_12), 
            solver_SEARCH.Value(x_13),
            solver_SEARCH.Value(x_23),
            solver_SEARCH.Value(x_24),
            solver_SEARCH.Value(x_32),
            solver_SEARCH.Value(x_34)
            ) )

        print('\n\n** Final Statistics **')
        print('  - conflicts : %i' % solver_SEARCH.NumConflicts())
        print('  - branches  : %i' % solver_SEARCH.NumBranches())
        print('  - wall time : %f s' % solver_SEARCH.WallTime())
        print("\n END PRINTING \n ===================================")
        return ###### end function

#### print =================

def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return

if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    modelo_cam_min()
    #print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function


'''
https://docs.mosek.com/modeling-cookbook/index.html

'''        