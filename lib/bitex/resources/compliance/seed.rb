module Bitex
  module Resources
    module Compliance
      class Seed < Private
        def self.create(id, **attrs)
          authorize_with_user(id) { super(**attrs) }
        end
      end
    end
  end
end
