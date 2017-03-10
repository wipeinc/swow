module Swow
  class Client
    MOUNT_REQUEST = "/wow/mount/".freeze

    module Mount
      def mounts(locale: @locale)
        get MOUNT_REQUEST, locale: locale
      end
    end
  end
end
