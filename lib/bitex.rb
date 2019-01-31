require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'bigdecimal'
require 'bigdecimal/util'
require 'curl'
require 'forwardable'
require 'json'
require 'json_api_client'
require 'static_models'

# Custom parser
require 'bitex/decimal_caster'

# Bitex library namespace
module Bitex
  ActiveSupport::Dependencies.autoload_paths += [File.expand_path(__dir__)]
end
