require 'spec_helper'

describe Bitex::Resources::Compliance::NoteSeed do
  describe '.create', vcr: { cassette_name: 'compliance/note_seeds/create' } do
    subject { client.note_seeds.create(title: title, body: body) }

    let(:title) { 'Identification note' }
    let(:body) { 'These are custom notes' }

    it { is_expected.to be_a(Bitex::Resources::Compliance::NoteSeed) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id title body created_at updated_at]) }

    its(:type) { is_expected.to eq('note_seeds') }
    its(:id) { is_expected.to be_present }

    its(:title) { is_expected.to eq(title) }
    its(:body) { is_expected.to eq(body) }
  end
end
