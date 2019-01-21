module Bitex
  module Resources
    # Our public market data endpoints let anyone check our market's volume, prices and transaction history.
    # It also provides aggregateted candlestick-like data points for the last 24 hours, 7 days and 30 days of trading.
    # You don't need an API key (or even sign up to Bitex) to access the public market data.
    class Market < Public
      # GET /api/markets/:orderbook_code
      #
      # Get full information of market.
      # If you want only some of the fields provided, you can specify which fields to include by using the `include` query param.
      #   Possible values are: bids, asks, transactions and candles.
      # See the example to get only the orderbook data (bids and asks).
      # If you require more information other than the default, take a look at the endpoints
      #   /api/markets/:orderbook_code/transactions and /api/markets/:orderbook_code/candles respectively.
      # To get all possible orderbook_codes check Orderbooks.
      #
      # @param [Symbol] orderbook_code. Values: :btc_usd, :btc_ars, :bch_usd, :btc_pyg, :btc_clp, :btc_uyu
      # @param [Array<Symbol>] resources. Values:  [:bids, :asks, :candles, :transactions]
      #
      # @return [Market]
      #
      # .find(orderbook_code, includes:)
    end
  end
end
