require 'omnicard/api'
require 'omnicard/client'
require 'omnicard/configuration'
require 'omnicard/error'


module Omnicard
  extend Configuration
  class << self
    # Alias for Omnicard::Client.new
    #
    # @return [Omnicard::Client]
    def new(options={})
      Omnicard::Client.new(options)
    end

    private
    # Delegate to Omnicard::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end