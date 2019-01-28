module Bitex
  module Resources
    module Compliance
      class NaturalDocketSeed < Seed
        # POST /api/natural_docket_seeeds
        #
        # @param [Integer] id. Impersonated user id.
        #
        # @param attrs [Hash]:
        #   @param [String] :first_name
        #   @param [String] :last_name
        #   @param [String] :nationality
        #   @param [String] :gender_code
        #   @param [String] :marital_status_code
        #   @param [Boolean] :politically_exposed
        #   @param [String] :birth_date ISO 8601 (YYYY-MM-DD)
        #
        # @return [NaturalDocketSeed]
        #
        # .create(id, **attrs)
      end
    end
  end
end
