module Helpers
  extend ActiveSupport::Concern

  included do
    def client
      build_client(api_key: 'your_magic_api_key')
    end

    def build_client(api_key: nil, sandbox: true)
      Bitex::Client.new(api_key: api_key, sandbox: sandbox)
    end
  end
end
