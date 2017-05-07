$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'simplecov'
SimpleCov.start
require "swow"
require 'vcr'
require 'dotenv'

Dotenv.load


if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

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

