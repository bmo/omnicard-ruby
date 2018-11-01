module Omnicard
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    # Perform an HTTP PUT request
    def put(path, params={}, options={})
      request(:put, path, params, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, params={}, options={})
      request(:delete, path, params, options)
    end

    private

    def self.success?(response)
      response['response']['status'] == 1000
    end

    def datafy(params)
      {data: params}
    end

    # Perform an HTTP request
    def request(method, path, params, options)
      # all requests return a status, transaction_id, and message

      params[:token] = @auth_token if @auth_token

      response = connection(options).send(method) do |request|
        case method.to_sym
          when :get, :delete
            request.url(path, params)

          when :post, :put
            request.path = path
            request.body = datafy(params) unless params.empty?
        end
      end

      if options[:raw]
        response
      else
        response.body
      end
    end

    def formatted_path(path, options={})
      #[path, options.fetch(:format, format)].compact.join('.')
    end
  end
end