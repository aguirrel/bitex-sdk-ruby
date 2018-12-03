require 'spec_helper'

describe Bitex::Resources::Compliance::PhoneSeed do
  let(:write_level_key) { 'client3_write_level_key' }

  shared_examples_for 'Phone Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id country number phone_kind_code has_telegram has_whatsapp note created_at updated_at]) }
  end

  describe '.create' do
    subject do
      client.phone_seeds.create(
        country: country,
        number: number,
        phone_kind_code: phone_kind_code,
        has_telegram: has_telegram,
        has_whatsapp: has_whatsapp,
        note: note
      )
    end

    let(:country) { 'AR' }
    let(:number) { '1234567890' }
    let(:phone_kind_code) { 'main' }
    let(:has_telegram) { true }
    let(:has_whatsapp) { false }
    let(:note) do
      'It´s a figure of speech, Morty! They´re bureaucrats! '\
        'I don´t respect them. Just keep shooting, Morty! '\
        'You have no idea what prison is like here!'
    end

    context 'with authorized level key', vcr: { cassette_name: 'compliance/phone_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Phone Seed'

      its(:country) { is_expected.to eq(country) }
      its(:number) { is_expected.to eq(number) }
      its(:phone_kind_code) { is_expected.to eq(phone_kind_code) }
      its(:has_telegram) { is_expected.to eq(has_telegram) }
      its(:has_whatsapp) { is_expected.to eq(has_whatsapp) }
      its(:note) { is_expected.to eq(note) }
    end
  end
end
