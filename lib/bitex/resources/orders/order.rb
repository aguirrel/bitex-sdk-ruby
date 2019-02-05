module Bitex
  module Resources
    module Orders
      # Abstract class for Bids and Asks.
      class Order < Private
        property :amount, type: :decimal
        property :remaining_amount, type: :decimal
        property :price, type: :decimal

        # GET /api/orders
        #
        # @return [ResultSet<Order>]
        #
        # self.all

        custom_endpoint :cancel, on: :collection, request_method: :post

        def self.create(orderbook:, amount:, price:)
          super(orderbook_code: orderbook.code, amount: amount, price: price)
        end
      end
    end
  end
end
