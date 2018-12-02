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

    autoload :Order, 'bitex/resources/private/order'
    autoload :Ask, 'bitex/resources/private/order/ask'
    autoload :Bid, 'bitex/resources/private/order/bid'

    autoload :Trade, 'bitex/resources/private/trade'
    autoload :Buy, 'bitex/resources/private/trade/buy'
    autoload :Sell, 'bitex/resources/private/trade/sell'
  end
end
