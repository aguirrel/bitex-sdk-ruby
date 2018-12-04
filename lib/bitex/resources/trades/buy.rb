module Bitex
  module Resources
    module Trades
      class Buy < Trade
        # GET /api/buys?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
        #
        # Market where the buys were done.
        #
        # self.all(orderbook: nil, days: nil, limit: nil)
        #
        # @param [Orderboook] orderbook.
        # @param [Integer] days. Number of days ago from which the trades were done.
        # @param [Integer] limit. Max amount of buys to list.
        #
        # GET /api/buys/:id
        #
        # .all(orderbook:, days:, limit:)

        # @param[Integer|String] id.
        #
        # @return [Buy]
        #
        # .find(id)
      end
    end
  end
end
