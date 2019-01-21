require 'spec_helper'

describe Bitex::Resources::Market do
  describe '.find' do
    context 'without resources parameters', vcr: { cassette_name: 'markets/find' } do
      subject(:market) { client.markets.find('btc_usd') }

      it { is_expected.to be_a(Bitex::Resources::Market) }

      its(:id) { is_expected.to eq('btc_usd') }
      its(:type) { is_expected.to eq('markets') }

      context 'included data by default' do
        its(:'asks.sample') { is_expected.to be_a(Bitex::Resources::OrderGroup) }
        its(:'bids.sample') { is_expected.to be_a(Bitex::Resources::OrderGroup) }
        its(:'candles.sample') { is_expected.to be_a(Bitex::Resources::Candle) }
        its(:'transactions.sample') { is_expected.to be_a(Bitex::Resources::Transaction) }
      end
    end

    context 'about included resources' do
      subject { client.markets.find('btc_usd', includes: resource) }

      context 'asks', vcr: { cassette_name: 'markets/with_resources/asks' } do
        let(:resource) { :asks }

        it { is_expected.to be_a(Bitex::Resources::Market) }

        its(:asks) { is_expected.to be_any }
        its(:bids) { is_expected.to be_empty }
        its(:candles) { is_expected.to be_empty }
        its(:transactions) { is_expected.to be_empty }
      end

      context 'bids', vcr: { cassette_name: 'markets/with_resources/bids' } do
        let(:resource) { :bids }

        it { is_expected.to be_a(Bitex::Resources::Market) }

        its(:asks) { is_expected.to be_empty}
        its(:bids) { is_expected.to be_any }
        its(:candles) { is_expected.to be_empty }
        its(:transactions) { is_expected.to be_empty }
      end

      context 'candles', vcr: { cassette_name: 'markets/with_resources/candles' } do
        let(:resource) { :candles }

        it { is_expected.to be_a(Bitex::Resources::Market) }

        its(:asks) { is_expected.to be_empty}
        its(:bids) { is_expected.to be_empty }
        its(:candles) { is_expected.to be_any }
        its(:transactions) { is_expected.to be_empty }
      end

      context 'transactions', vcr: { cassette_name: 'markets/with_resources/transactions' } do
        let(:resource) { :transactions }

        it { is_expected.to be_a(Bitex::Resources::Market) }

        its(:asks) { is_expected.to be_empty}
        its(:bids) { is_expected.to be_empty }
        its(:candles) { is_expected.to be_empty }
        its(:transactions) { is_expected.to be_any }
      end

      context 'multiple resources', vcr: { cassette_name: 'markets/with_resources/multiple' } do
        let(:resource) { [:asks, :bids] }

        it { is_expected.to be_a(Bitex::Resources::Market) }

        its(:asks) { is_expected.to be_any }
        its(:bids) { is_expected.to be_any }
        its(:candles) { is_expected.to be_empty }
        its(:transactions) { is_expected.to be_empty }
      end
    end
  end
end
