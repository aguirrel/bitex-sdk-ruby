module Bitex
  class Parser < JsonApiClient::Parsers::Parser
    def parse(klass, response)
      super(klass.superclas, response)
    end
  end
end
