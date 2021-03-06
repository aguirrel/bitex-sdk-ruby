require 'spec_helper'

describe Bitex::Resources::Orders::Ask do
  context 'without filters', vcr: { cassette_name: 'asks/all/without_filters' } do
    subject(:asks) { client.asks.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    it 'retrieves executing asks' do
      expect(subject.map(&:status).uniq).to eq([:executing])
    end

    context 'taking a sample' do
      subject(:sample) { asks.sample }

      it_behaves_like 'Orders'

      its(:type) { is_expected.to eq('asks') }
    end
  end

  context 'with filters', vcr: { cassette_name: 'asks/all/with_filters' } do
    subject(:asks) { client.asks.all(orderbook: orderbook) }

    let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:btc_usd) }

    it 'retrieves from specific orderbooks' do
      expect(asks.map(&:orderbook_code).uniq).to eq([:btc_usd])
    end
  end

  describe '.find', vcr: { cassette_name: 'asks/find' } do
    subject { client.asks.find('36270309') }

    it { is_expected.to be_a(Bitex::Resources::Orders::Ask) }

    its(:id) { is_expected.to eq('36270309') }
  end

  describe '.cancel', vcr: { cassette_name: 'asks/cancel' } do
    subject { client.asks.cancel(id: '36270309') }

    it { is_expected.to be_an(Array) }
    it { is_expected.to be_empty }
  end

  describe '.create', vcr: { cassette_name: 'asks/create' } do
    subject { client.asks.create(orderbook: orderbook, amount: 3, price: 150) }

    let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:bch_usd) }

    it { is_expected.to be_a(Bitex::Resources::Orders::Ask) }

    its(:orderbook_code) { is_expected.to eq(:bch_usd) }
    its(:amount) { is_expected.to eq(3) }
    its(:price) { is_expected.to eq(150) }
  end
end
