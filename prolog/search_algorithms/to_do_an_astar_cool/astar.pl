callastar(Start, Start, [0, 0, Start]) :-
    nl,
    format('The Start State and Goal State are the same').

callastar(Start, Goal, [Cost, Cost, Goal, Start]) :-
    edge(Start, Goal, Cost).

callastar(Start, Goal, Path) :-
    distanceSL(Start, Goal, SLD),
    astar([[0,SLD,Start]], Goal, [], Path).
    
astar([[PCost, PHCost, Goal |SubPath]|QTail], Goal, _Visted, [PCost, PHCost, Goal |SubPath]) :-
    CASE ONE CODE HERE: Goal state has been reached.

astar([[PCost, PHCost, CurrentV | SubPath]|QTail], Goal, Visited, Result) :- 
    not(member(CurrentV, Visited)),
    findall(V, edge(CurrentV, V, _Cost1), Edgelist), ...
    CASE TWO CODE HERE
    1) Remove vertices from Edgelist that are in Visited list
    2) Expand the set of configurations using (filtered) Edgelist
    3) Append(Expandedqueue, Oldqueue, Newqueue)
    4) Find the minimum configuration and move to the head of Newqueue 
    5) Add CurrentV to Visited list
    6) Recursively call astar

astar([[PCost, PHCost, CurrentV | SubPath]|QTail], Goal, Visited, Result) :-
    member(CurrentV, Visited), ...
    CASE THREE CODE HERE
    Qtail is the Newqueue.
    Find the minimum configuration in QTail and move it to the head of the Newqueue
    Recursively call astar

distancecalc(Xa, Ya, Xb, Yb, Result) :-
    Result is round(100*sqrt((Xa - Xb)*(Xa - Xb) + (Ya - Yb)*(Ya - Yb)))/100.

distanceSL(V1, V2, SLD) :- 
    coordinate(V1, X1, Y1),
    coordinate(V2, X2, Y2),
    distancecalc(X1, Y1, X2, Y2, SLD).
