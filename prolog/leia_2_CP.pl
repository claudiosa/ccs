:- use_module(library(clpfd)).

% Example input data
missions([
    [target(1, 4), target(2, 3), target(3, 2)],
    [target(1, 2), target(2, 3), target(3, 1)]
]).

% Duration of each target
target_duration(1, 5).
target_duration(2, 3).
target_duration(3, 4).

% Changeover time between different types of targets
changeover_time(1, 1, 2, 1). % For example: changing from target 1 to target 2 takes 1 unit of time
changeover_time(2, 1, 3, 2). % Adjust/change these values as per your problem

% Available fighters and their durations
fighter(1, 2).
fighter(2, 3).

% Main predicate to solve the problem
campaign_start(Missions, StartTime, FighterType) :-
    length(Missions, NumMissions),
    length(StartTime, NumMissions),
    length(FighterType, NumMissions),
    maplist(solve_mission, Missions, StartTime, FighterType).

solve_mission(Mission, StartTime, FighterType) :-
    length(Mission, NumTargets),
    length(StartTime, NumTargets),
    length(FighterType, NumTargets),
    maplist(solve_target, Mission, StartTime, FighterType).

solve_target(target(T, _), StartTime, FighterType) :-
    select_fighter(T, FighterType, StartTime, T).

select_fighter(1, [F|_], [0|_], F).
select_fighter(T, [F|_], StartTime, FighterType) :-
    T > 1,
    T1 is T - 1,
    element(T1, StartTime, PrevStart),
    target_duration(T1, PrevDuration),
    changeover_time(F, T1, T, Changeover),
    StartTime #= (PrevStart + PrevDuration + Changeover),
    element(T, FighterType, F).

% Example usage
main(StartTime, FighterType) :-
    missions(Missions),
    campaign_start(Missions, StartTime, FighterType).

x:- main(StartTime, FighterType) 
% Example query
% ?- main(StartTime, FighterType).
