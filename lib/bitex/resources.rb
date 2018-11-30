module Bitex
  module Resources
    autoload :Public, 'bitex/resources/public'
    autoload :Private, 'bitex/resources/private'

    autoload :Orderbook, 'bitex/resources/public/orderbook'
    autoload :Ticker, 'bitex/resources/public/ticker'
    autoload :Market, 'bitex/resources/public/market'
    autoload :OrderGroup, 'bitex/resources/public/order_group'
    autoload :Candle, 'bitex/resources/public/candle'
    autoload :Transaction, 'bitex/resources/public/transaction'
  end
end
