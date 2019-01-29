require 'spec_helper'

describe Bitex::Resources::Compliance::Issue do
  describe '.current', vcr: { cassette_name: 'compliance/issues/current' } do
    subject(:issues) { client.issues.current(601) }

    it { is_expected.to be_a(Bitex::Resources::Compliance::Issue) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id state created_at updated_at]) }

    its(:id) { is_expected.to be_present }
    its(:type) { is_expected.to eq('issues') }

    its(:person) { is_expected.to be_a(Bitex::Resources::Compliance::Person) }
    its(:natural_docket_seed) { is_expected.to be_a(Bitex::Resources::Compliance::NaturalDocketSeed) }
    its(:legal_entity_docket_seed) { is_expected.to be_nil }
    its(:argentina_invoicing_detail_seed) { is_expected.to be_a(Bitex::Resources::Compliance::ArgentinaInvoicingDetailSeed) }
    its(:chile_invoicing_detail_seed) { is_expected.to be_a(Bitex::Resources::Compliance::ChileInvoicingDetailSeed) }
    its(:'identification_seeds.sample') { is_expected.to be_a(Bitex::Resources::Compliance::IdentificationSeed) }
    its(:'domicile_seeds.sample') { is_expected.to be_a(Bitex::Resources::Compliance::DomicileSeed) }
    its(:'phone_seeds.sample') { is_expected.to be_a(Bitex::Resources::Compliance::PhoneSeed) }
    its(:'email_seeds.sample') { is_expected.to be_a(Bitex::Resources::Compliance::EmailSeed) }
    its(:'allowance_seeds.sample') { is_expected.to be_a(Bitex::Resources::Compliance::AllowanceSeed) }

    its(:observations) { is_expected.to be_empty }
    its(:note_seeds) { is_expected.to be_empty }
  end

  describe '.complete', vcr: { cassette_name: 'compliance/issues/complete' } do
    subject { client.issues.complete(601) }

    it { is_expected.to be_a(Bitex::Resources::Compliance::Issue) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id state]) }

    its(:id) { is_expected.to be_present }
    its(:type) { is_expected.to eq('issues') }

    its(:state) { is_expected.to eq('new') }
  end
end
