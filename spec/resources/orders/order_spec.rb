require 'spec_helper'

describe Bitex::Resources::Orders::Order do
  shared_examples_for 'Order' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount price status]) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[user orderbook]) }
  end

  describe '.all' do
    context 'with any level key', vcr: { cassette_name: 'orders/all' } do
      subject { read_level_client.orders.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves executing orders' do
        subject.map(&:status).all? { |status| expect(status).to eq('executing') }
      end

      it 'about resources types' do
        expect(subject.map(&:type))
          .to contain_exactly(*%w[bids bids bids bids asks asks asks asks asks])
      end

      context 'taking a first order' do
        subject { super().first }

        its(:type) { is_expected.to eq('bids') }

        it_behaves_like 'Order'
      end

      context 'taking a fifth order' do
        subject { super().fifth }

        its(:type) { is_expected.to eq('asks') }

        it_behaves_like 'Order'
      end
    end
  end

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
end
