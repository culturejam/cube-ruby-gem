require File.expand_path('../configuration', __FILE__)
require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)

module Cube
  class Client
    include  Cube::Connection
    include  Cube::Request

    # @private
    attr_accessor *Cube::Configuration::VALID_OPTIONS_KEYS

    def initialize(options={})
      options = Cube::options.merge(options)
      Cube::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Gets a cube metric.
    #
    def get_metric(expression, options={})
      options = options.merge(expression: expression)
      get("/1.0/metric", options, false, true, true)
    end

  end
end
