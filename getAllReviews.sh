#!/bin/bash
# Gets all critic review pages for each movie in the top 100 movies from 
# 1980 to 2018
# Usage: ./getAllReviews.sh
# Wesley Chavez 08-25-18

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
for i in {1980..2018}; do
    while IFS='' read -r line || [[ -n "$line" ]]; do
        "$SCRIPTPATH/getReviews.sh" $line
    done < "$SCRIPTPATH/years/$i.txt"
done
