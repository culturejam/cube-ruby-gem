require 'json'

module Cube
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    # Perform an HTTP POST request
    def post(path, options={}, raw=false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, raw=false)
      request(:put, path, options, raw)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, raw=false)
      request(:delete, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false)
      response = connection(raw).send(method) do |req|
        case method
        when :get, :delete
          req.url(path, options)
        when :post, :put
          req.path = path
          req.body = options unless options.empty?
        end
      end
      return response if raw
      return response.body
    end
  end
end
