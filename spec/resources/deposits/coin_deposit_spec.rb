require 'spec_helper'

describe Bitex::Resources::Deposits::CoinDeposit do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'coin_deposits/all/without_filters' } do
      subject(:deposits) { client.coin_deposits.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject(:sample) { deposits.sample }

        it { is_expected.to be_a(Bitex::Resources::Deposits::CoinDeposit) }

        its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id coin amount created_at]) }
        its(:type) { is_expected.to eq('coin_deposits') }

        its(:id) { is_expected.to be_a(String) }
        its(:coin) { is_expected.to be_a(Symbol) }
        its(:amount) { is_expected.to be_a(BigDecimal) }
        its(:created_at) { is_expected.to be_a(Time) }

        its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[address]) }
      end
    end

    context 'with filters', vcr: { cassette_name: 'coin_deposits/all/with_filters' } do
      subject(:deposits) { client.coin_deposits.all(from: str_date) }

      let(:str_date) { '2019-01-01' }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specified date' do
        expect(deposits.all? { |deposit| deposit.created_at >= str_date.to_time }).to be_truthy
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'coin_deposits/find' } do
    subject { client.coin_deposits.find('2920') }

    it { is_expected.to be_a(Bitex::Resources::Deposits::CoinDeposit) }

    its(:id) { is_expected.to eq('2920') }
  end
end
