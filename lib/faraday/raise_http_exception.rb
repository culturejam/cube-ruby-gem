require 'faraday'
require 'json'

module Cube
  module FaradayMiddleware
    class RaiseHttpException < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
          when 400
            raise Cube::BadRequest, error_message(response)
          when 401
            raise Cube::UnauthorizedAccess, "Unauthorized access."
          when 403
            raise Cube::ForbiddenAccess, "Access is forbidden."
          when 404
            raise Cube::NotFound, "Resource not found. #{response[:url]}"
          when 422
            raise Cube::UnprocessableEntity, error_message(response)
          when 500
            raise Cube::InternalServerError, error_message(response)
          when 503
            raise Cube::ServiceUnavailable, "Cube service is not available."
          end
        end
      end

      def initialize(app)
        super app
        @parser = nil
      end

      private

      def parsed_body(response)
        body = response[:body]
        if not body.nil? and not body.empty? and body.kind_of?(String)
          body = ::JSON.parse(body)
        end
      end

      def error_message(response)
        body = parsed_body(response)
        if body && body["message"]
          body["message"]
        end
      end

    end
  end
end
