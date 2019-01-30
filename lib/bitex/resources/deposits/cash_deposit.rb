module Bitex
  module Resources
    module Deposits
      class CashDeposit < Deposit
        # GET /api/cash_deposits?filter[from]={yyyy-mm-dd}
        #
        # filters:
        #   @param [String] from. 'YYYY-MM-DD'
        #
        # @return [ResultSet<CashDeposit>]
        #
        # .all(from:)

        # GET /api/cash_deposits/:id
        #
        # @param [String|Integer] id.
        #
        # @return [CashDeposit]
        #
        # .find(id)
      end
    end
  end
end
