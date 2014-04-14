# encoding: UTF-8
require 'faraday'

module Cube
  # Configuration settings for the Cube client.
  module Configuration
    # An array of whitelisted, valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :adapter,
      :format,
      :password,
      :url,
      :user_agent,
      :username
    ].freeze

    # An array of valid request/response formats.
    VALID_FORMATS = [:json, :text].freeze

    # The adapter that will be used to connect if none is set.
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # The response format appended to the path and sent in the 'Accept' header
    # if none is set.
    #
    # @note JSON is the only available format at this time.
    DEFAULT_FORMAT = :json

    # By default, don't set a password.
    DEFAULT_PASSWORD = nil

    # By default, don't use a proxy server.
    DEFAULT_PROXY = nil

    # The url that will be used to connect if none is set.
    DEFAULT_URL = nil

    # By default, don't set a username.
    DEFAULT_USERNAME = nil

    # The user agent that will be sent to the API endpoint if none is set.
    DEFAULT_USER_AGENT = "cube-ruby-gem/#{Cube::VERSION}".freeze

    # @private
    attr_accessor(*VALID_OPTIONS_KEYS)

    # When this module is extended, set all configuration options to their
    # default values.
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block.
    def configure
      yield self
    end

    # Create a hash of options and their values.
    def options
      VALID_OPTIONS_KEYS.reduce({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults.
    def reset
      self.adapter        = DEFAULT_ADAPTER
      self.format         = DEFAULT_FORMAT
      self.password       = DEFAULT_PASSWORD
      self.url            = DEFAULT_URL
      self.user_agent     = DEFAULT_USER_AGENT
      self.username       = DEFAULT_USERNAME
    end
  end
end
