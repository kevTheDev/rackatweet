
require 'json'

module Rackatweet
  class App

    def call(env)
      request = Rack::Request.new(env)
      
      number_of_tweets = number_of_tweets(request)
      
      timeline = Timeline.new({
        consumer_key: TEST_CONSUMER_KEY,
        consumer_secret: TEST_CONSUMER_SECRET,
        oauth_token: TEST_OAUTH_TOKEN,
        oauth_token_secret: TEST_OAUTH_TOKEN_SECRET
      })
      
      tweets = timeline.tweets
      
      
      # number_of_tweets = from params
      
      # 2 tweets = 
      
      # 3 stick in json format

      json = {
        tweets: tweets
      }.to_json

      [200, {'Content-Type' => 'application/json'}, [json]]
    end

    private

    def number_of_tweets(request)
      begin
        return request.params.fetch('tweet_count')
      rescue KeyError => e
        return 1
      end
    end
    
  end
end

