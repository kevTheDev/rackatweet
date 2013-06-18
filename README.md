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

## Testing

Run `rake test` to run the tests. A `Guardfile` is present to use with `Guard`.

## Thanks!

Jordan Elver for the idea
* https://github.com/jordelver