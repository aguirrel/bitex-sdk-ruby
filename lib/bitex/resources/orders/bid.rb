module Bitex
  module Resources
    module Orders
      # Trading endpoints have everything you need to place and cancel Buy orders,
      # as well as listing your active orders and every trade you make.
      class Bid < Order
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
        # @param [Hash] with id: for specific bids.
        #
        # @return [nil]
        #
        # self.cancel(id: id)
      end
    end
  end
end
