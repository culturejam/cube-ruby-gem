require 'json'

module Cube
  module Request
    # Perform an HTTP GET request
    def get(path, params={}, options={}, raw=false)
      request(:get, path, params, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, params={}, raw=false)
      request(:post, path, params, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, params={}, options={}, raw=false)
      request(:put, path, params, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, params={}, options={}, raw=false)
      request(:delete, path, params, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, params, options={}, raw=false)
      response = connection(raw).send(method) do |req|
        req.headers = req.headers.merge(options[:headers]) if options[:headers]
        case method
        when :get, :delete
          req.url(path, params)
        when :post, :put
          req.path = path
          req.body = params unless params.empty?
        end
      end
      return response if raw
      return response.body
    end
  end
end
