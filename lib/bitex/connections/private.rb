module Bitex
  module Connections
    class Private < Public
      cattr_accessor :api_key

      protected

      def custom_headers(headers)
        super(headers.merge(Authorization: api_key))
      end
    end
  end
end
