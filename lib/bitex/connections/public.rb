module Bitex
  module Connections
    # For access to public resources, needs send API version on header.
    class Public < JsonApiClient::Connection
      def run(request_method, path, params: nil, headers: {}, body: nil)
        super(request_method, path, params: params, headers: custom_headers(headers), body: body)
      end

      protected

      def custom_headers(headers = {})
        headers.merge(version: '2.1')
      end
    end
  end
end
