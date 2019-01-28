module Bitex
  module Resources
    # Generic base resource for private Bitex resources.
    class Private < Public
      cattr_accessor :api_key

      class << self
        def build(options = {})
          super(options).tap do |anonymous|
            anonymous.api_key = options[:api_key]
          end
        end

        protected

        def custom_connection(options = {})
          Connections::Private.tap { |connection| connection.api_key = options[:api_key] }
        end
      end
    end
  end
end
