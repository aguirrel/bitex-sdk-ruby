require 'spec_helper'

describe Bitex::Resources::Miscellaneous::Movement do
  describe '.all', vcr: { cassette_name: 'movements/all' } do
    subject(:movements) { client.movements.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { movements.sample }

      it { is_expected.to be_a(Bitex::Resources::Miscellaneous::Movement) }

      its(:'attributes.keys') {
        is_expected.to contain_exactly(
          *%w[type id timestamp currencies_involved currency amount fee fee_decimals fee_currency price price_decimals kind]
        )
      }
      its(:type) { is_expected.to eq('movements') }
    end
  end
end
