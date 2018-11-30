require 'spec_helper'

describe Bitex::Resources::Transaction do
  describe '.all' do
    shared_examples_for 'Transaction' do
      it { is_expected.to be_a(described_class) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id timestamp price amount]) }
      its(:type) { is_expected.to eq(resource_name) }
      its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[orderbook]) }
    end

    context 'without parameters', vcr: { cassette_name: 'transactions/all/without_params' } do
      subject { client.transactions.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Transaction'

        context 'about included resources' do
          subject { super().orderbook }

          it { is_expected.to be_a(Bitex::Resources::Orderbook) }
        end
      end
    end

    context 'with params' do
      let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }

      context 'with specific from days', vcr: { cassette_name: 'transactions/all/with_from' } do
        let(:from) { 10 }

        subject { client.transactions.all(from: from) }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'about sample' do
          subject { super().sample }

          it_behaves_like 'Transaction'

          context 'about includes resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }
          end
        end
      end

      context 'with specific orderbok', vcr: { cassette_name: 'transactions/all/with_orderbook' } do

        subject { client.transactions.all(orderbook: orderbook) }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'about sample' do
          subject { super().sample }

          it_behaves_like 'Transaction'

          context 'about includes resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }

            its(:code) { is_expected.to eq(orderbook.code) }
          end
        end
      end

      context 'with specific orderbok and from days', vcr: { cassette_name: 'transactions/all/with_orderbook_and_from' } do
        let(:orderbook) { Bitex::Resources::Orderbook.new(id: 1, code: 'btc_usd') }
        let(:from) { 2 }

        subject { client.transactions.all(orderbook: orderbook, from: from) }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'about sample' do
          subject { super().sample }

          it_behaves_like 'Transaction'

          context 'about includes resources' do
            subject { super().orderbook }

            it { is_expected.to be_a(Bitex::Resources::Orderbook) }

            its(:code) { is_expected.to eq(orderbook.code.to_s) }
          end
        end
      end
    end
  end
end
