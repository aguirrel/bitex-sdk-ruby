require 'spec_helper'

describe Bitex::Resources::Compliance::AllowanceSeed do
  let(:write_level_key) { 'write_level' }

  shared_examples_for 'Allowance Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id kind_code created_at updated_at]) }

    its(:kind_code) { is_expected.to eq(kind_code) }
  end

  describe '.create' do
    subject { client.allowance_seeds.create(kind_code: kind_code) }

    let(:kind_code) { 'usd' }

    context 'with authorized level key', vcr: { cassette_name: 'compliance/allowance_seed/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Allowance Seed'
    end
  end
end
