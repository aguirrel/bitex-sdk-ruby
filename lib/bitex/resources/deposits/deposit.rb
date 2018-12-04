module Bitex
  module Resources
    module Deposits
      # These endpoints are for loading balance in your Bitex account.
      #
      # For loading BTC you should get your Coin Wallet and send your BTC to the address displayed there.
      # Please note that if you send the BTC to your 'auto_sell_address', that balance will be sold automatically in the exchange
      # at the best price, and you will receive USD in your account.
      #
      # If you want to load Fiat balance (such as USD, ARS, CLP, PYG or UYU), we provide an experimental endpoint to get all the
      # information you need to make the transfer.
      # It's in HTML format, for it to be displayed in a browser and read by a human.
      class Deposit < Private
        # GET /api/<cash_deposits|coin_deposits>?filter[from]={yyyy-mm-dd}
        #
        # @param [String] from.
        #
        # @return [ResultSet<CashDeposit|CoinDeposit>]
        def self.all(from: nil)
          from.present? ? where(from: from).all : super()
        end

        # GET /api/<cash_deposit|coin_deposits>/:id
        #
        # @param [String|Integer] id.
        #
        # @return [CashDeposit|CoinDeposit]
        #
        def self.find(id)
          super(id)[0]
        end
      end
    end
  end
end
