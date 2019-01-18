require 'spec_helper'

describe Bitex::Resources::Ticker do
  describe '.all', vcr: { cassette_name: 'tickers/all' } do
    subject(:tickers) { client.tickers.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { tickers.sample }

      it { is_expected.to be_a(Bitex::Resources::Ticker) }

      its(:'attributes.keys') do
        is_expected.to contain_exactly(*%w[type id last open high low vwap volume bid ask price_before_last])
      end

      its(:type) { is_expected.to eq('tickers') }
    end
  end

  describe '.find', vcr: { cassette_name: 'tickers/find' } do
    subject { client.tickers.find('btc_usd') }

    it { is_expected.to be_a(Bitex::Resources::Ticker) }

    its(:id) { is_expected.to eq('btc_usd') }
  end
end
