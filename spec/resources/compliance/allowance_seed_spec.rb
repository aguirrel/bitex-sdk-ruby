require 'spec_helper'

describe Bitex::Resources::Compliance::AllowanceSeed do
  describe '.create', vcr: { cassette_name: 'compliance/allowance_seed/create' } do
    subject { client.allowance_seeds.create(kind_code: 'usd') }

    it { is_expected.to be_a(Bitex::Resources::Compliance::AllowanceSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id kind_code created_at updated_at]) }

    its(:type) { is_expected.to eq('allowance_seeds') }
    its(:id) { is_expected.to be_present }

    its(:kind_code) { is_expected.to eq('usd') }
  end
end
