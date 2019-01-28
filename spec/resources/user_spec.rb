require 'spec_helper'

describe Bitex::Resources::User  do
  describe '.create', vcr: { cassette_name: 'users/create' } do
    subject { client.users.create(email: 'user+test123@sample.com', password: 'password') }

    it { is_expected.to be_a(Bitex::Resources::User) }

    its(:'attributes.keys') do
      is_expected.to contain_exactly(*%w[type email password id name kyc_accepted otp_enabled do_not_email trezor_login_enabled])
    end

    its(:type) { is_expected.to eq('users') }
    its(:id) { is_expected.to be_present }
    its(:email) { is_expected.to eq('user+test123@sample.com') }
    its(:password) { is_expected.to eq('password') }

    its(:name) { is_expected.to eq('user+test123@sample.com')}
    its(:kyc_accepted) { is_expected.to be_falsey }
    its(:otp_enabled) { is_expected.to be_falsey }
    its(:do_not_email) { is_expected.to be_falsey }
    its(:trezor_login_enabled) { is_expected.to be_falsey }
  end

  describe '.find', vcr: { cassette_name: 'users/find' } do
    subject { client.users.find('600') }

    it { is_expected.to be_a(Bitex::Resources::User) }

    its(:id) { is_expected.to eq('600') }
  end

  describe '.all', vcr: { cassette_name: 'users/all' } do
    subject(:users) { client.users.all }

    it { is_expected.to be_a(JsonApiClient::ResultSet) }

    context 'taking a sample' do
      subject(:user) { users.sample }

      it { is_expected.to be_a(Bitex::Resources::User) }

      its(:type) { is_expected.to eq('users') }
    end
  end
end
