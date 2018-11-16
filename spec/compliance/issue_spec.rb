require 'spec_helper'

describe Bitex::Compliance::Issue do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Issue' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id state created_at updated_at]) }

    context 'about relationships' do
      subject { super().relationships }

      its(:person) { is_expected.to be_present }
      its(:natural_docket_seed) { is_expected.to be_present }
      its(:legal_entity_docket_seed) { is_expected.to be_present }
      its(:argentina_invoicing_detail_seed) { is_expected.to be_present }
      its(:chile_invoicing_detail_seed) { is_expected.to be_present }
      its(:identification_seeds) { is_expected.to be_present }
      its(:domicile_seeds) { is_expected.to be_present }
      its(:phone_seeds) { is_expected.to be_present }
      its(:email_seeds) { is_expected.to be_present }
      its(:allowance_seeds) { is_expected.to be_present }
      its(:observations) { is_expected.to be_present }
      its(:note_seeds) { is_expected.to be_present }
    end
  end

  describe '.current!' do
    subject { client.issues.current! }

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/issues/current/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key', vcr: { cassette_name: 'Compliance/issues/current/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Issue'
    end
  end
end
