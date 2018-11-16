require 'spec_helper'

describe Bitex::Payment do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Payment' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type amount currency keep callback_url customer_reference merchant_reference id confirmed_quantity expected_quantity
        kept last_quoted_on overpaid quote_valid_until settlement_amount settlement_currency status unconfirmed_quantity
        valid_until]
      )
    end
    its(:type) { is_expected.to eq(resource_name) }
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

    context 'with unauthorized key', vcr: { cassette_name: 'payments/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'payments/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'payments/create/authorized' } do
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

    let(:id) { 1 }

    context 'with unauthorized key', vcr: { cassette_name: 'payments/find/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'with non-existent id', vcr: { cassette_name: 'payments/find/non_existent_id' } do
        it_behaves_like 'Not Found'
      end

      context 'with existent id', vcr: { cassette_name: 'payments/find/authorized' } do
        it_behaves_like 'Payment'

        its(:id) { is_expected.to eq(id.to_s) }
      end
    end
  end
end
