require "forwardable"

module Swow
  class Fields
    extend Forwardable

    def_delegators :@fields, :size, :each, :empty?
    include Enumerable

    def initialize(fields, valid_fields)
      @valid_fields = valid_fields
      fields = @valid_fields if fields == :all
      fields = [fields].flatten
      @fields = fields
    end

    def valid?
      @fields.empty? || @fields.all? { |field| @valid_fields.include?(field) }
    end

    def validate!
      raise "Invalid field array #{@field}" unless valid?
    end
  end

  class CharacterFields < Fields
    def initialize(fields)
      super(fields, Swow::Constants::CHARACTER_FIELDS)
    end
  end
end
