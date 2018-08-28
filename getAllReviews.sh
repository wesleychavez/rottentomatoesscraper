#!/bin/bash
# Gets 100 review pages for each movie in the top 100 movies from 
# 1980 to 2018
# Usage: ./getAllReviews.sh
# Wesley Chavez 08-25-18

for i in {1980..2018}; do
    while IFS='' read -r line || [[ -n "$line" ]]; do
        ./getReviews.sh $line 100
    done < "$i.txt"
done
