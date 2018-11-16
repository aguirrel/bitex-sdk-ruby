require 'spec_helper'

describe Bitex::Compliance::ArgentinaInvoicingDetailSeed do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Argentinian Invoicing Detail Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id address country full_name receipt_kind_code tax_id tax_id_kind_code vat_status_code created_at updated_at]) }

    its(:address) { is_expected.to eq(address) }
    its(:country) { is_expected.to eq(country) }
    its(:full_name) { is_expected.to eq(full_name) }
    its(:receipt_kind_code) { is_expected.to eq(receipt_kind_code) }
    its(:tax_id) { is_expected.to eq(tax_id) }
    its(:tax_id_kind_code) { is_expected.to eq(tax_id_kind_code) }
    its(:vat_status_code) { is_expected.to eq(vat_status_code) }
  end

  describe '.create' do
    subject do
      client.argentina_invoicing_detail_seeds.create(
        address: address,
        country: country,
        full_name: full_name,
        receipt_kind_code: receipt_kind_code,
        tax_id: tax_id,
        tax_id_kind_code: tax_id_kind_code,
        vat_status_code: vat_status_code
      )
    end

    let(:address) { 'Dimension C-132' }
    let(:country) { 'AR'}
    let(:full_name) { 'Rick Sánchez' }
    let(:receipt_kind_code) { 'b' }
    let(:tax_id) { '20123456782' }
    let(:tax_id_kind_code) { 'cuil' }
    let(:vat_status_code) { 'consumidor_final' }

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/argentina_invoicing_detail_seed/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'Compliance/argentina_invoicing_detail_seed/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/argentina_invoicing_detail_seed/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Argentinian Invoicing Detail Seed'
    end
  end
end
