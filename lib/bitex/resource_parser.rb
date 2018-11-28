module JsonApiClient
  module Parsers
    class ResourceParser < Parser
      def parse(klass, response)
        super(klass.superclas, response)
      end
    end
  end
end
