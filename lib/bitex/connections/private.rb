module Bitex
  module Connections
    # For access to private resources, needs send your API key on header.
    class Private < Public
      cattr_accessor :api_key

      protected

      def custom_headers(headers)
        headers[:Authorization] = api_key unless headers.key?(:Authorization)
        super(headers)
      end
    end
  end
end
