require 'spec_helper'

describe Bitex::Resources::Orders::Ask do
  shared_examples_for 'Ask' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq('asks') }
    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount price status]) }
    its(:'relationships.attributes.keys') { is_expected.to include(*%w[user orderbook]) }
  end

  describe '.all' do
    context 'with any level key', vcr: { cassette_name: 'asks/all' } do
      subject { read_level_client.asks.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves executing asks' do
        subject.map(&:status).all? { |status| expect(status).to eq('executing') }
      end

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Ask'
      end
    end
  end

  describe '.find' do
    context 'with any level key', vcr: { cassette_name: 'asks/find' } do
      subject { read_level_client.asks.find(id) }

      let(:id) { '36' }

      it_behaves_like 'Ask'

      its(:status) { is_expected.to eq('executing') }
      its(:id) { is_expected.to eq(id) }
    end
  end

  describe '.cancel' do
    context 'with authorized level key', vcr: { cassette_name: 'asks/cancel' } do
      subject { write_level_client.asks.cancel(id: id) }

      let(:id) { '36' }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end

  describe '.create' do
    context 'with authorized level key', vcr: { cassette_name: 'asks/create' } do
      subject { write_level_client.asks.create(orderbook: orderbook, amount: amount, price: price) }

      let(:orderbook) { Bitex::Resources::Orderbook.new(id: '1', code: 'btc_usd') }
      let(:amount) { 2_000 }
      let(:price) { 100 }

      it_behaves_like 'Ask'

      its(:amount) { is_expected.to eq(amount) }
      its(:price) { is_expected.to eq(price) }

      it 'Your relationships with your orderbook' do
        expect(subject.relationships.orderbook[:data][:id]).to eq(orderbook.id)
      end
    end
  end
end
