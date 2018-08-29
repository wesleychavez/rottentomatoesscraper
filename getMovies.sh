#!/bin/bash
# Usage:    ./getMovies.sh
# Scrapes a list of 100 of the best movie urls (on rottentomatoes.com) from years 1980-2018 and saves them to file years/<yyyy>.txt
# Wesley Chavez 08-24-18

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
mkdir -p "$SCRIPTPATH/years"

for i in {1980..2018}; do 

    empty_flag=1
    while [ "$empty_flag" -eq 1 ]; do
        current_file="$SCRIPTPATH/years/$i.txt"
            
        # The meat is on the 16th line.
        curl -s "https://www.rottentomatoes.com/top/bestofrt/?year=$i" | sed '16!d' > "$current_file"
        
        ######### Next 5 vim commands. (No spaces allowed after \ in bash scripts)
        # New line before movie url  
        # Delete line 1
        # Remove everything after the first occurence of "/" on each line (End of movie url)
        # Write and quit
        
        vim -c ':%s/rottentomatoes\.com\/m\//\r/g' \
        -c ':1d' \
        -c ':%s/\/.*//g' \
        -c ':wq' "$current_file"

        # If file is not blank, we can exit while loop
        if (($(cat "$current_file" | wc -l) != 0)); then
            empty_flag=0
        fi
    
        # Try not to annoy them
        sleep 1

    done
done
