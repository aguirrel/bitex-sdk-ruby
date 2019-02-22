require 'spec_helper'

describe Bitex::Resources::Orders::Bid do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'bids/all/without_filters' } do
      subject(:bids) { client.bids.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves executing bids' do
        expect(subject.map(&:status).uniq).to eq([:executing])
      end

      context 'taking a sample' do
        subject(:sample) { bids.sample }

        it_behaves_like 'Orders'

        its(:type) { is_expected.to eq('bids') }
      end
    end

    context 'with filters', vcr: { cassette_name: 'bids/all/with_filters' } do
      subject(:bids) { client.bids.all(orderbook: orderbook) }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:btc_usd) }

      it 'retrieves from specific orderbooks' do
        expect(bids.map(&:orderbook_code).uniq).to eq([:btc_usd])
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'bids/find' } do
    subject { client.bids.find('36291147') }

    it { is_expected.to be_a(Bitex::Resources::Orders::Bid) }

    its(:id) { is_expected.to eq('36291147') }
  end

  describe '.cancel', vcr: { cassette_name: 'bids/cancel' } do
    subject { client.bids.cancel(id: '36291147') }

    it { is_expected.to be_an(Array) }
    it { is_expected.to be_empty }
  end

  describe '.create', vcr: { cassette_name: 'bids/create' } do
    subject { client.bids.create(orderbook: orderbook, amount: 3, price: 150) }

    let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:bch_usd) }

    it { is_expected.to be_a(Bitex::Resources::Orders::Bid) }

    its(:orderbook_code) { is_expected.to eq(:bch_usd) }
    its(:amount) { is_expected.to eq(3) }
    its(:price) { is_expected.to eq(150) }
  end
end
