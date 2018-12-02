require 'spec_helper'

describe Bitex::Resources::Trade do
  let(:key) { :read_level_key }

  shared_examples_for 'Trade' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id created_at coin_amount cash_amount fee price fee_currency fee_decimals])
    end
    its(:type) { is_expected.to eq('buys').or eq('sells') }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[orderbook order]) }
  end

  describe '.all' do
    subject { client.trades.all(orderbook: orderbook, days: days, limit: limit) }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'without filters', vcr: { cassette_name: 'trades/all/without_filters' } do
        let(:orderbook) { nil }
        let(:days) { nil }
        let(:limit) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Trade'

          context 'about included resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }
          end
        end
      end

      context 'with filters', vcr: { cassette_name: 'trades/all/with_filters' } do
        let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
        let(:days) { 10 }
        let(:limit) { 5 }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }
        its(:count) { is_expected.to eq(limit) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Trade'

          context 'about included resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }
          end
        end
      end
    end
  end
end
