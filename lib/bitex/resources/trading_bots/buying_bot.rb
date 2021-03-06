module Bitex
  module Resources
    module TradingBots
      # The robots buy crypts intelligently.
      class BuyingBot < TradingBot
        property :amount, type: :decimal
        property :remaining_amount, type: :decimal
        property :chunk_size, type: :decimal

        property :orderbook_code, type: :symbol

        property :eta, type: :time

        # GET /api/buying_bots
        #
        # Get all Buying Bots.
        #
        # @return [ResultSet<BuyingBot>]
        #
        # .all

        # GET /api/buying_bot/:id
        #
        # @param [String|Integer] id.
        #
        # @return [BuyingBot]
        #
        # .find(id)

        # POST /api/buying_bots
        #
        # A buying bot is an assistant that puts Buy orders for you. It uses a strategy of dividing the amount and making the
        # orders smaller, to get the best price.
        #
        # @param [Float|String] amount:
        #   The amount of quote money that you intend to spend buying base money.
        #   Both the quote and the base currencies are determined by the Orderbook selected.
        #   (e.g. A buying bot with amount = 100 and orderbook = BTC/USD, will spend 100 dollars in buying as much BTC as it can).
        #
        # @param [Orderbook] orderbook.
        #
        # @return [BuyingBot]
        #
        # .create(orderbook:, amount:)

        # POST /api/buying_bots/cancel
        #
        # This action represents an intention to cancel the Buying Bot.
        # No new bids will be made but if one is already being executed, it could be matched.
        #
        # @param [Integer] id.
        #
        # @return [BuyingBot]
        #
        # .cancel(id: id)
      end
    end
  end
end
