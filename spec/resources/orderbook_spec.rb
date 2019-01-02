require 'spec_helper'

describe Bitex::Resources::Orderbook do
  describe '.all', vcr: { cassette_name: 'orderbooks/all' } do
    subject { read_level_client.orderbooks.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a btc_usd as sample' do
      subject { super().find { |sample| sample.code == 'btc_usd' } }

      it { is_expected.to be_a(described_class) }

      its(:type) { is_expected.to eq('orderbooks') }
      its(:id) { is_expected.to eq('1') }
      its(:code) { is_expected.to eq('btc_usd') }
      its(:base) { is_expected.to eq({ 'code' => 'btc', 'decimals' => 8 }) }
      its(:quote) { is_expected.to eq({ 'code' => 'usd', 'decimals' => 2 }) }
    end
  end
end
