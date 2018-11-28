require 'active_support'
require 'active_support/core_ext'

require 'bigdecimal'
require 'bigdecimal/util'

require 'curl'
require 'json'
require 'json_api_client'
require 'string'

require 'bitex/version'

require 'bitex/resource_parser'
require 'bitex/resource_builder'

require 'bitex/connection'
require 'bitex/connection/public'
require 'bitex/connection/private'

require 'bitex/resource'
require 'bitex/resource/base'

require 'bitex/client'

# Bitex library namespace
module Bitex
end
