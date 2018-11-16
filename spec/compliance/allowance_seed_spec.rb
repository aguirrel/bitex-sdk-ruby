require 'spec_helper'

describe Bitex::Compliance::AllowanceSeed do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Allowance Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id kind_code created_at updated_at]) }

    its(:kind_code) { is_expected.to eq(kind_code) }
  end

  describe '.create' do
    subject { client.allowance_seeds.create(kind_code: kind_code) }

    let(:kind_code) { 'usd' }

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/allowance_seed/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'Compliance/allowance_seed/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/allowance_seed/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Allowance Seed'
    end
  end
end
