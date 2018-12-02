module Bitex
  module Resources
    # Store a set of instructions to be used when requesting cash/coin withdrawals from Bitex or other brokers/exchanges in the
    # Bitex Concierge network.
    class Withdrawal < Private
      # GET /api/<cash_withdrawals|coin_withdrawals>
      #
      # @param [String] from. Date from which to take the withdrawals. Fromat is ISO 8601 (YYYY-MM-DD)
      #
      # @return [Array<CashWithdrawal|CoinWithdrawal>].
      def self.all(from: nil)
        from.present? ? where(from: from).all : super()
      end

      # GET /api/<cash_withdrawals|coin_withdrawals>/:id
      #
      # @param [Integer|String] id.
      #
      # @return [<CashWithdrawal|CoinWithdrawal>]
      def self.find(id)
        super(id)[0]
      end

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
