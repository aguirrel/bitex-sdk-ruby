require 'spec_helper'

describe Bitex::Resources::Candle do
  shared_examples_for 'Candle' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id timestamp low open close high volume price_before_last vwap]) }
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[orderbook]) }
  end

  describe '.find' do
    subject { client.candles.find(days: days, orderbook: orderbook, span: span)  }

    context 'without parameters', vcr: { cassette_name: 'candles/find/without_params' } do
      let(:orderbook) { nil }
      let(:days) { nil }
      let(:span) { nil }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Candle'

        context 'about included resources' do
          subject { super().orderbook }

          it { is_expected.to be_a(Bitex::Resources::Orderbook) }
        end
      end
    end

    context 'with orderbook' do
      let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }

      context 'without span and days', vcr: { cassette_name: 'candles/find/with_orderbook' } do
        let(:days) { nil }
        let(:span) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Candle'

          context 'about included resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }
            its(:code) { is_expected.to eq(orderbook.code) }
          end
        end
      end

      context 'with span and days', vcr: { cassette_name: 'candles/find/with_span_and_days' } do
        let(:days) { 10 }
        let(:span) { 3 }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Candle'

          context 'about included resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }
            its(:code) { is_expected.to eq(orderbook.code) }
          end
        end
      end
    end
  end
end
