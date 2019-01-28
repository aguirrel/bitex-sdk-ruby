require 'spec_helper'

describe Bitex::Resources::Compliance::DomicileSeed do
  describe '.create', vcr: { cassette_name: 'compliance/domicile_seeds/create' } do
    subject do
      client.domicile_seeds.create(
        601,
        city: 'CABA',
        country: 'AR',
        floor: '0',
        postal_code: '1001',
        street_address: 'Balcarce',
        street_number: '50',
        state: 'zaraza',
        apartment: '9º B'
      )
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::DomicileSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id city country floor postal_code street_address street_number state apartment created_at updated_at]) }

    its(:type) { is_expected.to eq('domicile_seeds') }
    its(:id) { is_expected.to be_present }

    its(:city) { is_expected.to eq('CABA') }
    its(:country) { is_expected.to eq('AR') }
    its(:floor) { is_expected.to eq('0') }
    its(:postal_code) { is_expected.to eq('1001') }
    its(:street_address) { is_expected.to eq('Balcarce') }
    its(:street_number) { is_expected.to eq('50') }
    its(:state) { is_expected.to eq('zaraza') }
    its(:apartment) { is_expected.to eq('9º B') }
  end
end
