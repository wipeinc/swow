module Swow
  class Client
    GUILD_PROFILE_REQUEST = "/wow/guild".freeze

    module Guild
      def guild_profile(realm, name, fields: [], locale: @locale)
        fields = GuildFields.new(fields)
        fields.validate!
        get("#{GUILD_PROFILE_REQUEST}/#{realm}/#{name}", fields: fields,
            locale: locale)
      end
    end
  end
end
