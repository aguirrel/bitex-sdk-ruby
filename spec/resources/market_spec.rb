require 'spec_helper'

describe Bitex::Resources::Market do
  let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }

  shared_examples_for 'Market' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id]) }
    its(:id) { is_expected.to eq(orderbook.code.to_s) }
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[candles transactions bids asks]) }
  end

  describe '.find' do
    context 'without resources parameters', vcr: { cassette_name: 'markets/find' } do
      subject { client.markets.find(orderbook) }

      it_behaves_like 'Market'

      context 'included data by default' do
        it { expect(subject.bids.sample).to be_a(Bitex::Resources::OrderGroup) }
        it { expect(subject.asks.sample).to be_a(Bitex::Resources::OrderGroup) }
        it { expect(subject.candles.sample).to be_a(Bitex::Resources::Candle) }
        it { expect(subject.transactions.sample).to be_a(Bitex::Resources::Transaction) }
      end
    end

    context 'with valid resources' do
      context 'about included resources' do
        subject { client.markets.find(orderbook, resource) }

        context 'asks', vcr: { cassette_name: 'markets/with_resources/asks' } do
          let(:resource) { :asks }

          it_behaves_like 'Market'

          it { expect(subject.asks).to be_any }
          it { expect(subject.bids).to be_empty }
          it { expect(subject.candles).to be_empty }
          it { expect(subject.transactions).to be_empty }
        end

        context 'bids', vcr: { cassette_name: 'markets/with_resources/bids' } do
          let(:resource) { :bids }

          it_behaves_like 'Market'

          it { expect(subject.asks).to be_empty }
          it { expect(subject.bids).to be_any }
          it { expect(subject.candles).to be_empty }
          it { expect(subject.transactions).to be_empty }
        end

        context 'candles', vcr: { cassette_name: 'markets/with_resources/candles' } do
          let(:resource) { :candles }

          it_behaves_like 'Market'

          it { expect(subject.asks).to be_empty }
          it { expect(subject.bids).to be_empty }
          it { expect(subject.candles).to be_any }
          it { expect(subject.transactions).to be_empty }
        end

        context 'transactions', vcr: { cassette_name: 'markets/with_resources/transactions' } do
          let(:resource) { :transactions }

          it_behaves_like 'Market'

          it { expect(subject.asks).to be_empty }
          it { expect(subject.bids).to be_empty }
          it { expect(subject.candles).to be_empty }
          it { expect(subject.transactions).to be_any }
        end
      end
    end
  end
end
