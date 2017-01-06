module Swow

  class Client
  	REALM_STATUS_REQUEST = "/wow/realm/status".freeze
    CHARACTER_PROFILE_REQUEST = "/wow/character".freeze

  	include Swow::Constants

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

  	def realm_status(locale: @locale)
  		request = @conn.get REALM_STATUS_REQUEST, {locale: locale}
  		request.body
  	end


    def character_profile(realm, name, fields: [], locale: @locale)
      fields = CHARACTER_FIELDS if fields == :all
      fields = [fields].flatten
      if !fields.empty? && !fields.all? { |field| CHARACTER_FIELDS.include?(field) }
        raise "Invalid field array #{field}"
      end

      params = {fields: fields, locale: locale}.select { |_, v| !v.empty? && !v.nil? }
      request = @conn.get("#{CHARACTER_PROFILE_REQUEST}/#{realm}/#{name}",
                          params)
      request.body

    end

  	private

  	def default_params
  		{ apikey: @api_key, locale: @locale }
  	end
  end
end
