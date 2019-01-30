require 'spec_helper'

describe Bitex::Resources::Miscellaneous::Account do
  describe '.all', vcr: { cassette_name: 'accounts/all' } do
    subject(:accounts) { client.accounts.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:sampe) { accounts.sample }

      it { is_expected.to be_a(Bitex::Resources::Miscellaneous::Account) }

      its(:user) { is_expected.to be_a(Bitex::Resources::Miscellaneous::User) }

      its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id balances country]) }
      its(:type) { is_expected.to eq('accounts') }

      its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[movements pending_movements user]) }
    end
  end
end
