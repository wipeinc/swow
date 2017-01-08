module Swow
  class Client
    CHARACTER_PROFILE_REQUEST = "/wow/character".freeze

    module Character
      def character_profile(realm, name, fields: [], locale: @locale)
        fields = CharacterFields.new(fields)
        fields.validate!
        params = clean_params({fields: fields, locale: locale})
        request = @conn.get("#{CHARACTER_PROFILE_REQUEST}/#{realm}/#{name}",
                            params)
        request.body
      end
    end
  end
end
