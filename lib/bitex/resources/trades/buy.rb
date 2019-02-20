module Bitex
  module Resources
    module Trades
      # This displays your Buy Trades.
      class Buy < Trade
        property :cash_amount, type: :decimal
        property :coin_amount, type: :decimal
        property :fee, type: :decimal
        property :price, type: :decimal

        property :type, type: :symbol
        property :orderbook_code, type: :symbol

        property :created_at, type: :time

        # GET /api/buys?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
        #
        # Market where the buys were done.
        #
        # Optional filters:
        #   @param [Orderboook] orderbook.
        #   @param [Integer] days. Number of days ago from which the trades were done.
        #   @param [Integer] limit. Max amount of buys to list.
        #
        # @return [ResultSet<Sell>]
        #
        # .all(orderbook:, days:, limit:)

        # GET /api/buys/:id
        #
        # @param[Integer|String] id.
        #
        # @return [Buy]
        #
        # .find(id)
      end
    end
  end
end
