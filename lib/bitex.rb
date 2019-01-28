require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies'
require 'bigdecimal'
require 'bigdecimal/util'
require 'curl'
require 'forwardable'
require 'json'
require 'json_api_client'

# Bitex library namespace
module Bitex
  ActiveSupport::Dependencies.autoload_paths += %w[lib]
end

module JsonApiClient
  module Query
    class Requestor
      def update(record)
        request(
          :put,
          resource_path(record.attributes),
          body: { data: record.as_json_api, meta: record.meta },
          params: record.request_params.to_params
        )
      end
    end
  end
end
