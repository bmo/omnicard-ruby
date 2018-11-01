#
# A very rudimentary caching layer for the session token. It tests for places to put the token.
#
# If you want to use some other secure storage for the session token, you'll want to change this.

# Note that the hash key used is computed on the username/password combo, so if those change, the cached key will not be retrieved. Old ones
# expire in 7 days.
# 

# TODO: disable caching the session token with a configuration var.

module Omnicard
  class Client
    module Cache

      require 'digest/sha1'

      def class_exists?(class_name)
        klass = Module.const_get(class_name)
        return klass.is_a?(Class)
      rescue NameError
        return false
      end

      def init_cache
        if class_exists?('Redis')
          @redis = Redis.new
        end
      end

      def auth_cache_key
        Digest::SHA1.hexdigest(authentication.to_s)
      end

      def set_cached_auth_token(value)
        if class_exists?('Rails')
          Rails.cache.fetch("#{auth_cache_key}/oc/token", expires_in: 7.days) do
            value
          end
        elsif class_exists?('Redis')
          # expire in 7 days
          @redis.set(auth_cache_key, value, { ex: 604800 })
        end
      end

      def cached_auth_token(options={})
        if class_exists?('Rails')
          Rails.cache.fetch("#{auth_cache_key}/oc/token", expires_in: 7.days)
        elsif class_exists?('Redis')
          @redis.get(auth_cache_key)
        end
      end
    end
  end
end
