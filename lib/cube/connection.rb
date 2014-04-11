# encoding: UTF-8
require 'faraday_middleware'
require File.expand_path('../../faraday/raise_http_exception', __FILE__)

module Cube
  # Creates the Faraday connection object used in all requests.
  module Connection
    private

    def connection_options
      {
        headers: {
          'Accept' => "application/#{format}; charset=utf-8",
          'Content-Type' => "application/#{format}",
          'User-Agent' => user_agent
        },
        url: url
      }
    end

    def connection(raw = false)
      @conn ||= Faraday.new(connection_options) do |conn|
        conn.request :basic_auth, username, password if username && password
        conn.use Cube::FaradayMiddleware::RaiseHttpException
        unless raw
          case format.to_s.downcase
          when 'json'
            conn.request :json
            conn.response :json
          end
        end
        conn.adapter adapter
      end
    end
  end
end
