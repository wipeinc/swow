module Swow
  class Client
    REALM_STATUS_REQUEST = "/wow/realm/status".freeze
    module Realm
      def realm_status(locale: @locale)
        get REALM_STATUS_REQUEST, locale: locale
      end
    end
  end
end
