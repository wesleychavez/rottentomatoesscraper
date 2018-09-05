# rottentomatoesscraper
Saves critic reviews and ratings for the best movies on rottentomatoes.com

Requires: just Linux

To scrape all reviews and ratings from 1980-2018,
```
./getMovies.sh
./getAllReviews.sh
```
getAllReviews.sh calls getReviews.sh for each movie.  If you want to get ratings for a specific movie,

`./getReviews.sh movie_name`

Note: The movie name must match the Rotten Tomatoes url.

To get reviews for "The Meg" (https://www.rottentomatoes.com/m/the_meg):

```bash getReviews.sh the_meg```

This saves text files, each with up to 20 ratings and reviews separated 
by a new line, with no spaces before or after the reviews or ratings. 
```
review0
rating0
review1
rating1
...
```
If there is no rating (rating0 doesn't exist) for a given review, a line is ommitted. 
```
review0
review1
rating1
...
```
If there is no review (review1 doesn't exist) for a given rating, a new line is in place of the review.
```
review0
rating0

rating1
...
```
Note: as of now, there are up to 20 reviews per page.

After scraping the reviews and ratings with 
```
./getMovies.sh
./getAllReviews.sh
```
you can format the reviews and corresponding ratings nicely in .csv files with `./reviewsandratings2csv_all.sh`.
This calls `./reviewsandratings2csv.sh` for every file in `reviews/`.

`reviewsandratings2csv.sh` will only save the reviews for which there is a rating that is in increments of 0.5 out of 5 stars, or increments of 1 out of 10 stars.

