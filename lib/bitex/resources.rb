module Bitex
  module Resources
    autoload :Public, 'bitex/resources/public'
    autoload :Private, 'bitex/resources/private'

    autoload :Orderbook, 'bitex/resources/public/orderbook'
    autoload :Ticker, 'bitex/resources/public/ticker'
  end
end
