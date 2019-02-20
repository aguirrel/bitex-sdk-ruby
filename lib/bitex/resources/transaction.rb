module Bitex
  module Resources
    # Returns a list representing all individual trades for the past given hours, sorted by descending date.
    # For market relationships also.
    class Transaction < Public
      property :amount, type: :decimal
      property :price, type: :decimal
      property :orderbook_code, type: :symbol

      # GET https://bitex.la/api/transactions?filter[orderbook_code]={:orderbook_code}&filter[from]={:hours}
      #
      # Get last transactions of a given market.
      #
      # Optional filter
      #   @param [Orderbook] orderbook.
      #   @param [Integer|String] from.
      #     Number of hours from where you want the transactions to be retrieved. default value = 1 | maximum value = 24.
      #
      # @return [ResultSet<Transaction>]
      #
      # .all(orderbook:, from:)

      # GET /api/transactions/:id
      #
      # Get transaction by id.
      #
      # @return [Transaction]
      #
      # .find(id)
    end
  end
end
