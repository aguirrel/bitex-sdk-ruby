require 'spec_helper'

describe Bitex::Resources::Transaction do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'transactions/all/without_filters' } do
      subject(:transactions) { client.transactions.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from all transacted orderbooks' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(*%i[bch_usd btc_clp btc_ars btc_pyg btc_usd])
      end

      context 'taking a sample' do
        subject(:transaction) { transactions.sample }

        it { is_expected.to be_a(Bitex::Resources::Transaction) }

        its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id orderbook_code timestamp price amount]) }
        its(:type) { is_expected.to eq('transactions') }
      end
    end

    context 'with filters' do
      context 'with specific from hours', vcr: { cassette_name: 'transactions/all/with_from' } do
        subject(:transactions) { client.transactions.all(from: hours) }

        before(:each) { Timecop.freeze(date) }

        let(:date) { '2019-01-21 14:00'.to_time }
        let(:hours) { 10 }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        it 'retrieves transactions from specified hours' do
          transactions.all? { |transaction| transaction.timestamp >= (date - hours).to_i }
        end
      end

      context 'with specific orderbok', vcr: { cassette_name: 'transactions/all/with_orderbook' } do
        subject(:transactions) { client.transactions.all(orderbook: orderbook) }

        let(:orderbook) { Bitex::Resources::Orderbook.find_by_code('btc_usd') }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        it 'retrieves from specific orderbooks' do
          expect(transactions.map(&:orderbook_code).uniq).to eq([:btc_usd])
        end
      end

      context 'with specific orderbok and from hours', vcr: { cassette_name: 'transactions/all/with_orderbook_and_from' } do
        subject(:transactions) { client.transactions.all(orderbook: orderbook, from: hours) }

        before(:each) { Timecop.freeze(date) }

        let(:orderbook) { Bitex::Resources::Orderbook.find_by_code('bch_usd') }
        let(:date) { '2019-01-21 14:00'.to_time }
        let(:hours) { 10 }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        it 'retrieves from specific orderbooks' do
          expect(transactions.map(&:orderbook_code).uniq).to eq([:bch_usd])
        end

        it 'retrieves transactions from specified hours' do
          transactions.all? { |transaction| transaction.timestamp >= (date - hours).to_i }
        end
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'transactions/find' } do
    subject(:transaction) { client.transactions.find('163393') }

    it { is_expected.to be_a(Bitex::Resources::Transaction) }

    its(:id) { is_expected.to eq('163393') }
  end
end
