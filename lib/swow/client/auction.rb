module Swow
  class Client
    AUCTION_DATA_STATUS_REQUEST = "/wow/auction/data".freeze

    module Auction
      def auction_data_status(realm, locale: @locale)
        get("#{AUCTION_DATA_STATUS_REQUEST}/#{realm}", locale: locale)
      end
    end
  end
end
