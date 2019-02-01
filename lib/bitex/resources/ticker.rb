module Bitex
  module Resources
    # Overview of current market prices and trade volume, including Volume-Weighted Average Price.
    class Ticker < Public
      property :low, type: :decimal
      property :high, type: :decimal
      property :open, type: :decimal
      property :volume, type: :decimal
      property :vwap, type: :decimal
      property :ask, type: :decimal
      property :bid, type: :decimal
      property :last, type: :decimal
      property :price_before_last, type: :decimal

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
