module Bitex
  module Resources
    module Compliance
      # pending doc TODO
      class Issue < Private
        custom_endpoint :'current/complete', on: :collection, request_method: :post

        # GET /api/issues/current
        #
        # @param [String|Integer] id from impersonated user.
        #
        # @return [Issue]
        def self.current(id)
          authorize_with_user(id) { find('current') }
        end

        def self.complete(id)
          authorize_with_user(id) { send('current/complete')[0] }
        end
      end
    end
  end
end
