require 'spec_helper'

describe Bitex::Resources::Withdrawals::CoinWithdrawal do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'coin_withdrawals/all/without_filters' } do
      subject(:withdrawals) { client.coin_withdrawals.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject(:sample) { withdrawals.sample }

        it { is_expected.to be_a(Bitex::Resources::Withdrawals::CoinWithdrawal) }

        its(:type) { is_expected.to eq('coin_withdrawals') }
        its(:'relationships.attributes.keys') { is_expected.to contain_exactly('user') }

        its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type coin_code id to_addresses label amount status]) }
      end
    end

    context 'with filters', vcr: { cassette_name: 'coin_withdrawals/all/with_filters' } do
      subject(:withdrawals) { client.coin_withdrawals.all(from: str_date) }

      let(:str_date) { '2019-01-01' }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specified date' do
        expect(withdrawals.all? { |withdrawal| Date.strptime(withdrawal.created_at, '%FT') >= str_date.to_date }).to be_truthy
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'coin_withdrawals/find' } do
    subject { client.coin_withdrawals.find('68743') }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CoinWithdrawal) }

    its(:id) { is_expected.to eq('68743') }
  end

  describe '.create', vcr: { cassette_name: 'coin_withdrawals/create' } do
    subject { client.coin_withdrawals.create(to_addresses: to_addresses, label: label, amount: amount, coin_code: coin_code, otp: otp) }

    let(:amount) { 0.001 }
    let(:label) { 'api-test' }
    let(:to_addresses) { 'mk2jCye9XhXxVwfp9FyVMRwYDzQxscB5ev' }
    let(:coin_code) { 'btc' }
    let(:otp) { '614686' }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CoinWithdrawal) }

    its(:amount) { is_expected.to eq(amount) }
    its(:coin_code) { is_expected.to eq(coin_code) }
    its(:status) { is_expected.to eq('received') }
    its(:label) { is_expected.to eq(label) }
    its(:to_addresses) { is_expected.to eq(to_addresses) }
  end
end
