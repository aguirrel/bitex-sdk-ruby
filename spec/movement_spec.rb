require 'spec_helper'

describe Bitex::Movement do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  describe '.all' do
    subject { client.movements.all }

    context 'with unauthorized key', vcr: { cassette_name: 'movements/all/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key', vcr: { cassette_name: 'movements/all/authorized' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it { is_expected.to be_a(described_class) }

        its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id timestamp currencies_involved currency amount fee fee_decimals fee_currency price price_decimals kind]) }
        its(:type) { is_expected.to eq(resource_name) }
      end
    end
  end
end
