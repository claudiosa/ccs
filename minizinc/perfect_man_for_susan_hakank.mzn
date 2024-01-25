/*
Susan’s perfect man has black hair, brown eyes, and is tall and slim. Susan knows four
men: Arthur, Bill, Charles, and Dave. Only one of them has all the characteristics that
Susan requires.
1. Arthur and Bill have the same eye colour.
2. Only one of the men has both black hair and brown eyes.
3. Bill and Charles have the same hair colour.
4. Only two of the men are both tall and slim.
5. Charles and Dave are of differing build.
6. Only two of the men are both tall and dark-haired.
7. Dave and Arthur are the same height.
8. Only three of the men are both slim and brown-eyed.
Who is Susan’s perfect man? (taken from Clessa (1996))
*/

/*
Since there are four candidates, we set the domain size to 4 and we avoid some of the
isomorphisms by fixing arthur = 0, bill = 1, charles = 2 and dave = 3.

*/

% set of int: Mens_Name  = 1..4;
% array[Mens_Name] of string: names = ["Arthur", "Bill", "Charles", "Dave"];

% hakank: Using enums is often
enum names = {arthur,bill,charles,dave};

% index_of ... a function to be improved (it from internet)
% int: arthur = index_of("Arthur", names);
% int: bill = index_of("Bill", names);
% int: charles = index_of("Charles", names);
% int: dave = index_of("Dave", names);

array[names] of var bool: perfectMan;
array[names] of var bool: tall;
array[names] of var bool: dark;
array[names] of var bool: slim;
array[names] of var bool: brownEyed;

constraint
%%% Formulas 6.25 and 6.24 from Adrian's book
forall (x in names) 
  (perfectMan[ x ] <-> ( tall[ x ] /\ dark[ x ] /\  slim[ x ] /\ brownEyed[ x ] ) ) 
;

% constraint
% %%% Formulas 6.25 and 6.26 from Adrian's book
% exists (x in names, y in names)
%   ((perfectMan[ x ] /\ perfectMan[ y ]) -> x == y ) ;

constraint
%%% Formulas 6.27 from Adrian's book
% exists (x in names)
%   ( brownEyed[x] /\ dark[x] )
sum([brownEyed[x] /\ dark[x] | x in names]) == 1;


constraint
  ( brownEyed[arthur] <-> brownEyed[bill] )  ;   %Clue 1: Arthur and Bill have the same eye colour.
 

constraint
%%% Formulas 6.28 from Adrian's book
exists (x in names, y in names)
  (((brownEyed[x] /\ dark[x]) /\ (brownEyed[y] /\ dark[y])) -> x == y)   ;
%  Clue 2. Only one of the men has both black hair and brown eyes.
% hakank:
% sum([brownEyed[x] /\ dark[x] /\ brownEyed[x] /\ dark[x] = 1 | x in names]) = 1
% ;

% 3. Bill and Charles have the same hair colour.
constraint
  ( dark[bill] <-> dark[charles] )  ; %Clue 3
  % hakank
  % ( dark[bill] = dark[charles] )  ; %Clue 3 

% constraint
%   exists (x in names, y in names)
%    (( tall[x] /\ slim[x]) /\  (tall[y] /\ slim[y]) ->  x != y ) ; %Clue 4a
   
% constraint
%   exists (x in names, y in names, z in names)
%    (( tall[x] /\ slim[x] /\ tall[y] /\ slim[y] /\ tall[z] /\ slim[z] /\ (x != y) )-> (z = x \/ z = y )) ;    %Clue 4b

% hakank:
constraint
  % 4. Only two of the men are both tall and slim.
  sum( [ tall[x] /\slim[x] | x in names ]) = 2
;


constraint
  ( not slim[dave] <-> slim[charles] )  ; %Clue 5: Charles and Dave are of differing build.
  % ( slim[dave] != slim[charles] )  ; %Clue 5: Charles and Dave are of differing build.  hakank

% constraint
%   exists (x in names, y in names)
%    ( tall[x] /\ dark[x] /\  tall[y] /\ dark[y] /\ (x != y) ) ; %Clue 6a
   
% constraint
%   exists (x in names, y in names, z in names)
%    (( tall[x] /\ dark[x] /\ tall[y] /\ dark[y] /\ tall[z] /\ dark[z] /\ (x != y) )-> (z = x \/ z = y )) ;    %Clue 6b:  Only two of the men are both tall and dark-haired.

% hakank:
% 6. Only two of the men are both tall and dark-haired.
constraint
  sum( [ tall[x] /\dark[x] | x in names ]) = 2
;

constraint
  ( tall[dave] <-> tall[arthur] )  ; % ORIG
  % ( tall[dave] = tall[arthur] )  ; % hakank
  %Clue 7: Dave and Arthur are the same height.


% hakank: This does not constrain to exactly 3 persons
% constraint
%   exists (x in names, y in names)
%    (( ( not brownEyed[x] /\ slim[x]) /\ ( not brownEyed[y] /\ slim[y])) ->  x == y ) ; 
%    %Clue 8: 8. Only three of the men are both slim and brown-eyed.
% hakank:
constraint
sum( [ brownEyed[x] /\slim[x] | x in names ]) = 3
;

% hakank: There is exactly one perfect man
% (not needed)
% constraint
%  sum([perfectMan[x] | x in names]) == 1
% ;

/*
TEST sssss? 
 minizinc -a --solver Gecode perfect_man_for_susan.mzn 
*/
/*

%%% which men is perfect?
exists (x in names)
  (perfectMan[ x ] = true ) ;

PROBABLY is missing something here....

*/
constraint  

      perfectMan[ arthur ] = true
      \/
      perfectMan[ bill ] = true
      \/
      perfectMan[ charles ] = true
      \/
      perfectMan[ dave ] = true
      ;

% hakank.
constraint
 sum([perfectMan[x] | x in names]) = 1
;

solve satisfy;
 
 output ["Perfect: " ++show(i)++" "++ show(perfectMan[i])++" \t tall:"++ show(tall[i])++"  dark:"++ show(dark[i])++"  tall:"++ show(slim[i])++"  browEyed:"++ show(brownEyed[i])++"\n" | i in names]
++
 % hakank: Show who is the perfect man
 [ if fix(perfectMan[x]) == 1 then
   "Perfect: \(names[x])\n"
   endif
   | x in names
  ]
 ;
 
 
% function copied from https://stackoverflow.com/questions/35758640/index-of-string-value-in-minizinc-%%array
%%% TO IMPROVE LATER ... change it - so annoying
%% use
%% lb_array   for lower bound index

%% resume  element(INDEX, ARRAY, CONTEUDO) 
%The same as A[i] = y. That is, y is the ith element of the array A.


function int: index_of(string: elem, array[int] of string: elements) =
      let {
         int: index = length(elements); %%% number of elements
      } in    % calls the helper function with the last index
        get_index(elem, elements, index)
; 

% recursive helper function    
function int: get_index(string: elem, array[int] of string: elements, int: index) = 
    if index == 0 
        then -1  % the element was not found (base case of recursion)
    elseif elements[index] == elem 
        then index % the element was found
    else 
        get_index(elem, elements, index - 1) % continue searching
    endif  
;
 
 
