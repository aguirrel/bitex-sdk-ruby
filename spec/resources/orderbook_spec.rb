require 'spec_helper'

describe Bitex::Resources::Orderbook do
  describe '.all', vcr: { cassette_name: 'orderbooks/all' } do
    subject { client.orderbooks.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject { super().sample }

      shared_examples_for 'Pairs' do |pair|
        subject { super().send(pair).keys }

        it { is_expected.to contain_exactly(*%w[code decimals]) }
      end

      it { is_expected.to be_a(described_class) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id code base quote]) }
      its(:type) { is_expected.to eq(resource_name) }

      it_behaves_like 'Pairs', :base
      it_behaves_like 'Pairs', :quote
    end
  end
end
