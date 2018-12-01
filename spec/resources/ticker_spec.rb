require 'spec_helper'

describe Bitex::Resources::Ticker do
  describe '.all', vcr: { cassette_name: 'tickers/all' } do
    subject { client.tickers.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'tanking a sample' do
      subject { super().sample }

      it { is_expected.to be_a(described_class) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id price]) }
      its(:type) { is_expected.to eq(resource_name.singularize) }
    end
  end

  describe '.find' do
    let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
    context 'with orderbook code as id', vcr: { cassette_name: 'tickers/find' } do
      subject { client.tickers.find(orderbook.code) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id last open high low vwap volume bid ask price_before_last]) }
      its(:type) { is_expected.to eq(resource_name) }
    end
  end
end
