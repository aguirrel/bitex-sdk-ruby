module Bitex
  module Resources
    # This resource has the user's balances in Fiat currencies.
    class CashWallet < Private
      # GET /api/cash_wallet
      #
      # @param [String] from.
      #
      # @return [ResultSet<CashWallet>]
      #
      # .all

      # GET /api/cash_wallet/:currency_code
      #
      # @param [String] currency code. Fiat currency code.
      #
      # @return [CashWallet]
      def self.find(currency_code:)
        super(id: currency_code)[0]
      end
    end
  end
end
