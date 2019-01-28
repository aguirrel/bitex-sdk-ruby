module Bitex
  module Resources
    module Compliance
      class AllowanceSeed < Seed
        # POST /api/allowance_seed
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] kind_code.
        #
        # @return [AllowanceSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
