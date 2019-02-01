module Bitex
  module Resources
    module Deposits
      class CoinDeposit < Deposit
        property :amount, type: :decimal

        # GET /api/coin_deposits?filter[from]={yyyy-mm-dd}
        #
        # filters:
        #   @param [String] from. 'YYYY-MM-DD'
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
