module Bitex
  module Resources
    # Overview of current market prices and trade volume, including Volume-Weighted Average Price.
    class Ticker < Public
      # GET /api/tickers
      #
      # Get Tickers of all available markets
      #
      # @return JsonApiClient::ResultSet. It has the server response.
      #
      # #TODO ver test porque trae varios mercados
      # self.all

      # GET /api/tickers/:orderbook_code
      #
      # Get the ticker of a market.
      #
      # @param [Symbol] orderbook_code. Values: :btc_usd, :btc_ars, :bch_usd, :btc_pyg, :btc_clp, :btc_uyu
      #
      # @return JsonApiClient::ResultSet. It has the server response data, and in its only element, market parsed to json api.
      # # TODO como saltemos validaciones, es directo un .find(orderbook_code)
  #   def self.find(orderbook_code)
  #     raise UnknownOrderbook unless valid_code?(orderbook_code)

  #     super(orderbook_code)
  #   end
    end
  end
end
