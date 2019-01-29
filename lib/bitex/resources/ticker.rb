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
      # @param [Orderbook] orderbook.
      #
      # @return [Ticker]
      #
      def self.find(orderbook)
        super(orderbook.code)
      end
    end
  end
end
