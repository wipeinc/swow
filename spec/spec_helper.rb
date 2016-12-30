$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "swow"
require 'vcr'
require 'webmock'
require 'dotenv'

Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!
  c.filter_sensitive_data('BNET_API_KEY') { ENV["BNET_API_KEY"] }
  c.default_cassette_options = { :record => :all  }

end

