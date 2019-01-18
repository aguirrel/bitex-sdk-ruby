module Bitex
  module Resources
    # Overview of current market prices and trade volume, including Volume-Weighted Average Price.
    class Ticker < Public
      # GET /api/tickers/:orderbook_code
      #
      # Get Tickers of all available markets
      #
      # @return [ResultSet<Ticker>]
      #
      # .all

      # GET /api/tickers/:orderbook_code
      #
      # Get the ticker of a market.
      #
      # @param [Symbol] orderbook_code. Values: :btc_usd, :btc_ars, :bch_usd, :btc_pyg, :btc_clp, :btc_uyu
      #
      # @return [Ticker]
      #
      # .find(orderbook_code)
    end
  end
end
