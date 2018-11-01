module Omnicard
  # Custom error class for rescuing from all Omnicard errors
  class Error < StandardError
    attr_reader :http_headers, :http_body

    def initialize(message, http_headers, http_body)
      @http_headers = Hash[http_headers]
      @http_body = Hash[http_body]
      super message
    end

  end

  # Raised when Omnicard returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Omnicard returns the HTTP status code 401
  class Unauthorized < Error; end

  # Raised when Omnicard returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Omnicard returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Omnicard returns the HTTP status code 406
  class NotAcceptable < Error; end

  class EnhanceYourCalm < Error; end

  # Raised when Omnicard returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Omnicard returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Omnicard returns the HTTP status code 503
  class ServiceUnavailable < Error; end
end