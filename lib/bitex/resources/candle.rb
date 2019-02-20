module Bitex
  module Resources
    # For market relationships.
    class Candle < Public
      property :low, type: :decimal
      property :high, type: :decimal
      property :open, type: :decimal
      property :close, type: :decimal
      property :volume, type: :decimal
      property :vwap, type: :decimal
      property :price_before_last, type: :decimal

      property :orderbook_code, type: :symbol

      # GET /api/candles?filter[orderbook_code]={orderbook_code}&filter[days]={days}&span={span}
      #
      # Get candles for a given market
      #  filters:
      #    @param [Orderbook] orderbook.
      #    @param [Integer] days. number of days from where you want the candles to be. default = 1
      #    @param [Integer] span. timespan for each candle. default = 1
      #
      # @return [ResultSet<Candle>]
      #
      # .all(orderbook:, days:, span:)
    end
  end
end
