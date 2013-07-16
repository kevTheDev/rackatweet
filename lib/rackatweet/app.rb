require 'json'
require 'timeout'

module Rackatweet
  class App

    def call(env)
      request = Rack::Request.new(env)
      
      timeline = Timeline.new({
        consumer_key: Config.consumer_key,
        consumer_secret: Config.consumer_secret,
        oauth_token: Config.oauth_token,
        oauth_token_secret: Config.oauth_token_secret
      })
      
      timeline_params = timeline_params(request)
      
      json            = timeline.tweets(timeline_params, Config.timeout)
      status_code     = json.include?('errors') ? 500 : 200
      
      # We could change the status code here
      [status_code, {'Content-Type' => 'application/json', 'Cache-Control' => "public, max-age=#{Config.cache_expires_in}"}, [json]]
    end

    private
    
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

