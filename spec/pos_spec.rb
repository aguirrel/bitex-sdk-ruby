require 'spec_helper'

describe Bitex::Pos do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Pos' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id merchant_keep merchant_logo merchant_name merchant_site merchant_slug])
    end
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.create' do
    subject { client.pos.create( keep: keep, logo: logo, name: name, site: site, slug: slug) }

    let(:keep) { 10 }
    let(:logo) { 'https://myawesomesite.com/logo' }
    let(:name) { 'My Awesome Site' }
    let(:site) { 'https://myawesomesite.com' }
    let(:slug) { 'my-awesome-site' }

    context 'with invalid argument' do
      let(:key) { 'we_dont_care' }

      context 'for keep' do
        let(:keep) { -1 }

        it { expect { subject }.to raise_error(Bitex::InvalidArgument) }
      end

      context 'for slug' do
        let(:slug) { 'slug-with-upcase-ChArAcTeRs' }

        it { expect { subject }.to raise_error(Bitex::InvalidArgument) }
      end
    end

    context 'with unauthorized key', vcr: { cassette_name: 'pos/create/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with unauthorized level key', vcr: { cassette_name: 'pos/create/unauthorized_key' } do
      it_behaves_like 'Not enough level permissions'
    end

    context 'with authorized level key', vcr: { cassette_name: 'pos/create/authorized' } do
      let(:key) { write_level_key }

      it_behaves_like 'Pos'

      its(:merchant_keep) { is_expected.to eq(keep) }
      its(:merchant_logo) { is_expected.to eq(logo) }
      its(:merchant_name) { is_expected.to eq(name) }
      its(:merchant_site) { is_expected.to eq(site) }
      its(:merchant_slug) { is_expected.to eq(slug) }
    end
  end

  describe '.valid_keep?' do
    subject { described_class.send(:valid_keep?, keep) }

    let(:keep) { rand(0..9)}

    context 'with valid keep' do
      it { is_expected.to be_truthy }
    end

    context 'with invalid currency' do
      let(:keep) { - 1 }

      it { is_expected.to be_falsey }
    end
  end

  describe '.valid_slug?' do
    subject { described_class.send(:valid_slug?, slug) }

    context 'with valid slug' do
      let(:slug) { 'a-valid-slug' }

      it { is_expected.to be_truthy }
    end

    context 'with invalid currency' do
      let(:slug) { 'a-InVaLiD-sLuG' }

      it { is_expected.to be_falsey }
    end
  end
end
