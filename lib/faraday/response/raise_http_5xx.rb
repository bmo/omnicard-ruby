require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 500
        raise Omnicard::InternalServerError.new(error_message(env, "Something is technically wrong."), env[:response_headers], env[:response_body])
      when 502
        raise Omnicard::BadGateway.new(error_message(env, "Omnicard is down or being upgraded."), env[:response_headers], env[:response_body])
      when 503
        raise Omnicard::ServiceUnavailable.new(error_message(env, "(__-){ Omnicard is over capacity or a service error occured."), env[:response_headers], env[:response_body])
      end
    end

    private

    def error_message(env, body=nil)
      "#{env[:method].to_s.upcase} #{env[:url].to_s}: #{[env[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end