require 'faraday_middleware'
require File.expand_path('../../faraday/raise_http_exception', __FILE__)

module Cube
  module Connection
    private

    def connection(raw=false)
      options = {
        headers: {
          'Accept' => "application/#{format}; charset=utf-8",
          'Content-Type' => "application/#{format}",
          'User-Agent' => user_agent
        },
        url: url
      }

      @conn ||= Faraday.new(options) do |conn|
        conn.request :basic_auth, username, password if username && password
        conn.use Cube::FaradayMiddleware::RaiseHttpException
        unless raw
          case format.to_s.downcase
          when 'json'
            conn.request  :json
            conn.response :json
          end
        end
        conn.adapter adapter
      end
    end
  end
end
