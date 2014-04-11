# encoding: UTF-8
require File.expand_path('../cube/version', __FILE__)
require File.expand_path('../cube/error', __FILE__)
require File.expand_path('../cube/configuration', __FILE__)
require File.expand_path('../cube/client', __FILE__)

# Provides an interface to the Cube's HTTP interface.
# For more information on Cube, see:
# http://square.github.io/cube/
module Cube
  extend Configuration

  # Alias for Cube::Client.new
  #
  # @return [Cube::Client]
  def self.client(options = {})
    Client.new(options)
  end
end
