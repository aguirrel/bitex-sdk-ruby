require 'spec_helper'

describe Bitex::Resources::Orders::Bid do
  shared_examples_for 'Bid' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq('bids') }
    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount price status]) }
    its(:'relationships.attributes.keys') { is_expected.to include(*%w[user orderbook]) }
  end

  describe '.all' do
    context 'with any level key', vcr: { cassette_name: 'bids/all' } do
      subject { read_level_client.bids.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves executing bids' do
        subject.map(&:status).all? { |status| expect(status).to eq('executing') }
      end

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Bid'
      end
    end
  end

  describe '.find' do
    context 'with any level key', vcr: { cassette_name: 'bids/find' } do
      subject { read_level_client.bids.find(id) }

      let(:id) { '38' }

      it_behaves_like 'Bid'

      its(:status) { is_expected.to eq('executing') }
      its(:id) { is_expected.to eq(id) }
    end
  end

  describe '.cancel' do
    context 'with authorized level key', vcr: { cassette_name: 'bids/cancel' } do
      subject { read_level_client.bids.cancel(id: id) }

      let(:id) { '38' }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end

  describe '.create' do
    context 'with authorized level key', vcr: { cassette_name: 'bids/create' } do
      subject { read_level_client.bids.create(orderbook: orderbook, amount: amount, price: price) }

      let(:orderbook) { Bitex::Resources::Orderbook.new(id: '1', code: 'btc_usd') }
      let(:amount) { 2_000 }
      let(:price) { 100 }

      it_behaves_like 'Bid'

      its(:amount) { is_expected.to eq(amount) }
      its(:price) { is_expected.to eq(price) }

      it 'Your relationships with your orderbook' do
        expect(subject.relationships.orderbook[:data][:id]).to eq(orderbook.id)
      end
    end
  end
end
