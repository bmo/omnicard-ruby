require 'omnicard/version'

module Omnicard
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Omnicard::API}
    VALID_OPTIONS_KEYS = [
      :username,
      :password,
      :endpoint,
      :format,
      :user_agent,
      :adapter,
      :faraday_options,
      :faraday_logging].freeze

    # The adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # By default, don't set a username
    DEFAULT_USERNAME = nil

    # By default, don't set a password
    DEFAULT_PASSWORD = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note
    DEFAULT_ENDPOINT = 'https://api.omnicard.com/2.x/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json

    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "Omnicard Ruby Gem #{Omnicard::VERSION}".freeze

    DEFAULT_FARADAY_OPTIONS = {}.freeze

    DEFAULT_FARADAY_LOGGING = false

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Convenience method determining if pointed to the test env.
    def test?
      self.endpoint == DEFAULT_ENDPOINT
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.username           = DEFAULT_USERNAME
      self.password           = DEFAULT_PASSWORD
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.user_agent         = DEFAULT_USER_AGENT
      self.faraday_options    = DEFAULT_FARADAY_OPTIONS
      self
    end
  end
end