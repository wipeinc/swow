require "faraday"
require 'faraday_middleware/parse_oj'
require "oj"

module Swow

  class Client
  	REALM_STATUS_REQUEST = "/wow/realm/status"
  	include Swow::Constants

  	def initialize(api_key, region, locale: 'en_GB', logger: :logger)
  		raise "Invalid region #{region}" unless REGIONS.include?(region)

  		@api_key  = api_key
  		@locale = locale
  		@region = region

  		@conn = Faraday.new(url: base_url, params: default_params) do |builder|
  			  builder.request  :url_encoded             # form-encode POST params
  			  builder.response logger if logger
  			  builder.response :oj # parse json code
  			  builder.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  		end
  	end

  	def base_url
  		"https://#{@region}.api.battle.net"
  	end

  	def realm_status(locale: @locale)
  		request = @conn.get REALM_STATUS_REQUEST, {locale: locale}
  		request.body
  	end

  	private

  	def default_params
  		{ apikey: @api_key, locale: @locale }
  	end
  end
end