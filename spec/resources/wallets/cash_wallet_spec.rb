require 'spec_helper'

describe Bitex::Resources::Wallets::CashWallet do
  shared_examples_for 'Cash Wallet' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[id type balance available currency]) }
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.all' do
    subject { client.cash_wallets.all }

    context 'with any level key', vcr: { cassette_name: 'cash_wallet/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Cash Wallet'
      end
    end
  end

  describe '.find' do
    subject { client.cash_wallets.find(currency_code: currency_code)}

    context 'with any level key', vcr: { cassette_name: 'cash_wallet/find' } do
      let(:key) { read_level_key }

      let(:currency_code) { 'usd' }

      it_behaves_like 'Cash Wallet'
    end
  end
end
