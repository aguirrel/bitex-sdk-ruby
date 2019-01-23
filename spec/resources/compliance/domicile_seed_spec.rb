require 'spec_helper'

describe Bitex::Resources::Compliance::DomicileSeed do
  describe '.create', vcr: { cassette_name: 'compliance/domicile_seeds/create' } do
    subject do
      client.domicile_seeds.create(
        city: city,
        country: country,
        floor: floor,
        postal_code: postal_code,
        street_address: street_address,
        street_number: street_number,
        state: state,
        apartment: apartment
      )
    end

    let(:city) { 'CABA' }
    let(:country) { 'AR' }
    let(:floor) { '0' }
    let(:postal_code) { '1001' }
    let(:street_address) { 'Balcarce' }
    let(:street_number) { '50' }
    let(:state) { 'zaraza' }
    let(:apartment) { '9º B' }

    it { is_expected.to be_a(Bitex::Resources::Compliance::DomicileSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id city country floor postal_code street_address street_number state apartment created_at updated_at]) }

    its(:type) { is_expected.to eq('domicile_seeds') }
    its(:id) { is_expected.to be_present }

    its(:city) { is_expected.to eq(city) }
    its(:country) { is_expected.to eq(country) }
    its(:floor) { is_expected.to eq(floor) }
    its(:postal_code) { is_expected.to eq(postal_code) }
    its(:street_address) { is_expected.to eq(street_address) }
    its(:street_number) { is_expected.to eq(street_number) }
    its(:state) { is_expected.to eq(state) }
    its(:apartment) { is_expected.to eq(apartment) }
  end
end
