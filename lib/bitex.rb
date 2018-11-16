require 'active_support'
require 'active_support/core_ext'

require 'bigdecimal'
require 'bigdecimal/util'

require 'curl'
require 'json'
require 'json_api_client'

require 'bitex/client'
require 'bitex/forwarder'

require 'bitex/base'

Dir[File.expand_path('bitex/*.rb', __dir__)].each { |f| require f }

# Bitex library scope
module Bitex
end
