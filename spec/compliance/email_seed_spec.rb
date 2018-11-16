require 'spec_helper'

describe Bitex::Compliance::EmailSeed do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Email Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address email_kind_code created_at updated_at]) }

    its(:address) { is_expected.to eq(address) }
    its(:email_kind_code) { is_expected.to eq(email_kind_code) }
  end

  describe '.create' do
    subject { client.email_seeds.create(address: address, email_kind_code: email_kind_code) }

    let(:address) { 'person@example.com' }
    let(:email_kind_code) { 'invoicing' }

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/email_seeds/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'Compliance/email_seeds/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/email_seeds/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Email Seed'
    end
  end
end
