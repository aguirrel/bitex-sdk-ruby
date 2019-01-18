shared_examples_for 'Trading Bots' do
    it { is_expected.to be_a(described_class) }

  its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id orderbook_code amount remaining_amount chunk_size eta executing to_cancel]) }
  its(:type) { is_expected.to eq(resource_name) }
  its(:'relationships.attributes.keys') { is_expected.to include(*%w[user]) }
end
