require 'spec_helper'

describe Bitex::Resources::Order do
  let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
  let(:valid_orderbook_code) { orderbook.code }
  let(:invalid_orderbook_code) { :invalid_orderbook_code }

  shared_examples_for 'Order' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount price status]) }
    its(:type) { is_expected.to eq('asks').or eq('bids') }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[user orderbook]) }
  end

  describe '.all' do
    subject { client.orders.all }

    context 'with any level key', vcr: { cassette_name: 'orders/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Order'

        its(:status) { is_expected.to eq('executing') }
      end
    end
  end

  describe '.cancel' do
    subject { client.orders.cancel(filter) }

    let(:key) { write_level_key }

    context 'with filter cancel specific market', vcr: { cassette_name: 'orders/cancel/with_filter' } do
      let(:filter) { { filter: { orderbook_code: 'btc_usd' } } }

      it { is_expected.to be_empty }
    end

    context 'without filter all markets', vcr: { cassette_name: 'orders/cancel/without_filter' } do
      let(:filter) { { } }

      it { is_expected.to be_empty }
    end
  end
end
