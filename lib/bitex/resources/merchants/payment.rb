module Bitex
  module Resources
    module Merchants
      # Our Merchants API lets you accept bitcoin without worrying about the inner workings of the bitcoin Price and the bitcoin
      # Network.
      #
      # You just tell us the amount to charge in the customer's currency and we'll quote the bitcoin equivalent and set up a
      # unique Bitcoin Address for the bitcoin to be sent to. Each payment corresponds to a different bitcoin address.
      #
      # You can send bitcoin addresses via email, show them in your checkout using your own UI libraries, or easier yet: You can
      # setup your own Bitex powered point of sale and use the user friendly Payment's Page.
      #
      # All Bitcoins received as payment will be sold automatically at the best BTC/USD market price in Bitex. You can optionally
      # decide to keep part of the received Bitcoin and withdraw or sell them at a later date.
      #
      # Both USD and/or BTC received as payment will be credited to your Bitex Balance and can be withdrawn as per our supported
      # cash-out methods.
      #
      # Payments which are too small for our orderbook (roughly 2 USD or less) will not be settled automatically. They will be
      # kept as bitcoin in your balance and it's up to you to decide when to sell them.
      #
      # Contact us if you need settlements in currencies other than BTC or USD; if you need to have a guaranteed price instead of
      # settling at the best BTC/USD price; or if you need to automatically settle lots of micro-payments.
      class Payment < Merchant
        property :amount, type: :decimal
        property :settlement_amount, type: :decimal
        property :confirmed_quantity, type: :decimal
        property :unconfirmed_quantity, type: :decimal
        property :expected_quantity, type: :decimal
        property :keep, type: :decimal
        property :kept, type: :decimal
        property :overpaid, type: :decimal
        property :kept, type: :decimal

        property :currency_code, type: :symbol
        property :settlement_currency, type: :symbol
        property :status, type: :symbol

        property :last_quoted_on, type: :time
        property :quote_valid_until, type: :time
        property :valid_until, type: :time

        def self.resource_path
          "#{super()}/payments"
        end

        # GET /api/payments
        #
        # @return [ResultSet<Payment>]
        #
        # self.all

        # GET /api/payments/:id
        #
        # @param [Integer|String] id.
        #
        # @return [Payment]
        #
        # .find(id)

        # POST /api/merchants/payments
        #
        # Send us an amount and currency, and we'll quote it in bitcoin and give you an address where the payment is expected.
        # The bitcoins will credit to your Bitex account and can be sold automatically to get the original amount in your
        # requested currency.
        #
        # Payments have an expiration of 1 hour, the bitcoin transaction must be initiated within that timeframe, if your customer
        # takes longer you can always create a new payment and get a new quote and bitcoin address. If someone pays to an address
        # after the payment is expired the bitcoin quantity will still be credited to your bitex.la, so it's possible for you to
        # issue a refund and/or forward the received bitcoin to a new payment address yourself.
        #
        # At the moment, the payments are only accepted in BTC and are transferred to the merchant in USD (unless he keeps 100% in
        # BTC), no matter the amount or the currency specified in the payment.
        #
        # @param [String|Float] amount: Amount that the customer should pay.
        # @param [Integer] currency: Id of the Payment currency. Possible options are:
        #   btc: 1, usd: 3, ars: 4, uyu: 5, eur: 6, clp: 7, pen: 8, brl: 9, cop: 10, mxn: 11, pyg: 12, cny: 13, inr: 14, bch: 16
        # @param [String|Float] keep: Percentage of the received money to keep in BTC instead of converting it to USD.
        # @param [String] callback_url: You can provide a callback_url to get notifications about a payment.
        #   When a callback_url is set for a payment Bitex will POST updates to it everytime a payment status changes.
        #   Your callback_url must be HTTPS because we want to make sure we're only contacting you, and it will include your
        #   first active API key in it, so that you know it's us sending the callback. Your API key is our shared secret, so you
        #   may want to handle it the same way you handle your users login credentials, hiding it from web server request logs
        #   for example. Our request's content type will be application/json and the content will be a structure containing your
        #   API key and the payment as it would be returned when querying its status.
        #
        # @return [Payment]
        #
        # .create(amount:, currency:, keep:, callback_url:, customer_reference:, merchant_reference:)
      end
    end
  end
end
