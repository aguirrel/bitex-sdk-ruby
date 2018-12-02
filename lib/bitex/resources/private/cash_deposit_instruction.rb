module Bitex
  module Resources
    class CashDepositInstruction < Private
      # GET /api/cash_deposit_instructions?filter[from]={yyyy-mm-dd}
      #
      # ***************************************************************************************************************
      # Experimental endpoint:
      #   This endpoint may not be supported in further releases of the API.
      #   If your integration relies on it, please contact us at developers@bitex.la explaining your use case,
      #   in order to provide you with better support
      # ***************************************************************************************************************
      #
      # @return [ResultSet<CashDepositInstruction>]
      #
      # .all
    end
  end
end
