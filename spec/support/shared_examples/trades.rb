shared_examples_for 'Trades' do
  its(:'attributes.keys') do
    is_expected.to contain_exactly(*%w[type id created_at coin_amount cash_amount fee price fee_currency fee_decimals orderbook_code])
  end

  its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[order]) }
end
