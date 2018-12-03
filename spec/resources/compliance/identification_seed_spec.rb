require 'spec_helper'

describe Bitex::Resources::Compliance::IdentificationSeed do
  let(:write_level_key) { 'client3_write_level_key' }

  shared_examples_for 'Identification Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type id identification_kind_code number issuer public_registry_authority public_registry_book
        public_registry_extra_data created_at updated_at]
      )
    end
  end

  describe '.create' do
    subject do
      client.identification_seeds.create(
        identification_kind_code: identification_kind_code,
        number: number,
        issuer: issuer,
        public_registry_authority: public_registry_authority,
        public_registry_book: public_registry_book,
        public_registry_extra_data: public_registry_extra_data
      )
    end

    let(:identification_kind_code) { 'national_id' }
    let(:number) { '12345678' }
    let(:issuer) { 'AR' }
    let(:public_registry_authority) { 'public registry authority' }
    let(:public_registry_book) { 'public registry book' }
    let(:public_registry_extra_data) { 'public registry extra data' }

    context 'with authorized level key', vcr: { cassette_name: 'compliance/identification_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Identification Seed'

      its(:identification_kind_code) { is_expected.to eq(identification_kind_code) }
      its(:number) { is_expected.to eq(number) }
      its(:issuer) { is_expected.to eq(issuer) }

      # TODO why returns nil?
      its(:public_registry_authority) { is_expected.to be_nil }
      its(:public_registry_book) { is_expected.to be_nil }
      its(:public_registry_extra_data) { is_expected.to be_nil }
    end
  end
end
