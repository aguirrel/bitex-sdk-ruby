module Bitex
  module Resources
    # Generic base resource for private Bitex resources.
    class Private < Public
      cattr_accessor :api_key

      # To compose authorization with api key and impersonated user id
      def self.authorize_with_user(id)
        with_headers(Authorization: "#{api_key}\; user=#{id}") { yield }
      end
      def_delegator self, :authorize_with_user

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
