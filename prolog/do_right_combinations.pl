% Import necessary libraries
:- use_module(library(readutil)).
:- use_module(library(lists)).

% Define the mapping from numbers to ranges
number_map(1, 1).
number_map(10, 1).
number_map(19, 1).
number_map(28, 1).
number_map(37, 1).
number_map(2, 2).
number_map(11, 2).
number_map(20, 2).
number_map(29, 2).
number_map(3, 3).
number_map(12, 3).
number_map(21, 3).
number_map(30, 3).
number_map(4, 4).
number_map(13, 4).
number_map(22, 4).
number_map(31, 4).
number_map(5, 5).
number_map(14, 5).
number_map(23, 5).
number_map(32, 5).
number_map(6, 6).
number_map(15, 6).
number_map(24, 6).
number_map(33, 6).
number_map(7, 7).
number_map(16, 7).
number_map(25, 7).
number_map(34, 7).
number_map(8, 8).
number_map(17, 8).
number_map(26, 8).
number_map(35, 8).
number_map(9, 9).
number_map(18, 9).
number_map(27, 9).
number_map(36, 9).

% Map a list of numbers according to the number_map predicate
map_combination([], []).
map_combination([H|T], [MappedH|MappedT]) :-
    number_map(H, MappedH),
    map_combination(T, MappedT).

% Sort a combination in descending order
sort_descending(Combination, Sorted) :-
    sort(0, @>=, Combination, Sorted).

% Read all combinations from a file
read_combinations(File, Combinations) :-
    open(File, read, Stream),
    read_lines(Stream, Combinations),
    close(Stream).

read_lines(Stream, []) :-
    at_end_of_stream(Stream).

read_lines(Stream, [Combination|T]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, Combination),
    read_lines(Stream, T).

% Write combinations to a file
write_combinations(File, Combinations) :-
    open(File, write, Stream),
    write_combinations(Stream, Combinations),
    close(Stream).

write_combinations(_, []).
write_combinations(Stream, [Combination|T]) :-
    atomic_list_concat(Combination, ' ', Atom),
    write(Stream, Atom),
    nl(Stream),
    write_combinations(Stream, T).

% Remove duplicate combinations
remove_duplicates([], []).
remove_duplicates([H|T], [H|OutT]) :-
    \+ member(H, T),
    remove_duplicates(T, OutT).
remove_duplicates([H|T], OutT) :-
    member(H, T),
    remove_duplicates(T, OutT).

% Main procedure
process_combinations :-
    read_combinations('combinations.txt', OriginalCombinations),
    maplist(map_combination, OriginalCombinations, MappedCombinations),
    maplist(sort_descending, MappedCombinations, SortedCombinations),
    sort(SortedCombinations, UniqueCombinations),
    write_combinations('final_combinations.txt', UniqueCombinations).

% Entry point
:- initialization(process_combinations).
