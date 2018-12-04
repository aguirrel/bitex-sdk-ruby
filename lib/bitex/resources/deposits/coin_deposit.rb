module Bitex
  module Resources
    module Deposits
      class CoinDeposit < Deposit
        # GET /api/coin_deposits?filter[from]={yyyy-mm-dd}
        #
        # @param [String] from.
        #
        # @return [ResultSet<CoinDeposit>]
        #
        # .all(from: 'YYYY-MM-DD')

        # GET /api/coin_deposits/:id
        #
        # @param [String|Integer] id.
        #
        # @return [CoinDeposit]
        #
        # .find(id)
      end
    end
  end
end
