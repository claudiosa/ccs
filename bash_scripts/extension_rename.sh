/bin/bash
#
#
# Script que altera a extensão de vários arquivo de uma vez.
#
#

# Rename all *.MOV to *.mov
for f in *.MOV; do 
   mv -- "$f" "${f%.txt}.mov"
    # echo "$f :==> ${f%.txt}.mov "
  #  echo f
done
echo "TERMINOU"
# Rename all *.MOV to *.mov
rename MOV mov *.MOV
rename 's/\.txt$/.text/' *.txt

rename 's/\.old$/.new/' *.old
Try the command below, which is flexible with sub-directories. It will rename all .txt files under directory structure with a new extension.

find . -name "*.txt" -exec rename 's/.txt$/.newext/' {} \;
