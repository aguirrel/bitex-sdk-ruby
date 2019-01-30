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
        custom_endpoint :cancel, on: :collection, request_method: :post

        def self.create(orderbook:, amount:)
          super(orderbook_code: orderbook.code, amount: amount)
        end
      end
    end
  end
end
