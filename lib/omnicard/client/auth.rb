
module Omnicard
  class Client

    require 'digest/sha1'

    def try_with_relogin
      begin
        yield
      rescue Error => ex
        raise unless [Unauthorized, Forbidden].include?(ex.class)
        logger.debug("HANDLING ERROR, TRYING TO RELOGIN")
        login(true)
        yield
      end
    end

    module Auth

      def login(no_cache=false, options={})
        logger.debug("Login")
        if no_cache == false && !(@auth_token = (options[:auth_token] || cached_auth_token)).nil?
          logger.debug("Using Cached Credentials")
           return true  # we think we have an auth token
        end

        logger.debug("Authorizing")
        @auth_token = nil if no_cache


        response = post('apiUsers/auth.json', authentication)

        if response.response.status == 1000
           @auth_token = response.response.message
           set_cached_auth_token(@auth_token)
           true                                       
        else   # may not get here since middleware may catch it.
           @auth_token = nil
           set_cached_auth_token(@auth_token)
           raise Omnicard::Unauthorized.new('Unauthorized', response.response, response.error)
        end
      end

      def authenticated?
        !@auth_token.nil?
      end
    end
  end
end
