require 'spec_helper'

describe Bitex::Resources::Merchants::Pos do
  describe '.create', vcr: { cassette_name: 'pos/create' } do
    subject do
      client.pos.create(merchant_keep: keep, merchant_logo: logo, merchant_name: name, merchant_site: site, merchant_slug: slug)
    end

    let(:keep) { 10 }
    let(:logo) { 'https://mysite.com/logo' }
    let(:name) { 'My Site' }
    let(:site) { 'https://mysite.com' }
    let(:slug) { 'my-site' }

    it { is_expected.to be_a(Bitex::Resources::Merchants::Pos) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type id merchant_keep merchant_logo merchant_name merchant_site merchant_slug])
    end

    its(:merchant_keep) { is_expected.to eq(keep) }
    its(:merchant_logo) { is_expected.to eq(logo) }
    its(:merchant_name) { is_expected.to eq(name) }
    its(:merchant_site) { is_expected.to eq(site) }
    its(:merchant_slug) { is_expected.to eq(slug) }
  end
end
