require 'spec_helper'

describe Bitex::Resources::TradingBots::SellingBot do
  shared_examples_for 'Selling Bot' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount chunk_size eta executing to_cancel]) }
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to include(*%w[orderbook user]) }
  end

  describe '.all' do
    context 'with any level key', vcr: { cassette_name: 'selling_bots/all' } do
      subject { read_level_client.selling_bots.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Selling Bot'
      end
    end
  end

  describe '.find' do
    context 'with any level key', vcr: { cassette_name: 'selling_bots/find' } do
      subject { read_level_client.selling_bots.find(id) }

      let(:id) { '5' }

      it_behaves_like 'Selling Bot'

      its(:id) { is_expected.to eq(id) }
    end
  end

  describe '.create' do
    context 'with authorized level key', vcr: { cassette_name: 'selling_bots/create' } do
      subject { write_level_client.selling_bots.create(amount: amount, orderbook: orderbook) }

      let(:amount) { 100_000 }
      let(:orderbook) { Bitex::Resources::Orderbook.new(id: '1', code: 'btc_usd') }

      it_behaves_like 'Selling Bot'

      its(:amount) { is_expected.to eq(amount) }

      it 'your relationships with your orderbook' do
        expect(subject.relationships.orderbook[:data][:id]).to eq(orderbook.id)
      end
    end
  end

  describe '.cancel' do
    context 'with authorized level key', vcr: { cassette_name: 'selling_bots/cancel' } do
      subject { write_level_client.selling_bots.cancel(id: id) }

      let(:id) { '6' }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end
end
