module Bitex
  module Resources
    module Deposits
      # For loading BTC you should get your Coin Wallet and send your BTC to the address displayed there.
      # Please note that if you send the BTC to your 'auto_sell_address', that balance will be sold automatically in the exchange
      # at the best price, and you will receive USD in your account.
      class CoinDeposit < Deposit
        property :amount, type: :decimal
        property :coin, type: :symbol

        property :created_at, type: :time

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
