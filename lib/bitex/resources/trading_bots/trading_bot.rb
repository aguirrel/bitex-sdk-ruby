module Bitex
  module Resources
    module TradingBots
      # Trading Bots can manage a crypto sale or buy to help you get a better pricing than you would get if you executed the full
      # amount in a single order.
      #
      # The strategy used by bots is rather simple: They split up the amount to buy or sell in chunks of a given size and place
      # orders at the best market price.
      #
      # Orders are spaced by time_to_live seconds to allow for new buyers and sellers to replenish the orderbook before executing
      # again. Orders will be cancelled after time_to_live seconds if still executing.
      #
      # Bots also make sure to prevent executing in low-liquidity conditions: they will not place new orders if the spread
      # between the best Bid and the best Ask is over 10 USD.
      #
      # Bots do not check or lock funds! If your robot fails to place an order because of insufficient funds or other, then it
      # will be terminated prematurely. You'll find the termination reason in exit_status.
      class TradingBot < Private
        # GET /api/<selling_bots|buying_bots>
        #
        # Get all Trading Bots.
        #
        # @return [ResultSet<SellingBot|BuyingBot>]
        #
        # .all

        # GET /api/<selling_bots|buying_bots>/:id
        #
        # @param [String|Integer] id.
        #
        # @return [SellingBot|BuyingBot]
        def self.find(id)
          super(id)[0]
        end

        # POST /api/<selling_bots|buying_bots>
        #
        # @param [Orderbook] orderbook.
        # @param [Float|String] amount.
        #
        # @return [SellingBot|BuyingBot]
        def self.create(amount:, orderbook:)
          new(amount: amount).tap do |bot|
            bot.relationships.orderbook = orderbook
            bot.save
          end
        end

        custom_endpoint :cancel, on: :collection, request_method: :post
        # POST /api/<buying_bots|selling_bots>/cancel
        #
        # This action represents an intention to cancel the Trading Bot.
        # No new orders will be made but if one is already being executed, it could be matched.
        #
        # @param [Integer] id.
        #
        # @return [SellingBot|BuyingBot]
        #
        # .cancel(id: id)
      end
    end
  end
end
