module Bitex
  module Resources
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
      def self.all(orderbook: nil, days: nil, limit: nil)
        filters = {}.tap do |params|
          params[:days] = days if days.present?
          params[:orderbook_code] = orderbook.code if orderbook.present?
        end

        (limit.present? ? with_params(limit: limit).where(filters) : where(filters)).all
      end
    end
  end
end
