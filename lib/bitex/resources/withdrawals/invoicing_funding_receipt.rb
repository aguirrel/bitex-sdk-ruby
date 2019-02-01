module Bitex
  module Resources
    module Withdrawals
      class InvoicingFundingReceipt < Private
        property :amount, type: :decimal
        property :tax, type: :decimal
      end
    end
  end
end
