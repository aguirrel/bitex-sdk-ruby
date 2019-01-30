require 'spec_helper'

describe Bitex::Resources::Trades::Sell do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'sells/all/without_filters' } do
      subject(:sells) { client.sells.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from all orderbooks' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(*%w[bch_usd btc_ars btc_pyg btc_usd])
      end

      context 'taking a sample' do
        subject(:sample) { sells.sample }

        it_behaves_like 'Trades'

        its(:type) { is_expected.to eq('sells') }
      end
    end

    context 'with filters', vcr: { cassette_name: 'sells/all/with_filters' } do
      before(:each) { Timecop.freeze('2019-01-16') }

      subject(:sells) { client.sells.all(orderbook: orderbook, days: 15, limit: 50) }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code('btc_usd') }

      it 'retrieves from specific traded orderbooks' do
        expect(sells.map(&:orderbook_code).uniq).to eq(['btc_usd'])
      end

      it { expect(sells.all? { |sell| sell.created_at.to_time >= 15.days.ago }).to be_truthy }

      its(:count) { is_expected.to be <= 50 }
    end
  end

  describe '.find', vcr: { cassette_name: 'sells/find' } do
    subject { client.sells.find('159865') }

    it { is_expected.to be_a(Bitex::Resources::Trades::Sell) }

    its(:id) { is_expected.to eq('159865') }
  end
end
