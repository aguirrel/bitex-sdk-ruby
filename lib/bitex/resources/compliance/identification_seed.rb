module Bitex
  module Resources
    module Compliance
      class IdentificationSeed < Private
        # POST /api/identification_seeds
        #
        # The identification should be checked by an attachment demonstrating its validity.
        #
        # @param [String] identification_kind_code.
        # @param [String] issuer.
        # @param [Integer] number.
        #
        # @return [IdentificationSeed]
        def self.create(id, **attrs)
          authorize_with_user(id) { super(**attrs) }
        end
      end
    end
  end
end
