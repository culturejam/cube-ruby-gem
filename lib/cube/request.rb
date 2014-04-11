require 'json'

module Cube
  module Request
    # Perform an HTTP GET request
    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    # Perform an HTTP POST request
    def post(path, params={})
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

    # Perform an HTTP request
    # @param [Symbol] method The HTTP method
    # @param [String] path The request path
    # @param [Hash] params Request parameters
    # @options [Hash] Additional request options
    # @option options [Hash] :headers Request headers
    # @option options [Boolean] :raw True returns the entire request object,
    #                                otherwise the body is returned.
    def request(method, path, params={}, options={})
      options = { raw: false }.merge(options)
      response = connection(options[:raw]).send(method) do |req|
        req.headers = req.headers.merge(options[:headers]) if options[:headers]
        case method
        when :get, :delete
          req.url(path, params)
        when :post, :put
          req.path = path
          req.body = params unless params.empty?
        end
      end
      return response if options[:raw]
      return response.body
    end
  end
end
