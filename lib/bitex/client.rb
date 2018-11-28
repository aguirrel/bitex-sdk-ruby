module Bitex
  # This client connects via API to Bitex resources.
  class Client
    attr_reader :api_key

    def initialize(api_key: nil, sandbox: false)
      @api_key = api_key
      setup_environment(sandbox)
    end

    def setup_environment(sandbox)
      Base.site = "https://#{'sandbox.' if sandbox}bitex.la/api/"
    end

    # Accessors for public resources that need a public connection.
    [].each do |resource|
      accessor = resource.name.demodulize.underscore.downcase.pluralize

      define_method(accessor) do
        configured_connection = Class.new(Connection::Public)
        configured_resource = ResourceBuilder.build(resource, configured_connection)

        instance_variable_get("@#{accessor}") || instance_variable_set("@#{accessor}", configured_resource)
      end
    end

    # Accessors for private resources that need a connection with api key.
    [].each do |resource|
       accessor = resource.name.demodulize.underscore.downcase.pluralize

       define_method(accessor) do
         configured_connection = Class.new(Connection::Private)
         configured_connection.api_key = api_key
         configured_resource = ResourceBuilder.build(resource, configured_connection)

         instance_variable_get("@#{accessor}") || instance_variable_set("@#{accessor}", configured_resource)
       end
     end
  end
end
