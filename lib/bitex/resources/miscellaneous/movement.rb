module Bitex
  module Resources
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
