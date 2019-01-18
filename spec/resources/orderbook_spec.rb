require 'spec_helper'

describe Bitex::Resources::Orderbook do
  describe '.all', vcr: { cassette_name: 'orderbooks/all' } do
    subject(:orderbooks) { client.orderbooks.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { orderbooks.find { |orderbook| orderbook.code == 'btc_usd' } }

      it { is_expected.to be_a(Bitex::Resources::Orderbook) }

      its(:type) { is_expected.to eq('orderbooks') }
      its(:id) { is_expected.to eq('1') }
      its(:code) { is_expected.to eq('btc_usd') }
      its(:base) { is_expected.to eq({ 'code' => 'btc', 'decimals' => 8 }) }
      its(:quote) { is_expected.to eq({ 'code' => 'usd', 'decimals' => 2 }) }
    end
  end
end
