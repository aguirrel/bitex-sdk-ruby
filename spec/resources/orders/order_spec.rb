require 'spec_helper'

describe Bitex::Resources::Orders::Order do
  describe '.all', vcr: { cassette_name: 'orders/all' } do
    subject(:orders) { client.orders.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    it 'retrieves executing orders' do
      expect(subject.map(&:status).uniq).to eq([:executing])
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
end
