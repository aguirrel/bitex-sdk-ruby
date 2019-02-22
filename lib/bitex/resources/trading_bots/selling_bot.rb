module Bitex
  module Resources
    module TradingBots
      # The robots sell crypts intelligently.
      class SellingBot < TradingBot
        property :amount, type: :decimal
        property :remaining_amount, type: :decimal
        property :chunk_size, type: :decimal

        property :orderbook_code, type: :symbol

        property :eta, type: :time

        # GET /api/selling_bots
        #
        # Get all Selling Bots.
        #
        # @return [ResultSet<SellingBot>]
        #
        # .all

        # GET /api/selling_bot/:id
        #
        # @param [String|Integer] id.
        #
        # @return [SellingBot]
        #
        # .find(id)

        # POST /api/selling_bots
        #
        # A selling bot is an assistant that puts Sell orders for you. It uses a strategy of dividing the amount and making the
        # orders smaller, to get the best price.
        #
        # @param [Float|String] amount:
        #   The amount of base money that you intend to sell for quote money.
        #   Both the quote and the base currencies are determined by the Orderbook selected.
        #   (e.g. A selling bot with amount = 2 and orderbook = BTC/USD, will sell 2 BTC for as much USD as it can)
        #
        # @param [Orderbook] orderbook.
        #
        # @return [SellingBot]
        #
        # .create(orderbook:, amount:)

        # POST /api/selling_bots/cancel
        #
        # This action represents an intention to cancel the Selling Bot.
        # No new asks will be made but if one is already being executed, it could be matched.
        #
        # @param [Integer] id.
        #
        # @return [SellingBot]
        #
        # .cancel(id: id)
      end
    end
  end
end
