module Bitex
  module Resources
    module Trades
      # This displays your trades (Buy & Sell).
      class Trade < Private
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
