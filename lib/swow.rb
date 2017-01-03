require "faraday"
require 'faraday_middleware/parse_oj'
require "oj"

require "swow/version"
require "swow/constants"
require "swow/error"
require "swow/client"

module Swow
  include Swow::Constants
  include Swow::Error
end
