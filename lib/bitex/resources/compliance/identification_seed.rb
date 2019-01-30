module Bitex
  module Resources
    module Compliance
      class IdentificationSeed < Seed
        # POST /api/identification_seeds
        #
        # The identification should be checked by an attachment demonstrating its validity.
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] identification_kind_code.
        #   @param [String] issuer.
        #   @param [Integer] number.
        #
        # @return [IdentificationSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
