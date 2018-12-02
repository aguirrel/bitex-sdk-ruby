require 'spec_helper'

describe Bitex::Resources::BuyingBot do
  shared_examples_for 'Buying Bot' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id amount remaining_amount chunk_size eta executing to_cancel]) }
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[orderbook user]) }
  end

  describe '.all' do
    subject { client.buying_bots.all }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'enough funds', vcr: { cassette_name: 'buying_bots/all' } do
        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Buying Bot'
        end
      end
    end
  end

  describe '.create' do
    subject { client.buying_bots.create(amount: amount, orderbook: orderbook) }

    context 'with authorized level key', vcr: { cassette_name: 'buying_bots/create' } do
      let(:key) { write_level_key }
      let(:amount) { 100_000 }
      let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }

      it_behaves_like 'Buying Bot'

      its(:amount) { is_expected.to eq(amount) }
    end
  end

  describe '.find' do
    subject { client.buying_bots.find(id) }

    context 'with any level key', vcr: { cassette_name: 'buying_bots/find' } do
      let(:key) { read_level_key }
      let(:id) { '5' }

      it_behaves_like 'Buying Bot'

      its(:id) { is_expected.to eq(id) }
    end
  end

  describe '.cancel' do
    subject { client.buying_bots.cancel(id: id) }

    context 'with authorized level key', vcr: { cassette_name: 'buying_bots/cancel' } do
      let(:key) { write_level_key }
      let(:id) { '6' }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end
end
