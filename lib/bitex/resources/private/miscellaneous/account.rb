module Bitex
  module Resources
    module Miscellaneous
      # These endpoints give you access general information about your account such as your balances, movements including
      # deposits, withdrawals as well as executed bids and asks, and your list of Compliance Profiles, a collection of all the
      # people or legal entities associated to your bitex account in any capacity.
      #
      # If you're looking for your individual trades see Your latest Trades.
      # Most accounts only need one Compliance Profile, if you need to create sub-accounts have a look at our Reseller API.
      class Account < Private
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
