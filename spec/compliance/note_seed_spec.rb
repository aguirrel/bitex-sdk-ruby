require 'spec_helper'

describe Bitex::Compliance::NoteSeed do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Note Seed' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id title body created_at updated_at]) }

    its(:title) { is_expected.to eq(title) }
    its(:body) { is_expected.to eq(body) }
  end

  describe '.create' do
    subject { client.note_seeds.create(title: title, body: body) }

    let(:title) { 'Identification note' }
    let(:body) { 'These are custom notes' }

    context 'with unauthorized key', vcr: { cassette_name: 'Compliance/note_seeds/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'Compliance/note_seeds/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'Compliance/note_seeds/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Note Seed'
    end
  end
end
