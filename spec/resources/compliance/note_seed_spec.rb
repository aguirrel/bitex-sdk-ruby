require 'spec_helper'

describe Bitex::Resources::Compliance::NoteSeed do
  let(:write_level_key) { 'write_level' }

  shared_examples_for 'Note Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id title body created_at updated_at]) }
  end

  describe '.create' do
    subject { client.note_seeds.create(title: title, body: body) }

    let(:title) { 'Identification note' }
    let(:body) { 'These are custom notes' }

    context 'with authorized level key', vcr: { cassette_name: 'compliance/note_seeds/create' } do
      let(:key) { write_level_key }

      it_behaves_like 'Note Seed'

      its(:title) { is_expected.to eq(title) }
      its(:body) { is_expected.to eq(body) }
    end
  end
end
