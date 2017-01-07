require "swow/client/realm"
require "swow/client/character"

module Swow

  class Client
  	REALM_STATUS_REQUEST = "/wow/realm/status".freeze
    CHARACTER_PROFILE_REQUEST = "/wow/character".freeze

  	include Swow::Constants

    include Swow::Client::Realm
    include Swow::Client::Character

  	def initialize(api_key, region, locale: 'en_GB', logger: :logger)
  		raise "Invalid region #{region}" unless REGIONS.include?(region)

  		@api_key  = api_key
  		@locale = locale
  		@region = region

  		@conn = Faraday.new(url: base_url, params: default_params) do |builder|
  			  builder.request  :url_encoded
  			  builder.response :detailed_logger, logger if logger
          builder.response :battlenet_errors
  			  builder.response :oj # parse json code

          builder.options[:params_encoder] = Swow::ParamsEncoder
  			  builder.adapter  Faraday.default_adapter
  		end
  	end

  	def base_url
  		"https://#{@region}.api.battle.net"
  	end

  	private

    def clean_params(params)
      params.select { |_, v| !v.nil? && !v.empty? }
    end

  	def default_params
  		{ apikey: @api_key, locale: @locale }
  	end
  end
end
