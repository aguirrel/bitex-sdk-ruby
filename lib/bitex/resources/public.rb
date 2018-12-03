module Bitex
  module Resources
    # Generic base resource for public Bitex resources.
    class Public < JsonApiClient::Resource
      class << self
        def build(options = {})
          Class.new(self).tap do |anonymous|
            anonymous.connection_class = build_connection(options)
            anonymous.parser = Parser
            anonymous.site = "https://#{'sandbox.' if options[:sandbox]}bitex.la/api/"
          end
        end

        protected

        def build_connection(_options = {})
          Class.new(Connections::Public)
        end

        def resource_name
          (name || superclass.name).demodulize.underscore
        end
      end
    end
  end
end
