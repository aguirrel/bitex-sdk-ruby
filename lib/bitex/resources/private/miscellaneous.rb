module Bitex
  module Resources
    # Experimental endpoint: This endpoint may not be supported in further releases of the API. If your integration relies on it,
    # please contact us at developers@bitex.la explaining your use case, in order to provide you with better support.
    module Miscellaneous
      autoload :Movement, 'bitex/resources/private/miscellaneous/movement'
      autoload :Account, 'bitex/resources/private/miscellaneous/account'
      autoload :User, 'bitex/resources/private/miscellaneous/user'
    end
  end
end
