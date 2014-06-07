[![Code Climate](https://codeclimate.com/github/blairanderson/music-news.png)](https://codeclimate.com/github/blairanderson/music-news)
[![Build Status](https://travis-ci.org/blairanderson/music-news.svg?branch=master)](https://travis-ci.org/blairanderson/music-news)
[![Coverage Status](https://coveralls.io/repos/blairanderson/music-news/badge.png?branch=master)](https://coveralls.io/r/blairanderson/music-news?branch=master)



	```
	$ heroku pgbackups:capture --expire --account personal
	$ dropdb <your_dev_db>
	$ heroku pg:pull HEROKU_POSTGRESQL_<COLOR> <your_dev_db> --account personal
	```

```bash

bash -c 'echo "POSTMARK_API_KEY=`heroku config:get POSTMARK_API_KEY --account personal`" >> .env'
bash -c 'echo "POSTMARK_SMTP_SERVER=`heroku config:get POSTMARK_SMTP_SERVER --account personal`" >> .env'
bash -c 'echo "POSTMARK_INBOUND_ADDRESS=`heroku config:get POSTMARK_INBOUND_ADDRESS --account personal`" >> .env'

```

##Goals
[ ] It should be super easy to add a song to a list

[ ] Should be super easy to listen to music

[ ] Songs should be taggable

[ ] Should have playlists for latest/greatest/favorites

[ ] Should be able to view playlists for specific tags

[ ] should be able to create a blog post very simply from viewing any view

[ ] should be able to view an "artists" page with a bunch of their music available.

[ ] artist page should include youtube/bandcamp if available.

## Getting Started


`git clone git@github.com:blairanderson/music-news.git`

`bundle install`

`rake db:migrate db:test:prepare`

`rake` to run the tests

update environment variables

```bash

SOUNDCLOUD_ID:              <get this from soundcloud>
SOUNDCLOUD_SECRET:          <get this from soundcloud>
TWITTER_CONSUMER_KEY:       <get this from twitter>
TWITTER_CONSUMER_SECRET:    <get this from twitter>

```

if you have a wordpress blog that you'd like to publish to, then you can set these as well(would love to know a better way to do this...)

```bash

WORDPRESS_URL:              http://wordpressmusicblog.com/wp-login.php
WORDPRESS_USERNAME:         admin
WORDPRESS_PASSWORD:         passw0rt

```
