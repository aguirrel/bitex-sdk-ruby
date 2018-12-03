require 'spec_helper'

describe Bitex::Resources::Compliance::EmailSeed do
  let(:write_level_key) { 'write_level' }

  shared_examples_for 'Email Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address email_kind_code created_at updated_at]) }
  end

  describe '.create' do
    subject { client.email_seeds.create(address: address, email_kind_code: email_kind_code) }

    let(:address) { 'person@example.com' }
    let(:email_kind_code) { 'invoicing' }

    context 'with authorized level key', vcr: { cassette_name: 'compliance/email_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Email Seed'

      its(:address) { is_expected.to eq(address) }
      its(:email_kind_code) { is_expected.to eq(email_kind_code) }
    end
  end
end
