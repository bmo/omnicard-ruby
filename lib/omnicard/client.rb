module Omnicard
  # Wrapper for the Omnicard API
  #
  # @note All methods have been separated into modules
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.

    require 'omnicard/client/cache'
    require 'omnicard/client/auth'
    require 'omnicard/client/funds'
    require 'omnicard/client/egifts'
    require 'omnicard/client/orders'
    require 'omnicard/client/cards'
    require 'omnicard/client/vcards'

    alias :api_endpoint :endpoint

    include Omnicard::Client::Cache
    include Omnicard::Client::Auth
    include Omnicard::Client::Funds
    include Omnicard::Client::EGifts
    include Omnicard::Client::Orders
    include Omnicard::Client::Cards
    include Omnicard::Client::VCards

  end
end