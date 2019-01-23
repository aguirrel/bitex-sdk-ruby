require 'spec_helper'

describe Bitex::Resources::Compliance::NaturalDocketSeed do
  describe '.create', vcr: { cassette_name: 'compliance/natural_docket_seeds/create' } do
    subject do
      client.natural_docket_seeds.create(
        first_name: first_name,
        last_name: last_name,
        nationality: nationality,
        gender_code: gender_code,
        marital_status_code: marital_status_code,
        birth_date: birth_date
      )
    end

    let(:first_name) { 'Rick' }
    let(:last_name) { 'Sanchez' }
    let(:nationality) { 'AR' }
    let(:gender_code) { 'male' }
    let(:marital_status_code) { 'single' }
    let(:politically_exposed) { false }
    let(:birth_date) { '1989-05-17' }

    it { is_expected.to be_a(Bitex::Resources::Compliance::NaturalDocketSeed) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type first_name last_name nationality gender_code marital_status_code birth_date id job_title job_description 
            politically_exposed politically_exposed_reason created_at updated_at]
      )
    end

    its(:type) { is_expected.to eq('natural_docket_seeds') }
    its(:id) { is_expected.to be_present }
    its(:created_at) { is_expected.to be_present }
    its(:updated_at) { is_expected.to be_present }

    its(:first_name) { is_expected.to eq(first_name) }
    its(:last_name) { is_expected.to eq(last_name) }
    its(:nationality) { is_expected.to eq(nationality) }
    its(:gender_code) { is_expected.to eq(gender_code) }
    its(:gender_code) { is_expected.to eq(gender_code) }
    its(:marital_status_code) { is_expected.to eq(marital_status_code) }
    its(:birth_date) { is_expected.to eq(birth_date) }

    its(:politically_exposed) { is_expected.to be_nil }
    its(:politically_exposed_reason) { is_expected.to be_nil }
    its(:job_title) { is_expected.to be_nil }
    its(:job_description) { is_expected.to be_nil }
  end
end
