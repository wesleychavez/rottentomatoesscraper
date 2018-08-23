# rottentomatoesscraper
Saves critic reviews and ratings for a movie on rottentomatoes.com

Requires: just Linux

Usage:

```bash getReviews.sh movie_name number_of_reviewpages```

Note: as of now, there are 20 reviews per page

Note: The movie name must match the Rotten Tomatoes url.

To get 40 reviews for "The Meg" (https://www.rottentomatoes.com/m/the_meg):

```bash getReviews.sh the_meg 2```

To get all the reviews, set number_of_reviewpages to a ridiculously high number.
