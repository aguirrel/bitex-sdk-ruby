require 'spec_helper'

describe Bitex::CashWithdrawal do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Cash Withdrawal' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type amount fiat id status gross_amount cost fee net_amount country payment_method currency label created_at]
      )
    end
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.create' do
    subject { client.cash_withdrawals.create(amount: amount, fiat: fiat, withdrawal_instruction_id: id, otp: otp) }

    let(:amount) { 1_000 }
    let(:fiat) { :ars }
    let(:id) { 12 }
    let(:otp) { '111111' }

    context 'with unauthorized key', vcr: { cassette_name: 'cash_withdrawals/create/unauthorized' } do
      let(:key) { :we_dont_care }

      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'cash_withdrawals/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key' do
      let(:key) { write_level_key }

      context 'with invalid otp code', vcr: { cassette_name: 'cash_withdrawals/create/unauthorized_otp' } do
        it_behaves_like 'Not enough permissions'
      end

      context 'with non existent id', vcr: { cassette_name: 'cash_withdrawals/create/authorized_not_found' } do
        it_behaves_like 'Not Found'
      end

      context 'with existent id', vcr: { cassette_name: 'cash_withdrawals/create/authorized' } do
        it_behaves_like 'Cash Withdrawal'
      end
    end
  end
end
