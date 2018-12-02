require 'spec_helper'

describe Bitex::Resources::CoinDeposit do
  shared_examples_for 'Coin Deposit' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address coin amount created_at]) }
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.all' do
    subject { client.coin_deposits.all(from: from) }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'without filters', vcr: { cassette_name: 'coin_deposits/all/without_filters' } do
        let(:from) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Coin Deposit'
        end
      end

      context 'with filters', vcr: { cassette_name: 'coin_deposits/all/with_filters' } do
        let(:from) { '2018-01-01' }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Coin Deposit'
        end
      end
    end
  end

  describe '.find' do
    subject { client.coin_deposits.find(id) }

    context 'with any level key', vcr: { cassette_name: 'coin_deposits/find' } do
      let(:key) { read_level_key }
      let(:id) { '7' }

      it_behaves_like 'Coin Deposit'

      its(:id) { is_expected.to eq(id) }
    end
  end
end
