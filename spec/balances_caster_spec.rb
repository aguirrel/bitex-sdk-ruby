require 'spec_helper'

describe BalancesCaster do
  class SomeResource < JsonApiClient::Resource
    property :balances, type: :balances
  end

  subject(:resource) { SomeResource.new(balances:  { 'crypto_coin' => { 'total' => '10', 'available' => 20 } }) }

  its(:balances) { is_expected.to be_a(Hash) }

  context 'about casted balances' do
    subject(:balance) { resource.balances }

    its([:crypto_coin, :total]) { is_expected.to be_a(BigDecimal) }
    its([:crypto_coin, :available]) { is_expected.to be_a(BigDecimal) }
  end
end
