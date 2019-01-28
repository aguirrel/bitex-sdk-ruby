require 'spec_helper'

describe Bitex::Resources::Compliance::ChileInvoicingDetailSeed do
  describe '.create', vcr: { cassette_name: 'compliance/chile_invoicing_detail_seeds/create' } do
    subject do
      client.chile_invoicing_detail_seeds.create(
        601,
        ciudad: 'Santiago',
        comuna: 'Chile',
        giro: '2332',
        tax_id: '12053214-6',
        vat_status_code: 'consumidor_final'
      )
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::ChileInvoicingDetailSeed) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id ciudad comuna giro tax_id vat_status_code created_at updated_at])
    end

    its(:type) { is_expected.to eq('chile_invoicing_detail_seeds') }
    its(:id) { is_expected.to be_present }

    its(:ciudad) { is_expected.to eq('Santiago') }
    its(:comuna) { is_expected.to eq('Chile') }
    its(:giro) { is_expected.to eq('2332') }
    its(:tax_id) { is_expected.to eq('12053214-6') }
    its(:vat_status_code) { is_expected.to eq('consumidor_final') }
  end
end
