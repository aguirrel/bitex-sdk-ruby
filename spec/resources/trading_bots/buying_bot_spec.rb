require 'spec_helper'

describe Bitex::Resources::TradingBots::BuyingBot do
  describe '.all', vcr: { cassette_name: 'buying_bots/all' } do
    subject(:buying_bots) { client.buying_bots.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { buying_bots.sample }

      it_behaves_like 'Trading Bots'
    end
  end

  describe '.create', vcr: { cassette_name: 'buying_bots/create' } do
    subject { client.buying_bots.create(orderbook_code: 'btc_usd', amount: 100) }

    it { is_expected.to be_a(Bitex::Resources::TradingBots::BuyingBot) }

    its(:orderbook_code) { is_expected.to eq('btc_usd') }
    its(:amount) { is_expected.to eq(100) }
  end

  describe '.find', vcr: { cassette_name: 'buying_bots/find' } do
    subject { client.buying_bots.find('1432') }

    it { is_expected.to be_a(Bitex::Resources::TradingBots::BuyingBot) }

    its(:id) { is_expected.to eq('1432') }
  end

  describe '.cancel', vcr: { cassette_name: 'buying_bots/cancel' } do
    subject { client.buying_bots.cancel(id: '1432') }

    it { is_expected.to be_an(Array) }
    it { is_expected.to be_empty }
  end
end
