module Bitex
  module Resources
    # Returns a list representing all individual trades for the past given hours, sorted by descending date.
    # For market relationships also.
    class Transaction < Public
      # GET https://bitex.la/api/transactions?filter[orderbook_code]={:orderbook_code}&filter[from]={:hours}
      #
      # Get last transactions of a given market.
      #
      # @param [Bitex::Orderbook] orderbook.
      #   filter: Market from which you want to retrieve data. If no Orderbook is specified, all markets are retrieved.
      #
      # @param [Integer|String] from.
      #   filter: Number of hours from where you want the transactions to be retrieved. default value = 1 | maximum value = 24.
      #
      # @return JsonApiClient::ResultSet. It has the server response data, and all transactions parsed to json api.
      def self.all(orderbook: nil, from: nil)
        filters = {}.tap do |params|
          params.merge!(from: from) if from.present?
          params.merge!(orderbook_code: orderbook.code) if orderbook.present?
        end

        where(filters).all
      end

      # GET https://bitex.la/api/transactions/:id
      #
      # Get transaction by id.
      #
      # @return Transaction.
      #
      # self.find(id)
      def self.find(id)
        super(id)[0]
      end
    end
  end
end
