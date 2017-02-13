module Swow
  class Client
    CHARACTER_CLASSES_REQUEST = "/wow/data/character/classes".freeze

    module Data
      def character_classes(locale: @locale)
        get CHARACTER_CLASSES_REQUEST, locale: locale
      end
    end
  end
end
