module Bitex
  module Resources
    module Deposits
      class CashDepositInstruction < Private
        property :currency, type: :symbol

        # GET /api/cash_deposit_instructions?filter[from]={yyyy-mm-dd}
        #
        # ***************************************************************************************************************
        # Experimental endpoint:
        #   This endpoint may not be supported in further releases of the API.
        #   If your integration relies on it, please contact us at developers@bitex.la explaining your use case,
        #   in order to provide you with better support
        # ***************************************************************************************************************
        #
        # Optional filters:
        #   @param [String] from. Date from which to take the withdrawals. Fromat is ISO 8601 (YYYY-MM-DD)
        #
        # @return [ResultSet<CashDepositInstruction>]
        #
        # .all(from:)
      end
    end
  end
end
