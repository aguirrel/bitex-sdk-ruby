module Bitex
  module Resources
    # For market relationships.
    class Candle < Public
      # TODO VER que TRADE trae estas dos relaciones
      # /api/candles?filter[orderbook_code]={orderbook_code}&filter[days]={days}&span={span}
      #
      # Get candles for a given market
      #  filters:
      #    @param [Base::Resource::Orderbook] orderbook.
      #    @param [Integer] days. number of days from where you want the candles to be. default = 1
      #    @param [Integer] span. timespan for each candle. default = 1
      #
      # @return JsonApiClient::ResultSet. It has the server response data, and all transactions parsed to json api.
      def self.find(days: nil, orderbook: nil, span: nil)
        filters = {}.tap do |params|
          params.merge!(days: days) if days.present?
          params.merge!(orderbook_code: orderbook.code) if orderbook.present?
        end

        span.present? ? with_params(span: span).find(filters) : super(filters)
      end
    end
  end
end
