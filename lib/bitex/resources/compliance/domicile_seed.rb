module Bitex
  module Resources
    module Compliance
      class DomicileSeed < Seed
        # POST /api/domicile_seeds
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] city.
        #   @param [String] country.
        #   @param [String] floor.
        #   @param [String] postal_code.
        #   @param [String] street_address.
        #   @param [String] street_number.
        #   @param [String] state.
        #   @param [String] apartment.
        #
        # @return [DomicileSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
