#### CCS : Caminho Mínimo -- Exemplo simples
###MUITO IMPORTANTE a Classe da OR-TOOLS
from ortools.sat.python import cp_model

#Uma função ou classe para o problema
def modelo_cam_min():
    
    ## cria o modelo .... usa o método cp_model, da classe CpModel
    modelo = cp_model.CpModel()

    # cria as  VARIÁVEIS.... as arestas como vimos nos slides
    x_12 = modelo.NewIntVar(0, 1, 'x_12')
    x_13 = modelo.NewIntVar(0, 1, 'x_13')
    x_23 = modelo.NewIntVar(0, 1, 'x_23')
    x_24 = modelo.NewIntVar(0, 1, 'x_24')
    x_32 = modelo.NewIntVar(0, 1, 'x_32')
    x_34 = modelo.NewIntVar(0, 1, 'x_34')
    
    # Uma função caminho 
    f_CAM = modelo.NewIntVar(-999, 999, 'f_MIN')

    # RESTRICOES ADICIONADAS PARA OS FLUXOS DE ENTRADA(inp)
    # E SAÍDA (out) DE CADA NÓ DEVEM SER IGUAIS ... 
    # Uma aresta por vez eh SELECIONADA
    
    modelo.Add( 1 == (x_12 + x_13 ) )               # nó 1
    modelo.Add( (x_12 + x_32) == (x_23 + x_24) )    # nó 2
    modelo.Add( (x_13 + x_23) == (x_32 + x_34 ) )   # nó 3
    modelo.Add( (x_24 + x_34) == 1)                 # nó 4
    
    ### FUNCAO DO CAMINHO
    modelo.Add( f_CAM ==             
                10*x_12 + 5*x_13 +   
                3*x_23 + 6*x_24  +   
                4*x_32 + 20*x_34    
                )
    ### MINIMIZA FUNCAO DO CAMINHO
    modelo.Minimize( f_CAM )
    # OU ALGO ASSIM .... modelo.Minimize(sum([10*x_12 , 5*x_13, ....]))
    # OU modelo.Maximize( -f_CAM )
    
    # CHAMADA DO SOLVER PARA AS BUSCAS SOBRE O MODELO
    solver_SEARCH = cp_model.CpSolver()
    solver_SEARCH.parameters.max_time_in_seconds = 10
    status = solver_SEARCH.Solve( modelo )
    
    ## CUIDAR o que se deseja ... uma solução ou a ótima
    if status in (cp_model.OPTIMAL , cp_model.FEASIBLE):
       # print('MIN da função objectivo: %i' % solver_SEARCH.ObjectiveValue())
        my_print_VARS(  f_CAM, 
                        x_12, x_13, x_23 ,     
                        x_24, x_32, x_34 ,    
                        solver_SEARCH )
    
    elif (status == cp_model.INFEASIBLE) :   ##não é UNFEASIBLE 
        print(" INSATISFATÍVEL ")
        raise ValueError("No solution was found for the given input values")

    elif (status == cp_model.UNKNOWN) :
        raise ValueError(" The status of the model is unknown because a search limit was reached. ")
    
    else:
        raise ValueError(" .... INVALID  MODEL ....")                        
    
    print("END SOLVER and Model ")
    print_t(40)

    return ###### end function
################################################################### END MODEL

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
        print("\n END PRINTING \n===================================")
        return ###### end function

#### print =================
## aprendendo Python
def print_t(n):
    print()   # salta de linha
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
OTIMIZACAO:
https://docs.mosek.com/modeling-cookbook/index.html
'''        