module Swow
  class Client
    ITEM_REQUEST = "/wow/item".freeze

    module Item
      def item(itemid, locale: @locale)
        raise "itemid: #{itemid} is not a valid item id" if itemid.to_i == 0
        get("#{ITEM_REQUEST}/#{itemid}", locale: locale)
      end
    end
  end
end
