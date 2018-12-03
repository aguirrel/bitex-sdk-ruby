require 'spec_helper'

describe Bitex::Resources::Compliance::NaturalDocketSeed do
  let(:write_level_key) { 'client3_write_level_key' }

  shared_examples_for 'Natural Docket Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type id first_name last_name nationality gender_code marital_status_code politically_exposed birth_date job_title
        job_description politically_exposed_reason created_at updated_at]
      )
    end
  end

  describe '.create' do
    subject do
      client.natural_docket_seeds.create(
        first_name: first_name,
        last_name: last_name,
        nationality: nationality,
        gender_code: gender_code,
        marital_status_code: marital_status_code,
        politically_exposed: politically_exposed,
        birth_date: birth_date,
        job_title: job_title,
        job_description: job_description,
        politically_exposed_reason: politically_exposed_reason
      )
    end

    let(:first_name) { 'Rick' }
    let(:last_name) { 'Sanchez' }
    let(:nationality) { 'AR' }
    let(:gender_code) { 'male' }
    let(:marital_status_code) { 'single' }
    let(:politically_exposed) { false }
    let(:birth_date) { '1989-05-17' }

    let(:job_title) { 'scientific' }
    let(:job_description) { 'science, absolute reality' }
    let(:politically_exposed_reason) { 'I´m a rockstar' }

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/natural_docket_seeds/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Natural Docket Seed'

      its(:first_name) { is_expected.to eq(first_name) }
      its(:last_name) { is_expected.to eq(last_name) }
      its(:nationality) { is_expected.to eq(nationality) }
      its(:gender_code) { is_expected.to eq(gender_code) }
      its(:gender_code) { is_expected.to eq(gender_code) }
      its(:marital_status_code) { is_expected.to eq(marital_status_code) }
      its(:politically_exposed) { is_expected.to eq(politically_exposed) }
      its(:birth_date) { is_expected.to eq(birth_date) }

      its(:job_title) { is_expected.to eq(job_title) }
      its(:job_description) { is_expected.to eq(job_description) }
      its(:politically_exposed_reason) { is_expected.to eq(politically_exposed_reason) }
    end
  end
end
