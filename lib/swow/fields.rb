require "forwardable"
require "set"

module Swow
  class Fields
    extend Forwardable

    def_delegators :@fields, :size, :each, :empty?
    include Enumerable

    def initialize(fields, valid_fields)
      @valid_fields = valid_fields.to_set.flatten
      if fields == :all
        @fields = @valid_fields
      else
        if fields.is_a? Enumerable
          @fields = fields.to_set.flatten
        else
          @fields = Set.new [fields]
        end
      end
    end

    def valid?
      @fields.subset?(@valid_fields)
    end

    def validate!
      raise "Invalid fields: #{@fields.inspect}" unless valid?
    end
  end

  class CharacterFields < Fields
    def initialize(fields)
      super(fields, Swow::Constants::CHARACTER_FIELDS)
    end
  end


  class GuildFields < Fields
    def initialize(fields)
      super(fields, Swow::Constants::GUILD_FIELDS)
    end
  end
end
