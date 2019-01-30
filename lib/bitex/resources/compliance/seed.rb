module Bitex
  module Resources
    module Compliance
      # For all creation seeds u need authorize adding the impersonated user id.
      class Seed < Private
        def self.create(id, **attrs)
          authorize_with_user(id) { super(**attrs) }
        end
      end
    end
  end
end
