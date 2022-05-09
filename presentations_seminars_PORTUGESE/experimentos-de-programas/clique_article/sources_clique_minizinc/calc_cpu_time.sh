#!/bin/bash
##########################################
#time (mzn-g12fd clique_ex.mzn data_clique_04.dzn)
#time (mzn-g12fd clique_ex.mzn data_clique_06.dzn)
#time (mzn-g12fd clique_ex.mzn data_clique_08.dzn)
##########################################
## outros SOLVERS time(mzn-gecode -p 8 -a clique_ex.mzn data_clique_60.dzn)
## time(mzn-gecode -p 8  -a clique_ex.mzn data_clique_450.dzn)
###START=$(date +%s)
# do something
# start your script work here
# your logic ends here
#END=$(date +%s)
#DIFF=$(( $END - $START ))
#""echo "It took $DIFF seconds"
##########################################
### -all-solutions  ... in mzn-g12fd
start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_04.dzn"
mzn-g12fd clique_ex.mzn data_clique_04.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_06.dzn"
mzn-g12fd  clique_ex.mzn data_clique_06.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_08.dzn"
mzn-g12fd clique_ex.mzn data_clique_08.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_10.dzn"
mzn-g12fd clique_ex.mzn data_clique_10.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_20.dzn"
mzn-g12fd clique_ex.mzn data_clique_20.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_30.dzn"
mzn-g12fd clique_ex.mzn data_clique_30.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_40.dzn"
mzn-g12fd clique_ex.mzn data_clique_40.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_50.dzn"
mzn-g12fd clique_ex.mzn data_clique_50.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_60.dzn"
mzn-g12fd clique_ex.mzn data_clique_60.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_70.dzn"
mzn-g12fd clique_ex.mzn data_clique_70.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_80.dzn"
mzn-g12fd clique_ex.mzn data_clique_80.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_90.dzn"
mzn-g12fd clique_ex.mzn data_clique_90.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_100.dzn"
mzn-g12fd clique_ex.mzn data_clique_100.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_150.dzn"
mzn-g12fd clique_ex.mzn data_clique_150.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_200.dzn"
mzn-g12fd clique_ex.mzn data_clique_200.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur
##########################################
echo " THE END "
