module Bitex
  module Connections
    # For access to private resources, needs send your API key on header.
    class Private < Public
      cattr_accessor :api_key

      protected

      def custom_headers(headers)
        super(headers.merge(Authorization: api_key))
      end
    end
  end
end
