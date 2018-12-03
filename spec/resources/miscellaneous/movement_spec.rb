require 'spec_helper'

describe Bitex::Resources::Miscellaneous::Movement do
  shared_examples_for 'Movement' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq(resource_name) }
    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id timestamp currencies_involved currency amount fee fee_decimals fee_currency price price_decimals kind]) }
  end

  describe '.all' do
    subject { client.movements.all }

    context 'with any level key', vcr: { cassette_name: 'movements/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Movement'
      end
    end
  end
end
