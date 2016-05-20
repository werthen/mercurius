☿ mercurius [![Build Status](https://travis-ci.org/werthen/mercurius.svg?branch=master)] (https://travis-ci.org/werthen/mercurius)[![Coverage Status](https://coveralls.io/repos/github/werthen/mercurius/badge.svg?branch=master)](https://coveralls.io/github/werthen/mercurius?branch=master)[![Code Climate](https://codeclimate.com/github/werthen/mercurius/badges/gpa.svg)](https://codeclimate.com/github/werthen/mercurius)
---------

Improved programme catalogue of Ghent University

## Installation

1. Install postgres
2. Create mercurius role in postgres with CREATEDB permissions as follows: `CREATE ROLE mercurius WITH SUPERUSER CREATEDB LOGIN PASSWORD '';`
3. Execute `bundle install` in the project folder
4. Execute `rake db:setup`
5. Execute `rake scraper:scrape` to initiate the data gathering
6. `rails s` and you're off!
