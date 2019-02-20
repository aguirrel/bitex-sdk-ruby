require 'spec_helper'

describe Bitex::Resources::Candle do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'candles/all/without_filters' } do
      subject(:candles) { client.candles.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from all orderbooks' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(*%i[btc_usd btc_ars btc_clp btc_pyg btc_uyu bch_usd])
      end

      context 'taking a sample' do
        subject(:sample) { candles.sample }

        it { is_expected.to be_a(Bitex::Resources::Candle) }

        its(:'attributes.keys') do
          is_expected.to contain_exactly(*%w[type id timestamp low open orderbook_code close high volume price_before_last vwap])
        end

        its(:type) { is_expected.to eq('candles') }
        its(:low) { is_expected.to be_a(BigDecimal) }
        its(:open) { is_expected.to be_a(BigDecimal) }
        its(:close) { is_expected.to be_a(BigDecimal) }
        its(:high) { is_expected.to be_a(BigDecimal) }
        its(:volume) { is_expected.to be_a(BigDecimal) }
        its(:price_before_last) { is_expected.to be_a(BigDecimal) }
        its(:vwap) { is_expected.to be_a(BigDecimal) }
        its(:orderbook_code) { is_expected.to be_a(Symbol) }
      end
    end

    context 'with orderbook filter', vcr: { cassette_name: 'candles/all/with_orderbook' } do
      subject(:candles) { client.candles.all(orderbook: orderbook) }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:btc_usd) }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specific orderbook' do
        expect(subject.map(&:orderbook_code).uniq).to contain_exactly(:btc_usd)
      end
    end

    context 'with all filters', vcr: { cassette_name: 'candles/all/with_all_filters' } do
      subject(:candles) { client.candles.all(orderbook: orderbook, days: time_ago, span: span) }

      before(:each) { Timecop.freeze('2019-01-21 13:00') }
      let(:span) { 8 }
      let(:time_ago) { 10 }

      let(:orderbook) { Bitex::Resources::Orderbook.find_by_code(:btc_usd) }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves with specified days ago' do
        expect(candles.all? { |candle| Time.at(candle.timestamp) >= Time.now - time_ago.days }).to be_truthy
      end

      it 'retrieves with specified time span' do
        candles.each_cons(2) do |oldest, newest|
          hours_difference = (Time.at(newest.timestamp).hour - Time.at(oldest.timestamp).hour).abs
          expect(hours_difference).to be >= span
        end
      end
    end
  end
end
