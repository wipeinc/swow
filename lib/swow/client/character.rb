module Swow
  class Client
    CHARACTER_PROFILE_REQUEST = "/wow/character".freeze

    module Character
      def character_profile(realm, name, fields: [], locale: @locale)
        fields = CharacterFields.new(fields)
        fields.validate!
        get("#{CHARACTER_PROFILE_REQUEST}/#{realm}/#{name}", fields: fields,
            locale: locale)
      end
    end
  end
end
