


#include "SWI-cpp.h"
#include "SWI-Prolog.h"
#include "SWI-Stream.h"


#include <iostream>
using std::cout;
using std::cin;
using std::endl;

//#include "usr/lib/swi-prolog/include/SWI-Prolog.h"
//#include "usr/lib/swi-prolog/include/SWI-Stream.h"
//#include "usr/lib/swi-prolog/include/SWI-cpp.h"



int main(int argc, char **argv)
{
    int n;
    cout << "Please enter a number: ";
    cin >> n;

    PL_initialise(argc, argv);

    PlCall("consult('fatorial.pl')");

    term_t a, b, ans;
    functor_t func;

    a = PL_new_term_ref();
    PL_put_integer(a, n);
    b = PL_new_term_ref();
    ans = PL_new_term_ref();
    func = PL_new_functor(PL_new_atom("fat"), 2); // predicate name
    PL_cons_functor(ans, func, a, b);

    int fact;

    if (PL_call(ans, NULL))
    {
        PL_get_integer(b, &fact);
        cout << "Result is: " << fact << endl;
    }

    cin.ignore(2);
    return 0;
}
