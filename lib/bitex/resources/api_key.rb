module Bitex
  module Resources
    # You authenticate to the Bitex API by provinding one of your API keys as a POST or GET parameter called api_key.
    # You can have several active API keys at once.
    # It's your responsibility to keep all your API keys safe.
    # Always use the https protocol when making your requests.
    # Revoke your API keys immediately if you think they're compromised.
    # You need to Log in or Sign Up in order to create API Keys and use our Private Trading API.
    class ApiKey < Private
      # GET /api/api_keys
      #
      # Get all api keys.
      # Important: The tokens will be obfuscated after 10 minutes of the Api Key's creation (for security purposes).
      #
      # @return [ResultSet<ApiKey>]
      #
      # .all

      # GET /api/api_keys/:id
      #
      # @param [Integer|String] id.
      #
      # @return [ApiKey]
      #
      # .find(id)

      # POST /api/api_keys
      #
      # Create an Api Key.
      # This endpoint always requires an OTP. Users that don't have the 2FA enabled, will not be able to create Api Keys.
      #
      # @param [Symbol] permissions: { write: true }, { write: false }
      # @param [String] otp: your One Time Password.
      #
      # @return [ApiKey]
      def self.create(permissions: {}, otp: nil)
        with_headers('One-Time-Password': otp) { super(permissions) }
      end

      # DELETE /api/api_keys/:id
      #
      # Delete Api Key
      #
      # @param [Integer|String] id.
      #
      # @return [Boolean]
      #
      # #destroy
    end
  end
end
