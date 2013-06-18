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
  
    def tweets(params={}, timeout=10)
      begin
        response = Timeout::timeout(timeout) do
          access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?#{hash_to_param(params)}")
        end
        
        if response.body.include?('errors')
          response.body
        else
          "{\"tweets\": #{response.body} }"
        end
      rescue Timeout::Error => e
       "{\"errors\": [{\"message\": \"TimeoutError. Twitter not responding within #{timeout} seconds\", \"code\": 500}]}"
      rescue SocketError => e  # if the site is down
        '{"errors": [{"message": "Sorry, it looks like twitter or the network is down", "code": 500}]}'
      end
    end
    
    # File activesupport/lib/active_support/core_ext/object/to_param.rb, line 50
    def hash_to_param(hash={}, namespace = nil)
      hash.collect do |key, value|
        value.to_query(namespace ? "#{namespace}[#{key}]" : key)
      end.sort * '&'
    end
  
  end
end