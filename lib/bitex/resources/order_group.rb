module Bitex
  module Resources
    # For market relationships.
    class OrderGroup < Public
      property :price, type: :decimal
      property :amount, type: :decimal
    end
  end
end
