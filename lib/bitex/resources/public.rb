module Bitex
  module Resources
    # Generic base resource for public Bitex resources.
    class Public < JsonApiClient::Resource
      def self.build(options = {})
        Class.new(self).tap do |anonymous|
          anonymous.connection_class = build_connection(options)
          anonymous.parser = Parser
        end
      end

      protected

      def self.build_connection(_options = {})
        Class.new(Connections::Public)
      end

      class << self
        def resource_name
          (name || superclass.name).demodulize.underscore
        end
      end
    end
  end
end
