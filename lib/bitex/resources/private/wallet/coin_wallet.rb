module Bitex
  module Resources
    # This resource has the user's balances in crypto currencies.
    class CoinWallet < Wallet
      # GET /api/coin_wallets
      #
      # @param [String] from.
      #
      # @return [ResultSet<CoinWallet>]
      #
      # .all

      # GET /api/coin_wallets/:currency_code
      #
      # @param [String] currency code. Fiat currency code.
      #
      # @return [CoinWallet]
      #
      # .find(currency_code: currency_code)
    end
  end
end
