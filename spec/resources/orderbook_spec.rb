require 'spec_helper'

describe Bitex::Resources::Orderbook do
  describe '.all', vcr: { cassette_name: 'orderbooks/all' } do
    subject(:orderbooks) { client.orderbooks.all }

    it { is_expected.to be_a(Array) }

    context 'taking a sample' do
      subject(:sample) { orderbooks.detect { |orderbook| orderbook.code == :btc_usd } }

      it { is_expected.to be_a(Bitex::Resources::Orderbook) }

      its(:id) { is_expected.to eq(1) }
      its(:code) { is_expected.to eq(:btc_usd) }

      its(:base) { is_expected.to be_a(Bitex::Resources::Currency) }
      its(:'base.code') { is_expected.to eq(:btc) }

      its(:quote) { is_expected.to be_a(Bitex::Resources::Currency) }
      its(:'quote.code') { is_expected.to eq(:usd) }
    end
  end
end
