module Bitex
  module Resources
    module Trades
      # This displays your Sell Trades.
      class Sell < Trade
        property :cash_amount, type: :decimal
        property :coin_amount, type: :decimal
        property :fee, type: :decimal
        property :price, type: :decimal

        property :orderbook_code, type: :symbol

        property :created_at, type: :time

        # GET /api/sells?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
        #
        # Market where the sells were done.
        #
        # Optional filters:
        #   @param [Orderboook] orderbook.
        #   @param [Integer] days. Number of days ago from which the trades were done.
        #   @param [Integer] limit. Max amount of sells to list.
        #
        # @return [ResultSet<Sell>]
        #
        # .all(orderbook:, days:, limit:)

        # GET /api/sells/:id
        #
        # @param[Integer|String] id.
        #
        # @return [Sell]
        #
        # .find(id)
      end
    end
  end
end
