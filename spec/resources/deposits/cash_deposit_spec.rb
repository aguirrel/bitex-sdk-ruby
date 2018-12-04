require 'spec_helper'

describe Bitex::Resources::Deposits::CashDeposit do
  shared_examples_for 'Cash Deposit' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type id status requested_amount requested_currency deposit_method country clearing_data amount fiat gross_amount
        cost fee net_amount created_at]
      )
    end
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[funding_receipt]) }
  end

  describe '.all' do
    subject { client.cash_deposits.all(from: from) }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'without filters', vcr: { cassette_name: 'cash_deposits/all/without_filters' } do
        let(:from) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Cash Deposit'
        end
      end

      context 'with filters', vcr: { cassette_name: 'cash_deposits/all/with_filters' } do
        let(:from) { '2018-01-01' }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Cash Deposit'
        end
      end
    end
  end

  describe '.find' do
    subject { client.cash_deposits.find(id) }

    context 'with any level key', vcr: { cassette_name: 'cash_deposits/find' } do
      let(:key) { read_level_key }
      let(:id) { '5' }

      it_behaves_like 'Cash Deposit'

      its(:id) { is_expected.to eq(id) }
    end
  end
end
