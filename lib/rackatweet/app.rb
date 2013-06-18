
require 'json'

module Rackatweet
  class App

    def call(env)
      request = Rack::Request.new(env)
      
      timeline = Timeline.new({
        consumer_key: TEST_CONSUMER_KEY,
        consumer_secret: TEST_CONSUMER_SECRET,
        oauth_token: TEST_OAUTH_TOKEN,
        oauth_token_secret: TEST_OAUTH_TOKEN_SECRET
      })
      
      tweets = timeline.tweets(tweet_count(request))
      
      json = {
        tweets: tweets
      }.to_json

      [200, {'Content-Type' => 'application/json'}, [json]]
    end

    private

    def tweet_count(request)
      begin
        return request.params.fetch('tweet_count')
      rescue KeyError => e
        return 1
      end
    end
    
  end
end

