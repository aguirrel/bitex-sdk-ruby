module Bitex
  module Resources
    # For whitelabelers users.
    class User < Private
      # GET /api/users
      #
      # @return [ResultSet<User>]
      #
      # .all

      # POST /api/users
      #
      # @param [String] email.
      # @param [String] password.
      #
      # @return [User]
      #
      # .create(email:, password:)

      # GET /api/users
      #
      # @param [String|Integer] id.
      #
      # @return [User]
      def self.find(id)
        authorize_with_user(id) { super('me') }
      end

      # PUT /api/users/:id
      #
      # @params [Hash] options
      #   options[:email] [String] new email.
      #   options[:password] [String] new password.
      #   options[:do_not_email] [Boolean].
      #   options[:meta] hash with :current_password.
      #
      # return [Boolean]
      def update(**options)
        authorize_with_user(id) { super(**options) }
      end

      # To compose authorization with api key and user id
      def self.authorize_with_user(id)
        with_headers(Authorization: "#{api_key}\; user=#{id}") { yield }
      end
      def_delegator self, :authorize_with_user

      private_class_method :authorize_with_user
    end
  end
end
