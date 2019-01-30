require 'spec_helper'

describe Bitex::Resources::Trades::Buy do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'buys/all/without_filters' } do
      subject(:buys) { client.buys.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from all traded orderbooks' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(*%w[bch_usd btc_ars btc_pyg btc_usd])
      end

      context 'taking a sample' do
        subject(:sample) { buys.sample }

        it_behaves_like 'Trades'

        its(:type) { is_expected.to eq('buys') }
      end
    end

    context 'with filters', vcr: { cassette_name: 'buys/all/with_filters' } do
      before(:each) { Timecop.freeze('2019-01-16') }

      subject(:buys) { client.buys.all(orderbook: orderbook, days: 15, limit: 50) }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code('btc_usd') }

      it 'retrieves from specific orderbooks' do
        expect(buys.map(&:orderbook_code).uniq).to eq(['btc_usd'])
      end

      it { expect(buys.all? { |buy| buy.created_at.to_time >= 15.days.ago }).to be_truthy }

      its(:count) { is_expected.to be <= 50 }
    end
  end

  describe '.find', vcr: { cassette_name: 'buys/find' } do
    subject { client.buys.find('162689') }

    it { is_expected.to be_a(Bitex::Resources::Trades::Buy) }

    its(:id) { is_expected.to eq('162689') }
  end
end
