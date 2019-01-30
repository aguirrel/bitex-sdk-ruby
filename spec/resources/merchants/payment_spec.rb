require 'spec_helper'

describe Bitex::Resources::Merchants::Payment do
  describe '.all', vcr: { cassette_name: 'payments/all' } do
    subject(:payments) { client.payments.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { payments.sample }

      it { is_expected.to be_a(Bitex::Resources::Merchants::Payment) }

      its(:'attributes.keys') do
        is_expected.to contain_exactly(
          *%w[type amount currency_code keep callback_url customer_reference merchant_reference id confirmed_quantity
              expected_quantity kept last_quoted_on overpaid quote_valid_until settlement_amount settlement_currency status
              unconfirmed_quantity valid_until]
        )
      end

      its(:type) { is_expected.to eq('payments') }
    end

    context 'taking a sample with deposits' do
      subject(:sample) { payments.find { |payment| payment.coin_deposits.any? } }

      its(:address) { is_expected.to be_a(Bitex::Resources::Merchants::BitcoinAddress) }
      its(:coin_deposits) { is_expected.to be_a(Array) }
      its(:'coin_deposits.sample') { is_expected.to be_a(Bitex::Resources::Merchants::CoinDeposit) }
    end
  end

  describe '.find', vcr: { cassette_name: 'payments/find' } do
    subject { client.payments.find('328') }

    it { is_expected.to be_a(Bitex::Resources::Merchants::Payment) }

    its(:id) { is_expected.to eq('328') }
  end

  describe '.create', vcr: { cassette_name: 'payments/create' } do
    subject do
      client.payments.create(
        amount: amount,
        currency: currency_code,
        keep: keep,
        callback_url: callback_url,
        customer_reference: customer_reference,
        merchant_reference: merchant_reference
      )
    end

    let(:amount) { 100 }
    let(:callback_url) { 'https://myawesomesite.com/webhook' }
    let(:currency_code) { 1 } # :btc
    let(:customer_reference) { 'Purchase at My Store' }
    let(:keep) { 10 }
    let(:merchant_reference) { 'Sale id: 2212' }

    it { is_expected.to be_a(Bitex::Resources::Merchants::Payment) }

    its(:amount) { is_expected.to eq(amount) }
    its(:callback_url) { is_expected.to eq(callback_url) }
    its(:currency) { is_expected.to eq(currency_code) }
    its(:customer_reference) { is_expected.to eq(customer_reference) }
    its(:keep) { is_expected.to eq(keep) }
    its(:merchant_reference) { is_expected.to eq(merchant_reference) }
  end
end
