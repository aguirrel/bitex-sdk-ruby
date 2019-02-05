module Bitex
  module Resources
    # Experimental endpoint: This endpoint may not be supported in further releases of the API. If your integration relies on it,
    # please contact us at developers@bitex.la explaining your use case, in order to provide you with better support.
    module Miscellaneous
      # These endpoints give you access general information about your account such as your balances, movements including
      # deposits, withdrawals as well as executed bids and asks, and your list of Compliance Profiles, a collection of all the
      # people or legal entities associated to your bitex account in any capacity.
      #
      # If you're looking for your individual trades see Your latest Trades.
      # Most accounts only need one Compliance Profile, if you need to create sub-accounts have a look at our Reseller API.
      class Account < Private
        property :balances, type: :balances

        # GET /api/accounts
        #
        # Get all your accounts.
        #
        # @return [ResultSet<Account>]
        #
        # .all
      end
    end
  end
end
