module Bitex
  module Resources
    # Generic base resource for private Bitex resources.
    class Private < Public
      class << self
        protected

        def build_connection(options = {})
          Class.new(Connections::Private).tap { |connection| connection.api_key = options[:api_key] }
        end
      end
    end
  end
end
