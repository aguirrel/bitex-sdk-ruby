require 'spec_helper'

describe Bitex::Resources::Compliance::IdentificationSeed do
  describe '.create', vcr: { cassette_name: 'compliance/identification_seeds/create' } do
    subject do
      client.identification_seeds.create(
        601,
        identification_kind_code: 'national_id',
        number: '12345678',
        issuer: 'AR'
      )
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::IdentificationSeed) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type identification_kind_code number issuer id public_registry_authority public_registry_book
        public_registry_extra_data created_at updated_at]
      )
    end

    its(:type) { is_expected.to eq('identification_seeds') }
    its(:id) { is_expected.to be_present }

    its(:identification_kind_code) { is_expected.to eq('national_id') }
    its(:number) { is_expected.to eq('12345678') }
    its(:issuer) { is_expected.to eq('AR') }

    its(:public_registry_authority) { is_expected.to be_nil }
    its(:public_registry_book) { is_expected.to be_nil }
    its(:public_registry_extra_data) { is_expected.to be_nil }
  end
end
