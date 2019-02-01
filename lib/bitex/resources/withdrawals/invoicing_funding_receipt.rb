module Bitex
  module Resources
    module Withdrawals
      # Needed to parse the operation receipt.
      class InvoicingFundingReceipt < Private
        property :amount, type: :decimal
        property :tax, type: :decimal
      end
    end
  end
end
