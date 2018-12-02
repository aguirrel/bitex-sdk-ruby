module Bitex
  module Resources
    class Sell < Trade
      # GET /api/sells?filter[orderboook_code]={orderbook_code}&filter[days]={days}&lmit={limit}
      #
      # Market where the sells were done.
      #
      # self.all(orderbook: nil, days: nil, limit: nil)
      #
      # @param [Orderboook] orderbook.
      # @param [Integer] days. Number of days ago from which the trades were done.
      # @param [Integer] limit. Max amount of sells to list.
      #
      # GET /api/sells/:id
      #
      # .all(orderbook:, days:, limit:)

      # @param[Integer|String] id.
      #
      # @return [Sell]
      #
      # .find(id)
    end
  end
end

