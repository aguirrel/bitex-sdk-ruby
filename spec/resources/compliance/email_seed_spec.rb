require 'spec_helper'

describe Bitex::Resources::Compliance::EmailSeed do
  describe '.create', vcr: { cassette_name: 'compliance/email_seeds/create' } do
    subject { client.email_seeds.create(601, address: 'sdk+invoicing@whitelabeler.com', email_kind_code: 'invoicing') }

    it { is_expected.to be_a(Bitex::Resources::Compliance::EmailSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address email_kind_code created_at updated_at]) }

    its(:type) { is_expected.to eq('email_seeds') }
    its(:id) { is_expected.to be_present }

    its(:address) { is_expected.to eq('sdk+invoicing@whitelabeler.com') }
    its(:email_kind_code) { is_expected.to eq('invoicing') }
  end
end
