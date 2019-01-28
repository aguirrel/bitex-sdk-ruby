require 'spec_helper'

describe Bitex::Resources::Compliance::ArgentinaInvoicingDetailSeed do
  describe '.create', vcr: { cassette_name: 'compliance/argentina_invoicing_detail_seeds/create' } do
    subject do
      client.argentina_invoicing_detail_seeds.create(
        601,
        address: 'Dimension C-132',
        country: 'AR',
        full_name: 'Rick Sanchez',
        receipt_kind_code: 'b',
        tax_id: '20123456782',
        tax_id_kind_code: 'cuil',
        vat_status_code: 'consumidor_final'
      )
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::ArgentinaInvoicingDetailSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address country full_name receipt_kind_code tax_id tax_id_kind_code vat_status_code created_at updated_at]) }

    its(:type) { is_expected.to eq('argentina_invoicing_detail_seeds') }
    its(:id) { is_expected.to be_present }

    its(:address) { is_expected.to eq('Dimension C-132') }
    its(:country) { is_expected.to eq('AR') }
    its(:full_name) { is_expected.to eq('Rick Sanchez') }
    its(:receipt_kind_code) { is_expected.to eq('b') }
    its(:tax_id) { is_expected.to eq('20123456782') }
    its(:tax_id_kind_code) { is_expected.to eq('cuil') }
    its(:vat_status_code) { is_expected.to eq('consumidor_final') }
  end
end
