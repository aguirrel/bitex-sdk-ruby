require 'spec_helper'

describe Bitex::Client do
  let(:client) { described_class.new(api_key: api_key, sandbox: false) }
  let(:api_key) { 'my_secret_a_api_key' }

  describe '.new' do
    subject { client }

    it { is_expected.to have_attributes(api_key: api_key) }
  end

  describe '#setup_environment' do
    subject { client.setup_environment(sandbox) }

    let(:base_site) { "https://#{environment_prefix_path}bitex.la/api/" }

    shared_examples_for 'Environment' do
      it do
        is_expected.to eq(base_site)
        expect(Bitex::Base.site).to eq(base_site)
      end
    end

    context 'sandbox' do
      let(:sandbox) { true }
      let(:environment_prefix_path) { 'sandbox.' }

      it_behaves_like 'Environment'
    end

    context 'production' do
      let(:sandbox) { false }
      let(:environment_prefix_path) { '' }

      it_behaves_like 'Environment'
    end
  end
end
