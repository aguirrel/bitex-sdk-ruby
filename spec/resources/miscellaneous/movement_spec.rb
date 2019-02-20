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

      its(:id) { is_expected.to be_a(String) }
      its(:timestamp) { is_expected.to be_a(Integer) }
      its(:currencies_involved) { is_expected.to be_a(Symbol) }
      its(:currency) { is_expected.to be_a(Symbol) }
      its(:amount) { is_expected.to be_a(BigDecimal) }
      its(:fee) { is_expected.to be_a(BigDecimal) }
      its(:fee_decimals) { is_expected.to be_a(Integer) }
      its(:fee_currency) { is_expected.to be_a(Symbol) }
      its(:price) { is_expected.to be_a(BigDecimal) }
      its(:price_decimals) { is_expected.to be_a(Integer) }
      its(:kind) { is_expected.to be_a(Symbol) }
    end
  end
end
