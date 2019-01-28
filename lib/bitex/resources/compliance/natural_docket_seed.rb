module Bitex
  module Resources
    module Compliance
      class NaturalDocketSeed < Private
        # POST /api/natural_docket_seeeds
        #
        # @param [String] :first_name
        # @param [String] :last_name
        # @param [String] :nationality
        # @param [String] :gender_code
        # @param [String] :marital_status_code
        # @param [Boolean] :politically_exposed
        # @param [String] :birth_date ISO 8601 (YYYY-MM-DD)
        #
        # @return [NaturalDocketSeed]
        def self.create(id, **attrs)
          authorize_with_user(id) { super(**attrs) }
        end
      end
    end
  end
end
