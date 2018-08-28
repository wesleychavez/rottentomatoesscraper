# rottentomatoesscraper
Saves critic reviews and ratings for the best movies on rottentomatoes.com

Requires: just Linux

To scrape all reviews and ratings from 1980-2018,
```
./getMovies.sh
./getAllReviews.sh
```

Usage:

```bash getReviews.sh movie_name number_of_reviewpages```

This saves `number_of_reviewpages` text files, each with ratings and reviews separated 
by a new line, with no spaces before or after the reviews or ratings. 
```
review0
rating0
review1
rating1
...
```
If there is no rating (rating0 doesn't exist) for a given review, 
```
review0
review1
rating1
...
```
Note: as of now, there are 20 reviews per page

Note: The movie name must match the Rotten Tomatoes url.

To get 40 reviews (2 pages) for "The Meg" (https://www.rottentomatoes.com/m/the_meg):

```bash getReviews.sh the_meg 2```

To get all the reviews, set number_of_reviewpages to a ridiculously high number.
