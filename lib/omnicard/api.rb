require 'omnicard/authentication'
require 'omnicard/configuration'
require 'omnicard/connection'
require 'omnicard/request'

module Omnicard
  # @private
  class API
    include Connection
    include Request
    include Authentication

    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Omnicard.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
      init_cache
    end
  end
end

