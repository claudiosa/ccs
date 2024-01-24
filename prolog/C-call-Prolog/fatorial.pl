/*
$ swipl --goal=main -t halt -o saida2 -c fatorial.pl 
% fatorial.pl compiled 0.00 sec, 1,164 bytes
$ ./saida2
6
120
5040
$ swipl --stand_alone=true  --goal=main -t halt -o saida1 -c fatorial.pl 
% fatorial.pl compiled 0.00 sec, 1,164 bytes
$ ./saida1
6
120
5040
$ ls -al saida*
-rwxrwxrwx 1 root root 907617 Set  1 00:27 saida1
-rwxrwxrwx 1 root root 122822 Set  1 00:26 saida2
*/

%%% swipl -stand_alone=true  -g main -t halt -o saida.exe -c fatorial.pl 
%% nesta ordem...

main :- fat(3,N), write(N), nl,
        fat(5,X), write(X), nl,
        fat(7,Y), write(Y), nl.

fat( 0, 1 ).
fat( X, Fat ) :-   X  >  0, 
                        Aux  is  (X - 1),
                        fat( Aux , Parcial ),
                        Fat  is  ( X   *  Parcial ). 

/*
Exemplificando:
$ swipl --stand_alone=true  -g main -t halt -o saida.exe -c fatorial.pl 
% fatorial.pl compiled 0.00 sec, 1,164 bytes
$ ./saida.exe 
6
120
5040
$ 
*/
