module Swow
  class ParseTimestamps < ::Faraday::Response::Middleware
    def initialize(app, options = {})
      @min_timestamp = bnet_timestamp(Time.new(2000, 1, 1).to_i)
      @max_timestamp = bnet_timestamp(Time.now.to_i + 3600 * 24 * 30)
      super(app)
    end

    def call(env)
      response = @app.call(env)
      parse_timestamps! response.env[:body]
      response
    end


    def bnet_timestamp(timestamp)
      timestamp * 1000
    end

    def parse_bnet_timestamp(timestamp)
      Time.at(timestamp / 1000)
    end

    def is_a_timestamp?(value)
      value.is_a?(Integer) && (value > @min_timestamp && value < @max_timestamp)
    end

    def parse_timestamps!(data)
      is_a_timestamp = -> (x) { is_a_timestamp?(x) }
      case data
      when is_a_timestamp
        parse_bnet_timestamp(data)
      when Array
        data.each_with_index { |element, index| data[index] = parse_timestamps!(element) }
      when Hash
        data.each { |key, value| data[key] = parse_timestamps!(value) }
      else
        data
      end
    end
  end

  Faraday::Response.register_middleware timestamps_parser: ParseTimestamps
end
