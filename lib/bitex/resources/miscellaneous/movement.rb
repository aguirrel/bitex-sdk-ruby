module Bitex
  module Resources
    # Experimental endpoint: This endpoint may not be supported in further releases of the API. If your integration relies on it,
    # please contact us at developers@bitex.la explaining your use case, in order to provide you with better support.
    module Miscellaneous
      # This displays your movements (Buy, Sell, Deposit & Withdrawal) of the last 3 days.
      class Movement < Private
        property :amount, type: :decimal
        property :fee, type: :decimal
        property :price, type: :decimal

        property :currencies_involved, type: :symbol
        property :currency, type: :symbol
        property :fee_currency, type: :symbol
        property :kind, type: :symbol

        # GET /api/movements/
        #
        # @return [ResultSet<Movement>]
        #
        # self.all
      end
    end
  end
end
