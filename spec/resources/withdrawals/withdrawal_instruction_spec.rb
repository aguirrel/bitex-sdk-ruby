require 'spec_helper'

describe Bitex::Resources::Withdrawals::WithdrawalInstruction do
  describe '.all', vcr: { cassette_name: 'withdrawal_instructions/all' } do
    subject(:instructions) { client.withdrawal_instructions.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { instructions.sample }

      it { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type label body id schema]) }
      its(:type) { is_expected.to eq('withdrawal_instructions') }
    end
  end

  describe '.create' do
    subject { client.withdrawal_instructions.create(label: label, payment_method: method, payment_body: payment_body) }

    let(:label) { 'label' }

    let(:city) { 'Dimension C-132' }
    let(:further_instructions) { 'A further instructions' }
    let(:name) { 'Rick Sanchez' }
    let(:phone) { '1122334455' }
    let(:currency) { 'USD' }

    let(:shared_body_fields) do
      {
        'city' => city,
        'country' => country,
        'currency' => currency,
        'further_instructions' => further_instructions,
        'name' => name,
        'payment_method' => method,
        'phone' => phone
      }
    end

    let(:payment_body) { body.merge(shared_body_fields) }

    shared_examples_for 'Newest Withdrawal Instruction' do
      it { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }

      its(:label) { is_expected.to eq(label) }
      its(:body) { is_expected.to eq(body.merge(shared_body_fields)) }
    end

    context 'with domestic bank', vcr: { cassette_name: 'withdrawal_instructions/create/domestic_bank' } do
      let(:method) { 'domestic_bank' }
      let(:country) { 'AR' }
      let(:body) do
        {
          'account_type' => 'savings',
          'address' => 'a address',
          'bank' => 'hsbc',
          'bank_account_number' => '12345678',
          'cbu' => '1234567812345678',
          'cuit' => '20112233344552'
        }
      end

      it_behaves_like 'Newest Withdrawal Instruction'
    end

    context 'with international bank', vcr: { cassette_name: 'withdrawal_instructions/create/international_bank' } do
      let(:method) { 'international_bank' }
      let(:country) { 'CL' }
      let(:body) do
        {
          'account_type' => 'savings',
          'address' => 'a address',
          'bank' => 'bco_chile',
          'bank_account_number' => '12345678',
          'bank_address' => 'a bank address',
          'bank_city' => 'a bank city',
          'bank_country' => 'CL',
          'bank_postal_code' => 'AABBCC',
          'bank_swift' => 'BANKUS66',
          'postal_code' => 'XXYYZZ'
        }
      end

      it_behaves_like 'Newest Withdrawal Instruction'
    end

    context 'with third party', vcr: { cassette_name: 'withdrawal_instructions/create/third_party' } do
      let(:method) { 'third_party' }
      let(:country) { 'PY' }
      let(:body) { {} }

      it_behaves_like 'Newest Withdrawal Instruction'
    end
  end

  describe '.find', vcr: { cassette_name: 'withdrawal_instructions/find' } do
    subject { client.withdrawal_instructions.find('15416') }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }

    its(:id) { is_expected.to eq('15416') }
  end

  describe '.destroy', vcr: { cassette_name: 'withdrawal_instructions/destroy' } do
    subject { instruction.destroy }

    let(:instruction) { client.withdrawal_instructions.new(id: '15415') }

    it { is_expected.to be_truthy }
  end

  describe '.valid_payment?' do
    subject { described_class.send(:valid_payment?, method, body) }

    context 'valid method' do
      let(:method) { 'third_party' }

      context 'invalid body' do
        let(:body) { { we: :dont_care } }

        it { is_expected.to be_falsey }
      end

      context 'valid body' do
        let(:body) { { 'name' => 'n', 'city' => 'c', 'further_instructions' => 'fi', 'phone' => 'p' } }

        it { is_expected.to be_truthy }
      end
    end

    context 'valid body' do
      let(:body) { { 'name' => 'n', 'city' => 'c', 'further_instructions' => 'fi', 'phone' => 'p' } }

      context 'invalid method' do
        let(:method) { 'we_dont_care' }

        it { is_expected.to be_falsey }
      end

      context 'valid method' do
        let(:method) { 'third_party' }

        it { is_expected.to be_truthy }
      end
    end
  end

  describe '.valid_method?' do
    subject { described_class.send(:valid_method?, method) }

    context 'with invalid method' do
      let(:method) { :we_dont_care }

      it { is_expected.to be_falsey }
    end

    context 'with valid method' do
      let(:method) { %w[domestic_bank international_bank third_party].sample }

      it { is_expected.to be_truthy }
    end
  end

  describe '.valid_body?' do
    subject { described_class.send(:valid_body?, payment_method, payment_body_keys) }

    context 'with invalid payment method' do
      let(:payment_method) { :we_dont_care }
      let(:payment_body_keys) { {} }

      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe '.domestic_bank_body' do
    subject { described_class.send(:domestic_bank_body) }

    it do
      is_expected.to contain_exactly(
        *%w[name city further_instructions phone account_type address bank bank_account_number cbu country cuit currency]
      )
    end
  end

  describe '.international_bank_body' do
    subject { described_class.send(:international_bank_body) }

    it do
      is_expected.to contain_exactly(
        *%w[name city further_instructions phone account_type address bank bank_account_number bank_address bank_city
        bank_country bank_postal_code bank_swift postal_code]
      )
    end
  end

  describe '.third_party_body' do
    subject { described_class.send(:third_party_body) }

    it { is_expected.to contain_exactly(*%w[name city further_instructions phone]) }
  end

  describe '.shared_body_bank' do
    subject { described_class.send(:shared_body_bank) }

    it { is_expected.to contain_exactly(*%w[name city further_instructions phone account_type address bank bank_account_number]) }
  end

  describe '.shared_body' do
    subject { described_class.send(:shared_body) }

    it { is_expected.to contain_exactly(*%w[name city further_instructions phone]) }
  end
end
