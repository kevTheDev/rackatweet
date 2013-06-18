rackatweet
==========

# Rackatweet - Tweets as JSON via a rack app

A very simple rack app to provide a twitter timeline as JSON.

## Install

### Rails

In `Gemfile`

    gem 'rackatweet'

In `routes.rb`

    <AppName>::Application.routes.draw do
      match "/tweets.json", :to => Rackatweet::App.new
    end


You can use any of the twitter API params in the URL like:

    GET '/tweets.json?count=2&screen_name=kev_the_dev

See: https://dev.twitter.com/docs/api/1.1/get/statuses/user_timeline
  
    Valid params:

    count
    user_id
    screen_name
    since_id
    max_id
    trim_user
    exclude_replies
    contributor_details
    include_rts
    
## Testing

Run `rake test` to run the tests. A `Guardfile` is present to use with `Guard`.

## Thanks!

Jordan Elver for the idea
* https://github.com/jordelver