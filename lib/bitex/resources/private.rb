module Bitex
  module Resources
    # Generic base resource for private Bitex resources.
    class Private < Public
      class << self
        protected

        def custom_connection(options = {})
          Connections::Private.tap { |connection| connection.api_key = options[:api_key] }
        end
      end
    end
  end
end
