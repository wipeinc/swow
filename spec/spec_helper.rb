# require simplecov before anything else
if ENV["CI"] || ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "swow"
require 'vcr'
require 'dotenv'

Dotenv.load


VCR.configure do |c|
	c.cassette_library_dir = 'spec/cassettes'
	c.hook_into :faraday
	c.configure_rspec_metadata!
	c.filter_sensitive_data('BNET_API_KEY') { ENV["BNET_API_KEY"] }
	c.default_cassette_options = {
		:record => :once,
		:match_requests_on => [
		  	:host,
		  	:method,
		  	VCR.request_matchers.uri_without_param(:apikey)
  		] }	

end

