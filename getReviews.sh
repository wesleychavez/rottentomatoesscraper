#!/bin/bash
# getReviews.sh  Saves critic reviews and ratings for a movie on rottentomatoes.com

# Usage:    bash getReviews.sh movie_name

# Note: The movie name must match the Rotten Tomatoes url.
# To get all reviews for "The Meg" (https://www.rottentomatoes.com/m/the_meg):

# ./getReviews.sh the_meg
#
# - Wesley Chavez 
# Created: 08-22-18
###################################

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
mkdir -p "$SCRIPTPATH/reviews"

# Sometimes curl returns nothing.  Keep curling until num.txt is populated with number of review pages.
empty_flag=1
while [ "$empty_flag" -eq 1 ]; do
    # Get number of review pages for this movie
    curl -s "https://www.rottentomatoes.com/m/$1/reviews/?page=1&sort=" | sed '222!d' > num.txt

    # Only save number of pages.   
    vim -c ':%s/Page 1 of /\r' \
    -c ':1d' \
    -c ':%s/<\/span>.*//g' \
    -c ':wq' num.txt < /dev/tty
    
    # If file is not blank, exit loop.
    if (($(cat num.txt | wc -l) != 0)); then
        empty_flag=0
    else
        sleep .5
    fi
    
done

num_review_pages=$(cat num.txt)
rm num.txt

# Loop over pages
for i in $(seq 1 $num_review_pages); do 

    let "j = $i - 1" 
    current_file="$SCRIPTPATH/reviews/$1_$j.txt"
    echo "$current_file"

    # Keep curling until current_file is populated with reviews
    empty_flag=1
    while [ "$empty_flag" -eq 1 ]; do
        # Line 222 is where the reviews are.
        curl -s --retry 10 "https://www.rottentomatoes.com/m/$1/reviews/?page=$i&sort=" | sed '222!d' > "$current_file"
        
        ######### Next 5 vim commands. (No spaces allowed after \ in bash scripts)
        # New line before review  
        # New line before score
        # Delete line 1
        # Remove everything after the first occurence of " </div>" on each line (End of review text)
        # Remove everything after the first occurence of "</div>" on each line (End of rating text)
        # Sometimes it says " [Full Review in Spanish]" after the review before "</div>" so get rid of that too.
        # Write and quit.  "< /dev/tty" is for suppressing warning output that makes the terminal go bonkers.
        
        vim -c ':%s/the_review"> /\r/g' \
        -c ':%s/Original Score: /\r/g' \
        -c ':1d' \
        -c ':%s/ <\/div>.*//g' \
        -c ':%s/<\/div>.*//g' \
        -c ':%s/ \[.*//g' \
        -c ':wq' "$current_file" < /dev/tty
      
        # If review file is not blank, we can exit while loop
        if (($(cat "$current_file" | wc -l) != 0)); then
            empty_flag=0
        fi
    
        # Try not to annoy them  
        sleep .5
    done
done
