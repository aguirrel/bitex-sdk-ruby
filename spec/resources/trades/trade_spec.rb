require 'spec_helper'

describe Bitex::Resources::Trades::Trade do
  shared_examples_for 'Trade' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id created_at coin_amount cash_amount fee price fee_currency fee_decimals])
    end

    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[orderbook order]) }

    context 'about included resources' do
      its(:orderbook) { is_expected.to be_a(Bitex::Resources::Orderbook) }
    end
  end

  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'trades/all/without_filters' } do
      subject { read_level_client.trades.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'about records types' do
        expect(subject.map(&:type))
          .to contain_exactly(*%w[buys sells buys sells buys sells buys sells buys sells buys sells buys buys sells buys])
      end

      context 'taking first trade' do
        subject { super().first }

        its(:type) { is_expected.to eq('buys') }

        it_behaves_like 'Trade'
      end

      context 'taking second trade' do
        subject { super().second }

        its(:type) { is_expected.to eq('sells') }

        it_behaves_like 'Trade'
      end
    end

    context 'with filters', vcr: { cassette_name: 'trades/all/with_filters' } do
      subject { read_level_client.trades.all(orderbook: orderbook, days: days, limit: limit) }

      let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
      let(:days) { 10 }
      let(:limit) { 5 }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'sends required filters' do
        expect(URI.decode(subject.uri.query))
          .to eq("filter[days]=#{days}&filter[orderbook_code]=#{orderbook.code}&limit=#{limit}")
      end
    end
  end
end
