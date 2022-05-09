#!/bin/bash
##########################################
#time (mzn-g12fd clique_ex.mzn data_clique_04.dzn)
#time (mzn-g12fd clique_ex.mzn data_clique_06.dzn)
#time (mzn-g12fd clique_ex.mzn data_clique_08.dzn)
##########################################
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
echo "mzn-g12fd clique_ex.mzn data_clique_04.dzn"
mzn-g12fd clique_ex.mzn data_clique_04.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

start=$(date +%s.%N)
echo "mzn-g12fd clique_ex.mzn data_clique_04.dzn"
mzn-g12fd clique_ex.mzn data_clique_04.dzn
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n\n" $dur

##########################################
echo " THE END "