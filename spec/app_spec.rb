require 'rubygems'
gem 'minitest'

require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'
require_relative '../lib/geo-ip-json'

include Rack::Test::Methods

def app
  Rack::Lint.new(@app)
end

# Setup our rack app as we would with a config.ru file
def mock_app(options = {})

  # Create a mock to pass to the app
  #mock = MiniTest::Mock.new
  #mock.expect(:country, { country_code2: options[:country] }, options[:ip])

  builder = Rack::Builder.new do
    map '/rackatweets.json' do
      app = Rackatweet::App.new
      #app.geo_ip = mock
      run app
    end
  end

  @app = builder.to_app
end

describe "Rackatweet" do

  describe "valid IP address" do

    it "must return the country code" do
      mock_app(:country => 'us', :ip => ['1.2.3.4'])

      get '/geoip.json?ip=1.2.3.4'

      assert_equal 200, last_response.status

      json = JSON.parse(last_response.body)
      json['country'].must_equal 'us'
    end

    it "must use the request IP if the ip parameter is missing" do
      mock_app(:country => 'gb', :ip => ['4.5.6.7'])

      get '/geoip.json', nil, { 'REMOTE_ADDR' => '4.5.6.7' }

      assert_equal 200, last_response.status

      json = JSON.parse(last_response.body)
      json['country'].must_equal 'gb'
    end
  end

  describe "invalid IP address" do

    it "must return return an empty string if the ip is bogus" do
      mock_app(:country => '', :ip => ['not-an-ip-address'])

      get '/geoip.json?ip=not-an-ip-address'

      assert_equal 200, last_response.status

      json = JSON.parse(last_response.body)
      json['country'].must_equal ''
    end
  end
end
