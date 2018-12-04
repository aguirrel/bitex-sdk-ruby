module Bitex
  module Resources
    # Abstract class for Bids and Asks.
    class Order < Private
      # GET /api/orders
      #
      # @return [ResultSet<Order>]
      #
      # self.all

      custom_endpoint :cancel, on: :collection, request_method: :post
      # POST /api/orders/cancel?filter[orderbook_code]={orderbook_code}
      #
      # @param [Hash] filter:
      #   For cancel on all markets don't send filters
      #   For cancel on specific market send hash { filter: { orderbook_code: :code } }
      #
      # @return [nil]
      #
      # self.cancel(filter: { orderbook_code: :code })
      # self.cancel

      # For subclass findes
      def self.find(id)
        super(id)[0]
      end

      # POST /api/<asks|bids>
      #
      # @param [Orderbook] orderbook.
      # @param [Decimal|String] amount.
      #   The amount of an ask is the amount of Crypto (base currency) to sell.
      #   E.g: In the BTC/USD market, the ask amount is the amount of BTC to be sold for USD.
      # @param [Decimal|String] price.
      #
      # @return [Ask|Bid]
      def self.create(orderbook:, amount:, price:)
        new(amount: amount, price: price).tap do |order|
          order.relationships.orderbook = orderbook
          order.save
        end
      end
    end
  end
end
