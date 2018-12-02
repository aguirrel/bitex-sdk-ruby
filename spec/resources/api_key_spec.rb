require 'spec_helper'

describe Bitex::Resources::ApiKey do
  shared_examples_for 'Api Key' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type write id token]) }

    its(:type) { is_expected.to eq(resource_name) }
    its(:id) { is_expected.to be_present }
    its(:token) { is_expected.to be_present }
    its(:write) { is_expected.to be_boolean }
  end

  describe '.all' do
    subject { client.api_keys.all }

    context 'with any level key', vcr: { cassette_name: 'api_keys/all' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Api Key'
      end
    end
  end

  describe '.find' do
    subject { client.api_keys.find(id) }

    context 'with any level key', vcr: { cassette_name: 'api_keys/find' } do
      let(:key) { read_level_key }

      let(:id) { 31 }

      it_behaves_like 'Api Key'
    end
  end

  describe '.create' do
    subject { client.api_keys.create(permissions: permission, otp: code) }

    context 'with authorized level key' do
      let(:key) { write_level_key }

      let(:code) { '984176' }

      context 'a new read level', vcr: { cassette_name: 'api_keys/create/read_level' } do
        let(:permission) { { write: false } }

        it_behaves_like 'Api Key'

        its(:write) { is_expected.to be_falsey }
      end

      context 'a new write level', vcr: { cassette_name: 'api_keys/create/write_level' } do
        let(:permission) { { write: true } }

        it_behaves_like 'Api Key'

        its(:write) { is_expected.to be_truthy }
      end
    end
  end

  describe '.destroy' do
    subject { client.api_keys.new(id: id).destroy }

    context 'with authorized level key', vcr: { cassette_name: 'api_keys/destroy' } do
      let(:key) { write_level_key }

      let(:id) { 34 }

      it { is_expected.to be_truthy }
    end
  end
end
