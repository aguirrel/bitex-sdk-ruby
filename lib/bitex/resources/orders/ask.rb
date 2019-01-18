module Bitex
  module Resources
    module Orders
      # Trading endpoints have everything you need to place and cancel Sell orders,
      # as well as listing your active orders and every trade you make.
      class Ask < Order
        # GET /api/asks?filter[orderbook_code]={orderbook_code}
        #
        # Optional filters:
        #   @param [Orderbook] orderbook.
        #
        # @return [ResultSet<Ask>]
        #
        # .all(orderbook:)

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
        # @param [String] id.
        #
        # @return [nil]
        #
        # self.cancel(id: id)

        # POST /api/asks
        #
        # @param [String] orderbook code.
        # @param [Decimal|String] amount.
        # @param [Decimal|String] price.
        #
        # @return [Ask]
      end
    end
  end
end
