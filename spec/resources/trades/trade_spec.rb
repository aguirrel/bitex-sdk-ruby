require 'spec_helper'

describe Bitex::Resources::Trades::Trade do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'trades/all/without_filters' } do
      subject(:trades) { client.trades.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from all orderbooks' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(*%i[bch_usd btc_ars btc_pyg btc_usd])
      end

      context 'taking buy trade type' do
        subject(:buy) { trades.find { |trade| trade.type == 'buys' } }

        it_behaves_like 'Trades'

        its(:type) { is_expected.to eq('buys') }
      end

      context 'taking sell trade type' do
        subject(:sell) { trades.find { |trade| trade.type == 'sells' } }

        it_behaves_like 'Trades'

        its(:type) { is_expected.to eq('sells') }
      end
    end

    context 'with filters', vcr: { cassette_name: 'trades/all/with_filters' } do
      before(:each) { Timecop.freeze('2019-01-16') }

      subject(:trades) { client.trades.all(orderbook: orderbook, days: 50, limit: 100) }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:btc_usd) }

      it 'retrieves from specific traded orderbooks' do
        expect(trades.map(&:orderbook_code).uniq).to eq([:btc_usd])
      end

      it { expect(trades.all? { |trade| trade.created_at.to_time >= 50.days.ago }).to be_truthy }

      its(:count) { is_expected.to be <= 100 }
    end
  end
end
