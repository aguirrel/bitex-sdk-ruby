module Bitex
  module Resources
    class Currency
      include StaticModels::Model

      static_models_dense [
        [:id, :code, :name,                :decimals ],
        [1,   :btc,  'bitcoin',            8         ],
        [2,   :ltc,  'litecoin',           8         ],
        [3,   :usd,  'us_dollar',          2         ],
        [4,   :ars,  'argentine_peso',     2         ],
        [5,   :uyu,  'uruguayan_peso',     2         ],
        [6,   :eur,  'euro',               2         ],
        [7,   :clp,  'chilean_peso',       2         ],
        [8,   :pen,  'peruvian_sol',       2         ],
        [9,   :brl,  'brazilian_real',     2         ],
        [10,  :cop,  'colombian_peso',     2         ],
        [11,  :mxn,  'mexican_peso',       2         ],
        [12,  :pyg,  'paraguayan_guarani', 2         ],
        [13,  :cny,  'chinese_yuan',       2         ],
        [14,  :inr,  'indian_rupee',       2         ],
        [15,  :vef,  'venezuelan_bolivar', 2         ],
        [16,  :bch,  'bcash',              8         ]
      ]
    end
  end
end
