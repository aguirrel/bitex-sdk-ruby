module Bitex
  module Resources
    # Overview of current orderbooks resume.
    class Orderbook < Public
      include StaticModels::Model

      # rubocop:disable Style/SymbolArray, Layout/SpaceInsideArrayLiteralBrackets
      static_models_dense [
        [:id, :code,        :base,        :quote      ],
        [1,   :btc_usd,     Currency.btc, Currency.usd],
        [2,   :ltc_usd,     Currency.ltc, Currency.usd],
        [3,   :btc_ars_otc, Currency.btc, Currency.ars],
        [4,   :btc_usd_otc, Currency.btc, Currency.usd],
        [5,   :btc_ars,     Currency.btc, Currency.ars],
        [6,   :usd_ars_otc, Currency.usd, Currency.ars],
        [7,   :btc_clp_otc, Currency.btc, Currency.clp],
        [8,   :bch_usd,     Currency.bch, Currency.usd],
        [9,   :bch_usd_otc, Currency.bch, Currency.usd],
        [10,  :btc_pyg,     Currency.btc, Currency.pyg],
        [11,  :btc_clp,     Currency.btc, Currency.clp],
        [12,  :btc_uyu,     Currency.btc, Currency.uyu],
        [13,  :usd_clp_otc, Currency.usd, Currency.clp],
        [14,  :usd_uyu_otc, Currency.usd, Currency.uyu],
        [15,  :usd_pyg_otc, Currency.usd, Currency.pyg]
      ]
      # rubocop:enable Style/SymbolArray, Layout/SpaceInsideArrayLiteralBrackets

      # Get all orderbooks with your codes, base and quotes currencies.
      #
      # @return JsonApiClient::ResultSet. It has the server response.
      #
      # self.all
    end
  end
end
