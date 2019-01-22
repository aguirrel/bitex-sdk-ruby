module Bitex
  module Resources
    module Withdrawals
      # Store a set of instructions to be used when requesting cash withdrawals from Bitex or other brokers/exchanges in the
      # Bitex Concierge network.
      class CashWithdrawal < Withdrawal
        # GET /api/cash_withdrawals
        #
        # @param [String] from. Date from which to take the withdrawals. Fromat is ISO 8601 (YYYY-MM-DD)
        #
        # @return [ResultSet<CashWithdrawal>].
        #
        # self.all(from: from)

        # GET /api/cash_withdrawals/:id
        #
        # @param [Integer|String] id.
        #
        # @return [CashWithdrawal]

        # POST /api/cash_withdrawals
        #
        # @param [WithdrawalInstruction] withdrawal_instruction. Previously created instructions for withdrawal.
        # @param [Integer|String] otp. One Time Password.
        # @param [Float|String] amount. withdrawal amount.
        # @param [Float|String] fiat. Fiat currency code.
        #
        # @return [CashWithdrawal]
        def self.create(withdrawal_instruction:, amount:, fiat_code:, otp:)
          new(amount: amount, fiat_code: fiat_code).tap do |withdrawal|
            withdrawal.relationships.withdrawal_instruction = withdrawal_instruction
            with_headers('One-Time-Password': otp) { withdrawal.save }
          end
        end
      end
    end
  end
end
