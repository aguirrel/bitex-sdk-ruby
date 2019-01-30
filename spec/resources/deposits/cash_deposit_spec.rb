require 'spec_helper'

describe Bitex::Resources::Deposits::CashDeposit do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'cash_deposits/all/without_filters' } do
      subject(:deposits) { client.cash_deposits.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject(:sample) { deposits.sample }

        it { is_expected.to be_a(Bitex::Resources::Deposits::CashDeposit) }

        its(:'attributes.keys') do
          is_expected.to contain_exactly(
            *%w[type id status requested_amount requested_currency deposit_method country clearing_data amount fiat_code gross_amount
        cost fee net_amount created_at]
          )
        end
        its(:type) { is_expected.to eq('cash_deposits') }
        its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[funding_receipt]) }
      end
    end

    context 'with filters', vcr: { cassette_name: 'cash_deposits/all/with_filters' } do
      subject(:deposits) { client.cash_deposits.all(from: str_date) }

      let(:str_date) { '2019-01-01' }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specified date' do
        expect(deposits.all? { |deposit| Date.strptime(deposit.created_at, '%FT') >= str_date.to_date }).to be_truthy
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'cash_deposits/find' } do
    subject { client.cash_deposits.find('24177') }

    it { is_expected.to be_a(Bitex::Resources::Deposits::CashDeposit) }

    its(:id) { is_expected.to eq('24177') }
  end
end
