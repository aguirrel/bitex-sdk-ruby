require 'spec_helper'

describe Bitex::Resources::Withdrawals::CashWithdrawal do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'cash_withdrawals/all/without_filters' } do
      subject(:withdrawals) { client.cash_withdrawals.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject(:sample) { withdrawals.sample }

        it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

        its(:type) { is_expected.to eq('cash_withdrawals') }
        its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[withdrawal_instruction funding_receipt]) }

        context 'about included resources' do
          its(:withdrawal_instruction) { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }
        end

        its(:'attributes.keys') do
          is_expected.to contain_exactly(
            *%w[type fiat_code amount id status gross_amount cost fee net_amount country payment_method label created_at]
          )
        end
      end
    end

    context 'with filters', vcr: { cassette_name: 'cash_withdrawals/all/with_filters_dev' } do
      subject(:withdrawals) { client.cash_withdrawals.all(from: str_date) }

      let(:str_date) { '2018-01-01' }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specified date' do
        expect(withdrawals.all? { |withdrawal| Date.strptime(withdrawal.created_at, '%FT') >= str_date.to_date }).to be_truthy
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'cash_withdrawals/find' } do
    subject { client.cash_withdrawals.find('28787') }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

    its(:id) { is_expected.to eq('28787') }
  end

  describe '.create', vcr: { cassette_name: 'cash_withdrawals/create' } do
    subject { client.cash_withdrawals.create(withdrawal_instruction: withdrawal_instruction, amount: amount, fiat_code: fiat_code, otp: otp) }

    let(:withdrawal_instruction) { client.withdrawal_instructions.new(id: '15234') }
    let(:amount) { 150 }
    let(:fiat_code) { 'ars' }
    let(:otp) { '635198' }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

    its(:amount) { is_expected.to eq(amount) }
    its(:fiat_code) { is_expected.to eq(fiat_code) }
  end
end
