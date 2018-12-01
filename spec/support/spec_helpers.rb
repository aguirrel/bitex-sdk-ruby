module SpecHelpers
  extend ActiveSupport::Concern

  included do
    let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
    let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
    let(:key) { nil }
    let(:read_level_key) { 'read_level' }
    let(:write_level_key) { 'write_level' }
  end
end
