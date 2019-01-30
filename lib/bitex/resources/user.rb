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
    end
  end
end
