module Omnicard
  # @private
  module Authentication
    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
       {
              username: username,
              password: password
       }
    end

    # Check whether user is has been authenticated
    #
    # @return [Boolean]

    # @TODO see if we have a session ID
    
    def authenticated?
      !@auth_token.nil?
    end
  end
end