require 'spec_helper'

describe Bitex::Resources::Wallets::CoinWallet do
  describe '.all', vcr: { cassette_name: 'coin_wallet/all' } do
    subject(:wallets) { client.coin_wallets.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { wallets.sample }

      it { is_expected.to be_a(Bitex::Resources::Wallets::CoinWallet) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id balance available currency address auto_sell_address]) }
    end
  end

  describe '.find', vcr: { cassette_name: 'coin_wallet/find' } do
    subject { client.coin_wallets.find('3194') }

    it { is_expected.to be_a(Bitex::Resources::Wallets::CoinWallet) }

    its(:id) { is_expected.to eq('3194') }
  end
end
