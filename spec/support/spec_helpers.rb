module SpecHelpers
  extend ActiveSupport::Concern

  included do
    let(:client) { Bitex::Client.new(sandbox: true) }
    let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
    let(:api_key) { nil }
  end
end
