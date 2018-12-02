require 'spec_helper'

describe Bitex::Resources::CoinWithdrawal do
  shared_examples_for 'Coin Withdrawal' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[user coin]) }
  end

  describe '.all' do
    subject { client.coin_withdrawals.all(from: from) }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'without filters', vcr: { cassette_name: 'coin_withdrawals/all/without_filters' } do
        let(:from) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Coin Withdrawal'

          its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type to_addresses label amount id status]) }
        end
      end

      context 'with filters', vcr: { cassette_name: 'coin_withdrawals/all/with_filters' } do
        let(:from) { '2018-01-01' }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Coin Withdrawal'

          its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type to_addresses label amount id status]) }
        end
      end
    end
  end

  describe '.find' do
    subject { client.coin_withdrawals.find(id) }

    context 'with any level key', vcr: { cassette_name: 'coin_withdrawals/find' } do
      let(:key) { write_level_key }

      let(:id) { 4 }

      it_behaves_like 'Coin Withdrawal'

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type to_addresses label amount id status]) }
    end
  end

  describe '.create' do
    subject { client.coin_withdrawals.create(to_addresses: to_addresses, label: label, amount: amount, currency: currency, otp: otp) }

    context 'with authorized level key', vcr: { cassette_name: 'coin_withdrawals/create' } do
      let(:key) { write_level_key }

      let(:to_addresses) { 'mszEUK9E6E7n4SNcrjYH8Fr7ZTGP9n3dRb' }
      let(:label) { 'Trezor' }
      let(:amount) { 1_000 }
      let(:currency) { :btc }
      let(:otp) { '111111' }

      it_behaves_like 'Coin Withdrawal'

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type to_addresses label amount currency id status]) }
    end
  end
end
