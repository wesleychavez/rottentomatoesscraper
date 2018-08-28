#!/bin/bash
# Usage:    ./getMovies.sh
# Scrapes a list of 100 of the best movie urls (on rottentomatoes.com) from years 1980-2018 and saves them to file yyyy.txt
# Wesley Chavez 08-24-18

for i in {1980..2018}; do 

    current_file="$i.txt"
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

    # Try not to annoy them
    echo "Waiting"
    sleep 10
    echo "K curling again"

done
