#!/bin/bash
cd /home/jordy/scripts

input=$(ls -Art | grep \.sh$ | tail -n 1)
echo "$input" > temp.txt
if [[ $input == "lastmodified.sh" ]]; then
    printf "Dit bestand kan niet uitgevoerd worden\n"
else
    cat temp.txt | xargs -I % sh -c 'chmod +x %;'
    bash ./$input
fi