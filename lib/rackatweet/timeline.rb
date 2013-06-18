require 'oauth'

module Rackatweet
  class Timeline
  
    attr_reader :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret
  
    def initialize(options={})
      @consumer_key       = options.fetch(:consumer_key)
      @consumer_secret    = options.fetch(:consumer_secret)
      @oauth_token        = options.fetch(:oauth_token)
      @oauth_token_secret = options.fetch(:oauth_token_secret)
    end
  
    def oauth_token_hash
      { 
        oauth_token: oauth_token,
        oauth_token_secret: oauth_token_secret
      }
    end
  
    def consumer
      @consumer ||= OAuth::Consumer.new(consumer_key, consumer_secret, { site: "http://api.twitter.com", scheme: :header })
    end
  
    # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
    def access_token
      @access_token ||= OAuth::AccessToken.from_hash(consumer, oauth_token_hash )
    end
  
    def tweets
      # use the access token as an agent to get the home timeline
      response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?&include_rts=false")
      JSON.parse(response.body).first
    end
  
  end
end