module Bitex
  module Resources
    # Abstract class for Bids and Asks.
    class Order < Private
      has_one :orderbook
      has_one :user

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


      # GET /api/<asks|bids>/:id
      #
      # @param [String|Integer] id.
      #
      # @return [Order]
      #
      # .find(id)

      def self.create(orderbook_id:, amount:, price:)
        new(amount: amount, price: price).tap do |order|
          # TODO probar con el objeto orderbook completo - a ver q pasa - :)
          order.relationships.orderbook = Orderbook.new(id: orderbook_id)
          order.save
        end
      end

      # POST /api/[asks/bids]/:id/cancel
      #
      # This action represents an intention to cancel an [Ask|Bid].
      # Despite of this endpoint responding with a 204 status, the Ask may not have been cancelled if it was previously matched.
      # In order to check the status of the ask, you can query all your active orders with the /api/orders endpoint.
      #
      # @param [Integer] id.
      #
      # #cancel(id)

      # @return [String] resource type name.
      def self.resource_type
        name.demodulize.underscore.pluralize
      end
    end
  end
end
