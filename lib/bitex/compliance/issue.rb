module Bitex
  module Compliance
    # pending doc TODO
    class Issue < Base
      custom_endpoint :current, on: :collection, request_method: :get

      def self.current!
        current[0]
      end
    end
  end
end
