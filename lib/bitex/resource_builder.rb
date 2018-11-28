module Bitex
  # This class returns an anonymous Resource subclass configured with connection type.
  class ResourceBuilder
    def self.build(resource_class, connection)
      Class.new(resource_class).tap do |anonymous|
        anonymous.connection_class = connection
        anonymous.parser = JsonApiClient::Parsers::ResourceParser
      end
    end
  end
end
