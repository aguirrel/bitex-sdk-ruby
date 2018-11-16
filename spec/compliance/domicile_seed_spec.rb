require 'spec_helper'

describe Bitex::Compliance::DomicileSeed do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Domicile Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id city country floor postal_code street_address street_number state apartment created_at updated_at]) }

    its(:city) { is_expected.to eq(city) }
    its(:country) { is_expected.to eq(country) }
    its(:floor) { is_expected.to eq(floor) }
    its(:postal_code) { is_expected.to eq(postal_code) }
    its(:street_address) { is_expected.to eq(street_address) }
    its(:street_number) { is_expected.to eq(street_number) }
    its(:state) { is_expected.to eq(state) }
    its(:apartment) { is_expected.to eq(apartment) }
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

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/domicile_seeds/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'Compliance/domicile_seeds/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/domicile_seeds/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Domicile Seed'
    end
  end
end
