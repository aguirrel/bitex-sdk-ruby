require 'spec_helper'

describe Bitex::Resources::Deposits::CashDepositInstruction do
  shared_examples_for 'Cash Deposit Instruction' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[id type currency instructions]) }
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.all' do
    subject { client.cash_deposit_instructions.all }

    context 'with any level key', vcr: { cassette_name: 'cash_deposit_instructions/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Cash Deposit Instruction'
      end
    end
  end
end
