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

set of int: Mens_Name  = 1..4;
array[Mens_Name] of string: names = ["Arthur", "Bill", "Charles", "Dave"];

% index_of ... a function to be improved (it from internet)
int: arthur = index_of("Arthur", names);
int: bill = index_of("Bill", names);
int: charles = index_of("Charles", names);
int: dave = index_of("Dave", names);


array[Mens_Name] of var bool: perfectMan;
array[Mens_Name] of var bool: tall;
array[Mens_Name] of var bool: dark;
array[Mens_Name] of var bool: slim;
array[Mens_Name] of var bool: brownEyed;

constraint
%%% Formulas 6.25 and 6.24 from Adrian's book
forall (x in Mens_Name)
  (perfectMan[ x ] <-> ( tall[ x ] /\ dark[ x ] /\  slim[ x ] /\ brownEyed[ x ] ) ) ;

constraint
%%% Formulas 6.25 and 6.26 from Adrian's book
exists (x in Mens_Name, y in Mens_Name)
  ((perfectMan[ x ] /\ perfectMan[ y ]) -> x == y ) ;

constraint
%%% Formulas 6.27 from Adrian's book
exists (x in Mens_Name)
  ( brownEyed[x] /\ dark[x] )  ;

constraint
  ( brownEyed[arthur] <-> brownEyed[bill] )  ;   %Clue 1: Arthur and Bill have the same eye colour.

constraint
%%% Formulas 6.28 from Adrian's book
exists (x in Mens_Name, y in Mens_Name)
  (((brownEyed[x] /\ dark[x]) /\ (brownEyed[y] /\ dark[y])) -> x == y)   ;
%  Clue 2. Only one of the men has both black hair and brown eyes.

constraint
  ( dark[bill] <-> dark[charles] )  ; %Clue 3

constraint
  exists (x in Mens_Name, y in Mens_Name)
   (( tall[x] /\ slim[x]) /\  (tall[y] /\ slim[y]) ->  x != y ) ; %Clue 4a
   
constraint
  exists (x in Mens_Name, y in Mens_Name, z in Mens_Name)
   (( tall[x] /\ slim[x] /\ tall[y] /\ slim[y] /\ tall[z] /\ slim[z] /\ (x != y) )-> (z = x \/ z = y )) ;    %Clue 4b

constraint
  ( not slim[dave] <-> slim[charles] )  ; %Clue 5: Charles and Dave are of differing build.

constraint
  exists (x in Mens_Name, y in Mens_Name)
   ( tall[x] /\ dark[x] /\  tall[y] /\ dark[y] /\ (x != y) ) ; %Clue 6a
   
constraint
  exists (x in Mens_Name, y in Mens_Name, z in Mens_Name)
   (( tall[x] /\ dark[x] /\ tall[y] /\ dark[y] /\ tall[z] /\ dark[z] /\ (x != y) )-> (z = x \/ z = y )) ;    %Clue 6b:  Only two of the men are both tall and dark-haired.


constraint
  ( tall[dave] <-> tall[arthur] )  ; 
  %Clue 7: Dave and Arthur are the same height.


constraint
  exists (x in Mens_Name, y in Mens_Name)
   (( ( not brownEyed[x] /\ slim[x]) /\ ( not brownEyed[y] /\ slim[y])) ->  x == y ) ; 
   %Clue 8: 8. Only three of the men are both slim and brown-eyed.
   

/*
TEST sssss? 
 minizinc -a --solver Gecode perfect_man_for_susan.mzn 
*/
/*

%%% which men is perfect?
exists (x in Mens_Name)
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
    
      
  
solve satisfy;
 
 output ["Perfect: " ++show(i)++" "++ show(perfectMan[i])++" \t tall:"++ show(tall[i])++"  dark:"++ show(dark[i])++"  tall:"++ show(slim[i])++"  browEyed:"++ show(brownEyed[i])++"\n" | i in Mens_Name] ;


 
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
 
 