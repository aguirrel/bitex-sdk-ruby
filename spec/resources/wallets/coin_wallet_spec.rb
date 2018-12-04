require 'spec_helper'

describe Bitex::Resources::Wallets::CoinWallet do
  shared_examples_for 'Coin Wallet' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id balance available currency address auto_sell_address]) }
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.all' do
    subject { client.coin_wallets.all }

    context 'with any level key', vcr: { cassette_name: 'coin_wallet/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Coin Wallet'
      end
    end
  end

  describe '.find' do
    subject { client.coin_wallets.find(currency_code: currency_code)}

    context 'with any level key', vcr: { cassette_name: 'coin_wallet/find' } do
      let(:key) { read_level_key }

      let(:currency_code) { 'usd' }

      it_behaves_like 'Coin Wallet'
    end
  end
end
