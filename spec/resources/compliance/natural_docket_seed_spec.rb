require 'spec_helper'

describe Bitex::Resources::Compliance::NaturalDocketSeed do
  describe '.create', vcr: { cassette_name: 'compliance/natural_docket_seeds/create' } do
    subject do
      client.natural_docket_seeds.create(
        601,
        first_name: 'Rick',
        last_name: 'Sanchez',
        nationality: 'AR',
        gender_code: 'male',
        marital_status_code: 'single',
        politically_exposed: false,
        birth_date: '1989-05-17'
      )
    end

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

    its(:first_name) { is_expected.to eq('Rick') }
    its(:last_name) { is_expected.to eq('Sanchez') }
    its(:nationality) { is_expected.to eq('AR') }
    its(:gender_code) { is_expected.to eq('male') }
    its(:marital_status_code) { is_expected.to eq('single') }
    its(:birth_date) { is_expected.to eq('1989-05-17') }
    its(:politically_exposed) { is_expected.to be_falsey }

    its(:politically_exposed_reason) { is_expected.to be_nil }
    its(:job_title) { is_expected.to be_nil }
    its(:job_description) { is_expected.to be_nil }
  end
end
