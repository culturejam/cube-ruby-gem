# encoding: UTF-8
require 'faraday'
require 'json'

module Cube
  module FaradayMiddleware
    # Detects non-successful responses and raises semantic errors.
    class RaiseHttpException < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |response|
          case response[:status].to_i
          when 400
            fail Cube::BadRequest, error_message(response)
          when 401
            fail Cube::UnauthorizedAccess, 'Unauthorized access.'
          when 403
            fail Cube::ForbiddenAccess, 'Access is forbidden.'
          when 404
            fail Cube::NotFound, "Resource not found. #{response[:url]}"
          when 422
            fail Cube::UnprocessableEntity, error_message(response)
          when 500
            fail Cube::InternalServerError, error_message(response)
          when 503
            fail Cube::ServiceUnavailable, 'Cube service is not available.'
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
        ::JSON.parse(body) if body && !body.empty? && body.kind_of?(String)
      end

      def error_message(response)
        body = parsed_body(response)
        body['error'] if body && body['error']
      end
    end
  end
end
