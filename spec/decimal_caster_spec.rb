require 'spec_helper'

describe DecimalCaster do
  class SomeResource < JsonApiClient::Resource
    property :dont_lose_precision, type: :decimal
    property :schema_default, type: :decimal
    property :custom_default, type: :decimal, default: 10.to_d
  end

  subject(:resource) { SomeResource.new(dont_lose_precision: 1234_5678.1234_5678, schema_default: 'NaN') }

  its(:dont_lose_precision) do
    is_expected.to eq(1234_5678.1234_5678)
    is_expected.to be_a(BigDecimal)
  end

  its(:schema_default) do
    is_expected.to eq(0)
    is_expected.to be_a(BigDecimal)
  end

  its(:custom_default) do
    is_expected.to eq(10)
    is_expected.to be_a(BigDecimal)
  end
end
