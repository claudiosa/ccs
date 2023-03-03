/* 

  SWI-Prolo

  From Claudio
  """
  
What I was looking for is simplified in this example:

https://github.com/claudiosa/CCS/blob/master/picat/dcgs/01_dcg_file.pi

For an unformatted input such:
 VOO: 111         DE_ONDE: paris PARA: bruxelas
VOO: 333    DE_ONDE: salvador PARA: sao_paulo
     VOO: 222    DE_ONDE: sao_paulo PARA: floripa
 VOO: 123  DE_ONDE: rio_de_janeiro     PARA: joinville

with blank spaces et all

  """

  This is the version in SWI-Prolog which has more built-in 
  support for DCG, e.g. blanks, digits (which converts to integers) etc.

  Output: 
  111 paris bruxelas 
  333 salvador sao_paulo 
  222 sao_paulo floripa 
  123 rio_de_janeiro joinville 


*/

:- use_module(library(dcg/basics)).
go :-
  Chars1 = " VOO: 111         DE_ONDE: paris PARA: bruxelas
VOO: 333    DE_ONDE: salvador PARA: sao_paulo
     VOO: 222    DE_ONDE: sao_paulo PARA: floripa
 VOO: 123  DE_ONDE: rio_de_janeiro     PARA: joinville",
  writeln(Chars1),
  % Convert to codes since that's what's DCG expect
  string_codes(Chars1,Chars),
  nl,
  % Since we might have empty spaces it can match a lot
  % of different string. It's best to use once/1 here
  once(p(Lines,Chars,[])),

  % The results is ASCII codes ...
  maplist(writeln,Lines),
  nl,
  
  % So we print as strings using format/2
  w(Lines),
  fail, % checking what's happens on backtracking
  nl.
go.

% Print as springs
w([S|Ss]) :-
    maplist(w2,S),
    nl,
    w(Ss).

w2(S) :-
    format('~s ',[S]).

/*
 VOO: 111         DE_ONDE: paris PARA: bruxelas
VOO: 333    DE_ONDE: salvador PARA: sao_paulo
     VOO: 222    DE_ONDE: sao_paulo PARA: floripa
 VOO: 123  DE_ONDE: rio_de_janeiro     PARA: joinville

*/

% The details of a line.
% Note the conversion to int of the digits (must be an non empty line)
p1([Ds,S1,S2]) --> blanks, "VOO: ", blanks, digits(Ds),
                   blanks, "DE_ONDE: ", string(S1), blanks, "PARA: ", blanks, string(S2).
% End of the sequence.
p1([]) --> [].

% Parse a line. There are three cases:
%  - a line "\n" the rest of the line
p([L|Ls]) --> p1(L), {L \= []}, eol, p(Ls).
% - a single (last) line which is not an empty line
% p([L]) --> p1(L), {L \= []}. % not needed in SWI-Prolog
%  - end of the sequence
p([]) --> [].
