module Bitex
  # To parse anonymous configured resources.
  class Parser < JsonApiClient::Parsers::Parser
    def self.parse(klass, response)
      super(klass.superclass, response)
    end
  end
end
