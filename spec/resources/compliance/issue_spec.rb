require 'spec_helper'

=begin
describe Bitex::Resources::Compliance::Issue do
  let(:read_level_key) { 'client2_read_level_key' }

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

  describe '.current' do
    subject { client.issues.current }

    context 'with any level key', vcr: { cassette_name: 'compliance/issues/current' } do
      let(:key) { read_level_key }

      it_behaves_like 'Issue'
    end
  end
end
=end
