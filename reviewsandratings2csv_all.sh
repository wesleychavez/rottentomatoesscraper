#!/bin/bash
# Usage:    ./reviewsandratings2csv.sh
# Wesley Chavez 09-05-18

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

for filename in $SCRIPTPATH/reviews/*; do
    ./reviewsandratings2csv.sh $filename
done
