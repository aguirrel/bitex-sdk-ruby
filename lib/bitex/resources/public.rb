module Bitex
  module Resources
    # Generic base resource for public Bitex resources.
    class Public < JsonApiClient::Resource
      include Connections

      class << self
        def build(options = {})
          Class.new(self).tap do |anonymous|
            anonymous.connection_class = custom_connection(options)
            anonymous.parser = Bitex::Parser
            anonymous.site = "https://#{'sandbox.' if options[:sandbox]}bitex.la/api/"
          end
        end

        protected

        def custom_connection(_options = {})
          Connections::Public
        end

        def resource_name
          (name || superclass.name).demodulize.underscore
        end
      end
    end
  end
end
