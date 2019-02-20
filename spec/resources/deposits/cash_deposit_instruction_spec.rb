require 'spec_helper'

describe Bitex::Resources::Deposits::CashDepositInstruction do
  describe '.all', vcr: { cassette_name: 'cash_deposit_instructions/all' } do
    subject(:deposit_instructions) { client.cash_deposit_instructions.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { deposit_instructions.sample }

      it { is_expected.to be_a(Bitex::Resources::Deposits::CashDepositInstruction) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id currency instructions]) }
      its(:type) { is_expected.to eq('cash_deposit_instructions') }

      its(:id) { is_expected.to be_a(String) }
      its(:currency) { is_expected.to be_a(Symbol) }
      its(:instructions) { is_expected.to be_a(String) }
    end
  end
end
