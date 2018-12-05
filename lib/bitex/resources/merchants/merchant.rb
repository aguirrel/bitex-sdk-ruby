module Bitex
  module Resources
    module Merchants
      # Our Merchants API lets you accept bitcoin without worrying about the inner workings of the bitcoin Price and the bitcoin
      # Network.
      #
      # You just tell us the amount to charge in the customer's currency and we'll quote the bitcoin equivalent and set up a
      # unique Bitcoin Address for the bitcoin to be sent to. Each payment corresponds to a different bitcoin address.
      #
      # You can send bitcoin addresses via email, show them in your checkout using your own UI libraries, or easier yet:
      # You can setup your own Bitex powered point of sale and use the user friendly Payment's Page.
      #
      # All Bitcoins received as payment will be sold automatically at the best BTC/USD market price in Bitex.
      # You can optionally decide to keep part of the received Bitcoin and withdraw or sell them at a later date.
      #
      # Both USD and/or BTC received as payment will be credited to your Bitex Balance and can be withdrawn as per our supported
      # cash-out methods.
      #
      # Payments which are too small for our orderbook (roughly 2 USD or less) will not be settled automatically.
      # They will be kept as bitcoin in your balance and it's up to you to decide when to sell them.
      #
      # Contact us if you need settlements in currencies other than BTC or USD;
      # if you need to have a guaranteed price instead of settling at the best BTC/USD price;
      # or if you need to automatically settle lots of micro-payments.
      class Merchant < Private
        def self.resource_path
          'merchants'
        end
      end
    end
  end
end
