module Bitex
  module Resources
    # Experimental endpoint: This endpoint may not be supported in further releases of the API. If your integration relies on it,
    # please contact us at developers@bitex.la explaining your use case, in order to provide you with better support.
    module Miscellaneous
      # This displays your movements (Buy, Sell, Deposit & Withdrawal) of the last 3 days.
      class Movement < Private
        # GET /api/movements/
        #
        # @return [ResultSet<Buy|Sell|Deposit|Withdrawal>]
        #
        # self.all
      end
    end
  end
end
