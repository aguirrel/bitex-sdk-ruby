require 'spec_helper'

describe Bitex::Order do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:valid_orderbook_code) { :btc_usd }
  let(:invalid_orderbook_code) { :invalid_orderbook_code }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  describe '.all' do
    subject { client.orders.all }

    context 'with unauthorized', vcr: { cassette_name: 'orders/all/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key', vcr: { cassette_name: 'orders/all/authorized' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().find { |order| order.type == resource_name } }

        context 'of bid' do
          let(:resource_name) { 'bids' }

          it_behaves_like 'Order'

          its(:status) { is_expected.to eq('executing') }
        end

        context 'of ask' do
          let(:resource_name) { 'asks' }

          it_behaves_like 'Order'

          its(:status) { is_expected.to eq('executing') }
        end
      end
    end
  end

  describe '.cancel_all!' do
    subject { client.orders.cancel_all! }

    context 'with unauthorized', vcr: { cassette_name: 'orders/cancel_all/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'orders/cancel_all/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key' do
      let(:key) { write_level_key }

      context 'with existent id', vcr: { cassette_name: 'orders/cancel_all/authorized' } do
        it_behaves_like 'Cancelling order'
      end
    end
  end

  describe '.cancel!' do
    subject { client.orders.cancel!(orderbook_code: orderbook_code) }

    it_behaves_like 'Invalid orderbook code'

    context 'with valid orderbook code' do
      let(:orderbook_code) { valid_orderbook_code }

      context 'with unauthorized', vcr: { cassette_name: 'orders/cancel/unauthorized' } do
        it_behaves_like 'Not enough permissions'
      end

      context 'with unauthorized level key', vcr: { cassette_name: 'orders/cancel/unauthorized_key' } do
        it_behaves_like 'Not enough level permissions'
      end

      context 'with authorized level key' do
        let(:key) { write_level_key }

        context 'with existent id', vcr: { cassette_name: 'orders/cancel/authorized' } do
          it_behaves_like 'Cancelling order'
        end
      end
    end
  end
end
