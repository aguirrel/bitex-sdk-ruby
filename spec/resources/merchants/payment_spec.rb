require 'spec_helper'

describe Bitex::Resources::Merchants::Payment do
  shared_examples_for 'Payment' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq(resource_name) }
    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type amount currency keep callback_url customer_reference merchant_reference id confirmed_quantity expected_quantity
        kept last_quoted_on overpaid quote_valid_until settlement_amount settlement_currency status unconfirmed_quantity
        valid_until]
      )
    end

    context 'about included resources' do
      subject { super().address }

      it { is_expected.to be_a(Bitex::Resources::Merchants::BitcoinAddress) }
      its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[user payment]) }
    end
  end

  describe '.all' do
    subject { client.payments.all }

    context 'with any level key', vcr: { cassette_name: 'payments/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Payment'
      end
    end
  end

  describe '.create' do
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

    context 'with authorized level key', vcr: { cassette_name: 'payments/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Payment'

      its(:amount) { is_expected.to eq(amount) }
      its(:callback_url) { is_expected.to eq(callback_url) }
      its(:currency) { is_expected.to eq('btc') }
      its(:customer_reference) { is_expected.to eq(customer_reference) }
      its(:keep) { is_expected.to eq(keep) }
      its(:merchant_reference) { is_expected.to eq(merchant_reference) }
    end
  end

  describe '.find' do
    subject { client.payments.find(id) }

    context 'with any level key', vcr: { cassette_name: 'payments/find' } do
      let(:key) { read_level_key }

      let(:id) { '5' }

      it_behaves_like 'Payment'

      its(:id) { is_expected.to eq(id) }
    end
  end
end
