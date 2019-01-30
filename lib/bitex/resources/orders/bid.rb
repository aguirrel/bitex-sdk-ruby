module Bitex
  module Resources
    module Orders
      # Trading endpoints have everything you need to place and cancel Buy orders,
      # as well as listing your active orders and every trade you make.
      class Bid < Order
        # GET /api/bids?filter[orderbook_code]={orderbook_code}
        #
        # Optional filters:
        #   @param [Orderbook] orderbook.
        #
        # @return [ResultSet<Bid>]
        #
        # .all(orderbook:)

        # GET /api/bids/:id
        #
        # Possible status:
        #   - pending: The bid has not been processed yet.
        #   - executing: The bid is processed and could be matched.
        #   - completed: The bid has been matched completely.
        #   - to_cancel: You requested the cancellation but it can still be matched if a matching ask was sent previously.
        #   - cancelled: The bid is cancelled and will not receive more matches.
        #
        # @param [String|Integer] id.
        #
        # @return [Bid]
        #
        # .find(id)

        # POST /api/bids/cancel
        #
        # This action represents an intention to cancel a Bid. Despite of this endpoint responding with a 204 status,
        # the Bid may not have been cancelled if it was previously matched.
        # In order to check the status of the bid, you can query all your active orders with the /api/orders endpoint.
        #
        # @param [String] id.
        #
        # @return [nil]
        #
        # self.cancel(id: id)

        # POST /api/bids
        #
        # @param [Orderbook] orderbook.
        # @param [Decimal|String] amount.
        # @param [Decimal|String] price.
        #
        # @return [Bid]
        #
        # self.create(orderbook:, amount:, price:)
      end
    end
  end
end
