module Swow
  class Client
    AUCTION_DATA_STATUS_REQUEST = "/wow/auction/data".freeze

    module Auction
      def auction_data_status(realm, locale: @locale)
        params = clean_params({locale: locale})
        request = @conn.get("#{AUCTION_DATA_STATUS_REQUEST}/#{realm}",
                            params)
        request.body
      end
    end
  end
end
