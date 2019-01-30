require 'spec_helper'

describe Bitex::Resources::Webhook do
  describe '.create', vcr: { cassette_name: 'webhooks/create' } do
    subject { client.webhooks.create(url: 'https://webhooktest.com') }

    it { is_expected.to be_a(Bitex::Resources::Webhook) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[id type url]) }

    its(:type) { is_expected.to eq('webhooks') }
    its(:id) { is_expected.to be_present }
    its(:url) { is_expected.to eq('https://webhooktest.com') }
  end

  describe '.find', vcr: { cassette_name: 'webhooks/find' } do
    subject { client.webhooks.find }

    it { is_expected.to be_a(Bitex::Resources::Webhook) }

    its(:url) { is_expected.to eq('https://webhooktest.com') }
  end
end
