shared_examples_for 'Orders' do
  its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id created_at orderbook_code amount remaining_amount price status]) }
  its(:'relationships.attributes.keys') { is_expected.to include(*%w[user]) }

  its(:type) { is_expected.to be_a(String) }
  its(:id) { is_expected.to be_a(String) }
  its(:created_at) { is_expected.to be_a(Time) }
  its(:amount) { is_expected.to be_a(BigDecimal) }
  its(:remaining_amount) { is_expected.to be_a(BigDecimal) }
  its(:price) { is_expected.to be_a(BigDecimal) }
  its(:status) { is_expected.to be_a(Symbol) }
  its(:orderbook_code) { is_expected.to be_a(Symbol) }
end
