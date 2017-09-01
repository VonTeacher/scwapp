# Sun City West
## Golf Handicap Calculator

## Contents

- [What is it?](#what-is-it)
- [Why make it?](#why-make-it)
- [Challenges](#challenges)
- [Progress](#progress)

### What is it?

This app is a way to store and calculate handicap scores for golf. Handicaps are a numerical measure of a golfer's potential ability, but calculating them by hand is tedious and error-prone. The Sun City Weiss Golf Handicap Calculator keeps track of a golfer's scores and - once they have played enough rounds - uses a specific arithmetic formula developed by the USGA to approximate a player's potential to make par in relation to a tee's difficulty.

### Why make it?

My dad is an avid golfer and was keeping track of his scores, and those of his friends, in a spreadsheet. This required storing course ratings and slopes for every course played, adding courses in cases where someone played a new course, keeping track of the latest 20 rounds (out of which the best 10 are used for calculation), and manually sorting the scores and performing the final handicap calculations.

We spoke one day and he asked me if I would be able to build an app to take care of all the work he was doing. And that's how it began.

### Challenges

The first challenge was working on a wireframe. I sketched a couple of ideas that seemed to make sense to me. Over time, I simplified the design and went with a very basic model as the users of this app aren't looking for advanced functionality.

The second challenge regarded database setup. Setting up associations between users, rounds, courses, and tees took more time than I thought it would, but I believe I ended up with a simple design that meets normalization standards.

!["Table schema for the golf-app"](app/assets/images/golf-app-tables.PNG)

Lastly, there was a question about how to add new courses. Given that a large majority of rounds will be played on the courses in his community, it made sense to pre-populate the database with those records. But in the case of adding new courses, having a form to input course and tee information was my default solution. Then one day my dad got in touch to let me know about the USGA's National Course Registry Database. It has information on all USGA-registered courses in the country. This got me thinking about using a scraper to pull information from the registry, allowing the user to simply enter a course name, city, and state to begin a search for new courses to add.

The main challenge going forward is ensuring that the scraped data is accurate, that edge cases are considered (i.e. what if there are similarly named golf courses? what if the USGA changes the HTML and CSS layout of their listing page?), that the scraper is cleanly integrated into the Rails app (and by this I mean organized according to OOP principles and not just thrown in haphazardly), and that the final calculations are actually as expected.

### Progress

- [x] Write a basic scraper using Mechanize and collect all the information listed on a certain course's page for the selected tee (based on tee color and player gender).
- [ ] Take the data from this scrape and store it in the database.
- [ ] Present that newly stored information to the user and allow them to select it as an option for a new Round, as it is likely that a course being recently added correlates with a round recently played.
- [ ] Add a form for entering new Round data.
- [ ] Implement the handicap index calculation: this requires at least 5 rounds played and should only consider up to the most recent 20 rounds played. A [step-by-step explanation of the formula is laid out here](http://golfsoftware.com/hsd/golf-handicap-formula.html){:target="_blank"}.
- [ ] Ensure that the handicap index value is updated after a new Round entry is made.
