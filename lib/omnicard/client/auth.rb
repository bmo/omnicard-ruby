
module Omnicard
  class Client

    require 'digest/sha1'

    def try_with_relogin
      begin
        yield
      rescue Error => ex
        raise unless [Unauthorized, Forbidden].include?(ex.class)
        # "HANDLING ERROR, TRYING TO RELOGIN"
        yield
      end
    end

    module Auth

      def login(no_cache=false, options={})

        if no_cache == false && !(@auth_token = (options[:auth_token] || cached_auth_token)).nil?
           return true  # we think we have an auth token
        end

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
