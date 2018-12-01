module Bitex
  module Resources
    # Trading endpoints have everything you need to place and cancel Sell orders,
    # as well as listing your active orders and every trade you make.
    class Ask < Order
      # GET /api/asks/:id
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
      # @return [Ask]
      #
      # .find(id)

      # POST /api/asks/cancel
      #
      # This action represents an intention to cancel an Ask. Despite of this endpoint responding with a 204 status,
      # the Ask may not have been cancelled if it was previously matched.
      # In order to check the status of the ask, you can query all your active orders with the /api/orders endpoint.
      #
      # @param [Hash] with id: for specific asks.
      #
      # @return [nil]
      #
      # self.cancel(id: id)
    end
  end
end
