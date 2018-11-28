module Bitex
  module Connection
    class Private < Public
      cattr_accessor :api_key

      def custom_headers(headers)
        super(headers.merge(Authorization: api_key))
      end
    end
  end
end
