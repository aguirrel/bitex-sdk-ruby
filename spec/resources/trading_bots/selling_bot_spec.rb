require 'spec_helper'

describe Bitex::Resources::TradingBots::SellingBot do
  describe '.all', vcr: { cassette_name: 'selling_bots/all' } do
    subject(:selling_bots) { client.selling_bots.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { selling_bots.sample }

      it { is_expected.to be_a(Bitex::Resources::TradingBots::SellingBot) }

      it_behaves_like 'TradingBots'

      its(:type) { is_expected.to eq('selling_bots') }
    end
  end

  describe '.create', vcr: { cassette_name: 'selling_bots/create' } do
    subject { client.selling_bots.create(orderbook: orderbook, amount: 0.03) }

    let(:orderbook) { Bitex::Resources::Orderbook.find_by_code('btc_usd') }

    it { is_expected.to be_a(Bitex::Resources::TradingBots::SellingBot) }

    its(:orderbook_code) { is_expected.to eq(:btc_usd) }
    its(:amount) { is_expected.to eq(0.03) }
  end

  describe '.find', vcr: { cassette_name: 'selling_bots/find' } do
    subject { client.selling_bots.find('4301') }

    it { is_expected.to be_a(Bitex::Resources::TradingBots::SellingBot) }

    its(:id) { is_expected.to eq('4301') }
  end

  describe '.cancel', vcr: { cassette_name: 'selling_bots/cancel' } do
    subject { client.selling_bots.cancel(id: '4301') }

    it { is_expected.to be_an(Array) }
    it { is_expected.to be_empty }
  end
end
