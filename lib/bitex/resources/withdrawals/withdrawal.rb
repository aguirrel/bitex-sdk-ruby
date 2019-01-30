module Bitex
  module Resources
    module Withdrawals
      # Store a set of instructions to be used when requesting cash/coin withdrawals from Bitex or other brokers/exchanges in the
      # Bitex Concierge network.
      class Withdrawal < Private
        # POST /api/<cash_withdrawals|coin_withdrawals>
        #
        # @params [{}] hash. Subclass responsibility.
        #
        # @return [<CashWithdrawal|CoinWithdrawal>]
        #
        # .create(hash)
      end
    end
  end
end
