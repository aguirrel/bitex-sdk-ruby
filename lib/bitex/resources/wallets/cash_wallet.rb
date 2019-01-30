module Bitex
  module Resources
    module Wallets
      # This resource has the user's balances in fiat currencies.
      class CashWallet < Wallet
        # GET /api/cash_wallets
        #
        # @param [String] from.
        #
        # @return [ResultSet<CashWallet>]
        #
        # .all

        # GET /api/cash_wallets/:currency_code
        #
        # @param [String] currency code. Fiat currency code.
        #
        # @return [CashWallet]
        #
        # .find(currency_code)
      end
    end
  end
end
