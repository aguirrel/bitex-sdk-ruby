require 'spec_helper'

describe Bitex::Resources::Orders::Order do
  describe '.all', vcr: { cassette_name: 'orders/all' } do
    subject(:orders) { client.orders.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    it 'retrieves executing orders' do
      expect(subject.map(&:status).uniq).to eq(['executing'])
    end

    context 'taking bid order type' do
      subject(:bid) { orders.find { |order| order.type == 'bids' } }

      it_behaves_like 'Orders'

      its(:type) { is_expected.to eq('bids') }
    end

    context 'taking ask order type' do
      subject(:ask) { orders.find { |order| order.type == 'asks' } }

      it_behaves_like 'Orders'

      its(:type) { is_expected.to eq('asks') }
    end
  end

=begin
  describe '.cancel' do
    context 'with authorized level key' do
      subject { write_level_client.orders.cancel(filter) }

      context 'with filter cancel specific market', vcr: { cassette_name: 'orders/cancel/with_filter' } do
        let(:filter) { { filter: { orderbook_code: 'btc_usd' } } }

        it { is_expected.to be_an(Array) }
        it { is_expected.to be_empty }
      end

      context 'without filter all markets', vcr: { cassette_name: 'orders/cancel/without_filter' } do
        let(:filter) { { } }

        it { is_expected.to be_an(Array) }
        it { is_expected.to be_empty }
      end
    end
  end
=end
end
