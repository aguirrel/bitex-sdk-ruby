require 'spec_helper'

describe Bitex::Resources::Compliance::PhoneSeed do
  describe '.create', vcr: { cassette_name: 'compliance/phone_seeds/create' } do
    subject do
      client.phone_seeds.create(
        601,
        country: 'AR',
        number: '1234567890',
        phone_kind_code: 'main',
        has_telegram: true,
        has_whatsapp: true,
        note: note
      )
    end

    let(:note) do
      'It´s a figure of speech, Morty! They´re bureaucrats! '\
        'I don´t respect them. Just keep shooting, Morty! '\
        'You have no idea what prison is like here!'
    end

    it { is_expected.to be_a(Bitex::Resources::Compliance::PhoneSeed) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(
        *%w[type id country number phone_kind_code has_telegram has_whatsapp note created_at updated_at]
      )
    end

    its(:type) { is_expected.to eq('phone_seeds') }
    its(:id) { is_expected.to be_present }

    its(:country) { is_expected.to eq('AR') }
    its(:number) { is_expected.to eq('1234567890') }
    its(:phone_kind_code) { is_expected.to eq('main') }
    its(:has_telegram) { is_expected.to be_truthy }
    its(:has_whatsapp) { is_expected.to be_truthy }
    its(:note) { is_expected.to eq(note) }
  end
end
