require "swow/client/realm"
require "swow/client/character"
require "swow/client/data"
require "swow/client/auction"
require "swow/client/item"
require "swow/client/guild"

module Swow

  class Client

  	include Swow::Constants

    include Swow::Client::Realm
    include Swow::Client::Character
    include Swow::Client::Data
    include Swow::Client::Auction
    include Swow::Client::Item
    include Swow::Client::Guild

  	def initialize(api_key, region, locale: 'en_GB', logger: :logger)
  		raise "Invalid region #{region}" unless REGIONS.include?(region)

  		@api_key  = api_key
  		@locale = locale
  		@region = region

  		@conn = Faraday.new(url: base_url, params: default_params) do |builder|
  			  builder.request  :url_encoded
  			  builder.response :detailed_logger, logger if logger
          builder.response :battlenet_errors
          builder.response :timestamps_parser
  			  builder.response :oj # parse json code

          builder.options[:params_encoder] = Swow::ParamsEncoder
  			  builder.adapter  Faraday.default_adapter
  		end
  	end

  	def base_url
  		"https://#{@region}.api.battle.net"
  	end

  	private

    def get(path, fields: {}, locale: @locale)
      path = Addressable::URI.parse(path).normalize.path
      params = clean_params({fields: fields, locale: locale})
      @conn.get(path, params)
    end

    def clean_params(params)
      params.select { |_, v| !v.nil? && !v.empty? }
    end

  	def default_params
  		{ apikey: @api_key, locale: @locale }
  	end
  end
end
