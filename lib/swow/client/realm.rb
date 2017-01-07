module Swow
  class Client
    module Realm
      def realm_status(locale: @locale)
        request = @conn.get REALM_STATUS_REQUEST, {locale: locale}
        request.body
      end
    end
  end
end
