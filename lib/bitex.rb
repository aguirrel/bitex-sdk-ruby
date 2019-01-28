require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'bigdecimal'
require 'bigdecimal/util'
require 'curl'
require 'forwardable'
require 'json'
require 'json_api_client'

# Bitex library namespace
module Bitex
  ActiveSupport::Dependencies.autoload_paths += %w[lib]
end
