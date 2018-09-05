#!/bin/bash
# Usage:    ./reviewsandratings2csv.sh filename
# Wesley Chavez 09-05-18

# fbname is the basename of the movie without directory or extension
echo "$fbname"
fbname=$(basename "$1" .txt)
echo "$fbname"

# 0/5 -> 0 on the same line as the corresponding review.
# vim needs to know the basename (:t:r) to save as .csv 
vim -c ':%s/\n0\/5\n/,0\r/g' \
    -c ':%s/\n1\/5\n/,1\r/g' \
    -c ':%s/\n2\/5\n/,2\r/g' \
    -c ':%s/\n3\/5\n/,3\r/g' \
    -c ':%s/\n4\/5\n/,4\r/g' \
    -c ':%s/\n5\/5\n/,5\r/g' \
    -c ':let writefile=expand("%:t:r") . ".csv"' \
    -c 'exec "write" writefile' \
    -c ':q!' "$1"

# 0.0/5 -> 0
vim -c ':%s/\n0\.0\/5\n/,0\r/g' \
    -c ':%s/\n1\.0\/5\n/,1\r/g' \
    -c ':%s/\n2\.0\/5\n/,2\r/g' \
    -c ':%s/\n3\.0\/5\n/,3\r/g' \
    -c ':%s/\n4\.0\/5\n/,4\r/g' \
    -c ':%s/\n5\.0\/5\n/,5\r/g' \
    -c ':wq' "$fbname.csv"

# 0.5/5 -> 0.5
vim -c ':%s/\n0\.5\/5\n/,0.5\r/g' \
    -c ':%s/\n1\.5\/5\n/,1.5\r/g' \
    -c ':%s/\n2\.5\/5\n/,2.5\r/g' \
    -c ':%s/\n3\.5\/5\n/,3.5\r/g' \
    -c ':%s/\n4\.5\/5\n/,4.5\r/g' \
    -c ':%s/\n5\.5\/5\n/,5.5\r/g' \
    -c ':wq' "$fbname.csv"

# 0/10 -> 0
vim -c ':%s/\n0\/10\n/,0\r/g' \
    -c ':%s/\n1\/10\n/,0.5\r/g' \
    -c ':%s/\n2\/10\n/,1\r/g' \
    -c ':%s/\n3\/10\n/,1.5\r/g' \
    -c ':%s/\n4\/10\n/,2\r/g' \
    -c ':wq' "$fbname.csv"

# 5/10 -> 2.5
# Delete all lines without ".,"
# Up to 10 vim commands per bash command
vim -c ':%s/\n5\/10\n/,2.5\r/g' \
    -c ':%s/\n6\/10\n/,3\r/g' \
    -c ':%s/\n7\/10\n/,3.5\r/g' \
    -c ':%s/\n8\/10\n/,4\r/g' \
    -c ':%s/\n9\/10\n/,4.5\r/g' \
    -c ':%s/\n10\/10\n/,5\r/g' \
    -c ':%g!/\.,/d' \
    -c ':wq' "$fbname.csv"
