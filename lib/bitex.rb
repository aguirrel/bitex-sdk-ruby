require 'active_support'
require 'active_support/core_ext'
require 'bigdecimal'
require 'bigdecimal/util'
require 'curl'
require 'json'
require 'json_api_client'

# Bitex library namespace
module Bitex
  autoload :VERSION, 'version'

  autoload :Connections, 'bitex/connections'
  autoload :Resources, 'bitex/resources'

  autoload :Parser, 'bitex/parser'

  autoload :Client, 'bitex/client'
end
