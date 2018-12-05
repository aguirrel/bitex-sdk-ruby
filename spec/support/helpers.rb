module Helpers
  extend ActiveSupport::Concern

  included do
    def build_client(api_key: nil, sandbox: true)
      Bitex::Client.new(api_key: api_key, sandbox: sandbox)
    end

    let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  end
end
