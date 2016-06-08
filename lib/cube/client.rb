# encoding: UTF-8
require File.expand_path('../configuration', __FILE__)
require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)

module Cube
  # Holds the top-level abstracted Cube API calls.
  class Client
    include Cube::Connection
    include Cube::Request

    attr_accessor(*Cube::Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Cube.options.merge(options)
      Cube::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Gets a cube metric.
    #
    def get_metric(expression, params = {}, options = {})
      params = params.merge(expression: expression)
      get('/1.0/metric', params, options)
    end
    
    # Gets a cube events.
    #
    def get_events(expression, params = {}, options = {})
      params = params.merge(expression: expression)
      get('/1.0/event', params, options)
    end
  end
end
