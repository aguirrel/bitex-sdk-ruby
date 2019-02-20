shared_examples_for 'Trades' do
  its(:'attributes.keys') do
    is_expected.to contain_exactly(*%w[type id created_at coin_amount cash_amount fee price fee_currency fee_decimals orderbook_code])
  end

  its(:type) { is_expected.to be_a(Symbol) }
  its(:id) { is_expected.to be_a(String) }
  its(:created_at) { is_expected.to be_a(Time) }
  its(:coin_amount) { is_expected.to be_a(BigDecimal) }
  its(:cash_amount) { is_expected.to be_a(BigDecimal) }
  its(:fee) { is_expected.to be_a(BigDecimal) }
  its(:price) { is_expected.to be_a(BigDecimal) }
  its(:fee_currency) { is_expected.to be_a(String) }
  its(:fee_decimals) { is_expected.to be_a(Integer) }
  its(:orderbook_code) { is_expected.to be_a(Symbol) }

  its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[order]) }
end
