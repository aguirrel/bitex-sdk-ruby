require 'spec_helper'

describe Bitex::Resources::Miscellaneous::Account do
  shared_examples_for 'Account' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id balances country]) }
    its(:type) { is_expected.to eq(resource_name) }
    its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[movements pending_movements user]) }

    context 'about included resources' do
      subject { super().user }

      it { is_expected.to be_a(Bitex::Resources::Miscellaneous::User) }
    end
  end

  describe '.all' do
    subject { client.accounts.all }

    context 'with any level key', vcr: { cassette_name: 'accounts/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Account'

        context 'about balances' do
          subject { super().balances }

          let(:currency_codes) { %w[btc usd ars clp bch pyg uyu] }

          it { is_expected.to be_a(ActiveSupport::HashWithIndifferentAccess) }
          its(:keys) { is_expected.to contain_exactly(*currency_codes) }

          context 'taking a btc balance' do
            subject { super()[currency_codes.sample] }

            its(:keys) { is_expected.to contain_exactly(*%w[total available]) }
          end
        end
      end
    end
  end
end
