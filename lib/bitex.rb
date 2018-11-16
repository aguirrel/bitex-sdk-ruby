require 'active_support'
require 'active_support/core_ext'

require 'bigdecimal'
require 'bigdecimal/util'

require 'curl'
require 'json'
require 'json_api_client'
require 'string'

require 'bitex/client'
require 'bitex/forwarder'

require 'bitex/base'

require 'bitex/order_group'
Dir[File.expand_path('bitex/order_group/*.rb', __dir__)].each { |f| require f }

Dir[File.expand_path('bitex/*.rb', __dir__)].each { |f| require f }

# Bitex library scope
module Bitex
  ORDERBOOKS = { btc_usd: 1, btc_ars: 5, bch_usd: 8, btc_pyg: 10, btc_clp: 11, btc_uyu: 12 }.freeze

  class InvalidArgument < StandardError
  end

  class MalformedOtp < StandardError
  end

  class OrderNotPlaced < StandardError
  end

  class UnknownOrderbook < StandardError
  end
end
