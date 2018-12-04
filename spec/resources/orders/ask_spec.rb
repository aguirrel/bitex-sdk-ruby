require 'spec_helper'

describe Bitex::Resources::Orders::Ask do
  let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
  let(:valid_orderbook_code) { orderbook.code }
  let(:invalid_orderbook_code) { :invalid_orderbook_code }

  shared_examples_for 'Ask' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount price status]) }
    its(:type) { is_expected.to eq('asks') }
    its(:'relationships.attributes.keys') { is_expected.to include(*%w[user orderbook]) }
  end

  describe '.all' do
    subject { client.asks.all }

    context 'with any level key', vcr: { cassette_name: 'asks/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Ask'

        its(:status) { is_expected.to eq('executing') }
      end
    end
  end

  describe '.find' do
    subject { client.asks.find(id) }

    context 'with any level key', vcr: { cassette_name: 'asks/find' } do
      let(:key) { read_level_key }
      let(:id) { '36' }

      it_behaves_like 'Ask'

      its(:status) { is_expected.to eq('executing') }
      its(:id) { is_expected.to eq(id) }
    end
  end

  describe '.cancel' do
    subject { client.asks.cancel(id: id) }

    context 'with authorized level key', vcr: { cassette_name: 'asks/cancel' } do
      let(:key) { write_level_key }
      let(:id) { '36' }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end

  describe '.create' do
    subject { client.asks.create(orderbook: orderbook, amount: amount, price: price) }

    let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
    let(:amount) { 2_000 }
    let(:price) { 100 }

    context 'with authorized level key', vcr: { cassette_name: 'asks/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Ask'
    end
  end
end
