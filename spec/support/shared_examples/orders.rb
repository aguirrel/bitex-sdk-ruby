shared_examples_for 'Orders' do
  its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id orderbook_code amount remaining_amount price status]) }
  its(:'relationships.attributes.keys') { is_expected.to include(*%w[user]) }
end
