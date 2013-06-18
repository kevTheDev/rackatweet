
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
      
      timeline_params = timeline_params(request)
      tweets          = timeline.tweets(timeline_params)
      
      json = {
        tweets: tweets
      }.to_json

      [200, {'Content-Type' => 'application/json'}, [json]]
    end

    private
    
    # Options that we will pass via AJAX
    
    # can we have the oauth config here as well?

    def count(request)
      begin
        return request.params.fetch('count')
      rescue KeyError => e
        return 1
      end
    end
    
    def timeline_param(request, param_key)
      begin
        return request.params.fetch(param_key)
      rescue KeyError => e
        return nil
      end
      
    end
    
    def timeline_params(request)
      params = { count: count(request) }

      set_request_param_unless_nil(request, params, 'user_id')
      set_request_param_unless_nil(request, params, 'screen_name')
      set_request_param_unless_nil(request, params, 'since_id')
      set_request_param_unless_nil(request, params, 'max_id')
      set_request_param_unless_nil(request, params, 'trim_user')
      set_request_param_unless_nil(request, params, 'exclude_replies')
      set_request_param_unless_nil(request, params, 'contributor_details')
      set_request_param_unless_nil(request, params, 'include_rts')
      
      params
    end
    
    
    def set_request_param_unless_nil(request, hash, key)
      value     = timeline_param(request, key)
      hash[key] = value unless value.nil?
    end
    
  end
end

