shared_examples_for 'TradingBots' do
  its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id orderbook_code amount remaining_amount chunk_size eta executing to_cancel]) }
  its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[user]) }

  its(:type) { is_expected.to be_a(String) }
  its(:id) { is_expected.to be_a(String) }
  its(:eta) { is_expected.to be_a(Time) }
  its(:chunk_size) { is_expected.to be_a(BigDecimal) }
  its(:amount) { is_expected.to be_a(BigDecimal) }
  its(:remaining_amount) { is_expected.to be_a(BigDecimal) }
  its(:executing) { is_expected.to be_in([true, false]) }
  its(:to_cancel) { is_expected.to be_in([true, false]) }
  its(:orderbook_code) { is_expected.to be_a(Symbol) }
end
