module Bitex
  module Resources
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
