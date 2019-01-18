module Bitex
  module Resources
    module Orders
      # Abstract class for Bids and Asks.
      class Order < Private
        # GET /api/orders
        #
        # @return [ResultSet<Order>]
        #
        # self.all

        custom_endpoint :cancel, on: :collection, request_method: :post
      end
    end
  end
end
