require 'singleton'

module Swow
  class Print
    include Singleton
    def initialize
      begin
        require 'awesome_print'
        @print_method = :ap
      rescue LoadError
        require 'pp'
        @print_method = :pp
      end
    end


    def pretty_print(content)
      Kernel.send(@print_method, content)
    end
  end

  class << self
    def pretty_print(content)
      Print.instance.pretty_print(content)
    end

    alias_method :pp, :pretty_print
  end
end
