require 'spec_helper'

describe Bitex::Resources::Compliance::ChileInvoicingDetailSeed do
  describe '.create', vcr: { cassette_name: 'compliance/chile_invoicing_detail_seeds/create' } do
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

    it { is_expected.to be_a(Bitex::Resources::Compliance::ChileInvoicingDetailSeed) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id ciudad comuna giro tax_id vat_status_code created_at updated_at])
    end

    its(:type) { is_expected.to eq('chile_invoicing_detail_seeds') }
    its(:id) { is_expected.to be_present }

    its(:ciudad) { is_expected.to eq(ciudad) }
    its(:comuna) { is_expected.to eq(comuna) }
    its(:giro) { is_expected.to eq(giro) }
    its(:tax_id) { is_expected.to eq(tax_id) }
    its(:vat_status_code) { is_expected.to eq(vat_status_code) }
  end
end
