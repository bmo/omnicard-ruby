require 'faraday_middleware'
require 'faraday/response/raise_http_4xx'
require 'faraday/response/raise_http_5xx'

module Omnicard
  # @private
  module Connection
    private
    
    def connection(options={})
      merged_options = faraday_options.merge({
        :headers => {
          'Accept'       => "application/json",
          'User-Agent'   => user_agent,
          #'Content-Type' => "application/json"
        },
        :ssl => {:verify => false},
        :url => options.fetch(:endpoint, api_endpoint)
      })

      Faraday.new(merged_options) do |faraday|
        faraday.request :url_encoded

        faraday.response :logger if faraday_logging 

        faraday.use Faraday::Response::RaiseHttp4xx

        faraday.use FaradayMiddleware::FollowRedirects, limit:10

        unless options[:raw]
          case options.fetch(:format, response_format).to_s.downcase
          when 'json'
            faraday.use Faraday::Response::Mashify
            faraday.use Faraday::Response::ParseJson
          end
        end
        faraday.use Faraday::Response::RaiseHttp5xx
        faraday.adapter Faraday.default_adapter

      end
    end
  end
end