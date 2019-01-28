module Bitex
  module Resources
    module Compliance
      class NaturalDocketSeed < Private
        # POST /api/natural_docket_seeeds
        #
        # @params [String] :first_name
        # @params [String] :last_name
        # @params [String] :nationality
        # @params [String] :gender_code
        # @params [String] :marital_status_code
        # @params [Boolean] :politically_exposed
        # @params [String] :birth_date ISO 8601 (YYYY-MM-DD)
        #
        # @return [NaturalDocketSeed]
        def self.create(id, **attrs)
          authorize_with_user(id) { super(**attrs) }
        end
      end
    end
  end
end
