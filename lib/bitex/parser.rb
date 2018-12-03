module Bitex
  class Parser < JsonApiClient::Parsers::Parser
    def self.parse(klass, response)
      klass = klass.superclass if klass.name.nil?
      super(klass, response)
    end
  end
end
