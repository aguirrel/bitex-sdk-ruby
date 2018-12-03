require 'spec_helper'

describe Bitex::Resources::Compliance::ChileInvoicingDetailSeed do
  let(:write_level_key) { 'write_level' }

  shared_examples_for 'Chile Invoicing Detail Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id ciudad comuna giro tax_id vat_status_code created_at updated_at]) }
  end

  describe '.create' do
    subject do
      client.chile_invoicing_detail_seeds.create(
        ciudad: ciudad,
        comuna: comuna,
        giro: giro,
        tax_id: tax_id,
        vat_status_code: vat_status_code
      )
    end

    let(:ciudad) { 'Santiago' }
    let(:comuna) { 'Chile' }
    let(:giro) { '2332' }
    let(:tax_id) { '12053214-6' }
    let(:vat_status_code) { 'consumidor_final' }

    context 'with authorized level key', vcr: { cassette_name: 'compliance/chile_invoicing_detail_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Chile Invoicing Detail Seed'

      its(:ciudad) { is_expected.to eq(ciudad) }
      its(:comuna) { is_expected.to eq(comuna) }
      its(:giro) { is_expected.to eq(giro) }
      its(:tax_id) { is_expected.to eq(tax_id) }
      its(:vat_status_code) { is_expected.to eq(vat_status_code) }
    end
  end
end
