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


#### OAuth

Create a twitter application at: https://dev.twitter.com/apps

Make a note of your consumer_key, consumer_secret, oauth_token, and oauth_token_secret

If you are using Rails, then create an initializer like:

    if defined?(Rackatweet)
      Rackatweet::Config.consumer_key = ENV['CONSUMER_KEY']
      Rackatweet::Config.consumer_secret = ENV['CONSUMER_SECRET']
      Rackatweet::Config.oauth_token = ENV['OAUTH_TOKEN']
      Rackatweet::Config.oauth_token_secret = ENV['OAUTH_TOKEN_SECRET']
      Rackatweet::Config.timeout = ENV['TIMEOUT'] # optional - default is 10s
    end

Start the rails server in development:
    
    CONSUMER_KEY=k6CTN1GQrctgHKv5nz9Dgg CONSUMER_SECRET=CwnPSXKph85qlc7hJ0RyxeaIBGdPwY367AvLU1Ysa3M OAUTH_TOKEN=15569673-BCnAfXMSIHp7fokQ9qNRrglqPBo2FvgowbvJziISw OAUTH_TOKEN_SECRET=bBsHBUF7IrFSlyOhPnTPwn6BWywcrl5z6LGX6QnbMs8 rails server

Or on heroku add the following config variables:

    CONSUMER_KEY
    CONSUMER_SECRET
    OAUTH_TOKEN
    OAUTH_TOKEN_SECRET
    
The OAUTH token should never expire. The rack app will make the access token request only once. So if you restart the server it will happen again.
    
Optionally set the TIMEOUT variable

    TIMEOUT=10 sets the timeout to 10s when accessing the twitter API, the default is 10 (accepts float or integer value)


### Twitter API Params


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
    
    
Responses:

Successful response:

    {
      "tweets": []
    }

Error:

    {
      "errors": ["message": "Error message", "code": statusCode]
    }

Errors returned by the twitter API are handled as above.

There are two additional errors, SocketError & TimeoutError both with a statusCode of 500


## Thanks!

Jordan Elver for the idea
* https://github.com/jordelver