require 'spec_helper'

describe Bitex::Client do
  describe '.new' do
    subject { described_class.new(api_key: key, sandbox: sandbox) }

    let(:key) { :we_dont_care }

    context 'for any public service' do
      subject { super().orderbooks }

      let(:sandbox) { false }

      its(:site) { is_expected.to eq('https://bitex.la/api/') }
    end

    context 'for any private service' do
      subject { super().orders }

      let(:sandbox) { true }

      its(:site) { is_expected.to eq('https://sandbox.bitex.la/api/') }
    end
  end
end
