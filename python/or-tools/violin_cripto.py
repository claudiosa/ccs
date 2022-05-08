# by  CCS
#
'''
    V I O L I N
-     C E L L O
----------------
    C O R N E T
...................
'''
# VERY VERY IMPORTANT
from ortools.sat.python import cp_model

# model function


def model_violin_crypto():
    t = 'model_violin_cripto'
    the_model = cp_model.CpModel()

    # VARS....take care the supported types of cp_model
    V = the_model.NewIntVar(0, 9, 'V')
    I = the_model.NewIntVar(0, 9, 'I')
    O = the_model.NewIntVar(0, 9, 'O')
    L = the_model.NewIntVar(0, 9, 'L')
    N = the_model.NewIntVar(0, 9, 'N')

    C = the_model.NewIntVar(0, 9, 'C')
    E = the_model.NewIntVar(0, 9, 'E')

    R = the_model.NewIntVar(0, 9, 'R')
    T = the_model.NewIntVar(0, 9, 'T')

    # CARRY VECTOR [ index 0 a 4 ]
    carry = [the_model.NewIntVar(0, 1, 'x[%i]' % i) for i in range(5)]
    f_maximiza = the_model.NewIntVar(0, 999999, 'f_maximiza')

    # CONSTRAINTS ADDED of the problem
    # all different
    the_model.AddAllDifferent([V, I, O, L, N, C, E, R, T])

    # the constraints of coluns
    the_model.Add((N + carry[0]*10) - O == T)
    the_model.Add(((I-carry[0]) + carry[1]*10) - L == E)
    the_model.Add(((L-carry[1]) + carry[2]*10) - L == N)
    the_model.Add(((O - carry[2]) + carry[3]*10) - E == R)
    the_model.Add(((I-carry[3]) + carry[4]*10) - C == O)
    the_model.Add((V - carry[4]) == C)

    # maximizefunction F_MOST such

    the_model.Add(f_maximiza == L + O + V + E)

    # optmization  function
    the_model.Maximize(f_maximiza)

    # data_from_model = call the solver for model s
    # code calls the solver
    solver_OUT = cp_model.CpSolver()
    solver_OUT.parameters.max_time_in_seconds = 10
    status = solver_OUT.Solve(the_model)

    if status not in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        raise ValueError("No solution was found for the given input values")
    else:
        my_print_VARS(f_maximiza, V, I, O, L, N, C, E, R, T, carry, solver_OUT)
        print("\n END SOLVER and Model ")
        print_t(40)

    return  # end function


# PRINTING FUNCTION

def my_print_VARS(f_most, V, I, O, L, N, C, E, R, T, carry, solver_OUT):

    print('MAX = %i' % solver_OUT.Value(f_most))

    print(f'V:%i || I:%i || O:%i || L:%i || N:%i || C:%i ||  E:%i ||  R:%i || T:%i'
          % (
              solver_OUT.Value(V),
              solver_OUT.Value(I),
              solver_OUT.Value(O),
              solver_OUT.Value(L),
              solver_OUT.Value(N),
              solver_OUT.Value(C),
              solver_OUT.Value(E),
              solver_OUT.Value(R),
              solver_OUT.Value(T)
          )),

    for index in range(len(carry)):
        print(f'carry[%i] : %i ' % (index, solver_OUT.Value(carry[index])))

    print('\n\n** Final Statistics **')
    print('  - conflicts : %i' % solver_OUT.NumConflicts())
    print('  - branches  : %i' % solver_OUT.NumBranches())
    print('  - wall time : %f s' % solver_OUT.WallTime())
    print("\n END PRINTING \n ===================================")
    return  # end function

# print =================


def print_t(n):
    print()
    for i in range(n):
        print('=', end="")
    print()
    return


if __name__ == '__main__':
    print("\n=============== RESULTS ====================")
    model_violin_crypto()
    # print(f'\n END MAIN \n %s' % print_t(40))
    print(f'\n END MAIN ')
    print_t(40)
    # return ###### end function

    '''
    TEM QUE FICAR NESTE ANINHAMENTO
    print('x0 = %i' % solver_OUT.Value(carry[0]))
    print('x1 = %i' % solver_OUT.Value(carry[1]))
    print('x2 = %i' % solver_OUT.Value(carry[2]))
    print('x3 = %i' % solver_OUT.Value(carry[3]))
    '''
