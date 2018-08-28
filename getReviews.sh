#!/bin/bash
# getReviews.sh  Saves critic reviews and ratings for a movie on rottentomatoes.com

# Usage:    bash getReviews.sh movie_name number_of_reviewpages

# Note: as of now, there are 20 reviews per page

# Note: The movie name must match the Rotten Tomatoes url.
# To get 40 reviews for "The Meg" (https://www.rottentomatoes.com/m/the_meg):
# bash getReviews.sh the_meg 2 
# To get all the reviews, set number_of_reviewpages to a ridiculously high number
# - Wesley Chavez 08-22-18
###################################

for i in $(seq 1 $2); do 

    let "j = $i - 1" 
    current_file="$1_$j.txt"
    echo "$current_file"
    # Line 222 is where the reviews are.
    curl -s "https://www.rottentomatoes.com/m/$1/reviews/?page=$i&sort=" | sed '222!d' > "$current_file"
    
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
  
    # If we've parsed all the reviews
    if (($(cat "$current_file" | wc -l) == 0)); then
        echo "Out of reviews"
        rm "$current_file"
        break
    fi
    # Try not to annoy them  
    echo "Waiting"
    sleep 10
    echo "K curling again"
done
