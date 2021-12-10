%You need to plan the maintenance for several power plants. Each power plant will have to be shut down while undergoing maintenance. There is 3 power plants and 3 specialists.

%The goal is to minimize the cost from loss of production following the temporary shutdown of each power plant.

%You have the demand forecasts by the company that owns the power plants.

%The plan must schedule the power plants C, for maintenance tasks J on T days, with S specialists.

%Each task takes place at a planta and lasts 1 day (N), during which the plant does not produce any energy. There is one task per plant T = C. Each task requires certain qualifications and these qualifications must be met by corresponding S specialists (each task will require between 1 and S specialists to be completed).

%Each specialist con only work on one maintenance task per day.

%It takes the specialist the distance between the power plant (in days N) to travel from one power plant to another. If this distance is 0, there is no need to account for travel time.

%You are minimizing the cost of extra enevry the company will buy to meet demand. Plants normaly produce (prod) GW per day to satisfy daily demand D. However, they will no produce during down time, so the company will have to purchase from the competition at a price of $1000 per GW.

%DATA FOR THE MODEL ACCORDING TO THE DESCRIPTION

include "globals.mzn";

C = 3;%number of powerplants
N = 5;%number of days
K = 3;%number of skills
S = 3;%number of specialists

dist = array2d(1..C, 1..C, [0,1,1,
                            1,0,1,
                            1,1,0]
                            ); %distance between plants in a 2d array (C x C)

demand = [35,33,30,35,35]; %daily demand of energy that must be met by the plants

prod = [10,12,15]; %production of each plant (C1; C2; C3)

skills = array2d(1..S, 1..K,[1,0,0,
                             0,1,1,
                             0,1,1]); %skills (K) of each specialist (S) in a 2d array (S x K)

skills_req = array2d(1..C, 1..K,[1,1,1,
                                0,2,2,
                                1,2,2]); %requirement of skills (K) for a plant to undergo maintenance in a 2d array (C x K)

%MODEL

int: C;%plants
int: N;%days
int: K;%skills
int: S;%specialists

%% for decision variables
set of int: S_set = 1..S; %%% Specialist
set of int: K_set = 1..K; %%% Skill
set of int: C_set = 1..C; %%% PLANT

array[1..C,1..C] of int: dist;
array[1..N] of int: demand;
array[1..C] of int: prod;
array[1..S,1..K] of int: skills;
array[1..C,1..K] of int: skills_req;

%assignment of skills X days over specialist set
array [1..K , 1..N] of var set of S_set: skill_day_assignment;

%assignment ospecialist x days over plant set
array [1..S , 1..N] of var set of C_set: specialist_day_assignment;
                  
%the assignment of specialists must fill the need for skills

constraint
 skill_day_assignment[1,1] = {1,3}
 ;


%each specialist can only be assigned for 1 plant each day
%constraint forall(s in 1..S, n in 1..N)(sum (c in 1..C)(spec_assignment[s,c,n])==1);

%production/day
/*
array[1..C,1..N] of var int: prod_day;
constraint forall(c in 1..C, n in 1..N, s in 1..S) (
                                                    if spec_assignment[s,c,n] == 1 then         prod_day[c,n] == 0 else prod_day[c,n] == prod[c] endif
                                                    );
*/
solve satisfy

%%array[1..N,1..C] of int: production_day; %array demonstrating the production of each plant each day
%%array[1..S,1..K] of var 0..1: assignment_c1; %assignment of workers for plant c1
%%array[1..S,1..K] of var 0..1: assignment_c2; %assignment of workers for plant c2
%%array[1..S,1..K] of var 0..1: assignment_c3; %assignment of workers for plant c3
%%constraint forall (i in 1..S, j in 1..K) (assignment_c1[i,j] * skills[i,j] >= skills_req[i,j]);
%%constraint forall (i in 1..S, j in 1..K) (assignment_c2[i,j] * skills[i,j] >= skills_req[i,j]);
%%constraint forall (i in 1..S, j in 1..K) (assignment_c3[i,j] * skills[i,j] >= skills_req[i,j]);


%array[1..S,1..C] of var 0..1: assignment_d2;
%array[1..S,1..C] of var 0..1: assignment_d3;
%array[1..S,1..C] of var 0..1: assignment_d4;
%array[1..S,1..C] of var 0..1: assignment_d5;

% constraint forall(k in 1..K, s in 1..S, c in 1..C) (
%           (skills[s,k]*a_d1[s,c]) >= skills_req[c,k]);





