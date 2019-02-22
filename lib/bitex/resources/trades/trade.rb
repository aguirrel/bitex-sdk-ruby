module Bitex
  module Resources
    module Trades
      # This displays your trades (Buy & Sell).
      class Trade < Private
        property :cash_amount, type: :decimal
        property :coin_amount, type: :decimal
        property :fee, type: :decimal
        property :price, type: :decimal

        property :orderbook_code, type: :symbol

        property :created_at, type: :time

        # GET /api/trades?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
        #
        # Market where the buys/sells were done.
        #
        # @param [Orderboook] orderbook.
        # @param [Integer] days. Number of days ago from which the trades were done.
        # @param [Integer] limit. Max amount of trades to list.
        #
        # @return [<Buy|Sell>]
      end
    end
  end
end
