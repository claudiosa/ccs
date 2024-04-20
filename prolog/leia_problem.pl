%:- use_module(library(clpfd)).

% Define the missions, targets, fighters, and their durations
missions([mission1, mission2, mission3]).
targets([target1, target2, target3]).
fighters([fighter1, fighter2, fighter3, fighter4]).
duration(fighter1, [5, 7, 9]).
duration(fighter2, [6, 8, 10]).
duration(fighter3, [4, 6, 8]).
duration(fighter4, [3, 5, 7]).

% Define the changeover time between targets for each fighter
changeover_time(fighter1, target1, target2, 2).
changeover_time(fighter1, target2, target3, 3).
changeover_time(fighter2, target1, target2, 1).
changeover_time(fighter2, target2, target3, 2).
changeover_time(fighter3, target1, target2, 3).
changeover_time(fighter3, target2, target3, 2).
changeover_time(fighter4, target1, target2, 1).
changeover_time(fighter4, target2, target3, 1).

% Define the number of available fighters for each target
num_fighters(target1, 2).
num_fighters(target2, 2).
num_fighters(target3, 2).

% Generate the start time and fighter type arrays
generate_arrays(StartTime, FighterType) :-
    missions(Missions),
    targets(Targets),
    length(Missions, NumMissions),
    length(Targets, NumTargets),
    length(StartTime, NumMissions),
    length(FighterType, NumMissions),
    generate_arrays_helper(Missions, Targets, 1, StartTime, FighterType),
    maplist(labeling([]), StartTime),
    maplist(labeling([]), FighterType).

% Helper predicate to generate arrays recursively
generate_arrays_helper([], _, _, [], []).
generate_arrays_helper([Mission|Ms], Targets, MissionIndex, [StartTimeRow|StartTimeRest], [FighterTypeRow|FighterTypeRest]) :-
    generate_start_time_row(Mission, Targets, MissionIndex, StartTimeRow),
    generate_fighter_type_row(Mission, Targets, MissionIndex, FighterTypeRow),
    NextMissionIndex #= MissionIndex + 1,
    generate_arrays_helper(Ms, Targets, NextMissionIndex, StartTimeRest, FighterTypeRest).

% Generate the start time array for a mission
generate_start_time_row(_, [], _, []).
generate_start_time_row(Mission, [Target|Targets], MissionIndex, [StartTime|Rest]) :-
    nth1(MissionIndex, StartTime, StartTimeRow),
    StartTimeRow = [StartTime|_],
    generate_start_time_row(Mission, Targets, MissionIndex, Rest).

% Generate the fighter type array for a mission
generate_fighter_type_row(_, [], _, []).
generate_fighter_type_row(Mission, [Target|Targets], MissionIndex, [FighterType|Rest]) :-
    nth1(MissionIndex, FighterType, FighterTypeRow),
    FighterTypeRow = [FighterType|_],
    generate_fighter_type_row(Mission, Targets, MissionIndex, Rest).

% Entry point of the program
main :-
    generate_arrays(StartTime, FighterType),
    format('Start Time Array: ~w~n', [StartTime]),
    format('Fighter Type Array: ~w~n', [FighterType]).

% Call main predicate to execute the program
%:- initialization(main).
