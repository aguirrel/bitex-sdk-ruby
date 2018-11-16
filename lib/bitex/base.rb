module Bitex
  # Generic base resource for Bitex resources.
  class Base < JsonApiClient::Resource
    extend Forwardable

    def self.find(*args)
      super(*args)[0]
    end

    def_delegator self, :with_headers
  end
end
