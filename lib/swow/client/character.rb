module Swow
  class Client
    module Character
      def character_profile(realm, name, fields: [], locale: @locale)
        fields = CharacterFields.new(fields)
        params = clean_params({fields: fields, locale: locale})
        request = @conn.get("#{CHARACTER_PROFILE_REQUEST}/#{realm}/#{name}",
                            params)
        request.body
      end
    end
  end
end
