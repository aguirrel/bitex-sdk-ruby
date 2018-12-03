require 'spec_helper'

describe Bitex::Resources::Compliance::DomicileSeed do
  let(:write_level_key) { 'client3_write_level_key' }

  shared_examples_for 'Domicile Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id city country floor postal_code street_address street_number state apartment created_at updated_at]) }
  end

  describe '.create' do
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

    context 'with authorized level key', vcr: { cassette_name: 'compliance/domicile_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Domicile Seed'

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
end
