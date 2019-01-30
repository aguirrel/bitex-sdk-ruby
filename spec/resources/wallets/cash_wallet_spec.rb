require 'spec_helper'

describe Bitex::Resources::Wallets::CashWallet do
  describe '.all', vcr: { cassette_name: 'cash_wallet/all' } do
    subject(:wallets) { client.cash_wallets.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { wallets.sample }

      it { is_expected.to be_a(Bitex::Resources::Wallets::CashWallet) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[id type balance available currency]) }
      its(:type) { is_expected.to eq('cash_wallets') }
    end
  end

  describe '.find', vcr: { cassette_name: 'cash_wallet/find' } do
    subject { client.cash_wallets.find('usd') }

    it { is_expected.to be_a(Bitex::Resources::Wallets::CashWallet) }

    its(:id) { is_expected.to eq('usd') }
  end
end
