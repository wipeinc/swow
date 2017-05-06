require 'thor'
require 'json'


module Swow
  module CLI
    def self.start(*args)
      Main.start(*args)
    end

    class Main < Thor
      OJ_MIMIC_ON_TYPES = [Array, Hash, Integer, String, DateTime, Date, Time]

      class_option :key, type: :string,
                         desc: 'Battle.net API Key'
      class_option :locale, type: :string,
                            desc: 'Battle.net result default locale',
                            default: 'en_GB'
      class_option :to_json, type: :boolean,
                             default: false,
                             desc: 'Output the result in JSON format'
      class_option :headers, type: :boolean,
                             default: false,
                             desc: 'Add headers to the result'

      method_option :fields, type: :array, default: [],
                             aliases: '-f'

      desc 'character [region] [realm] [character]', 'fetching character data'
      def character_profile(region, realm, character)
        unless (options['fields'] - Swow::Constants::CHARACTER_FIELDS.to_a).empty?
          raise ArgumentError, "invalid fields #{options['fields'].join(',')}"
        end
        client = Swow::Client.new(options["key"], region,
                                  locale: options['locale'])
        profile = client.character_profile(realm, character,
                                           fields: options['fields'])
        print(profile)
      end

      private
      def print(answer)
        if options['to_json']
          puts JSON.pretty_generate(answer.body)
        else
          if options['headers']
            puts '-- HEADERS --'
            Swow.pp answer.headers
            puts "\n"
            puts '-- BODY --'
          end
          Swow.pp answer.body
        end
      end
    end
  end
end
