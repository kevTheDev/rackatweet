require 'json'

module Rackatweet
  class App
    attr_writer :geo_ip

    def call(env)
      request = Rack::Request.new(env)
      
      number_of_tweets = number_of_tweets(request)
      
      
      
      # fetch the tweets

      
      # 1 twitter_username = from params
      
      # number_of_tweets = from params
      
      # 2 tweets = 
      
      # 3 stick in json format

      # json = {
#         country: country
#       }.to_json

      [200, {'Content-Type' => 'application/json'}, [json]]
    end

    private

    def number_of_tweets(request)
      begin
        request.params.fetch('tweet_count')
      rescue KeyError => e
        # do something here
      end
    end
    
  end
end

