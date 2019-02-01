module Bitex
  module Resources
    module Withdrawals
      # Store a set of instructions to be used when requesting coin withdrawals from Bitex or other brokers/exchanges in the
      # Bitex Concierge network.
      class CoinWithdrawal < Withdrawal
        property :amount, type: :decimal

        # GET /api/coin_withdrawals
        #
        # @param [String] from. Date from which to take the withdrawals. Fromat is ISO 8601 (YYYY-MM-DD)
        #
        # @return [ResultSet<CoinWithdrawal>].
        #
        # self.all(from: from)

        # GET /api/coin_withdrawals/:id
        #
        # @param [Integer|String] id.
        #
        # @return [CoinWithdrawal]

        # POST /api/coin_withdrawals
        #
        # @param [String] to_addresses. Address to withdraw.
        # @param [Integer|String] otp. One Time Password.
        # @param [Float|String] amount. withdrawal amount.
        # @param [String] coin_code. Currently, the possible crypto currencies values are 'btc' and 'bch'.
        # @param [String] label.
        #
        # @return [CoinWithdrawal]
        def self.create(to_addresses:, label:, amount:, coin_code:, otp:)
          new(to_addresses: to_addresses, label: label, amount: amount, coin_code: coin_code).tap do |withdrawal|
            with_headers('One-Time-Password': otp) { withdrawal.save }
          end
        end
      end
    end
  end
end
