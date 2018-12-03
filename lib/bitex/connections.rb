module Bitex
  # Here manage different requirements for specific resources.
  module Connections
    autoload :Public, 'bitex/connections/public'
    autoload :Private, 'bitex/connections/private'
  end
end
