require 'spec_helper'

describe Bitex::Resources::ApiKey do
  describe '.all', vcr: { cassette_name: 'api_keys/all' } do
    subject(:api_keys) { client.api_keys.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sample) { api_keys.sample }

      it { is_expected.to be_a(Bitex::Resources::ApiKey) }

      its(:'attributes.keys') do
        is_expected.to contain_exactly(
          *%w[type id token fund_account create_withdrawal get_withdrawal get_balances trading payments compliance api_keys]
        )
      end

      its(:type) { is_expected.to eq('api_keys') }
    end
  end

  describe '.find', vcr: { cassette_name: 'api_keys/find' } do
    subject { client.api_keys.find('184') }

    it { is_expected.to be_a(Bitex::Resources::ApiKey) }

    its(:id) { is_expected.to eq('184') }
  end

  describe '.create', vcr: { cassette_name: 'api_keys/create' } do
   subject do
     client.api_keys.create(
       permissions: {
         fund_account: fund_account_permission,
         payments: payments_permission,
         api_keys: api_keys_permission
       },
       otp: otp
     )
   end

   let(:api_keys_permission) { true }
   let(:fund_account_permission) { true }
   let(:payments_permission) { true }

   let(:otp) { '826641' }

   it { is_expected.to be_a(Bitex::Resources::ApiKey) }

   its(:id) { is_expected.to be_present }
   its(:token) { is_expected.to be_present }

   its(:api_keys) { is_expected.to eq(api_keys_permission) }
   its(:fund_account) { is_expected.to eq(fund_account_permission) }
   its(:payments) { is_expected.to eq(payments_permission) }
   its(:create_withdrawal) { is_expected.to be_falsey }
   its(:get_withdrawal) { is_expected.to be_falsey }
   its(:get_balances) { is_expected.to be_falsey }
   its(:trading) { is_expected.to be_falsey }
   its(:compliance) { is_expected.to be_falsey }
  end

  describe '.destroy', vcr: { cassette_name: 'api_keys/destroy' } do
    subject { client.api_keys.new(id: '184').destroy }

    it { is_expected.to be_truthy }
  end
end
