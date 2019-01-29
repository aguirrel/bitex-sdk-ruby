module Bitex
  module Resources
    # Generic base resource for public Bitex resources.
    class Public < JsonApiClient::Resource
      extend Forwardable

      include Connections

      attr_accessor :meta

      class << self
        def build(options = {})
          Class.new(self).tap do |anonymous|
            anonymous.connection_class = custom_connection(options)
            anonymous.parser = Bitex::Parser
            anonymous.site = "https://#{'sandbox.' if options[:sandbox]}bitex.la/api/"
          end
        end

        # @options [Hash]: this argument can give this optionals kwargs
        #   includes: with tables symbols list
        #   filters: with kwarg conditional fields. Here send :limit and :span filters
        def all(**options)
          return super() unless options.any?

          build_query(options).all
        end

        def find(*args, **options)
          return super(*args)[0] unless options.any?

          build_query(options).find(*args)[0]
        end

        def build_query(options)
          query = add_includes(options.delete(:includes)) if options.key?(:includes)
          query = set_filters(query, options.extract!(:limit, :span)) if options.key?(:limit) || options.key?(:span)
          options.any? ? set_conditions(query, options) : query
        end

        def add_includes(tables)
          includes(*tables)
        end

        def set_filters(query, filters)
          query.present? ? query.with_params(filters) : with_params(filters)
        end

        def set_conditions(query, conditions)
          conditions[:orderbook_code] = conditions.delete(:orderbook).code if conditions.key?(:orderbook)
          query.present? ? query.where(conditions) : where(conditions)
        end

        def custom_connection(_options = {})
          Connections::Public
        end

        def resource_name
          (name || superclass.name).demodulize.underscore
        end
      end

      def update_attributes(attrs = {})
        self.meta = attrs.delete(:meta)
        super(attrs)
      end
      def_delegator self, :with_headers
    end
  end
end
