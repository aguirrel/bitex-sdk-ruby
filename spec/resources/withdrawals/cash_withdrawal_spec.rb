require 'spec_helper'

describe Bitex::Resources::Withdrawals::CashWithdrawal do
  shared_examples_for 'Cash Withdrawal' do
    it { is_expected.to be_a(described_class) }

    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to include(*%w[withdrawal_instruction funding_receipt]) }

    context 'about included resources' do
      its(:withdrawal_instruction) { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }
    end
  end

  describe '.all' do
    subject { client.cash_withdrawals.all(from: from) }

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'without filters', vcr: { cassette_name: 'cash_withdrawals/all/without_filters' } do
        let(:from) { nil }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Cash Withdrawal'

          its(:'attributes.keys') do
            is_expected.to contain_exactly(
              *%w[type amount id status gross_amount cost fee net_amount country payment_method currency label created_at]
            )
          end
        end
      end

      context 'with filters', vcr: { cassette_name: 'cash_withdrawals/all/with_filters' } do
        let(:from) { '2018-01-01' }

        it { is_expected.to be_a(JsonApiClient::ResultSet) }

        context 'taking a sample' do
          subject { super().sample }

          it_behaves_like 'Cash Withdrawal'

          its(:'attributes.keys') do
            is_expected.to contain_exactly(
              *%w[type amount id status gross_amount cost fee net_amount country payment_method currency  label created_at]
            )
          end
        end
      end
    end
  end

  describe '.find' do
    subject { client.cash_withdrawals.find(id) }

    context 'with any level key', vcr: { cassette_name: 'cash_withdrawals/find' } do
      let(:key) { write_level_key }

      let(:id) { '2' }

      it_behaves_like 'Cash Withdrawal'

      its(:id) { is_expected.to eq(id) }
      its(:'attributes.keys') do
        is_expected.to contain_exactly(
          *%w[type amount id status gross_amount cost fee net_amount country payment_method currency  label created_at]
        )
      end
    end
  end

  describe '.create' do
    subject { client.cash_withdrawals.create(withdrawal_instruction: withdrawal_instruction, amount: amount, currency: currency, otp: otp) }

    context 'with authorized level key', vcr: { cassette_name: 'cash_withdrawals/create' } do
      let(:key) { write_level_key }

      let(:withdrawal_instruction) { client.withdrawal_instructions.new(id: 14) }
      let(:amount) { 1_000 }
      let(:currency) { :ars }
      let(:otp) { '111111' }

      it_behaves_like 'Cash Withdrawal'

      its(:'attributes.keys') do
        is_expected.to contain_exactly(
          *%w[type amount fiat id status gross_amount cost fee net_amount country payment_method currency  label created_at]
        )
      end
    end
  end
end
