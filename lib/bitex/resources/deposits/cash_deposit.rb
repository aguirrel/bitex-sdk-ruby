module Bitex
  module Resources
    module Deposits
      class CashDeposit < Deposit
        # cost: is the amount taken from your deposit by third-party institutions (such as banks and/or the government)
        # fee: is the amount taken by the local digital wallet associated to your Bitex account.
        # amount: is the amount received, which is the same as net_amount.
        # gross_amount: is the result of adding the net_amount, the fee and the cost.

        # GET /api/cash_deposits?filter[from]={yyyy-mm-dd}
        #
        # @param [String] from.
        #
        # @return [ResultSet<CashDeposit>]
        #
        # .all(from: 'YYYY-MM-DD')

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
