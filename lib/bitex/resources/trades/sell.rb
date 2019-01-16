module Bitex
  module Resources
    module Trades
      class Sell < Trade
        # GET /api/sells?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
        #
        # Market where the sells were done.
        #
        # @param [Orderboook] orderbook.
        # @param [Integer] days. Number of days ago from which the trades were done.
        # @param [Integer] limit. Max amount of sells to list.
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
